package com.toast.member.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	// 로거
	Logger logger = LoggerFactory.getLogger(getClass());

	private static final String SENDER_EMAIL = "beomhihan@gmail.com"; // 발신자 이메일
    private static final String SMTP_HOST = "smtp.gmail.com"; // SMTP 서버 주소
    private static final int SMTP_PORT = 587; // SMTP 서버 포트
    private static final String SMTP_USER = "beomhihan@gmail.com"; // 이메일 계정 (사용자)
    private static final String SMTP_PASSWORD = "ewul hfoc blan tuqg"; // 이메일 비밀번호 (비밀)

    public void sendPwMail(String email, String tempPw) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(SMTP_HOST);
        mailSender.setPort(SMTP_PORT);
        mailSender.setUsername(SMTP_USER);
        mailSender.setPassword(SMTP_PASSWORD);

        // 메일을 HTML 형식으로 보내는 설정
        mailSender.getJavaMailProperties().put("mail.smtp.auth", "true");
        mailSender.getJavaMailProperties().put("mail.smtp.starttls.enable", "true");
        mailSender.getJavaMailProperties().put("mail.smtp.timeout", "5000");

        MimeMessage message = mailSender.createMimeMessage();

        try {
            message.setFrom(SENDER_EMAIL);
            message.setRecipients(MimeMessage.RecipientType.TO, email);
            message.setSubject("임시 비밀번호 안내");
            String body = "<h3>안녕하세요.</h3>";
            body += "<p>" + "요청하신 임시 비밀번호는 <strong>" + tempPw + "</strong> 입니다." + "</p>";
            body += "<p>" + "로그인 후 반드시 비밀번호를 변경해주세요." + "</p>";
            body += "<p>" + "감사합니다." + "</p>";
            message.setText(body, "UTF-8", "html");

            mailSender.send(message);
            logger.info("임시 비밀번호 메일을 성공적으로 보냈습니다.");
        } catch (MessagingException e) {
            logger.error("메일 전송 실패", e);
        }
    }	

}
