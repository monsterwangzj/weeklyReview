package com.tnt.weeklyreview.dao;

import com.tnt.weeklyreview.model.Task;

import java.util.List;
import java.util.Map;

/**
 * Created by zhaojunwzj on 12/24/15.
 */
public interface WeeklyReviewMapper {
    int save(Task task);

    int update(Task task);

    int remove(Long id);

    List<Task> getTasks(Long userId, int beginDate, int endDate);

    List<Task> getTasks4Day(Map map);
}
