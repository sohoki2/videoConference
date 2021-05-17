package egovframework.let.uat.uia.web;


import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.AdminLoginVO;

//import egovframework.let.sym.log.clg.service.EgovLoginLogService;
//import egovframework.let.sym.log.clg.service.LoginLog;

import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.let.utl.sim.service.EgovClntInfo;
import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.trace.LeaveaTrace;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.support.WebApplicationContextUtils;

@Controller
public class EgovLoginController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLoginController.class);
	
	
    /** EgovLoginService */
	@Autowired
    private EgovLoginService loginService;

	/** EgovMessageSource */
    @Autowired
    EgovMessageSource egovMessageSource;


	/** EgovPropertyService */
    @Autowired
    protected EgovPropertyService propertiesService;
    
    

    /** TRACE */
    @Resource(name="leaveaTrace")
    LeaveaTrace leaveaTrace;
    
	/*@Resource(name="EgovLoginLogService")
	private EgovLoginLogService loginLogService;    */
    /**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
    @RequestMapping(value="/backoffice/login.do")
	public String loginUsrView(@ModelAttribute("adminLoginVO") AdminLoginVO adminLoginVO,
											HttpServletRequest request,
											HttpServletResponse response,
											ModelMap model) throws Exception {
    	
    	return "/backoffice/login";
	}
    /**
	 * 일반(스프링 시큐리티) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */    
    @RequestMapping(value="/backoffice/SecurityLogin.do")
    public String actionSecurityLogin(@ModelAttribute("AdminLoginVO") AdminLoginVO adminLoginVO, 
    		                                           HttpServletResponse response,
						    		                   HttpServletRequest request,
						    		                   ModelMap model) throws Exception {

    	// 접속IP
    	String userIp = EgovClntInfo.getClntIP(request);
        
    	
    
    	AdminLoginVO resultVO = loginService.actionLogin(adminLoginVO);   
    	
    	boolean loginPolicyYn = true;
    	
    	LOGGER.debug("======================================================");
        if (resultVO != null && resultVO.getAdminId() != null && loginPolicyYn) {
        	
            // 2. spring security 연동        
        	request.getSession().setAttribute("AdminLoginVO", resultVO);
        	UsernamePasswordAuthenticationFilter springSecurity = null;
        	ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
        	Map<String, UsernamePasswordAuthenticationFilter> beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
        	
        	
        	if (beans.size() > 0) {
        		springSecurity = (UsernamePasswordAuthenticationFilter)beans.values().toArray()[0];
        		springSecurity.setUsernameParameter("egov_security_username");
        		springSecurity.setPasswordParameter("egov_security_password");
        		springSecurity.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(request.getServletContext().getContextPath() +"/egov_security_login", "POST"));
        	} else {
        		throw new IllegalStateException("No AuthenticationProcessingFilter");
        	}
        	springSecurity.setContinueChainBeforeSuccessfulAuthentication(false);	// false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)
        	
            try{
            	LOGGER.debug("======================================================1");
            	//여기 부분 다시 확인 필요
            	springSecurity.doFilter(new RequestWrapperForSecurity(request, resultVO.getAdminName() + resultVO.getAdminId() , resultVO.getAdminId()), response, null);
            	
            	Authentication authentication = new UsernamePasswordAuthenticationToken(resultVO.getAdminId(), "USER_PASSWORD");   
            	SecurityContext securityContext = SecurityContextHolder.getContext();
                securityContext.setAuthentication(authentication);
                HttpSession session = request.getSession(true);
            	
                resultVO.setIp(EgovClntInfo.getClntIP(request));
                //날짜 체크 이후 값 확인 하기 
                String currentDay = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
                
                
            	 /*if ( Integer.valueOf(resultVO.getUpdatePassword()) < Integer.valueOf(currentDay) ){
                 	model.addAttribute("message", "패스워드가 만료 되었습니다.");
                 	return "forward:/backoffice/basicManage/passChangeView.do";
                 }else {*/
            	
            	
                	model.addAttribute("message", "login_ok"); 
                	LOGGER.debug("======================================================2");
                 	return "forward:/backoffice/actionMain.do";	// 성공 시 페이지.. (redirect 불가)
                 //}
            }catch (Exception e1){
            	LOGGER.debug("login Error:" + e1.toString());
            	return "/backoffice/login";
            }
           
        } else {
        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "/backoffice/login";
        }
    }

    
    /**
	 * 로그인 후 메인화면으로 들어간다
	 * @param
	 * @return 로그인 페이지
	 * @exception Exception
	 */
    @RequestMapping(value="/backoffice/actionMain.do")
	public String actionMain( HttpServletRequest request, ModelMap model)  {
    	try{
    		
    		// 1. Spring Security 사용자권한 처리
		    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    	if(!isAuthenticated) {
	    		LOGGER.debug("=== fail:" + isAuthenticated);
	    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
	    		return "/backoffice/login";
	    	}
	    	
	    	HttpSession httpSession = request.getSession(true);
	    	AdminLoginVO loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
	    	loginVO.setIp(EgovClntInfo.getClntIP(request));
	    	
	    	
	  		
	    	return "forward:/backoffice/resManage/resList.do?searchRoomType=swc_gubun_1";
    	} catch(Exception e){
    		LOGGER.debug("login Error:" + e.toString());
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "/backoffice/login";
    	}		    	
	}

    /**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/backoffice/actionLogout.do")
	public String actionLogout(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	String returnUrl = "";
    	
    	LOGGER.debug(request.getHeader("referer"));
    	if(request.getHeader("referer").contains("backoffice"))	{
    		returnUrl = "redirect:/backoffice/login.do";
    		request.getSession().setAttribute("AdminLoginVO", null);
    	} else {
    		returnUrl = "redirect:/front/login.do";
    		request.getSession().setAttribute("empInfoVO", null);
    	}
    	
    	return returnUrl;
    }
}
class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);

		this.username = username;
		this.password = password;
	}
	
	@Override
	public String getServletPath() {		
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/egov_security_login";
	}

	@Override
	public String getRequestURI() {		
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/egov_security_login";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("egov_security_username")) {
			return username;
		}

		if (name.equals("egov_security_password")) {
			return password;
		}

		return super.getParameter(name);
	}
}