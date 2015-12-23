package com.tnt.weeklyreview.service.impl;

import com.tnt.weeklyreview.dao.WeeklyReviewMapper;
import com.tnt.weeklyreview.model.Task;
import com.tnt.weeklyreview.service.WeeklyReviewService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by zhaojunwzj on 12/24/15.
 */
public class WeeklyReviewServiceImpl implements WeeklyReviewService {

    @Autowired
    private WeeklyReviewMapper weeklyReviewMapper;

    public int saveTask(Task task) {
        int result = weeklyReviewMapper.save(task);
        return result;
    }

    public int updateTask(Task task) {
        return weeklyReviewMapper.update(task);
    }

    public List<Task> getTasks(Long userId, int beginDate, int endDate) {
        return weeklyReviewMapper.getTasks(userId, beginDate, endDate);
    }

    public List<Task> getTasks4Day(Long userId, int date) {
        return weeklyReviewMapper.getTasks(userId, date);
    }
    
}
