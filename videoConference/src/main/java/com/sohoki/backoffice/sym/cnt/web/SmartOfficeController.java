package com.sohoki.backoffice.sym.cnt.web;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.sym.log.annotation.NoLogging;

import egovframework.com.cmm.util.EgovUserDetailsHelper;

@RestController
public class SmartOfficeController {

	
	@NoLogging
	@RequestMapping(value="/backoffice/inc/top_inc.do")
	public ModelAndView nhisTop() throws Exception{		
		ModelAndView model = new ModelAndView();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		//System.out.println(" top ===============  isAuthenticated :  " + isAuthenticated);
		
		model.setViewName("/backoffice/inc/top_inc");
		return model;
	}
	@NoLogging
	@RequestMapping(value="/backoffice/inc/bottom_inc.do")	
	public ModelAndView nhisBottom() throws Exception{				
		ModelAndView model = new ModelAndView();
		
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		//System.out.println(" buttom ===============  isAuthenticated :  " + isAuthenticated);
		
		model.setViewName("/backoffice/inc/bottom_inc");
		return model;		
	}
}
