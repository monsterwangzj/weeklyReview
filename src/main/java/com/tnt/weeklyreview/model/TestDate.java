package com.tnt.weeklyreview.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by zhaojunwzj on 1/1/16.
 */
public class TestDate {
    public static void main(String[] args) {
        // 定义输出日期格式
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEE");

        Date currentDate = new Date();


        // 比如今天是2012-12-25
        List<Integer> days = dateToWeek(currentDate);
        System.out.println("今天的日期: " + sdf.format(currentDate));
        for (Integer date : days) {
            System.out.println(sdf.format(date));
        }
    }

    public static List<Integer> dateToWeek(Date mdate) {
        int weekDay = Calendar.getInstance().get(Calendar.DAY_OF_WEEK) - 1;
        if (weekDay == 0) { //sunday
            weekDay = 7;
        }
        Date fdate;
        List<Integer> list = new ArrayList<Integer>();
        Long fTime = mdate.getTime() - weekDay * 24 * 3600000;
        for (int a = 1; a <= weekDay; a++) {
            fdate = new Date();
            fdate.setTime(fTime + (a * 24 * 3600000));
            int dateInt = getDateInt(fdate);
            list.add(a - 1, dateInt);
        }
        return list;
    }

    private static int getDateInt(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(date);
        int dateInt = Integer.parseInt(dateStr);
        return dateInt;
    }
}
