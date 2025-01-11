package com.toast.stats.controller;

import com.toast.stats.service.StatsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.Map;

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

    @PostMapping(value = "/stats_comment.ajax")
    public Map<String, Object> stats_comment(String game_idx, String game_market) throws IOException {
        int game_idxInt = Integer.parseInt(game_idx);
        int game_marketInt = Integer.parseInt(game_market);

        return statsService.comment(game_idxInt, game_marketInt);
    }
}
