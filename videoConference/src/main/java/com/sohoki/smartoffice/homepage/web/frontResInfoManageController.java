package com.sohoki.smartoffice.homepage.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;

import egovframework.com.cmm.service.Globals;

@RestController
@RequestMapping("/web")
public class frontResInfoManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(frontResInfoManageController.class);
	
	@Autowired
	private EmpInfoManageService empInfo;
	
	//로그인 페이지로 이동 
	@RequestMapping(value="Login.do")
	public ModelAndView actionLogin(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
                                    , HttpServletRequest request
			    		            , HttpSession session
			    	                , BindingResult bindingResult) throws Exception {
		
		ModelAndView mav = new ModelAndView();
    	
    	String empno = (String) request.getSession().getAttribute("empno");
		LOGGER.debug("-----------------------------------------------------------------");
    	if(empno != null){
    		mav.setViewName("/web/index");
    	}else{
    		mav.setViewName("/web/login");
    	}
    	return mav;	
    }
	//회원 가입 페이지로 이동 
	@RequestMapping(value="Join.do")
	public ModelAndView actionJoin(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
                                         , HttpServletResponse response
			    		                 , HttpServletRequest request
			    		                 , BindingResult bindingResult
			    		                 , ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView("/web/join");
    	return mav;	
    }
	@RequestMapping(value="JoinProcess.do")
	public ModelAndView actionJoinProcess(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
                                         , HttpServletResponse response
			    		                 , HttpServletRequest request
			    		                 , BindingResult bindingResult
			    		                 , ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView(Globals.JSONVIEW);
		try {
			
		}catch(Exception e) {
			
		}
    	return mav;	
    }
	@RequestMapping(value="uniCheck.do")
	public ModelAndView actionUniCheck(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
                                         , HttpServletResponse response
			    		                 , HttpServletRequest request
			    		                 , BindingResult bindingResult
			    		                 , ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView(Globals.JSONVIEW);
		try {
			
		}catch(Exception e) {
			
		}
    	return mav;	
    }
	@RequestMapping(value="LoginCheck.do")
	public ModelAndView actionLoginProcess(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			    		                 , HttpServletRequest request
			    		                 , BindingResult bindingResult
			    		                 , ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView("/web/join");
		try {
			
			
		}catch(Exception e) {
			
		}
    	return mav;	
    }
	
	
}
