package com.tnt.weeklyreview.controller;

import com.tnt.weeklyreview.model.UserInfo;
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

    @RequestMapping("/showInfos")
    public @ResponseBody Object showUserInfos() {
        List<UserInfo> userInfos = weeklyReviewService.getUsers();
        return userInfos;
    }

}
