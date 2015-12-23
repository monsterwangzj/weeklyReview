package com.tnt.weeklyreview.dao;

import com.tnt.weeklyreview.model.Task;

import java.util.List;

/**
 * Created by zhaojunwzj on 12/24/15.
 */
public interface WeeklyReviewMapper {
    int save(Task task);

    int update(Task task);

    List<Task> getTasks(Long userId, int beginDate, int endDate);

    List<Task> getTasks(Long userId, int date);
    
}
