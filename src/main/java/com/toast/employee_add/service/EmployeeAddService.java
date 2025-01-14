package com.toast.employee_add.service;

import com.toast.dataconfig.DataConfig;
import com.toast.employee_add.dao.EmployeeAddDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class EmployeeAddService {
    Logger logger = LoggerFactory.getLogger(getClass());
    private final EmployeeAddDAO employee_add_DAO;
    private final PasswordEncoder encoder;
    private final DataConfig dataconfig;


    public EmployeeAddService (EmployeeAddDAO employee_add_DAO, PasswordEncoder encoder, DataConfig dataconfig) {
        this.employee_add_DAO = employee_add_DAO;
        this.encoder = encoder;
        this.dataconfig = dataconfig;
    }


   /* public void saveExcel(List<Map<String, Object>> dataList) { //세션 추가
        if(employee_add_DAO.saveExcel(dataList)>0) {
            logger.info("엑셀 데이터 불러오기 성공");
        }

    }
*/
    public boolean empl_add_all(List<Map<String, Object>> lists){
        logger.info("서비스에서 받은 일괄 등록 데이터:{}", lists);
        boolean success = false;

        //전달할 param값
        List<Map<String,Object>> data_list = new ArrayList<Map<String,Object>>();

        for(Map<String,Object> list: lists){
            logger.info("list:{}",list);

            //임시 아이디
            String random_id = UUID.randomUUID().toString();
            random_id = random_id.substring(0,3);

            list.put("empl_id",random_id+ list.get("empl_per_phone"));

            //패스워드 인코딩 (시큐리티)
            String password = (String) list.get("empl_pw");
            encoder.encode(password);
            list.put("empl_pw", encoder.encode(password));

            //주민등록번호 인코딩(AES)
            String encode_ssn2 = null;
            try {
                encode_ssn2 = dataconfig.aesCBCEncode((String) list.get("empl_ssn2"));
                list.put("empl_ssn2", encode_ssn2);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

            //파일 키
            String file_key = UUID.randomUUID().toString();
            list.put("file_key", file_key);

            //성별 -> int값으로 변환
            String gender = (String) list.get("empl_gender");
            if(gender.equals("남")||gender.equals("남자")){
                //임시 아이디
                list.put("empl_gender",0);
            }else if(gender.equals("여")||gender.equals("여자")){
                list.put("empl_gender",1);
            }


            logger.info("list:{}",list);
            data_list.add(list);
        }

        logger.info("data_list:{}",data_list);


        if(employee_add_DAO.empl_add_all(data_list)>0){
            success = true;
        }

        return success;
    }

    public boolean if_member_exists(List<String> phone_numbers) {
        boolean exists = false;
        List<String> exist = new ArrayList<>();

        for(String phone_number: phone_numbers){
            if(employee_add_DAO.if_member_exists(phone_number)>0){
                exists = true;
            }
        }

        logger.info("exists:{}",exists);

        return exists;
    }
}
