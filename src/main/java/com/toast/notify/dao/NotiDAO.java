package com.toast.notify.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface NotiDAO {

    int approval_noti_insert(Map<String, Object> parameter);
}
