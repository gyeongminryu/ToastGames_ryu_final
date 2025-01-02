package com.toast.management.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.management.dto.ProjectInfoDTO;
import com.toast.management.dto.TeamListDTO;

@Mapper
public interface ProjectDAO {

	List<TeamListDTO> searchByTeamName(String teamName);

	List<TeamListDTO> searchByTeamHead(String teamHead);

	List<TeamListDTO> getAllTeams();

	int projectTeamAddDo(Map<String, String> param);

	ProjectInfoDTO projectTeamInfo(String team_idx);

	

}
