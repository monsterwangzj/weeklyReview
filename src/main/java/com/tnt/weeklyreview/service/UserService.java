package com.tnt.weeklyreview.service;

import java.util.List;

import com.tnt.weeklyreview.model.UserInfo;

public interface UserService {

	UserInfo getUserById(int id);

	UserInfo getUser(String username, String password);

	List<UserInfo> getUsers();
	
	int insert(UserInfo userInfo);
}
