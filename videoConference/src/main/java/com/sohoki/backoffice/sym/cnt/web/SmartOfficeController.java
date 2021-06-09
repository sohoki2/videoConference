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
	public ModelAndView smartworkTop() throws Exception{		
		ModelAndView model = new ModelAndView();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		//System.out.println(" top ===============  isAuthenticated :  " + isAuthenticated);
		
		model.setViewName("/backoffice/inc/top_inc");
		return model;
	}
	@NoLogging
	@RequestMapping(value="/backoffice/inc/bottom_inc.do")	
	public ModelAndView smartworkBottom() throws Exception{				
		ModelAndView model = new ModelAndView();
		
		
		model.setViewName("/backoffice/inc/bottom_inc");
		return model;		
	}
	@NoLogging
	@RequestMapping(value="/backoffice/inc/uni_pop.do")	
	public ModelAndView smartworkPop() throws Exception{				
		ModelAndView model = new ModelAndView();
		
		model.setViewName("/backoffice/inc/back_uniPop");
		return model;		
	}
}
