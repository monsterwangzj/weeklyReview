package com.tnt.weeklyreview.controller;

import com.tnt.weeklyreview.model.Task;
import com.tnt.weeklyreview.service.WeeklyReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
        // 验证登录
        boolean isLogin = false;
        Long userId = null;
        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                String cookieName = cookie.getName();
                if (cookieName.equals("uid")) {
                    String uid = cookie.getValue();
                    try {
                        userId = Long.parseLong(uid);
                        isLogin = true;
                    } catch (Exception e) {
                    }
                }
            }
        }

        if (!isLogin) {
            return "redirect:/user/login.htmls";
        }


        response.setContentType("application/xml;utf-8");
        response.setCharacterEncoding("utf-8");

        List<Integer> dateIntList = dateToWeek();
        info.put("dateIntList", dateIntList);
        info.put("uid", userId.toString());
        for (int k = 0; k < dateIntList.size(); k++) {
            int dateInt = dateIntList.get(k);

            List<Task> tasks = weeklyReviewService.getTasks4Day(userId, dateInt);
            List<Task> vipTasks = new ArrayList<Task>();
            List<Task> otherTasks = new ArrayList<Task>();
            List<Task> nextWeekTasks = new ArrayList<Task>();
            List<Task> myThinkTasks = new ArrayList<Task>();
            if (!CollectionUtils.isEmpty(tasks)) {
                for (int i = 0; i < tasks.size(); i++) {
                    Task task = tasks.get(i);
                    if (task != null) {
                        int type = task.getTaskType();
                        if (type == 0) {
                            vipTasks.add(task);
                        } else if (type == 1) {
                            otherTasks.add(task);
                        } else if (type == 2) {
                            nextWeekTasks.add(task);
                        } else if (type == 3) {
                            myThinkTasks.add(task);
                        }
                    }
                }
            }
            String todayDate = getDateStr(dateInt);
            info.put(dateInt + "-todayDate", todayDate);
            info.put(dateInt + "-vipTasks", vipTasks);
            info.put(dateInt + "-otherTasks", otherTasks);
            info.put(dateInt + "-nextWeekTasks", nextWeekTasks);
            info.put(dateInt + "-myThinkTasks", myThinkTasks);
        }

        return "user_index";
    }

    @RequestMapping("/saveOrUpdateTask4Day")
    public
    @ResponseBody
    Object saveOrUpdateTask4Day(HttpServletRequest request) {
        String uid = request.getParameter("uid");
        String dateIntStr = request.getParameter("dateInt");
        Integer dateInt = Integer.parseInt(dateIntStr);
        Long userId = Long.parseLong(uid);

        String prefix = dateIntStr + "-vip";
        String vipCountStr = request.getParameter(dateIntStr + "-vipCount");
        Integer vipCount = Integer.parseInt(vipCountStr);
        saveOrUpdateWithType(vipCount, userId, prefix, dateInt, request);

        prefix = dateIntStr + "-other";
        String otherCountStr = request.getParameter(dateIntStr + "-otherCount");
        Integer otherCount = Integer.parseInt(otherCountStr);
        saveOrUpdateWithType(otherCount, userId, prefix, dateInt, request);

        prefix = dateIntStr + "-nextWeek";
        String nextWeekCountStr = request.getParameter(dateIntStr + "-nextWeekCount");
        Integer nextWeekCount = Integer.parseInt(nextWeekCountStr);
        saveOrUpdateWithType(nextWeekCount, userId, prefix, dateInt, request);

        prefix = dateIntStr + "-myThink";
        String myThinkCountStr = request.getParameter(dateIntStr + "-myThinkCount");
        Integer myThinkCount = Integer.parseInt(myThinkCountStr);
        saveOrUpdateWithType(myThinkCount, userId, prefix, dateInt, request);

        List<Task> tasks = weeklyReviewService.getTasks4Day(userId, getDateInt()); // FIXME: 1/1/16
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

    private Long getLongValue(String idStr) {
        Long id = null;
        try {
            id = Long.parseLong(idStr);
        } catch (Exception e) {

        }

        return id;
    }

    private void saveOrUpdateWithType(int vipCount, Long userId, String prefix, int dateInt, HttpServletRequest request) {
        if (vipCount > 0) {
            for (int i = 1; i <= vipCount; i++) {
                String taskContent = request.getParameter(prefix + "-text" + i);
                String starStr = request.getParameter(prefix + "-star" + i);
                String priorityStr = request.getParameter(prefix + "-priority" + i);
                String idStr = request.getParameter(prefix + "-id" + i);
                float star = getStarValue(starStr);
                Long id = getLongValue(idStr);
                Long priority = getLongValue(priorityStr);

                if (taskContent == null || taskContent.equals("")) {
                    continue;
                }
                int taskType = 0;
                if (prefix.contains("vip")) {
                    taskType = 0;
                } else if (prefix.contains("other")) {
                    taskType = 1;
                } else if (prefix.contains("nextWeek")) {
                    taskType = 2;
                } else if (prefix.contains("myThink")) {
                    taskType = 3;
                }
                Task task = genTask(userId, taskContent, star, taskType, dateInt, priority.intValue());
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

    private Task genTask(Long userId, String taskcontent, float rate, int taskType, int dateInt, int priority) {
        Date date = new Date();
        long currentTimeMillis = date.getTime();
        Task task = new Task();
        task.setUserId(userId);
        task.setCreateTime(currentTimeMillis);
        task.setLastModified(currentTimeMillis);
        task.setTask(taskcontent);
        task.setRate(rate);

        task.setPriority(priority);
        task.setTaskType(taskType);
        task.setDate(dateInt);

        return task;
    }

    private static int getDateInt() {
        Date date = new Date();
        return getDateInt(date);
    }

    private static int getDateInt(Date date) {
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

    private String getDateStr(int dateInt) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        try {
            Date date = sdf.parse(Integer.toString(dateInt));
            SimpleDateFormat sdf2 = new SimpleDateFormat("MM.dd");
            String dateStr = sdf2.format(date);

            return dateStr;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }


    public static List<Integer> dateToWeek() {
        int weekDay = Calendar.getInstance().get(Calendar.DAY_OF_WEEK) - 1;
        if (weekDay == 0) { //sunday
            weekDay = 7;
        }
        Date fdate;
        List<Integer> list = new ArrayList<Integer>();
        Long fTime = new Date().getTime() - weekDay * 24 * 3600000;
        for (int a = 1; a <= weekDay; a++) {
            fdate = new Date();
            fdate.setTime(fTime + (a * 24 * 3600000));
            int dateInt = getDateInt(fdate);
            list.add(a - 1, dateInt);
        }
        return list;
    }

}
