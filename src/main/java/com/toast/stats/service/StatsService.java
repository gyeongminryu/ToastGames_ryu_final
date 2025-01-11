package com.toast.stats.service;

import com.toast.stats.dto.StatsDTO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import com.toast.stats.dao.StatsDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StatsService {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final StatsDAO statsDAO;
    String driver_id = "webdriver.chrome.driver";
    String driver_path = "C:/STUDY/driver/chromedriver-win64/chromedriver.exe";

    WebDriver driver = null;
    ChromeOptions options = null;

    public StatsService(StatsDAO statsDAO) {
        this.statsDAO = statsDAO;

        // 사용할 크롬 드라이버의 환경 변수 등록
        System.setProperty(driver_id, driver_path);

        // 옵션 활성화
        options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");
    }

    // 게임 목록
    public List<StatsDTO> list() throws IOException {
        List<StatsDTO> list = statsDAO.list();
        Document doc;

        for (StatsDTO item : list) {
            // 구글 스토어 데이터 수집
            doc = Jsoup.connect(getAddr(item.getGame_idx(), 1)).get();
            item.setData_google(getData(doc, 1));

            // 앱마켓 데이터 수집
            doc = Jsoup.connect(getAddr(item.getGame_idx(), 2)).get();
            item.setData_appmarket(getData(doc, 2));
        }

        return list;
    }

    public Map<String, Object> getData(Document doc, int game_market) throws IOException {
        Map<String, Object> data = new HashMap<>();
        Element info;
        Element grade;
        Element review;

        switch (game_market) {
            case 1:
                info = doc.getElementsByClass("w7Iutd").get(0);
                grade = doc.getElementsByClass("Te9Tpc").get(0);
                data.put("cntReview", info.getElementsByClass("g1rdde").get(0).text());
                data.put("downloads", info.getElementsByClass("ClM7O").get(1).text());
                data.put("grade", grade.getElementsByClass("jILTFe").get(0).text());
                break;

            case 2:
                info = doc.getElementsByClass("l-row").get(0);
                grade = doc.getElementsByClass("product-header__list").get(0);
                data.put("thumbnail", info.getElementsByClass("we-artwork--ios-app-icon").get(0).child(0).attr("srcset").split(" ")[0]);
                data.put("cntReview", grade.getElementsByClass("we-rating-count").get(0).text().split(" • ")[1]);
                data.put("grade", grade.getElementsByClass("we-rating-count").get(0).text().split(" • ")[0]);
                data.put("ranking", grade.getElementsByClass("inline-list").get(0).text());
                break;
        }

        return data;
    }

    public String getAddr(int game_idx, int game_market) {

        return statsDAO.getAddr(game_idx, game_market);
    }
}
