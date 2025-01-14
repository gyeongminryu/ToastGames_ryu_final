package com.toast.work.dao;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface WorkDAO {

    // 출근 시간 저장
    void saveStartTime(int empl_idx, LocalTime attend_date, Date sqlDate);

    // 근무 일 기록 업데이트 (퇴근 시간 포함)
    void updateWorkDay(int empl_idx, LocalTime attend_date, LocalTime leave_date, double total_hours, double overtime_hours);

    // 출근 시간 가져오기
    LocalTime getStartTimeForEmployee(int empl_idx);

    // 주어진 날짜 범위에 해당하는 근무 기록 가져오기
    List<Map<String, Object>> getWorkRecord(@Param("empl_idx") int empl_idx, @Param("startDate") String startDate);

    // 임직원의 근무일 목록 가져오기
    List<String> getWorkDate(int empl_idx);

    // 총 근무 시간 및 초과 근무 시간 합계 가져오기
    Map<String, Object> getSumWork(@Param("empl_idx") int empl_idx, @Param("startDate") String startDate);

    // 모든 사원의 ID 목록 가져오기
    List<Integer> getAllEmployeeIds();

    // 근무 기록 삽입 (출근 기록이 없을 경우)
    void insertWorkRecord(Map<String, Object> params);

    // 해당 날짜에 출근 기록이 존재하는지 확인
    boolean checkWorkRecordExists(int empl_idx, LocalDate workDate);

    // 출근 상태 저장 (출근/퇴근 여부)
    void saveAttendanceStatus(int empl_idx, boolean isLoggedIn);

    // 출근 상태 조회 (출근 중인지 여부)
    Boolean getAttendanceStatus(int empl_idx);
}
