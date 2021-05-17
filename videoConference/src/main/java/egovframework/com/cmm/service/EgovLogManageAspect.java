package egovframework.com.cmm.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.AdminLoginVO;


public class EgovLogManageAspect {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLogManageAspect.class);
	  @Autowired
	  private EgovLogManageService logManageService;
	 
	  /**
	   * 로그인 로그정보를 생성한다.
	   * EgovLoginController.actionMain Method
	   * 
	   * @param 
	   * @return void
	   * @throws Exception 
	   */
	  public void logLogin() throws Throwable {
	 
	      String uniqId = "";
	      String ip = "";
	      /* Authenticated  */
	      Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	      if(isAuthenticated.booleanValue()) {
		      AdminLoginVO user = (AdminLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		      uniqId = user.getAdminId();
		      ip = user.getIp() == null ? "": user.getIp();
	      }
	      /*
	      LoginLog loginLog = new LoginLog();
	      loginLog.setConnectId(uniqId);
          loginLog.setConnectIp(ip);
          loginLog.setConnectMthd("I"); // 로그인:I, 로그아웃:O
          loginLog.setErrorOccrrAt("N");
          loginLog.setErrorCode("");
          logManageService.logInsertLoginLog(loginLog);
          */
	 
	  }
	 
	  /**
	   * 로그아웃 로그정보를 생성한다.
	   * EgovLoginController.actionLogout Method
	   * 
	   * @param 
	   * @return void
	   * @throws Exception 
	   */
	  public void logLogout() throws Throwable {
	 
	      String uniqId = "";
	      String ip = "";
	 
	      LOGGER.debug("-------------------------------------------------------------------------------LOGGOUT CHECK");
	      /* Authenticated  */
	      Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	      if(isAuthenticated.booleanValue()) {
		      AdminLoginVO user = (AdminLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		      uniqId = user.getAdminId();
		      ip = user.getIp();
	      }
	 
	      LoginLog loginLog = new LoginLog();
	      loginLog.setConnectId(uniqId);
          loginLog.setConnectIp(ip);
          loginLog.setConnectMthd("O"); // 로그인:I, 로그아웃:O
          loginLog.setErrorOccrrAt("N");
          loginLog.setErrorCode("");
          logManageService.logInsertLoginLog(loginLog);
	  }
}
