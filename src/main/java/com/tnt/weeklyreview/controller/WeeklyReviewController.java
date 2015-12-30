package com.tnt.weeklyreview.controller;

import com.tnt.weeklyreview.model.Task;
import com.tnt.weeklyreview.service.WeeklyReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by zhaojunwzj on 12/24/15.
 */
@Controller
@RequestMapping("/weeklyreview")
public class WeeklyReviewController {

    @Autowired
    private WeeklyReviewService weeklyReviewService;

    @RequestMapping("/getTask4Day")
    public String getTask4Day(ModelMap info, HttpServletRequest request, HttpServletResponse response) {
        int date = getDateInt();
        List<Task> tasks = weeklyReviewService.getTasks4Day(1L, date);

        response.setContentType("application/xml;utf-8");
        response.setCharacterEncoding("utf-8");

        List<Task> vipTasks = new ArrayList<Task>();
        List<Task> otherTasks = new ArrayList<Task>();
        List<Task> nextWeekTasks = new ArrayList<Task>();
        List<Task> myThinkTasks = new ArrayList<Task>();
        if (!CollectionUtils.isEmpty(tasks)) {
            for (int i = 0; i < tasks.size(); i++) {
                Task task = tasks.get(i);
                if (task != null) {
                    int type = task.getTaskType();
                    if (type == 0) { // 今日重点工作
                        vipTasks.add(task);
                    } else if (type == 1) { // 其它工作
                        otherTasks.add(task);
                    } else if (type == 2) { // 下周工作计划
                        nextWeekTasks.add(task);
                    } else if (type == 3) { // 我的思考
                        myThinkTasks.add(task);
                    }
                }
            }
        }
        String todayDate = getDateStr();
        info.put("todayDate", todayDate);
        info.put("vipTasks", vipTasks);
        info.put("otherTasks", otherTasks);
        info.put("nextWeekTasks", nextWeekTasks);
        info.put("myThinkTasks", myThinkTasks);

        return "user_index";
    }

    @RequestMapping("/saveOrUpdateTask4Day")
    public
    @ResponseBody
    Object saveOrUpdateTask4Day(HttpServletRequest request) {
        String uid = request.getParameter("uid");
        Long userId = Long.parseLong(uid);

        String prefix = "vip";
        String vipCountStr = request.getParameter("vipCount");
        Integer vipCount = Integer.parseInt(vipCountStr);
        saveOrUpdateWithType(vipCount, userId, prefix, request);

        prefix = "other";
        String otherCountStr = request.getParameter("otherCount");
        Integer otherCount = Integer.parseInt(otherCountStr);
        saveOrUpdateWithType(otherCount, userId, prefix, request);

        prefix = "nextWeek";
        String nextWeekCountStr = request.getParameter("nextWeekCount");
        Integer nextWeekCount = Integer.parseInt(nextWeekCountStr);
        saveOrUpdateWithType(nextWeekCount, userId, prefix, request);

        prefix = "myThink";
        String myThinkCountStr = request.getParameter("myThinkCount");
        Integer myThinkCount = Integer.parseInt(myThinkCountStr);
        saveOrUpdateWithType(myThinkCount, userId, prefix, request);

        List<Task> tasks = weeklyReviewService.getTasks4Day(userId, getDateInt());
        return tasks;
    }

    private float getStarValue(String starStr) {
        float star = 0;
        try {
            star = Float.parseFloat(starStr);
        } catch (Exception e) {

        }

        return star;
    }

    private Long getIdValue(String idStr) {
        Long id = null;
        try {
            id = Long.parseLong(idStr);
        } catch (Exception e) {

        }

        return id;
    }

    private void saveOrUpdateWithType(int vipCount, Long userId, String prefix, HttpServletRequest request) {
        if (vipCount > 0) {
            for (int i = 1; i <= vipCount; i++) {
                String taskContent = request.getParameter(prefix + "-text" + i);
                String starStr = request.getParameter(prefix + "-star" + i);
                String idStr = request.getParameter(prefix + "-id" + i);
                float star = getStarValue(starStr);
                Long id = getIdValue(idStr);

                if (taskContent == null || taskContent.equals("")) {
                    continue;
                }
                int taskType = 0;
                if (prefix.equals("vip")) {
                    taskType = 0;
                } else if (prefix.equals("other")) {
                    taskType = 1;
                } else if (prefix.equals("nextWeek")) {
                    taskType = 2;
                } else if (prefix.equals("myThink")) {
                    taskType = 3;
                }
                Task task = genTask(userId, taskContent, star, taskType);
                if (id != null) {
                    task.setId(id);
                    int row = weeklyReviewService.updateTask(task);
                } else {
                    int row = weeklyReviewService.saveTask(task);
                }
            }
        }
    }

    @RequestMapping("/removeTask")
    public
    @ResponseBody
    Object removeTask(HttpServletRequest request) {
        String idStr = request.getParameter("id");
        Long id = Long.parseLong(idStr);

        if (id != null) {
            int row = weeklyReviewService.removeTask(id);
        }

        return "success";
    }

    private Task genTask(Long userId, String taskcontent, float rate, int taskType) {
        Date date = new Date();
        long currentTimeMillis = date.getTime();
        Task task = new Task();
        task.setUserId(userId);
        task.setCreateTime(currentTimeMillis);
        task.setLastModified(currentTimeMillis);
        task.setTask(taskcontent);
        task.setRate(rate);

        task.setTaskType(taskType);
        task.setDate(getDateInt());

        return task;
    }

    private int getDateInt() {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(date);
        int dateInt = Integer.parseInt(dateStr);
        return dateInt;
    }

    private String getDateStr() {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
        String dateStr = sdf.format(date);

        return dateStr;
    }

}
