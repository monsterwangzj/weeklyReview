package com.tnt.weeklyreview.controller;

import com.tnt.weeklyreview.model.Task;
import com.tnt.weeklyreview.service.WeeklyReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
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
    public @ResponseBody Object getTask4Day() {
        List<Task> tasks = weeklyReviewService.getTasks4Day(1L, 20151224);
        return tasks;
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
                float vipStar = Float.parseFloat(vipStarStr);

                if (vipTask == null || vipTask.equals("")) {
                    continue;
                }
                Task task = genTask(userId, vipTask, vipStar, 0);
                int row = weeklyReviewService.saveTask(task);
            }
        }

        List<Task> tasks = weeklyReviewService.getTasks4Day(userId, getDateInt());
        return tasks;
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
