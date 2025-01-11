package com.toast.stats.service;

import com.toast.regdata.dao.ManageFormDAO;
import com.toast.stats.dao.StatsDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class StatsService {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final StatsDAO statsDAO;

    public StatsService(StatsDAO statsDAO) {
        this.statsDAO = statsDAO;
    }

    // 게임 목록
    public Map<String, Object> list() {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("list", statsDAO.list());

        return result;
    }
}
