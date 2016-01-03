package com.tnt.weeklyreview.dao;

import java.util.List;

import com.tnt.weeklyreview.model.UserInfo;

public interface UserInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer id);

    UserInfo selectByUsernamenPwd(UserInfo userInfo);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);
    
    List<UserInfo> selectAll();
}