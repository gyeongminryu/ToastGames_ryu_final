package com.toast.management.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.toast.management.dto.TeamListDTO;

@Mapper
public interface ProjectDAO {

	List<TeamListDTO> searchByTeamName(String teamName);

	List<TeamListDTO> searchByTeamHead(String teamHead);

	List<TeamListDTO> getAllTeams();

}
