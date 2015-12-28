package com.tnt.weeklyreview.service.impl;

import com.tnt.weeklyreview.dao.WeeklyReviewMapper;
import com.tnt.weeklyreview.model.Task;
import com.tnt.weeklyreview.service.WeeklyReviewService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhaojunwzj on 12/24/15.
 */
@Service("weeklyReviewService")
public class WeeklyReviewServiceImpl implements WeeklyReviewService {

    @Autowired
    private WeeklyReviewMapper weeklyReviewMapper;

    public int saveTask(Task task) {
        int result = weeklyReviewMapper.save(task);
        return result;
    }

    public int updateTask(Task task) {
        int row = weeklyReviewMapper.update(task);
        return row;
    }

    public int removeTask(Long taskId) {
        int row = weeklyReviewMapper.remove(taskId);

        return row;
    }

    public List<Task> getTasks(Long userId, int beginDate, int endDate) {
        return weeklyReviewMapper.getTasks(userId, beginDate, endDate);
    }

    public List<Task> getTasks4Day(Long userId, int date) {
        Map paramMap=new HashMap();
        paramMap.put("userId",userId);
        paramMap.put("date",date);
        return weeklyReviewMapper.getTasks4Day(paramMap);
    }
    
}
