package com.sohoki.backoffice.sym.log.web;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.sohoki.backoffice.sym.log.service.EgovSysLogService;
import com.sohoki.backoffice.sym.log.vo.SysLog;
import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;


@RestController
@RequestMapping("/cmm/error")
public class CommonErrorController extends HttpServlet  {

	private static final Logger LOGGER = LoggerFactory.getLogger(CommonErrorController.class);
	
	@Autowired
	private EgovSysLogService sysLogService;
	
	
	
	@RequestMapping(value="throwable")
	public ModelAndView throwable(HttpServletRequest request){
		
		ModelAndView model = new ModelAndView();
		LOGGER.info("throwable");
		pageErrorLog(request);
		model.addObject("msg", "예외가 발생하였습니다");
		model.setViewName("/cmm/error/ErrorPage");
		return model;
		
	}
	@RequestMapping(value="egovError", method=RequestMethod.POST)
	public ModelAndView ErrorPage(HttpServletRequest request, Exception ex ){
		
		ModelAndView model = new ModelAndView();
		pageErrorLog(request);
		model.addObject("msg", "예외가 발생하였습니다");
		
		model.setViewName("/cmm/error/ErrorPage");
		return model;
		
	}
	
	
	@RequestMapping(value="exception.do")
	public ModelAndView exception(HttpServletRequest request){
		
		ModelAndView model = new ModelAndView();
		pageErrorLog(request);
		model.addObject("msg", "예외가 발생하였습니다");
		model.setViewName("/cmm/error/ErrorPage");
		return model;
		
	}
	@RequestMapping(value="400")
	public ModelAndView pageError400(HttpServletRequest request){
		
		ModelAndView model = new ModelAndView();
		
		pageErrorLog(request);
		model.addObject("msg", "잘못된 요청 입니다.");
		model.setViewName("/cmm/error/ErrorPage");
		return model;
		
	}
	@RequestMapping(value="403")
	public ModelAndView pageError403(HttpServletRequest request){
		
		ModelAndView model = new ModelAndView();
		pageErrorLog(request);
		model.addObject("msg", "접근이 금지되었습니다.");
		model.setViewName("/cmm/error/ErrorPage");
		return model;
		
	}
	@RequestMapping(value="500",method=RequestMethod.GET)
	public ModelAndView pageError500(HttpServletRequest request, Exception e){
		
		ModelAndView model = new ModelAndView();
		//pageErrorLog(request);
		model.addObject("msg", "예외가 발생하였습니다.");
		model.setViewName("/cmm/error/ErrorPage");
		 
		return model;
		
	}
	
	
	@RequestMapping(value="404", method=RequestMethod.GET)
	public ModelAndView pageError404(HttpServletRequest request, Exception e){
		 
		 pageErrorLog(request);
		 if (request.getAttribute("javax.servlet.error.request_uri").toString().contains("do") || request.getAttribute("javax.servlet.error.request_uri").toString().contains("jsp") ){
			 
			 
			 ModelAndView mav = new ModelAndView();
			 SysLog sysLog = new SysLog();
				
	    	 String uniqId = "";
	    	 String ip = "";
	         Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();	        
	        if(isAuthenticated.booleanValue()) {
	        		AdminLoginVO user = (AdminLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	    			uniqId = user.getAdminId();// .getUniqId();
	    			ip = user.getIp() == null ? "": user.getIp();
	         }
	        
	         sysLog.setErrorCode( request.getAttribute("javax.servlet.error.status_code").toString() );
			 sysLog.setSrvcNm(request.getAttribute("javax.servlet.error.servlet_name").toString());
	    	 sysLog.setMethodNm(request.getAttribute("javax.servlet.error.request_uri").toString());
	    	 sysLog.setProcessSeCode("E");
	    	 sysLog.setProcessTime("0");
	    	 sysLog.setRqesterId(uniqId);
	    	 sysLog.setRqesterIp(ip);
	    	 try {
		 			sysLogService.logInsertSysLog(sysLog);
		 	 } catch (Exception e1) {
		 			e1.printStackTrace();
		 	 }
	    	 sysLog = null;
	    	// goView로 이동 
	    	 mav.addObject("msg", "요청하신 페이지 또는 파일이 존재하지 않습니다.");
			 mav.setViewName("/cmm/error/egovError");
			 
			 return mav;
		 }
		 return null;
	}
	@RequestMapping(value="503")
	public ModelAndView pageError503(HttpServletRequest request){
		
		ModelAndView model = new ModelAndView();
		pageErrorLog(request);
		model.addObject("msg", "서버스를 사용할 수 없습니다.");
		model.setViewName("/cmm/error/ErrorPage");
		return model;
		
	}
	private void pageErrorLog(HttpServletRequest request){
		LOGGER.info("status_code:" + request.getAttribute("javax.servlet.error.status_code"));
		LOGGER.info("exception_type:" + request.getAttribute("javax.servlet.error.exception_type"));
		LOGGER.info("message:" + request.getAttribute("javax.servlet.error.message"));
		LOGGER.info("request_uri:" + request.getAttribute("javax.servlet.error.request_uri"));
		LOGGER.info("exception:" + request.getAttribute("javax.servlet.error.exception"));
		LOGGER.info("servlet_name:" + request.getAttribute("javax.servlet.error.servlet_name"));
	}
	
}
