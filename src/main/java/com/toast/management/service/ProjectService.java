package com.toast.management.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.management.dao.ProjectDAO;
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

}
