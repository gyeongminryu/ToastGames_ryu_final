package com.toast.employee_add.controller;

import com.toast.dataconfig.DataConfig;
import com.toast.employee_add.service.EmployeeAddService;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class EmployeeAddController {


    private final EmployeeAddService employeeAddService;
    Logger logger = LoggerFactory.getLogger(getClass());


    private final EmployeeAddService employeeService;
    private final DataConfig dataConfig;


    public EmployeeAddController(EmployeeAddService employeeService, DataConfig dataConfig, EmployeeAddService employeeAddService) {this.employeeService = employeeService;this.dataConfig = dataConfig;
        this.employeeAddService = employeeAddService;
    }

    @RequestMapping (value = "/employee_add_all.go")
    public String main() {
        return "manage_employee_regist_multiple";
    }

    //엑셀 읽는 함수
    @RequestMapping(value = "/manage_employee_regist_insert.do")
    public String readExcel(@RequestParam MultipartFile file, Model model) throws IOException, IOException {


        //파일 확장명 찾기
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        logger.info(extension);
        Workbook workbook = null;
        String page = "manage_employee_regist_insert";
        String msg = "";

        try {
//			//Workbook : 엑셀 상위
            if(extension.equals("xlsx")) { //2007 이상 버전
                logger.info("xlsx 파일");
                workbook = new XSSFWorkbook(file.getInputStream());


                //logger.info("함수 밖에서 확인한 dataList:{}",make_dataList(workbook,file));

                //서비스 단에 dataList 전달해서 insert
                //employeeService.saveExcel(make_dataList(workbook,file));
               make_dataList(workbook,file);
               model.addAttribute("data",data_list);//make_dataList(workbook,file)
               model.addAttribute("data_col_names",data_col_names);
               model.addAttribute("row_length",row_length);
                model.addAttribute("col_length",col_length);


            } else if(extension.equals("xls")) {
                logger.info("xls 파일");
                workbook = new HSSFWorkbook();
                //logger.info("함수 밖에서 확인한 dataList:{}",make_dataList(workbook,file));
                make_dataList(workbook,file);

                //서비스 단에 dataList 전달해서 insert
                //employeeService.saveExcel(make_dataList(workbook,file));
                model.addAttribute("data",make_dataList(workbook,file));
                model.addAttribute("data_col_names",data_col_names);
                model.addAttribute("row_length",row_length);
                model.addAttribute("col_length",col_length);



            }else{
                logger.info("올바른 형태의 파일이 아닙니다.");
                msg = "올바른 형태의 파일이 아닙니다.";

                model.addAttribute("msg",msg);
                logger.info("msg:{}",msg);

                page = "manage_employee_regist_multiple"; //alert 내용 전달하려면 redirect (x), excel로
            }

        } catch (Exception e) {
            logger.error("파일 처리 중 오류가 발생했습니다.", e);
        }finally {
            //xlsx와 xls가 아닌 파일 업로드 때는 close가 안되게 해야함 -> 아니면 에러 생김

            if(workbook != null) {			//workbook이 null이 아닌 경우에만 close
                workbook.close();
                logger.info("workbook 닫힘");
            }
        }
        logger.info("page:{}",page);
        return page;
    }






    List<Map<String, Object>> data_list = new ArrayList<>();
    List<Map<String, Object>> data_col_names = new ArrayList<>();
    int row_length = 0;
    int col_length = 0;

    //엑셀 읽어서 전달할 파라메터(데이터 리스트) 만드는 함수
    private List<Map<String, Object>> make_dataList(Workbook workbook, MultipartFile file) {
        data_list.clear(); //초기화-> 이거 안해주면 초기화가 안되어서 두번 출력됨 (logger에서 찍어줘서 그런 듯)
        data_col_names.clear(); //초기화 -> 이거 안해주면 초기화가 안되어서 두번 출력됨 (logger에서 찍어줘서 그런 듯)

        //DB 내 이름과 양식 명 이름 매칭을 위한 값
        Map<String, String> colname = new HashMap<String, String>();
        colname.put("이름", "empl_name");
        colname.put("비밀번호", "empl_pw");
        colname.put("성별", "empl_gender");
        colname.put("생년월일", "empl_birth");
        colname.put("주민등록번호 앞자리", "empl_ssn1");
        colname.put("주민등록번호 뒷자리", "empl_ssn2");

        /* 필요 없음 - 빼기
        colname.put("아이디", "empl_id");
        colname.put("급여 입금 계좌", "empl_account");
        colname.put("은행 명", "empl_bank_idx");

        colname.put("사내 이메일", "empl_cmp_email");
        colname.put("사내 유선번호", "empl_cmp_phone");
        colname.put("근무상태", "empl_emp_state"); //기본값 가발령

        */

        colname.put("개인 이메일", "empl_per_email");
        colname.put("개인 전화번호", "empl_per_phone");
        colname.put("주소", "empl_addr");


        colname.put("입사일", "empl_join_date");
        colname.put("직무", "empl_job");

        Sheet worksheet = workbook.getSheetAt(0); //엑셀 파일 내에서 시트가 여러개일 수 있다는 가정 하에
        logger.info("worksheet:{}",worksheet);
        logger.info("worksheet row:{}",worksheet.getPhysicalNumberOfRows());

        Row first_row = worksheet.getRow(0);
        logger.info("first_row:{}",first_row);
        logger.info("first_row col:{}",first_row.getPhysicalNumberOfCells());




        //i = 행
        //j = 열


        row_length = worksheet.getPhysicalNumberOfRows();
        col_length = first_row.getPhysicalNumberOfCells();
        for(int i = 0; i<worksheet.getPhysicalNumberOfRows();i++) {


            logger.info("새로운 행 시작");
            logger.info("새로운 행 시작 dataList 확인:{}",data_list);
            Map<String, Object> data = new LinkedHashMap<>(); //할때마다 계속 새로운 map 생성하게?
            //파라메터 값이 순서대로 안들어가는 문제 발생 -> HashMap에서 LinkedHashMap

            if(i==0){
                data_col_names.add(data);//열 이름 가져와서 동적으로 표 구성하게끔 구성
            }else{
                data_list.add(data);
            }





            for(int j=0; j< first_row.getPhysicalNumberOfCells();j++) {

                    logger.info("first_row_value:{}", first_row.getCell(j).getStringCellValue());

                    String col_value= colname.get(first_row.getCell(j).getStringCellValue());
                    Cell cell_value = null;

                    Row row = worksheet.getRow(i);
                    // logger.info("row:{}",row);

                    cell_value = row.getCell(j);
                    logger.info("cell_value:{}", cell_value);

                    // getStringValue처럼 데이터 형태를 지정하지 않고 값을 가져오는 방법
                    logger.info("value의 데이터 형태값:{}", cell_value.getCellType());



                    //first_row_value를 꺼낸 것을 map에서 넣은 후 값을 꺼내어 넣기
                    switch (cell_value.getCellType()) {
                        case STRING:
                            logger.info("String 데이터 타입");
                            data.put(col_value, String.valueOf(cell_value));
                            logger.info("data 들어갔는지 확인:{}", data);

                            break;

                        case NUMERIC:
                            logger.info("NUMERIC 데이터 타입");
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            logger.info("cell_value.getDateCellValue:{}",cell_value.getDateCellValue());

                            //엑셀에서 DATE 형식 포맷해서 가져오는 법 : https://m.blog.naver.com/wlstjrk00/221173556075
                            data.put(col_value, String.valueOf(sdf.format(cell_value.getDateCellValue())));
                            logger.info("data 들어갔는지 확인:{}", data);

                            break;

                        default:
                            logger.info("데이터 타입 확인 완료");
                            break;
                    }

            }
        }
        logger.info("함수 안에서 확인한 dataList:{}",data_list);
        logger.info("함수 안에서 확인한 data_colname:{}",data_col_names);
        return data_list; //위에 코드에 완성된 dataList 전달
    }



    //일괄 등록 후 페이지에서 모든 값들 다 수정하고 DB에 insert 시켜주는 함수 + 패스워드/주민등록번호 암호화
    @RequestMapping (value="/empl_add_all.ajax")
    @ResponseBody
    public Map<String,Object> empl_add_all(@RequestBody Map<String,Object> param){
        logger.info("param:{}",param);
        logger.info("param:{}",param.get("list"));

        boolean success = false;
        List<Map<String,Object>> lists = (List<Map<String, Object>>) param.get("list");
        success = employeeAddService.empl_add_all(lists);


        //logger.info("data_list:{}",data_list);
        Map<String,Object> map = new HashMap<>();
        return map;
    }


    //일괄 등록 전 이미 존재하는 사원인지 확인하기

    @RequestMapping(value="/manage_if_member_exists.ajax")
    @ResponseBody
    public Map<String,Object> manage_if_member_exists(@RequestBody Map<String,Object> param){
        Map<String,Object> data = new HashMap<>();
        logger.info("param:{}",param);
        List<String> phone_numbers = (List<String>) param.get("phone_numbers");
        logger.info("phone:{}",phone_numbers);


        data.put("exists",employeeAddService.if_member_exists(phone_numbers));
        return data;
    }
}


