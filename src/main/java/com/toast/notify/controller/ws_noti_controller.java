package com.toast.notify.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.socket.WebSocketSession;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ServerEndpoint(value="/notify/{empl_idx}")
public class ws_noti_controller {
    Logger logger = LoggerFactory.getLogger(getClass());
    static Map<Integer, Session> user_list = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("empl_idx") int empl_idx) {
        logger.info("접속한 세션 ID:"+session.getId()+"empl_id :"+empl_idx);

        user_list.put(empl_idx, session);
        logger.info("알림 리스트" + user_list.keySet());
    }


    @OnClose
    public void onClose(Session session) {
        String close_id = session.getId();
        logger.info("종료한 세션 ID:"+close_id);
        for(Map.Entry<Integer, Session> entry : user_list.entrySet()) {

            if(entry.getValue().getId().equals(close_id)) {
                user_list.remove(entry.getKey());
                break;
            }
            logger.info("회원 리스트 : " + user_list.keySet());
        }
    }

    @OnError
    public void onError(Session session, Throwable e) {
        logger.info("에러난 세션 ID:"+ session.getId()+"원인 : "+e.toString());
    }

    //@OnMessage 어노테이션은 하나의 파라메터만 받을 수 있음
    @OnMessage
    public void onMessage(String message) {

        List<Integer> targetUserIds = new ArrayList<>();

            logger.info("메시지 내용 :" + message);

            String [] arr = message.split("/");

            String title = arr[0];
            String description = arr[1];
            String date = arr[2];
            String target_user=arr[3];

            logger.info("title:{}",title);
            logger.info("description:{}",description);
            logger.info("date:{}",date);
            logger.info("target_user:{}",target_user);

            //target_user이 int냐 배열이냐에 따라 달리

            //배열이면
            if(target_user.contains(",")){
                String[] userIds = target_user.split(",");
                for(String userId : userIds){
                    targetUserIds.add(Integer.parseInt(userId));
                }
            }else{
                targetUserIds.add(Integer.parseInt(target_user));
            }

        broad_cast("{\"title\":\"" + arr[0] + "\",\"description\":\"" + arr[1] + "\",\"date\":\"" + arr[2] + "\"}", targetUserIds);


    }

    public void broad_cast(String text,List<Integer> targetUser_idxs) {

        logger.info("알림 보낼 targetUser_idxs:{}",targetUser_idxs);
        for(Integer user_idx : user_list.keySet()){
            if(targetUser_idxs.contains(user_idx)){
                logger.info("알림 보낼 user_idx:{}",user_idx);

                Session session = user_list.get(user_idx);
                try {
                    session.getBasicRemote().sendText(text);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
    }

}
