package com.toast.stats.controller;

import com.toast.stats.service.StatsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;

@RestController
public class StatsController {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final StatsService statsService;

    public StatsController(StatsService statsService) {
        this.statsService = statsService;
    }

    // 게임 목록
    @GetMapping(value = "/stats_dashboard.go")
    public ModelAndView stats_dashboard() throws InterruptedException {
        ModelAndView mav = new ModelAndView("stats_dashboard");

        try {
            mav.addObject("list", statsService.list());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return mav;
    }
}
