package com.toast.management.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.management.dto.EmployeeDetailDTO;
import com.toast.management.dto.ProjectInfoDTO;
import com.toast.management.dto.ProjectMemberDetailDTO;
import com.toast.management.dto.TeamListDTO;

@Mapper
public interface ProjectDAO {

	List<TeamListDTO> searchByTeamName(String teamName);

	List<TeamListDTO> searchByTeamHead(String teamHead);

	List<TeamListDTO> getAllTeams();

	int projectTeamAddDo(Map<String, String> param);

	ProjectInfoDTO projectTeamInfo(String team_idx);

	List<ProjectInfoDTO> projectHistoty(String team_idx);

	EmployeeDetailDTO teammemberdetail(String head_idx);

	int projectTeamMemberAdd(Integer integer, String team_idx);

	List<ProjectMemberDetailDTO> projectTeamMemberList(String team_idx);

	int removeTeamMember(String member_idx, String team_idx);

	int projectTeamUpdateDo(Map<String, String> param);

	List<ProjectMemberDetailDTO> searchProjectTeamMembers(String team_idx, String category, String keyword);

	List<TeamListDTO> searchDeptAllMember();

	

	

}
