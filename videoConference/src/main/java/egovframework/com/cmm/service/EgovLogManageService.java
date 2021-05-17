package egovframework.com.cmm.service;

import org.springframework.web.servlet.ModelAndView;

public interface EgovLogManageService {
	
	//public List selectLoginLogInfo(LoginLog searchVO) throws Exception;
	
	public ModelAndView selectLoginLogInfo( LoginLog searchVO) throws Exception;
	
	public int logInsertLoginLog(LoginLog vo  ) throws Exception;
	
	
}
