package com.toast.rent.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.rent.dto.ResourceManageDTO;
import com.toast.rent.dto.ResourcePhotoDTO;
import com.toast.schedule.dto.ScheduleDTO;

@Mapper
public interface ResourceManageDAO {

	//사원정보 가져오기
	ResourceManageDTO getEmplMg(String loginId);

	//카테고리 목록 가져오기
	List<ResourceManageDTO> resourceCateMg();
	
	//카테고리 검색
	Map<String, Object> categroySearch(String keyword);

	//총 페이지
	int allCount(int cnt);

	//물품 목록 가져오기
	List<ResourceManageDTO> resourceList(int limit, int offset);

	//카테고리별 페이지
	int filterListCount(int cnt, String category);

	//카테고리별 목록 가져오기
	List<ResourceManageDTO> resourceFilterList(String category,int limit, int offset);

	//카테고리 & 검색 총 페이지
	int allSearchCount(Map<String, Object> map);
	
	//전체보기 카테고리 & 검색 목록 가져오기
	List<ResourceManageDTO> resourceSearchList(Map<String, Object> map);

	//카테고리 선택 & 검색 페이지
	int filterSearchCount(Map<String, Object> map);

	//카테고리 선택 & 검색 목록 가져오기
	List<ResourceManageDTO> filterSearchList(Map<String, Object> map);

	//물품 사진 등록
	int prodFileAdd(ResourcePhotoDTO photo_dto);

	//물품 등록
	int prodWrite(ResourceManageDTO dto);
	
	//물품 대여상세 가져오기
	ResourceManageDTO prodMgDetail(int prod_idx);

	//물품 대여 사원정보가져오기
	ResourceManageDTO rentEmpl(int prod_rent_empl_idx);

	//물품 파일 가져오기
	List<ResourcePhotoDTO> prodMgFile(String file_key);

	//대여기록 총 페이지
	int allHisCount(int cnt, int prodIdx);

	//대여 기록 페이징
	List<ResourceManageDTO> rentManageList(int prodIdx,int limit, int offset);

	//대여 승인
	int permitProd(int prod_idx);

	//물품 대여 승인 상태 업뎃
	int permitProdState(int prod_rent_idx);
	
	//물품 반납
	int permitReturn(int prod_idx);

	//반납일시 입력
	int insertReturnDate(ResourceManageDTO dto);

	//물품 정보 가져오기
	ResourceManageDTO getProductinfo(int prod_idx);

	//물품 파일키 추가
	int prodFileKeyAdd(String fileKey,int prod_idx);

	//물품 정보 수정
	int prodUpdate(ResourceManageDTO dto);

	//물품 첨부파일 삭제
	int prodFileRemove(String fileKey);

	//파일키 가져오기
	String getProdFileKey(int prod_idx);

	//파일키 지우기
	int prodFileKeyRemove(int prod_idx, String fileKey);

	//반납예정일시
	LocalDateTime getExpDate(int prod_rent_idx);

	//반납일정 추가정보 가져오기
	ResourceManageDTO getReturnInfo(int prod_rent_idx);

	//반납 일정 추가(schedule)
	int insertReturnSchedule(ScheduleDTO scheduleReturn);

	//폐기물품 정보가져오기
	ResourceManageDTO prodInfo(int prod_idx);

	//물품 폐기 처리
	int prodDispo(ResourceManageDTO dto);

	//폐기처리 사진
	int dispFileKeyAdd(String fileKey,int prod_idx);

	//물품 사용불가처리
	int prodDispUpdate(int i, int j, int prod_idx);

	//인수자 부서 정보
	List<ResourceManageDTO> getDeptList();

	//인수자 팀 정보
	List<ResourceManageDTO> getTeamList();

	//부서별 인수자
	List<ResourceManageDTO> getDeptEmpl(int deptIdx);

	//팀별 인수자
	List<ResourceManageDTO> getTeamEmpl(int teamIdx);

	//팀장 인수자
	ResourceManageDTO getTeamHeadEmpl(int teamIdx);
	


	
	


}
