package com.toast.rent.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.toast.rent.dto.ResourceDTO;

@Mapper
public interface ResourceDAO {

	
	//List<ResourceDTO> resourceList();

	
	//카테고리 목록 가져오기
	List<ResourceDTO> resourceCate();

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
	
	//카테고리 & 검색 목록 가져오기
	List<ResourceDTO> resourceSearchList(String option, String keyword,int limit, int offset);

}
