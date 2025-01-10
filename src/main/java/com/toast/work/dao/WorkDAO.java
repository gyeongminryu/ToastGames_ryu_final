package com.toast.work.dao;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WorkDAO {

	void saveStartTime(int empl_idx, LocalTime attend_date, Date sqlDate);

	void updateWorkDay(int empl_idx, LocalTime attend_date, LocalTime leave_date, int total_hours, int overtime_hours);

	LocalTime getStartTimeForEmployee(int empl_idx);

	List<Map<String, Object>> getWorkRecord(int empl_idx, LocalDate workDate);

	List<String> getWorkDate(int empl_idx);

	int getWeeklyWorkTime(int empl_idx);

	int getDailyWorkTimes(int empl_idx);

}
