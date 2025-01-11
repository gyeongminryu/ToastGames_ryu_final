package com.toast.stats.dao;

import com.toast.stats.dto.StatsDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StatsDAO {

    // 게임 목록
    List<StatsDTO> list();
    String getAddr(int game_idx, int game_market);

}
