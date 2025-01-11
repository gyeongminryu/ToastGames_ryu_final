package com.toast.stats.dto;

import java.util.Map;

public class StatsDTO {

    // game_list
    private int game_idx;
    private String game_name;
    private String game_type;

    // game_market_list
    private int game_list_idx;
    private int game_market;
    private String market_addr;

    // other
    private Map<String, Object> data_google;
    private Map<String, Object> data_appmarket;

    // Getter
    public int getGame_idx() {
        return game_idx;
    }

    public String getGame_name() {
        return game_name;
    }

    public String getGame_type() {
        return game_type;
    }

    public int getGame_list_idx() {
        return game_list_idx;
    }

    public int getGame_market() {
        return game_market;
    }

    public String getMarket_addr() {
        return market_addr;
    }

    public Map<String, Object> getData_google() {
        return data_google;
    }

    public Map<String, Object> getData_appmarket() {
        return data_appmarket;
    }

    // Setter
    public void setGame_idx(int game_idx) {
        this.game_idx = game_idx;
    }

    public void setGame_name(String game_name) {
        this.game_name = game_name;
    }

    public void setGame_type(String game_type) {
        this.game_type = game_type;
    }

    public void setGame_list_idx(int game_list_idx) {
        this.game_list_idx = game_list_idx;
    }

    public void setGame_market(int game_market) {
        this.game_market = game_market;
    }

    public void setMarket_addr(String market_addr) {
        this.market_addr = market_addr;
    }

    public void setData_google(Map<String, Object> data_google) {
        this.data_google = data_google;
    }

    public void setData_appmarket(Map<String, Object> data_appmarket) {
        this.data_appmarket = data_appmarket;
    }

}
