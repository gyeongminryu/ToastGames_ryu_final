package com.toast.notify.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.HashMap;
import java.util.Map;

@ServerEndpoint(value="/notify/{user_id}")
public class approval_noti_controller {
    Logger logger = LoggerFactory.getLogger(getClass());
    static Map<String, Session> user_list = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("user_id") int user_id) {

    }


    @OnClose
    public void onClose(Session session) {

    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        logger.error(throwable.toString());
    }

    @OnMessage
    public void onMessage(String message, Session session) {

        // JSONParser를 사용하여 JSON 파싱
        ObjectMapper mapper = new ObjectMapper();

        try{
            //메시지 - JSON 문자열을 JSON Node 객체로 변환
            JsonNode jsonNode = mapper.readTree(message);
            String noti_target_user = jsonNode.get("noti_target_user").asText();
            logger.info("noti_target_user:{}",noti_target_user);

        }catch (Exception e){
            e.printStackTrace();
        }

    }

}
