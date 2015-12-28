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
            for (int i =0;i<tasks.size();i++) {
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
        info.put("vipTasks", vipTasks);
        info.put("otherTasks", otherTasks);
        info.put("nextWeekTasks", nextWeekTasks);
        info.put("myThinkTasks", myThinkTasks);

        return "user_index";
    }

    @RequestMapping("/saveOrUpdateTask4Day")
    public @ResponseBody Object saveOrUpdateTask4Day(HttpServletRequest request) {
        String uid = request.getParameter("uid");
        Long userId = Long.parseLong(uid);

        String vipCountStr = request.getParameter("vipCount");
        Integer vipCount = Integer.parseInt(vipCountStr);
        if (vipCount > 0) {
            for (int i = 1; i <= vipCount; i++) {
                String vipTask = request.getParameter("vip-text" + i);
                String vipStarStr = request.getParameter("vip-star" + i);
                String idStr = request.getParameter("id" + i);
                float vipStar = Float.parseFloat(vipStarStr);
                Long id = null;
                try {
                    id = Long.parseLong(idStr);
                } catch (Exception e) {

                }

                if (vipTask == null || vipTask.equals("")) {
                    continue;
                }
                Task task = genTask(userId, vipTask, vipStar, 0);
                if (id != null) {
                    task.setId(id);
                    int row = weeklyReviewService.updateTask(task);
                } else {
                    int row = weeklyReviewService.saveTask(task);
                }

            }
        }

        List<Task> tasks = weeklyReviewService.getTasks4Day(userId, getDateInt());
        return tasks;
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

}
