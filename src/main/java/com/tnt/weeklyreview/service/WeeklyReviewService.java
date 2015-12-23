package com.tnt.weeklyreview.service;

import com.tnt.weeklyreview.model.Task;

import java.util.List;

/**
 * Created by zhaojunwzj on 12/24/15.
 */
public interface WeeklyReviewService {

    /**
     * 保存task
     *
     * @param task
     * @return
     */
    int saveTask(Task task);

    /**
     * 更新task
     *
     * @param task
     * @return
     */
    int updateTask(Task task);

    /**
     * 获取某个时间段的task列表
     *
     * @param userId
     * @param beginDate
     * @param endDate
     * @return
     */
    List<Task> getTasks(Long userId, int beginDate, int endDate);

    /**
     * 获取某一天的task列表
     *
     * @param userId
     * @param date
     * @return
     */
    List<Task> getTasks4Day(Long userId, int date);

}
