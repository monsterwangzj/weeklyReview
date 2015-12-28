package com.tnt.weeklyreview.model;

import java.io.Serializable;

/**
 * Created by zhaojunwzj on 12/24/15.
 */
public class Task implements Serializable {

    private static final long serialVersionUID = 47832438;

    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    private String task;

    private float rate;

    /**
     * 任务类型 0重要工作;1其它工作;2下周计划;3我的思考
     */
    private int taskType;

    /**
     * 日期
     */
    private int date;

    /**
     * 状态, 默认0, -1为已删除
     */
    private int status;

    private long createTime;

    private long lastModified;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getTask() {
        return task;
    }

    public void setTask(String task) {
        this.task = task;
    }

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

    public int getDate() {
        return date;
    }

    public void setDate(int date) {
        this.date = date;
    }

    public long getCreateTime() {
        return createTime;
    }

    public void setCreateTime(long createTime) {
        this.createTime = createTime;
    }

    public long getLastModified() {
        return lastModified;
    }

    public void setLastModified(long lastModified) {
        this.lastModified = lastModified;
    }

    public int getTaskType() {
        return taskType;
    }

    public void setTaskType(int taskType) {
        this.taskType = taskType;
    }
}
