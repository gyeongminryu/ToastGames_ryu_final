package com.toast.management.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.toast.management.dao.ProjectDAO;
import com.toast.management.dto.ProjectInfoDTO;
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

	public void projectTeamAddDo(Map<String, String> param) {
		
		projectDAO.projectTeamAddDo(param);
	}

	public void projectTeamDetail(String team_idx,Model model) {
		// project history
		
		
		// project info 
		ProjectInfoDTO team_info =projectDAO.projectTeamInfo(team_idx);
		model.addAttribute("team_info",team_info);
		
		// project member
		
		
	}

}
