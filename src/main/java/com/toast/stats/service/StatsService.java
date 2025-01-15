package com.toast.stats.service;

import com.toast.stats.dto.StatsDTO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import com.toast.stats.dao.StatsDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StatsService {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final StatsDAO statsDAO;
    String driver_id = "webdriver.chrome.driver";
    String driver_path = "C:/STUDY/driver/chromedriver-win64/chromedriver.exe";
    //String driver_path = "/usr/local/drivers/chromedriver";

    WebDriver driver = null;
    ChromeOptions options = null;

    public StatsService(StatsDAO statsDAO) {
        this.statsDAO = statsDAO;

        // 사용할 크롬 드라이버의 환경 변수 등록
        System.setProperty(driver_id, driver_path);

        // 옵션 활성화
        options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");

        // 한국어 설정
        options.addArguments("--lang=ko");

        // 도커는 GUI가 아니므로 반드시 아래 옵션을 추가해야 한다.
        options.addArguments("--headless");  // 헤드리스 모드
        options.addArguments("--no-sandbox");  // 샌드박스 비활성화
        options.addArguments("--disable-dev-shm-usage");  // 공유 메모리 사용 비활성화
        options.addArguments("--remote-debugging-port=9222");  // 디버깅 포트 설정
        options.addArguments("--disable-gpu");  // GPU 비활성화
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

        switch (game_market) {
            case 1:
                info = doc.getElementsByClass("w7Iutd").get(0);
                grade = doc.getElementsByClass("Te9Tpc").get(0);
                data.put("cntReview", info.getElementsByClass("g1rdde").get(0).text());
                data.put("downloads", info.getElementsByClass("ClM7O").get(1).text());
                data.put("score", grade.getElementsByClass("jILTFe").get(0).text());
                break;

            case 2:
                info = doc.getElementsByClass("l-row").get(0);
                grade = doc.getElementsByClass("product-header__list").get(0);
                data.put("thumbnail", info.getElementsByClass("we-artwork--ios-app-icon").get(0).child(0).attr("srcset").split(" ")[0]);
                data.put("cntReview", grade.getElementsByClass("we-rating-count").get(0).text().split(" • ")[1]);
                data.put("score", grade.getElementsByClass("we-rating-count").get(0).text().split(" • ")[0]);
                data.put("ranking", grade.getElementsByClass("inline-list").get(0).text());
                break;
        }

        return data;
    }

    public String getAddr(int game_idx, int game_market) {

        return statsDAO.getAddr(game_idx, game_market);
    }

    public Map<String, Object> comment(int game_idx, int game_market) throws IOException {
        Map<String, Object> data = new HashMap<>();
        List<String> percentage = new ArrayList<>();
        List<String> comments = new ArrayList<>();
        String score = "";
        List<WebElement> list;

        // Jsoup 설정
        Elements scorePercentage;
        Document doc;

        // 셀레니움 설정
        driver = new ChromeDriver(options);
        driver.manage().window().maximize();

        switch (game_market) {
            case 1:
                driver.get(getAddr(game_idx, game_market));
                driver.findElements(By.className("ksBjEc")).get(3).click();
                list = driver.findElements(By.className("RHo1pe"));

                doc = Jsoup.connect(getAddr(game_idx, game_market)).get();
                score = doc.getElementsByClass("jILTFe").get(0).text();
                scorePercentage = doc.getElementsByClass("RutFAf");
                //logger.info(scorePercentage.get(0).attr("style").toString().split(" ")[1]);

                for (int i = 0; i < scorePercentage.size(); i++) {
                    percentage.add(scorePercentage.get(i).attr("style").toString().split(" ")[1]);
                }

                for (WebElement elem : list) {
                    //logger.info(elem.findElements(By.className("X5PpBb")).get(0).getText());
                    //logger.info(elem.findElements(By.className("bp9Aid")).get(0).getText());
                    //logger.info(elem.findElements(By.className("h3YV2d")).get(0).getText());
                    comments.add(elem.findElements(By.className("X5PpBb")).get(0).getText());
                    comments.add(elem.findElements(By.className("bp9Aid")).get(0).getText());
                    comments.add(elem.findElements(By.className("h3YV2d")).get(0).getText());
                }
                break;

            case 2:
                driver.get(getAddr(game_idx, game_market) + "?see-all=reviews");
                list = driver.findElements(By.className("we-customer-review"));
                String commentText = "";

                for (WebElement elem : list) {
                    comments.add(elem.findElements(By.className("we-customer-review__user")).get(0).getText());
                    comments.add(elem.findElements(By.className("we-customer-review__date")).get(0).getText());
                    commentText = elem.findElements(By.className("we-customer-review__title")).get(0).getText();
                    commentText += "<br />";
                    commentText += elem.findElements(By.className("we-clamp")).get(0).getText();
                    comments.add(commentText);
                }

                doc = Jsoup.connect(getAddr(game_idx, game_market)).get();
                score = doc.getElementsByClass("we-customer-ratings__averages__display").get(0).text();
                scorePercentage = doc.getElementsByClass("we-star-bar-graph__bar__foreground-bar");

                for (int i = 0; i < scorePercentage.size(); i++) {
                    //logger.info(scorePercentage.get(i).attr("style").toString());
                    percentage.add(scorePercentage.get(i).attr("style").toString().split(" ")[1]);
                }

                break;
        }

        driver.close();

        data.put("score", score);
        data.put("percentage", percentage);
        data.put("list", comments);
        return data;
    }
}
