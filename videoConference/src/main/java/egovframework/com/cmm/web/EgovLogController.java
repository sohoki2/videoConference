package egovframework.com.cmm.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovLogManageService;
import egovframework.com.cmm.service.LoginLog;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;


@RestController
@RequestMapping("/backoffice/loginfo")
public class EgovLogController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLogController.class);
	
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
	private EgovLogManageService logservice;
	
	@RequestMapping(value="loginList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView selectLoginLogInfo(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                  , @ModelAttribute("searchVO") LoginLog searchVO
			                                                  , HttpServletRequest request
			                                                  , HttpServletResponse response
															  , BindingResult bindingResult
			                                                  )throws Exception{
		
		     ModelAndView mav = new ModelAndView("/backoffice/loginfo/loginList");
		     try{
		    	 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			     if(!isAuthenticated) {
			    	    mav.addObject("message", egovMessageSource.getMessage("fail.common.login"));
			    	    mav.setViewName("/backoffice/login");
			    		return mav;
			     }else{
			    	 /** pageing */       
			    	 mav = logservice.selectLoginLogInfo( searchVO);
					 
			     }
		     }catch(Exception e){
		    	 LOGGER.debug("selectLoginLogInfo error: " + e.toString());
		    	  throw e;
		     }
		     return mav;
	}
}
