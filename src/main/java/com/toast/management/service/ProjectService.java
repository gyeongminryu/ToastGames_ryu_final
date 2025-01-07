package com.toast.management.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.toast.management.dao.ProjectDAO;
import com.toast.management.dto.EmployeeDetailDTO;
import com.toast.management.dto.ProjectInfoDTO;
import com.toast.management.dto.ProjectMemberDetailDTO;
import com.toast.management.dto.TeamListDTO;

@Service
public class ProjectService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ProjectDAO projectDAO;
	
	public ProjectService(ProjectDAO projectDAO) {
		this.projectDAO = projectDAO;
	}

	public List<TeamListDTO> searchTeamlist(String teamName, String teamHead) {
		List<TeamListDTO> tema_list = new ArrayList();
		
		 if (teamName != null && !teamName.isEmpty()) {
			 tema_list = projectDAO.searchByTeamName(teamName);
		    } else if (teamHead != null && !teamHead.isEmpty()) {
		    	tema_list =  projectDAO.searchByTeamHead(teamHead);
		    } else {
		    	tema_list = projectDAO.getAllTeams();
		    }
		return tema_list;
	}
	// projectTeamMemberAdd
	public void projectTeamAddDo(Map<String, String> param) {
		
		projectDAO.projectTeamAddDo(param);
	}

	public void projectTeamDetail(String team_idx,Model model) {
		
		// project history 팀장 변경이력? 가져온 team_head_idx로 사원정보 가져오기?
		List<ProjectInfoDTO> team_his = projectDAO.projectHistoty(team_idx);
		for (ProjectInfoDTO projectInfoDTO : team_his) {
			String head_idx =projectInfoDTO.getTeam_head_idx();
			EmployeeDetailDTO member_detail =projectDAO.teammemberdetail(head_idx);
			String head_name =	member_detail.getEmpl_name();
			String head_dept_name =	member_detail.getDept_name();
			String head_position_name =	member_detail.getPosition_name();
			projectInfoDTO.setHead_position_name(head_position_name);
			projectInfoDTO.setHead_name(head_name);
			projectInfoDTO.setHead_dept_name(head_dept_name);
		}
		model.addAttribute("team_his",team_his);
		// project info 팀 상세정보 - 이름 팀장정보 팀원수
		ProjectInfoDTO team_info =projectDAO.projectTeamInfo(team_idx);
		model.addAttribute("team_info",team_info);
		
		// project member 팀원 목록 보여주기
		
		
	}

	public void projectTeamMemberAdd(List<Integer> members, String team_idx) {
		// 중복값 제거
		 List<Integer> uniqueMembers = new ArrayList<>(new HashSet<>(members));
		for (Integer integer : uniqueMembers) {
			projectDAO.projectTeamMemberAdd(integer,team_idx);
		}
		
	}
	
	// 프로젝트 팀원 목록 가져오는 서비스
	public void projectTeamMemberList(String team_idx, Model model) {
		
		List<ProjectMemberDetailDTO> team_members =	projectDAO.projectTeamMemberList(team_idx);
		model.addAttribute("team_members",team_members);
	}

	public void removeTeamMember(String member_idx, String team_idx) {
		projectDAO.removeTeamMember(member_idx,team_idx);
		
	}

	public void projectTeamUpdateDo(Map<String, String> param) {
		projectDAO.projectTeamUpdateDo(param);
		
	}

	public List<ProjectMemberDetailDTO> searchProjectTeamMembers(String team_idx, String category, String keyword) {
		// TODO Auto-generated method stub
		return projectDAO.searchProjectTeamMembers(team_idx,category,keyword);
	}

}
