package com.toast.rent.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.rent.dto.ResourceDTO;
import com.toast.rent.dto.ResourcePhotoDTO;

@Mapper
public interface ResourceDAO {

	
	//List<ResourceDTO> resourceList();

	//사원정보 가져오기
	int getEmpl(String loginId);
	
	//카테고리 목록 가져오기
	List<ResourceDTO> resourceCate();
	
	//카테고리 검색
	Map<String, Object> categroySearch(String keyword);

	//총 페이지
	int allCount(int cnt);

	//물품 목록 가져오기
	List<ResourceDTO> resourceList(int limit, int offset);

	//카테고리별 페이지
	int filterListCount(int cnt, String category);

	//카테고리별 목록 가져오기
	List<ResourceDTO> resourceFilterList(String category,int limit, int offset);

	//카테고리 & 검색 총 페이지
	int allSearchCount(int cnt, String option, String keyword);
	
	//전체보기 카테고리 & 검색 목록 가져오기
	List<ResourceDTO> resourceSearchList(String option, String keyword,int limit, int offset);

	//카테고리 선택 & 검색 페이지
	int filterSearchCount(int cnt, String option, String keyword, String category);

	//카테고리 선택 & 검색 목록 가져오기
	List<ResourceDTO> filterSearchList(String option, String keyword, String category, int limit, int offset);
	
	//물품 상세보기
	ResourceDTO prodDetail(int prod_idx);
	
	//물품 대여상태 보기
	ResourceDTO prodRentDetail(int prod_idx);

	//물품 대여 신청
	int rentRequest(ResourceDTO dto);

	//물품 대여 상태 업뎃
	int updateRentState(ResourceDTO dto);

	//내 대여 기록 가져오기
	List<ResourceDTO> myRentList(int empl_idx);

	//내 대여 총 페이지
	int myAllCount(int cnt, int empl_idx);

	//내 대여 총 리스트
	List<ResourceDTO> myProdList(int empl_idx, int limit, int offset);

	//내 반납 총 페이지
	int myReturnListCount(Map<String, Integer> map);

	//내 반납 총 리스트
	List<ResourceDTO> myReturnList(Map<String, Integer> map);

	//내 대여 상세보기
	ResourceDTO myRentDetail(int prod_rent_idx);

	//파일키 가져오기
	List<String> getProdFileKey(int prod_idx);

	//물품 파일 가져오기
	ResourcePhotoDTO prodFile(String file_key);

	//물품 idx가져오기
	int getIdx(int prod_rent_idx);

	

	


}
