package com.tnt.weeklyreview.controller;

import com.tnt.weeklyreview.model.Task;
import com.tnt.weeklyreview.service.WeeklyReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public @ResponseBody Object showUserInfos() {
        List<Task> tasks = weeklyReviewService.getTasks4Day(1L, 20151224);
        return tasks;
    }

}
