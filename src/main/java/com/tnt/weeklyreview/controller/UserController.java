package com.tnt.weeklyreview.controller;

import com.tnt.weeklyreview.model.UserInfo;
import com.tnt.weeklyreview.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/showInfo/{userId}")
    public String showUserInfo(ModelMap modelMap, @PathVariable int userId) {
        UserInfo userInfo = userService.getUserById(userId);
        modelMap.addAttribute("userInfo", userInfo);
        return "/user/showInfo";
    }

    @RequestMapping("/showInfos")
    public
    @ResponseBody
    Object showUserInfos() {
        List<UserInfo> userInfos = userService.getUsers();
        return userInfos;
    }

    @RequestMapping("/login")
    public String login() {

        List<UserInfo> userInfos = userService.getUsers();

        return "login";
    }

    @RequestMapping("/signin")
    public String signin(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            // 错误
            return "login";
        }
        UserInfo userInfo = userService.getUser(username, password);
        if (userInfo == null) {
            return "login";
        }

        Cookie cookie = new Cookie("uid", userInfo.getId().toString());
        cookie.setMaxAge(Integer.MAX_VALUE);
        cookie.setPath("/");
        response.addCookie(cookie);

        return "redirect:/weeklyreview/getTask4Day.htmls";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        for(Cookie cookie : cookies){
            String cookieName = cookie.getName();
            if (cookieName.equals("uid")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }

        }
        return "redirect:/user/login.htmls";
    }

}
