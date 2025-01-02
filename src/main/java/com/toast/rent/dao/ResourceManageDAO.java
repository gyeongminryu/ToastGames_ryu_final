package com.toast.rent.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.rent.dto.ResourceManageDTO;
import com.toast.rent.dto.ResourcePhotoDTO;

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


}
