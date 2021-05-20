package com.sohoki.smartoffice.front.sts.res.web;

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

@RestController
@RequestMapping("/front")
public class frontResInfoManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(frontResInfoManageController.class);
	
	@Autowired
	private EmpInfoManageService empInfo;
	
	//로그인 페이지로 이동 
	@RequestMapping(value="Login.do")
	public ModelAndView actionSecurityLoginSSO(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
                                         , HttpServletResponse response
			    		                 , HttpServletRequest request
			    		                 , HttpSession session
			    		                 , BindingResult bindingResult
			    		                 , ModelMap model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
    	
    	String empno = (String) request.getSession().getAttribute("empno");
		
    	if(empno != null){
    		mav.setViewName("/front/index_main");
    	}else{
    		mav.setViewName("/front/login");
    	}
    	return mav;	
    }
	
	
}
