package com.sohoki.smartoffice.front.sts.res.service;

import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

public interface ResManageService {
	
	ModelAndView selectResManageListByPagination (Map<String, Object> params) throws Exception;
}
