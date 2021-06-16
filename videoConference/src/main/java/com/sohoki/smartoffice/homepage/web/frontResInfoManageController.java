package com.sohoki.smartoffice.homepage.web;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.cus.com.servie.CompanyInfoManageService;
import com.sohoki.backoffice.cus.com.servie.UserInfoManageService;
import com.sohoki.backoffice.cus.com.vo.UserInfo;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.cus.ten.service.TennantInfoManageService;
import com.sohoki.backoffice.sts.res.service.ResInfoManageService;
import com.sohoki.backoffice.sts.res.service.TimeInfoManageService;
import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCode;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.sym.space.service.MeetingRoomInfoManageService;
import com.sohoki.backoffice.sym.space.service.OfficeSeatInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/web")
public class frontResInfoManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(frontResInfoManageController.class);
	
	
	@Autowired
	private EmpInfoManageService empService;
	
	@Autowired
	private UniSelectInfoManageService  uniService;
	
	@Autowired
	private UserInfoManageService    userService;
	
	@Autowired
	private FloorInfoManageService floorService;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
	private CenterInfoManageService centerService;
	
	@Autowired
	private MeetingRoomInfoManageService meetingService;
	
	@Autowired
	private TimeInfoManageService timeService;
	
	@Autowired
	private ResInfoManageService resService;
	
	@Autowired
	private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private CompanyInfoManageService companyService;
	
	@Autowired
	private TennantInfoManageService tennService;
	
	
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
	//사용자 로그인 프로세스
	@RequestMapping(value="LoginProcess.do")
	public ModelAndView actionUniCheck(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                           , @RequestBody Map<String, Object> params 
                                       , HttpServletRequest request
			    		               , BindingResult bindingResult) throws Exception {
		ModelAndView mav = new ModelAndView(Globals.JSONVIEW);
		try {
			//session은 EmpInfoVO 설정 
			String userIp = EgovClntInfo.getClntIP(request);
			
		
			EmpInfoVO resultVO = empService.selectEmpInfoLogin(params);;  
    		if (resultVO != null && resultVO.getEmpno() != null ) {

	        	request.getSession().setAttribute("empInfoVO", resultVO);
	        	mav.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
	        } else {
	        	LOGGER.debug("로그인 실패");
	        	mav.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);	
	        	mav.addObject(Globals.STATUS_MESSAGE, "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");
 	        }
		}catch(Exception e) {
			LOGGER.debug("로그인 실패");
			mav.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			mav.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
    	return mav;	
    }
	//sso 연동 
	@RequestMapping(value="SsoInfo.do")
	public ModelAndView actionSsoLogin(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                           , @RequestParam("empno") String empno 
                                       , HttpServletRequest request
			    		               , BindingResult bindingResult) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//session은 EmpInfoVO 설정 
			String userIp = EgovClntInfo.getClntIP(request);
			
		
			EmpInfoVO resultVO = empService.selectEmpInfoDetailNo(empno); 
    		if (resultVO != null && resultVO.getEmpno() != null ) {

	        	request.getSession().setAttribute("empInfoVO", resultVO);
	        	//mav.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
	        	mav.setViewName("redirect:/web/index.do");
	        } else {
	        	mav.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				mav.addObject(Globals.STATUS_MESSAGE, "잘못된 사번 입니다.");
	        	mav.setViewName("/web/Login");
 	        }
		}catch(Exception e) {
			LOGGER.debug("로그인 실패");
			mav.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			mav.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
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
			                              , @RequestBody UserInfo vo
			    		                  , HttpServletRequest request
			    		                  , BindingResult bindingResult) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			vo.setComCode("C_00000004");
			vo.setUserState("USER_STATE_1");
			int ret = userService.updateUserInfoManage(vo);
			String message = (vo.getMode().equals("Ins")) ? " 서울관광플라자에 오신걸 환영합니다<br/>회원가입을 완료 하였습니다" : "회원 정보가 수정 되었습니다";
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, message);
			}else {
				throw new Exception();
			}
		}catch(Exception e) {
			LOGGER.debug("actionJoinProcess error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
    	return model;	
    }
	@RequestMapping(value="passChange.do")
	public ModelAndView userPassChange(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
		                              , @RequestBody UserInfo vo
		    		                  , HttpServletRequest request
		    		                  , BindingResult bindingResult) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			String url = "/web/index";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		
		  		
		  		
		  		vo.setUserNo(empInfoVO.getEmpno());
		  		userService.updatePasswordChange(vo);
		  		
				if (vo.getResult() >0){
					model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
					model.addObject(Globals.STATUS_MESSAGE, "정상적으로 변경 되었습니다.");
				}else if (vo.getResult()== -1){
					model.addObject(Globals.STATUS  , Globals.STATUS_FAIL);
					model.addObject(Globals.STATUS_MESSAGE, "기존 패스워드가 일치 하지 않습니다");
				}else {
					throw new Exception();
				}
		  	}
			
		}catch(Exception e) {
			LOGGER.debug("actionJoinProcess error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
    	return model;	
    }
	
	//회원 탈퇴
	@RequestMapping(value="withdrawal.do")
	public ModelAndView actionWithdrawalProcess(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                                    , HttpServletRequest request
			    		                        , BindingResult bindingResult) throws Exception {
		ModelAndView mav = new ModelAndView(Globals.JSONVIEW);
		try {
			
			empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			String url = "/web/index";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		
		  		int ret = userService.deleteUserInfoManage(empInfoVO.getEmpno(), null);
		  		if (ret >0){
		  			request.getSession().setAttribute("empInfoVO", null);  
		  			mav.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
		  			mav.addObject(Globals.STATUS_MESSAGE, "정상적으로 회원 탈퇴 되셨습니다.");
				}else {
					throw new Exception();
				}
		  	}
		}catch(Exception e) {
			LOGGER.debug("actionJoinProcess error:"  + e.toString());
			mav.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			mav.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
    	return mav;	
    }
	
	@RequestMapping(value="Logout.do")
	public ModelAndView actionLogoutProcess(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                                , HttpServletRequest request
			    		                    , BindingResult bindingResult) throws Exception {
		ModelAndView mav = new ModelAndView(Globals.JSONVIEW);
		try {
			 request.getSession().setAttribute("empInfoVO", null);  
			 mav.setViewName("redirect:/web/Login.do");
		}catch(Exception e) {
			 LOGGER.error("actionLogoutProcess error:" + e.toString());
		}
    	return mav;	
    }
	@RequestMapping(value="userUniCheck.do")
	public ModelAndView userUniCheck(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                         , @RequestBody Map<String, Object> params 
                                     , HttpServletResponse response
			    		             , HttpServletRequest request
			    		             , BindingResult bindingResult) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			
			String result =  uniService.selectIdDoubleCheck("EMPNO", "tb_empInfo", "EMPNO=["+params.get("userId")+"[") > 0 ? Globals.STATUS_FAIL : Globals.STATUS_SUCCESS;
			model.addObject(Globals.STATUS, result);
		}catch(Exception e) {
			 LOGGER.error("actionLogoutProcess error:" + e.toString());
		}
    	return model;	
    }
	
	
	@NoLogging
	@RequestMapping(value="inc/top_inc.do")
	public ModelAndView webTop() throws Exception{		
		ModelAndView model = new ModelAndView();
		//다음주 설정 작업 예정 
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		//System.out.println(" top ===============  isAuthenticated :  " + isAuthenticated);
		
		model.setViewName("/web/inc/top_inc");
		return model;
	}
	//메세지 공용툴
	@NoLogging
	@RequestMapping(value="inc/unimessage.do")
	public ModelAndView unimessage() throws Exception{		
		ModelAndView model = new ModelAndView();
		//다음주 설정 작업 예정 
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		//System.out.println(" top ===============  isAuthenticated :  " + isAuthenticated);
		
		model.setViewName("/web/inc/uniMessage");
		return model;
	}
	@NoLogging
	@RequestMapping(value="inc/bottom_inc.do")	
	public ModelAndView webBottom() throws Exception{				
		ModelAndView model = new ModelAndView();
		
		
		
		
		model.setViewName("/web/inc/bottom_inc");
		return model;		
	}
	@NoLogging
	@RequestMapping(value="inc/right_menu.do")	
	public ModelAndView webRight() throws Exception{				
		ModelAndView model = new ModelAndView();
		
		
		model.setViewName("/web/inc/right_menu");
		return model;		
	}
	@RequestMapping(value="index.do")	
	public ModelAndView webIndex(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
					            , HttpServletRequest request
					            , BindingResult bindingResult) throws Exception{				
		ModelAndView model = new ModelAndView();
		
		
		empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		String url = "/web/index";
	  	if (empInfoVO.getEmpno() ==  null) {
	  		url = "/web/login";
	  	}else {
	  		//공지 및 
	  		
	  		HashMap<String, Object> params = new HashMap<String, Object>();
	  		if (util.NVL( params.get("centerId"), "").equals("") )
		  		params.put("centerId", "C21052601");
	  		params.put("authorCode", empInfoVO.getAuthorCode());
	  		params.put("comCode", empInfoVO.getComCode());
	  		params.put("searchResStartday", util.reqDay(0));
	  		
	  		//오늘날짜
	  		LOGGER.debug("centerId" +  params.get("centerId") + params.get("searchResStartday"));
			model.addObject(Globals.JSON_RETURN_RESULTLISR, resService.selectIndexList(params));
			model.addObject(Globals.JSON_RETURN_RESULT,  params);
		  	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	
		  	
	  	}
		model.setViewName(url);
		return model;		
	}
	//회의실 예약 부터 시작
	
	@RequestMapping(value="meetingDay.do")	
	public ModelAndView webMeetingInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                           , HttpServletRequest request
			                           , BindingResult bindingResult) throws Exception{				
	    ModelAndView model = new ModelAndView();
	    try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/meetingDay";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		LOGGER.debug("---------------------------------------------------");
		  		Map<String, Object> params = new HashMap<String, Object>();
		  		if (util.NVL( params.get("centerId"), "").equals("") )
			  		params.put("centerId", "C21052601");
			  	HashMap<String, Object> reginfo = new HashMap<String, Object>();
			  	reginfo.put("centerId", params.get("centerId").toString());
			  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
			  	params.put("searchFloor", "MEETING");
			  	params.put("authorCode", empInfoVO.getAuthorCode());
			  	params.put("comCode", empInfoVO.getComCode());
			  	
			  	reginfo.put("itemGubun", "ITEM_GUBUN_1");
			  	reginfo.put("searchRoomType", "SWC_GUBUN_1");
			  	
			  	List<Map<String,Object>> floorList = floorService.selectFloorInfoManageListByPagination(params);
			  	if (floorList.size() > 0) {
			  		String floorSeq = floorList.get(0).get("floor_seq").toString();
				  	model.addObject("floorinfo", floorList);
				  	//기초 정리 하기 
				  	String searchDay = util.reqDay(0);
				  	reginfo.put("floorSeq", floorSeq);
				  	reginfo.put("centerId", params.get("centerId").toString());
				  	reginfo.put("searchResStartday", searchDay);
				  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
			  	}else {
			  		model.addObject(Globals.STATUS, Globals.STATUS_FAILLACK);
			  		model.addObject(Globals.STATUS_MESSAGE, "적용되는 시설물이 없습니다.");
			  	}
			  	
		  	}
		  	model.setViewName(url);
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMeetingInfo error:" + e.toString() + ":" + lineNumber);
	    	
	    }
	    return model;
	
		
	}
	//회의실 예약 부터 시작
	@RequestMapping(value="meetingDayAjax.do")	
	public ModelAndView webMeetingAjaxInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                               , @RequestBody Map<String, Object> params
				                           , HttpServletRequest request
				                           , BindingResult bindingResult) throws Exception{				
	    ModelAndView model = new ModelAndView(Globals.JSONVIEW);
	    try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/meetingDay";
		  	if (empInfoVO.getEmpno() ==  null) {
				model.addObject(Globals.STATUS_MESSAGE, "세션이 만료 되었습니다.");
 	    		model.addObject(Globals.STATUS,  Globals.STATUS_LOGINFAIL);
 	    		return model;	
		  	}else {
		  		if (util.NVL( params.get("searchCenterId"), "").equals("") )
			  		params.put("searchCenterId", "C21052601");
		  		
			  	String searchDay = util.NVL(params.get("searchResStartday"), "").equals("")  ? util.reqDay(0)  : params.get("searchResStartday").toString();
			  	//기초 데이터 넣기 
			  	params.put("searchResStartday", searchDay);
			  	
			  	List<Map<String, Object>> seatListVOs = meetingService.selectMeetingRoomEmptyManageList(params);
				for (Map<String, Object>  seatinfoVO : seatListVOs) {
					Map<String, Object> searchTime = new HashMap<String, Object>();
					searchTime.put("itemId", seatinfoVO.get("meeting_id").toString());
					searchTime.put("swcResday", searchDay);
					List<Map<String, Object>> timeInfos = timeService.selectSTimeInfoBarList(searchTime);						
					seatinfoVO.put("timeInfo", timeInfos);
				}
				model.addObject("seatInfo", seatListVOs);
				model.addObject(Globals.JSON_RETURN_RESULT,  params);
			  	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			  	
			  	
		  	}
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
	      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("error:" + e.toString() + ":" + lineNumber);
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, e.toString());
			model.addObject("seatInfo", null);
	    }
	    return model;
	
		
	}
	// 시간 콤보 보여주기 
	@RequestMapping(value="resSeatTime.do")
	public ModelAndView selectResInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
									  , @RequestBody Map<String, Object> searchVO
									  , HttpServletRequest request
									  , BindingResult bindingResult	) throws Exception {
								
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			String nowData = "";
			LOGGER.debug("----------------------------------" +searchVO.get("searchResStartday").toString());
			if (searchVO.get("searchResStartday").toString().equals(util.reqDay(0))) {
				nowData = LocalDateTime.now().format(DateTimeFormatter.ofPattern("HHmm"));
			}else {
				nowData = "0800";
			}
			LOGGER.debug("nowData:" + nowData);
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("code", "SWC_TIME");
			params.put("nowData", nowData);
			List<CmmnDetailCode> list = cmmnDetailService.selectCmmnDetailComboEtc(params);
			model.addObject("resStartTime", list);
			model.addObject("resEndTime", list);
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info("error:" + e.toString() + ":" +  ste[0].getLineNumber());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
	}
	//좌석 예약 리스트
	@RequestMapping(value="resSeatResult.do")
	public ModelAndView selectSeatList(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
									   , @RequestBody Map<String, Object> searchVO
									   , HttpServletRequest request
									   , BindingResult bindingResult	) throws Exception {
								
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			model.addObject(Globals.JSON_RETURN_RESULTLISR,  timeService.selectSeatSearchResult(searchVO));
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info("error:" + e.toString() + ":" +  ste[0].getLineNumber());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
	}
	
	//회의실 예약 
	@RequestMapping(value="resInfo.do")
	public ModelAndView selectResInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
									  , @RequestBody ResInfoVO searchVO
									  , HttpServletRequest request
									  , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);		
		try{
			
			//SSO 관련 내용 넣기  
			EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
 	    		model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
 	    		return model;				
			}
			
			
			if (!searchVO.getResSeq().equals("0")){
				
				Map<String, Object> resInfo = resService.selectResManageView(searchVO.getResSeq());
				
				model.addObject("resInfo", resInfo);
				//참석자
				LOGGER.debug("resInfo.getResAttendlist():" + resInfo.get("res_attendlist"));
				if (! util.NVL(resInfo.get("res_attendlist"), "").equals("")){
					List<String> empNoList =  Arrays.asList(resInfo.get("res_attendlist").toString().split("\\s*,\\s*"));
					LOGGER.debug("empNoList:" + empNoList.size());
					model.addObject("resUserList", empService.selectMeetinngUserList(empNoList));
					
				}
				//영상회의 이면 
				if (resInfo.get("res_gubun").toString().equals("SWC_GUBUN_2") && !util.NVL(resInfo.get("meeting_seq"), "").equals("")){
					List<String> swSeqList =   util.dotToList(resInfo.get("meeting_seq").toString() );
					model.addObject("resRoomInfo", meetingService.selectConferenceList(swSeqList));
				}
			}else {
				
				//좌석 일반 공용으로 쓸려고 만듬 
				String resStartDay = util.NVL(searchVO.getResStartday(), util.reqDay(0)) ;
				String nowData  = resStartDay.equals( util.reqDay(0)) ?  LocalDateTime.now().format(DateTimeFormatter.ofPattern("HHmm"))  : "0800";
				searchVO.setResStarttime(util.NVL(searchVO.getResStarttime(), nowData));
				
				
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("code", "SWC_TIME");
				params.put("nowData", searchVO.getResStarttime());
				
				
				model.addObject("resStartTime", cmmnDetailService.selectCmmnDetailComboEtc(params));
				if (searchVO.getSearchRoomType().equals("SWC_GUBUN_3")) {
					params.put("nowData", "0800");
					model.addObject("resEndTime", cmmnDetailService.selectCmmnDetailComboEtc(params));
				}else {
					model.addObject("resEndTime", cmmnDetailService.selectCmmnDetailComboEtc(params));
				}
				//좌석 예약 일때는 ITEM 값 없음 
				if (!searchVO.getItemId().equals(""))
				  model.addObject("seatInfo", meetingService.selectMeetingRoomDetailInfoManage(searchVO.getItemId() ));
			}
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	
			
		}catch(Exception e){
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info("error:" + e.toString() + ":" +  ste[0].getLineNumber());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
		
	}
	//회의실 예약
	@RequestMapping(value="resReservertionUpdate.do")	
	public ModelAndView resUpdateInfo (@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
									  , @RequestBody ResInfoVO searchVO
									  , HttpServletRequest request
									  , BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			//SSO 관련 내용 넣기  
	 		EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			//관련 내용 넣기 
			if (user ==  null || user.getEmpno().equals("")  ){
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
 	    		model.addObject(Globals.STATUS,  Globals.STATUS_LOGINFAIL);
 	    		return model;				
			}
			//사용자 정버 넣기 
			// 테스트로 해서 사용자 정보 넣기 
			
			searchVO.setUserId( user.getEmpno() );
			LOGGER.debug("------------------------------------------------------------------" + user.getAuthorCode());
			LOGGER.debug("------------------------------------------------------------------" + user.getEmpno());
			//크레딧 정보 사용 여부 확인 
			if (user.getAuthorCode().equals("ROLE_USER")) {
				String tennInfo = util.NVL(resService.selectTennInfo(searchVO), "");
				if (tennInfo.indexOf("|")> 0 && tennInfo.length()> 2) {
					String tennInfosp[] =  tennInfo.split("\\|");
					//추후 변경 예정
					if (Integer.valueOf(tennInfosp[0]) > Integer.valueOf(tennInfosp[1])) {
						
						searchVO.setTennCnt(tennInfosp[1]);
					}else {
						model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
						model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.tenninsuff"));	
						return model;
					}
				}	
			}else {
				searchVO.setTennCnt("0");
			}
			LOGGER.debug("searchVO:" + searchVO.getTennCnt());
			//좌석 이면 동일 시간때 있는지 확인 필요
			int ret = 0;
			if (searchVO.getItemGubun().equals("ITEM_GUBUN_2")) {
				
				Map<String, Object> timeinfo = new HashMap<String, Object>();
			    timeinfo.put("timeStartDay", searchVO.getResStartday());
			    timeinfo.put("strTime", searchVO.getResStarttime());
			    timeinfo.put("endTime",  searchVO.getResEndtime());
			    timeinfo.put("userId", searchVO.getUserId());
			    timeinfo.put("resGubun", searchVO.getResGubun());
			    
				ret =   timeService.selectResSeatPreCheckInfo(timeinfo);
				if (ret > 0) {
					model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
					model.addObject(Globals.STATUS_MESSAGE, "동일 시간때 다른데 예야된 좌석이 있습니다.");	
					return model;
				}
				
			}
			
			ret = resService.insertResManage(searchVO); 
			if (ret > 0){
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE,
				egovMessageSource.getMessage("sucess.common.reservation")); //크레딧 차감
			}else if (ret <0){
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			    model.addObject(Globals.STATUS_MESSAGE,
			    egovMessageSource.getMessage("fail.common.reservation")); 
			}else { throw new  Exception(); }
			 
		}catch(Exception e){
			
			LOGGER.debug("error:"+ e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
	}
	//웗별 캘린더
	@RequestMapping(value="resCalendar.do")
	public ModelAndView selectResMonthListInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
											  , @ModelAttribute("ResInfoVO") ResInfoVO searchVO
											  , HttpServletRequest request
											  , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView("/web/resCalendar");
		try{
			empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/meetingDay";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		
		  		Map<String, Object> params = new HashMap<String, Object>();
		  		if (util.NVL( params.get("centerId"), "").equals("") )
			  		params.put("centerId", "C21052601");
			  	HashMap<String, Object> reginfo = new HashMap<String, Object>();
			  	reginfo.put("centerId", params.get("centerId").toString());
			  	params.put("searchFloor", "MEETING");
			  	
			  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
			  	 //권한 설정 
			  	params.put("authorCode", empInfoVO.getAuthorCode());
			  	params.put("comCode", empInfoVO.getComCode());
			  	
			  	List<Map<String,Object>> floorList = floorService.selectFloorInfoManageListByPagination(params);
			  	if (floorList.size() > 0) {
			  		if (searchVO.getFloorSeq().equals(""))
				  		searchVO.setFloorSeq(floorList.get(0).get("floor_seq").toString());
				  	  
				  	model.addObject("floorinfo", floorList);
				  	//기초 정리 하기 
				  	reginfo.put("floorSeq", searchVO.getFloorSeq());
				  	reginfo.put("centerId", params.get("centerId").toString());
				  	
				  	
				  	model.addObject("selectMonthList", resService.selectCalenderInfo());
				  	String searchTxt =  searchVO.getSearchCalenderTitle().equals("") ? LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMM")) : searchVO.getSearchCalenderTitle();
				  	searchVO.setSearchCalenderTitle(searchTxt);
				  	searchVO.setFloorSeq(searchVO.getFloorSeq());
					List<ResInfoVO> calenderList =  resService.selectCalenderMeetingState(searchVO);
					
					
					int firstDay = Integer.parseInt(calenderList.get(0).getWeekTxt())-1;
					model.addObject("calenderInfo",  calenderList);
					model.addObject("frDay",  firstDay);
					
					model.addObject(Globals.STATUS_REGINFO,  searchVO);
			  	}else {
			  		model.addObject(Globals.STATUS, Globals.STATUS_FAILLACK);
			  		model.addObject(Globals.STATUS_MESSAGE, "적용되는 시설물이 없습니다.");
			  	}
		  	}		
		}catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		
		return model;
	}
	@RequestMapping(value="meetingResource.do")	
	public ModelAndView webMeetingResourceInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
			                                   , HttpServletRequest request
			                                   , BindingResult bindingResult) throws Exception{				
	    ModelAndView model = new ModelAndView();
	    try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/meetingDay";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		HashMap<String, Object> searchVO = new HashMap<String, Object>();
		  		int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			    searchVO.put("pageUnit", pageUnit);
			    searchVO.put("pageIndex", 1);
			  
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
		  		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	}
		  	model.setViewName("/web/meetingResource");
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMeetingInfo error:" + e.toString() + ":" + lineNumber);
	    	
	    }
	    return model;
	}
	@RequestMapping(value="meetingList.do")
	public ModelAndView selectResListInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
										  , @ModelAttribute("ResInfoVO") ResInfoVO searchVO
										  , HttpServletRequest request
										  , BindingResult bindingResult	) throws Exception {
		
        ModelAndView model = new ModelAndView();
		
	    try{
	    	//SSO 관련 내용 넣기  	 		
	    	EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/web/login");
				return model;
			}
			PaginationInfo paginationInfo = new PaginationInfo();
	  		paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.getPageIndex(), "1") ) );
			paginationInfo.setRecordCountPerPage( propertiesService.getInt("pageUnit"));
			paginationInfo.setPageSize( propertiesService.getInt("pageSize"));
			
			
			Map<String, Object> params = new HashMap<String, Object>();
			
			
			
			List<com.sohoki.backoffice.sym.cnt.vo.CenterInfo> list = centerService.selectCenterInfoManageCombo();
			String centerId =  searchVO.getSearchCenter().equals("") ? list.get(0).getCenterId() :  searchVO.getSearchCenter();
			
			
	  		if (util.NVL( params.get("centerId"), "").equals("") )
		  		params.put("centerId", "C21052601");
	  		
		  	HashMap<String, Object> reginfo = new HashMap<String, Object>();
		  	reginfo.put("centerId", params.get("centerId").toString());
		  	params.put("searchFloor", "MEETING");
		  	params.put("authorCode", empInfoVO.getAuthorCode());
		  	params.put("comCode", empInfoVO.getComCode());
		  	
		  	List<Map<String,Object>> floorList = floorService.selectFloorInfoManageListByPagination(params);
		  	if (floorList.size() > 0) {
		  		model.addObject("floorinfo", floorList);
			  	
			  	String floorSeq =  searchVO.getFloorSeq().equals("") ?  floorList.get(0).get("floor_seq").toString() : searchVO.getFloorSeq();
			  	searchVO.setFloorSeq(floorSeq);
			  	
			  	String searchResStartday = searchVO.getSearchResStartday().equals("") ?    util.reqDay(0): searchVO.getSearchResStartday();
			  	searchVO.setSearchResStartday(searchResStartday);
			  	
			  	
				params.put("firstIndex", Integer.valueOf( paginationInfo.getFirstRecordIndex()));
				params.put("lastRecordIndex", Integer.valueOf(paginationInfo.getLastRecordIndex()));
				params.put("recordCountPerPage", Integer.valueOf( paginationInfo.getRecordCountPerPage()));
				params.put("searchResStartday",  searchResStartday);
				params.put("itemGubun", "ITEM_GUBUN_1");
				params.put("resGubun", "SWC_GUBUN_1");
				params.put("searchFloorSeq", floorSeq);
				
				
		    	List<Map<String, Object>> reslist = resService.selectResManageListByPagination(params);
		  		int totCnt = reslist.size() > 0 ?  Integer.valueOf(reslist.get(0).get("total_record_count").toString()) : 0;
			    model.addObject(Globals.JSON_RETURN_RESULTLISR,  reslist );
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
			    paginationInfo.setTotalRecordCount(totCnt);
			    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
			    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		  	}else {
		  		model.addObject(Globals.STATUS, Globals.STATUS_FAILLACK);
		  		model.addObject(Globals.STATUS_MESSAGE, "적용되는 시설물이 없습니다.");
		  	}
		  	
		     
		     
	    }catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	 
	    }
	    model.setViewName("/web/meetingList");
	    return model;
		
	}
	@RequestMapping(value="seatInfo.do")
	public ModelAndView selectSeatInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
										  , @ModelAttribute("ResInfoVO") ResInfoVO searchVO
										  , HttpServletRequest request
										  , BindingResult bindingResult	) throws Exception {
		
        ModelAndView model = new ModelAndView();
		
	    try{
	    	//SSO 관련 내용 넣기  	 		
	    	EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/web/login");
				return model;
			}
			
			Map<String, Object> params = new HashMap<String, Object>();
			if (util.NVL( params.get("centerId"), "").equals("") )
		  		params.put("centerId", "C21052601");
		  	HashMap<String, Object> reginfo = new HashMap<String, Object>();
		  	reginfo.put("centerId", params.get("centerId").toString());
		  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
		  	params.put("searchFloor", "SEAT");
		  	params.put("authorCode", user.getAuthorCode());
		  	params.put("comCode", user.getComCode());
		  	
		  	List<Map<String,Object>> floorList = floorService.selectFloorInfoManageListByPagination(params);
		  	if (floorList.size() > 0) {
		  	  	String floorSeq = floorList.get(0).get("floor_seq").toString();
			  	model.addObject("floorinfo", floorList);
			  	String searchDay = util.reqDay(0);
			  	reginfo.put("floorSeq", floorSeq);
			  	reginfo.put("centerId", params.get("centerId").toString());
			  	reginfo.put("searchResStartday", searchDay);
			  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
		  	}else {
		  		model.addObject(Globals.STATUS, Globals.STATUS_FAILLACK);
		  		model.addObject(Globals.STATUS_MESSAGE, "적용되는 시설물이 없습니다.");
		  	}
		  	
		     
	    }catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	 
	    }
	    model.setViewName("/web/seatInfo");
	    return model;
		
	}
	@RequestMapping (value="selectTimeInfo.do")
	public ModelAndView selectTimeInfo (@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
							            , @RequestBody Map<String,Object>  resSearch
							            , HttpServletRequest request
							    	    , BindingResult bindingResult) throws Exception{	
		
		
		
			ModelAndView model = new 	ModelAndView(Globals.JSONVIEW);
				
			try{
					//기초 리스트 형태 보여주기 
					
				EmpInfoVO user = new EmpInfoVO();
				user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
				if (user ==  null){
					LOGGER.debug("로그인 기록 없음");		   
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					return model;
				}
				String searchDay = resSearch.get("searchResStartday").equals("")  ? util.reqDay(0)  : resSearch.get("searchResStartday").toString();
				resSearch.put("swcResday", searchDay);
				List<Map<String, Object>> timeInfos = timeService.selectSTimeInfoBarList(resSearch);						
					
				model.addObject(Globals.JSON_RETURN_RESULTLISR, timeInfos);	
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			}catch(Exception e){
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, e.toString());
				model.addObject("seatInfo", null);
			}
			return model;
	}
	@RequestMapping(value="mybooking.do")
	public ModelAndView webMybooking(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
						            , HttpServletRequest request
						            , BindingResult bindingResult) throws Exception{		
		ModelAndView model = new ModelAndView();
		model.setViewName("/web/myBooking");
        try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/myBooking";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		HashMap<String, Object> searchVO = new HashMap<String, Object>();
		  		int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			    searchVO.put("pageUnit", pageUnit);
			    searchVO.put("pageIndex", 1);
			  
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
		  		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	}
		
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMybooking error:" + e.toString() + ":" + lineNumber);
	    	
	    }
		return model;
	}
	@RequestMapping(value="mybookingAjax.do")
	public ModelAndView webMybookingAjax(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
						                 , HttpServletRequest request
						                 , BindingResult bindingResult) throws Exception{		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/myBooking";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		 
		  		 
		  		
		  		 HashMap<String, Object> searchVO = new HashMap<String, Object>();
		  		 
			     searchVO.put("empno", empInfoVO.getEmpno());
			     
			     PaginationInfo paginationInfo = new PaginationInfo();
				 paginationInfo.setCurrentPageNo( Integer.valueOf( util.NVL(searchVO.get("pageIndx"), "1")));
				 paginationInfo.setRecordCountPerPage(Integer.valueOf( util.NVL(searchVO.get("pageUnit"), propertiesService.getInt("pageUnit"))));
				 paginationInfo.setPageSize(Integer.valueOf( util.NVL(searchVO.get("pageSize"), propertiesService.getInt("pageSize"))));
				 
				 searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
				 searchVO.put("lastIndex", paginationInfo.getLastRecordIndex());
				 searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
				 
		         String date1 = util.NVL(searchVO.get("searchStartDay"),  com.sohoki.backoffice.util.SmartUtil.reqDay(0)) ;
		         String date2 =  util.NVL(searchVO.get("searchEndDay"),  com.sohoki.backoffice.util.SmartUtil.reqDay(90)) ;
		         searchVO.put("searchStartDay", date1);
		         searchVO.put("searchEndDay", date2);
		          
		  		 List<Map<String, Object>> reslist = resService.selectResManageListByPagination(searchVO);
		  		 int totCnt = reslist.size() > 0 ?  Integer.valueOf(reslist.get(0).get("total_record_count").toString()) : 0;
			     model.addObject(Globals.JSON_RETURN_RESULTLISR,  reslist );
			     model.addObject(Globals.STATUS_REGINFO, searchVO);
			     
			     
			     paginationInfo.setTotalRecordCount(totCnt);
			     model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
			     model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			     model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			  
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
		  		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	}
		
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMybooking error:" + e.toString() + ":" + lineNumber);
	    	
	    }
		return model;
	}
	@RequestMapping(value="resUpdate.do")
	public ModelAndView resUpdateStateInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
										   , @RequestBody ResInfoVO searchVO
										   , HttpServletRequest request
										   , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
 	    		model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
 	    		return model;				
			}
			
			searchVO.setUserId(user.getEmpno());
			
			
			int ret = resService.updateResManageChange(searchVO);
			if (ret > 0){
				Map<String, Object> cominfo = new HashMap<String, Object>();
				LOGGER.debug("getAuthorCode" + empInfoVO.getAuthorCode());
			    if (user.getAuthorCode().equals("ROLE_USER")) {
			    	cominfo = companyService.selectCompanyInfoManageDetail(user.getComCode().toString());
			    }else {
			    	cominfo.put("tenn_info", 0);
			    	cominfo.put("tenn_total_info", 0);
			    }
			    model.addObject(Globals.STATUS_COMINFO, cominfo);
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE,   "정상적으로 처리 되었습니다.");
			}else {
				throw new Exception();
			}
			
		}catch(Exception e){
			LOGGER.error("resUpdateInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
		}
		return model;
	}
	@RequestMapping(value="myPage.do")
	public ModelAndView webMyPage(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
						            , HttpServletRequest request
						            , BindingResult bindingResult) throws Exception{		
		ModelAndView model = new ModelAndView();
		String url = "/web/myPage";
        try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		
		  		
		  		
		  		HashMap<String, Object> searchVO = new HashMap<String, Object>();
		  		int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			    searchVO.put("pageUnit", pageUnit);
			    searchVO.put("pageIndex", 1);
			    empInfoVO = empService.selectEmpInfoDetailNo(empInfoVO.getEmpno().toString());
			    Map<String, Object> cominfo = new HashMap<String, Object>();
			    LOGGER.debug("getAuthorCode" + empInfoVO.getAuthorCode());
			    if (empInfoVO.getAuthorCode().equals("ROLE_USER")) {
			    	cominfo = companyService.selectCompanyInfoManageDetail(empInfoVO.getComCode().toString());
			    }else {
			    	cominfo.put("tenn_info", 0);
			    	cominfo.put("tenn_total_info", 0);
			    }
			    model.addObject(Globals.STATUS_USERINFO, empInfoVO);
			    model.addObject(Globals.STATUS_COMINFO, cominfo);
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
			    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	}
		  	model.setViewName(url);
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMyPage error:" + e.toString() + ":" + lineNumber);
	    	
	    }
		return model;
	}
	@RequestMapping(value="myTennAjax.do")
	public ModelAndView webTennAjax(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
			                        , @RequestBody Map<String, Object> searchVO 
						            , HttpServletRequest request
						            , BindingResult bindingResult) throws Exception{		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/myBooking";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		 searchVO.put("empno", empInfoVO.getEmpno());
			     searchVO.put("searchTenn", "tenn");
			     PaginationInfo paginationInfo = new PaginationInfo();
				 paginationInfo.setCurrentPageNo( Integer.valueOf( util.NVL(searchVO.get("pageIndex"), "1")));
				 paginationInfo.setRecordCountPerPage(Integer.valueOf( util.NVL(searchVO.get("pageUnit"), propertiesService.getInt("pageUnit"))));
				 paginationInfo.setPageSize(Integer.valueOf( util.NVL(searchVO.get("pageSize"), propertiesService.getInt("pageSize"))));
				 searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
				 searchVO.put("lastIndex", paginationInfo.getLastRecordIndex());
				 searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
				 searchVO.put("mode", "mode");
				 
		  		 List<Map<String, Object>> reslist = tennService.selectTennantSubInfoManageListByPagination(searchVO);
		  		 int totCnt = reslist.size() > 0 ?  Integer.valueOf(reslist.get(0).get("total_record_count").toString()) : 0;
			     model.addObject(Globals.JSON_RETURN_RESULTLISR,  reslist );
			     model.addObject(Globals.STATUS_REGINFO, searchVO);
			     
			     
			     paginationInfo.setTotalRecordCount(totCnt);
			     model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
			     model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			     model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			  
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
		  		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	}
		
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMybooking error:" + e.toString() + ":" + lineNumber);
	    	
	    }
		return model;
	}
	@RequestMapping(value="myModify.do")
	public ModelAndView webmyModify(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
						            , HttpServletRequest request
						            , BindingResult bindingResult) throws Exception{		
		ModelAndView model = new ModelAndView();
		String url = "/web/myModify";
        try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		
		  		
		  		
		  		HashMap<String, Object> searchVO = new HashMap<String, Object>();
		  		int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			    searchVO.put("pageUnit", pageUnit);
			    searchVO.put("pageIndex", 1);
			    empInfoVO = empService.selectEmpInfoDetailNo(empInfoVO.getEmpno().toString());
			    model.addObject(Globals.STATUS_USERINFO, empInfoVO);
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
			    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	}
		  	model.setViewName(url);
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMyPage error:" + e.toString() + ":" + lineNumber);
	    	
	    }
		return model;
	}
	@RequestMapping(value="notice.do")
	public ModelAndView selectNotice(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
                                     , HttpServletResponse response
			    		             , HttpServletRequest request
			    		             , BindingResult bindingResult) throws Exception {
		
		
		ModelAndView model = new ModelAndView();
		model.setViewName("/web/notice");
        try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/myBooking";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		String boardSeq = request.getParameter("board_seq");
		  		HashMap<String, Object> searchVO = new HashMap<String, Object>();
		  		int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			    searchVO.put("pageUnit", pageUnit);
			    searchVO.put("pageIndex", 1);
			    searchVO.put("boardSeq", boardSeq);
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
		  		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  	}
		
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMybooking error:" + e.toString() + ":" + lineNumber);
	    	
	    }
		return model;
    }
	//회의실 예약 부터 시작
	@RequestMapping(value="coronation.do")	
	public ModelAndView webCoronation(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                           , HttpServletRequest request
			                           , BindingResult bindingResult) throws Exception{				
	    ModelAndView model = new ModelAndView();
	    try {
	    	
	    	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
		  	String url = "/web/coronation";
		  	if (empInfoVO.getEmpno() ==  null) {
		  		url = "/web/login";
		  	}else {
		  		LOGGER.debug("---------------------------------------------------");
		  		Map<String, Object> params = new HashMap<String, Object>();
		  		if (util.NVL( params.get("centerId"), "").equals("") )
			  		params.put("centerId", "C21052601");
			  	HashMap<String, Object> reginfo = new HashMap<String, Object>();
			  	reginfo.put("centerId", params.get("centerId").toString());
			  	//추후 변경 예정 
			  	reginfo.put("itemGubun", "ITEM_GUBUN_3");
			  	reginfo.put("searchRoomType", "SWC_GUBUN_3");
			  	
			  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
			  	params.put("searchFloor", "CORN");
			  	//권한 설정 
			  	params.put("authorCode", empInfoVO.getAuthorCode());
			  	params.put("comCode", empInfoVO.getComCode());
			  	List<Map<String,Object>> floorList = floorService.selectFloorInfoManageListByPagination(params);
			  	if (floorList.size() > 0) {
			  		String floorSeq = floorList.get(0).get("floor_seq").toString();
				  	model.addObject("floorinfo", floorList);
				  	//기초 정리 하기 
				  	String searchDay = util.reqDay(0);
				  	reginfo.put("floorSeq", floorSeq);
				  	reginfo.put("centerId", params.get("centerId").toString());
				  	reginfo.put("searchResStartday", searchDay);
				  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
			  	}else {
			  		model.addObject(Globals.STATUS, Globals.STATUS_FAILLACK);
			  		model.addObject(Globals.STATUS_MESSAGE, "적용되는 시설물이 없습니다.");
			  	}
		  	}
		  	model.setViewName(url);
	    }catch(Exception e) {
	    	StackTraceElement[] ste = e.getStackTrace();
		      
	        int lineNumber = ste[0].getLineNumber();
	    	LOGGER.debug("webMeetingInfo error:" + e.toString() + ":" + lineNumber);
	    	
	    }
	    return model;
	
		
	}
	//kiosk정리 하기 
	@RequestMapping(value="resPadInfo.do")
	public ModelAndView selecKioskPop (@ModelAttribute("ResInfoVO")  ResInfoVO resSearch
                                       , @RequestParam("meetingId") String meetingId
									   , HttpServletRequest request
									   , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView("/web/kiosk/meetingR");
		try{
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, meetingService.selectMeetingRoomDetailInfoManage(meetingId));
			//신규 수정 
			
		}catch(Exception e){
			LOGGER.error("selectResInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
		
	}
	@RequestMapping(value="resPadInfoAjax.do")
	public ModelAndView selecKioskPopAjax (@RequestParam("meetingId") String meetingId
										   , HttpServletRequest request) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			HashMap<String, Object> resSearch = new HashMap<String, Object>();
			
			resSearch.put("meetingId", meetingId);
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			List<Map<String, Object>> resInfos =  resService.selectIndexList(resSearch);
			model.addObject(Globals.JSON_RETURN_RESULTLISR , resInfos);
			//
			//신규 수정 
			
			String searchDay = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			
			model.addObject("dayInfo",    searchDay.substring(0,10));
			model.addObject("timeInfo",    searchDay.substring(11,19));
			
			
			
			List<Map<String, Object>> timeLists = resService.selectKioskCalendarList(meetingId);
			LOGGER.debug("-----------------------------   size:" + timeLists.size());
			
			/*
			 * JSONArray resTime = new JSONArray(); for (Map<String, Object> timeList :
			 * timeLists){ LOGGER.debug("-------------------------------------------------"
			 * + timeList.get("res_title").toString()); Map<String, Object> searchTime = new
			 * HashMap<String, Object>(); searchTime.put("title",
			 * timeList.get("res_title").toString() ); searchTime.put("start",
			 * timeList.get("res_starttime").toString()); searchTime.put("end",
			 * timeList.get("res_endtime").toString()); Map<String, Object> searchTime_sub =
			 * new HashMap<String, Object>(); searchTime_sub.put("author",
			 * timeList.get("empname").toString() ); searchTime_sub.put("id",
			 * timeList.get("res_seq").toString() ); searchTime.put("extendedProps",
			 * searchTime_sub); searchTime.put("color", "#F2F2F2");
			 * searchTime.put("textColor", "#808080"); resTime.add(searchTime); }
			 */
			JSONArray jsonArr1 = new JSONArray();
			JSONObject jsonobj = new JSONObject();
			JSONObject jsonobj_sub = new JSONObject();
			for (Map<String, Object> timeList : timeLists){
				jsonobj.put("title", timeList.get("res_title").toString() );
				jsonobj.put("start", timeList.get("res_starttime").toString());
				jsonobj.put("end", timeList.get("res_endtime").toString());
				jsonobj_sub.put("author",  timeList.get("empname").toString() );
				jsonobj_sub.put("id",  timeList.get("res_seq").toString() );
				jsonobj.put("extendedProps", jsonobj_sub);
				jsonobj.put("color", "#F2F2F2");
				jsonobj.put("textColor", "#808080");			
				jsonArr1.add(jsonobj);
			}
			
			model.addObject("resTime", jsonArr1);
			
			//model.addObject("resTime", resTime);
			int i = 0;
			/* 참석자는 사용 안함
			for (Map<String, Object>  resInfo :   resInfos ){
				if (! util.NVL(resInfo.get("resattendlist"), "").equals("")  && i ==0){
					List<String> empNoList =  Arrays.asList(resInfo.get("resattendlist").toString().split("\\s*,\\s*"));
					LOGGER.debug("empNoList:" + empNoList.size());
					model.addObject("resUserList", empInfo.selectMeetinngUserList(empNoList));					
				}	
				i++;
			}
			*/
			
		}catch(Exception e){
			
			
			LOGGER.error("selectResInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
	}
	@RequestMapping(value="resPadStateAjax.do")
	public ModelAndView kioskInOtStateChnage (@RequestBody  ResInfoVO resinfo
											  , HttpServletRequest request
											  , BindingResult bindingResult	) throws Exception {
				ModelAndView model = new ModelAndView(Globals.JSONVIEW);
				try{
					LOGGER.debug("==================================================");
					int ret = resService.resStateChagenCheck(resinfo);
					if (ret > 0){
						model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
						model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
					}else {
					    model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
						throw new Exception(); 
					}		
				}catch(Exception e){
					model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
				}
				return model;
	}
	@RequestMapping(value="resLoginCheckAjax.do")
	public ModelAndView kioskLoginCheck (@RequestBody  ResInfoVO resinfo
										 , HttpServletRequest request
										 , BindingResult bindingResult	) throws Exception {
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
	    try{
			
			LOGGER.debug("sso 로그인");
			if (resinfo.getMode().equals("R")){
				//예약 일때 
				EmpInfoVO empInfoVO = new EmpInfoVO();
				empInfoVO.setEmpid(resinfo.getUserId()); 
				if(empInfoVO.getEmpid() != null && empInfoVO.getEmpid() != ""){
	    			//로그인 수정 
					EmpInfoVO resultVO = empService.selectEmpInfoDetailNo(empInfoVO.getEmpid());
					//EmpInfo resultVO = empInfo.selectSmartOfficeLoginAction(empInfoVO.getEmpid());        
	        		if (resultVO != null && resultVO.getEmpno() != null ) {
	    	        	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
	    	        	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
	    	        } else {
	    	        	LOGGER.debug("로그인 실패");
	    	        	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
	    	        	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
		 	        }
	        	}else{
	        		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
	    	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);		
	    	    	
	        	}
			}else {
				//취소 일때 취소도 같이 적용 할지 체크 
				Map<String, Object> info =  resService.selectResManageView(resinfo.getResSeq());
				
				if (info.get("user_id").toString().equals(resinfo.getUserId())){
					resinfo.setReservProcessGubun("PROCESS_GUBUN_6");
					resinfo.setCancelCode("CANCEL_CODE_3");
					resinfo.setCancelReason("현장 예약 취소");
					int ret = resService.updateResManageChange(resinfo);
					
					if (ret > 0){
						model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
						model.addObject(Globals.STATUS_MESSAGE,   "정상적으로 처리 되었습니다.");
					}else {
						throw new Exception();
					}
				}else {
					model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				}
				
				info = null;
			}
			
		}catch(Exception e){
			LOGGER.debug("error:" + e.toString());
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.request.msg"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		return model;
			
	}
	@RequestMapping(value="resReservertionKioskUpdate.do")	
	public ModelAndView resUpdateKioskInfo (@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
										    , @RequestBody ResInfoVO searchVO
										    , HttpServletRequest request
										    , BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			//SSO 관련 내용 넣기  
	 		

			//사용자 정버 넣기 
			searchVO.setUserId( searchVO.getProxyUserId() );
			int ret = resService.insertResManage(searchVO);
			if (ret > 0){
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("sucess.common.reservation"));
				
			}else if (ret <0){
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.reservation"));	
			}else {
				throw new Exception();
			}
		}catch(Exception e){
			LOGGER.debug("error:"+ e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
	}
	@RequestMapping(value="resMeetingInfoAjax.do")
	public ModelAndView selectResMeetingInfoAjax(@RequestParam("resSeq") String resSeq	) throws Exception {
		
		     ModelAndView model = new ModelAndView(Globals.JSONVIEW);	
		     try{
		    	 model.addObject("resInfo", resService.selectResManageView(resSeq));
		    	 model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		     }catch(Exception e){
		    	 model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		     }
		     return model;
	}
	@RequestMapping(value="resInfoAjax.do")
	public ModelAndView selectResInfoAjax(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
															  , @RequestBody ResInfoVO searchVO
															  , HttpServletRequest request
															  , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);		
		try{
			
			
			
			LOGGER.debug("===========================================================");
			if (!searchVO.getResSeq().equals("0")){
				
				Map<String, Object> resInfo = resService.selectResManageView(searchVO.getResSeq());
				
				
				model.addObject("resInfo", resInfo);
				//참석자
				/*
				if (! util.NVL(resInfo.get("res_attendlist"), "").equals("")){
					List<String> empNoList =  Arrays.asList(resInfo.get("res_attendlist").toString().split("\\s*,\\s*"));
					LOGGER.debug("empNoList:" + empNoList.size());
					model.addObject("resUserList", empInfo.selectMeetinngUserList(empNoList));
				}
				
				//영상회의 이면 
				if (resInfo.get("RES_GUBUN").toString().equals("SWC_GUBUN_2") && !util.NVL(resInfo.get("meeting_seq"), "").equals("")){
					LOGGER.debug("resInfo.getMeetingSeq():" + resInfo.get("meeting_seq"));
					List<String> swSeqList =   util.dotToList(resInfo.get("meeting_seq").toString() );
					model.addObject("resRoomInfo", meetingService.selectConferenceList(swSeqList));
				}
				*/
			}else {
				LOGGER.debug("===========================================================1");
				
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("code", "SWC_TIME");
				params.put("nowData", searchVO.getResStarttime());
				model.addObject("resStartTime", cmmnDetailService.selectCmmnDetailComboEtc(params));
				
				params.put("code", "SWC_TIME");
				params.remove("nowData");
				params.put("overData", searchVO.getResEndtime());
				model.addObject("resEndTime", cmmnDetailService.selectCmmnDetailComboEtc(params));
				model.addObject("seatInfo", meetingService.selectMeetingRoomDetailInfoManage(searchVO.getItemId()));
			}
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	
			
		}catch(Exception e){
			LOGGER.error("selectResInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
		
	}
	
}
