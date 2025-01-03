package com.toast.document.service;

import com.toast.document.dao.ManageFormDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class ManageFormService {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final ManageFormDAO manageFormDAO;

    public ManageFormService(ManageFormDAO manageFormDAO) {
        this.manageFormDAO = manageFormDAO;
    }
}
