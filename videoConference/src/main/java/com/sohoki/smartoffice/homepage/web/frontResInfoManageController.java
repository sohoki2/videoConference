package com.sohoki.smartoffice.homepage.web;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.sohoki.backoffice.cus.com.servie.UserInfoManageService;
import com.sohoki.backoffice.cus.com.vo.UserInfo;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.sts.res.service.ResInfoManageService;
import com.sohoki.backoffice.sts.res.service.TimeInfoManageService;
import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.sym.space.service.MeetingRoomInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.sim.service.EgovClntInfo;

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
			
		
			EmpInfoVO resultVO = empService.selectEmpInfoDetailNo(empno);;  
    		if (resultVO != null && resultVO.getEmpno() != null ) {

	        	request.getSession().setAttribute("empInfoVO", resultVO);
	        	mav.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
	        	mav.setViewName("/web/index");
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
			vo.setMode("Ins");
			vo.setComCode("C_00000004");
			vo.setUserState("USER_STATE_1");
			int ret = userService.updateUserInfoManage(vo);
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, " 서울관광플라자에 오신걸 환영합니다<br/>회원가입을 완료 하였습니다");
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
	
	
	@RequestMapping(value="Logout.do")
	public ModelAndView actionLogoutProcess(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
			                                , @RequestBody Map<String, Object> params 
			    		                    , HttpServletRequest request
			    		                    , BindingResult bindingResult) throws Exception {
		ModelAndView mav = new ModelAndView(Globals.JSONVIEW);
		try {
			 request.getSession().setAttribute("userinfo", null);  
			 mav.setViewName("redirect:/backoffice/login.do");
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
		
		String empno = (String) request.getSession().getAttribute("empInfoVO");
		String url = "/web/index";
		
		if (empno ==  null) {
			url = "/web/login";
		}
		LOGGER.debug("url:" + url);
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
			  	
			  	List<Map<String,Object>> floorList = floorService.selectFloorInfoManageListByPagination(params);
			  	String floorSeq = floorList.get(0).get("floor_seq").toString();
			  	model.addObject("floorinfo", floorList);
			  	//기초 정리 하기 
			  	String searchDay = util.reqDay(0);
			  	reginfo.put("floorSeq", floorSeq);
			  	reginfo.put("centerId", params.get("centerId").toString());
			  	reginfo.put("searchResStartday", searchDay);
			  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
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
				
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("code", "SWC_TIME");
				params.put("nowData", searchVO.getResStarttime());
				model.addObject("resStartTime", cmmnDetailService.selectCmmnDetailComboEtc(params));
				model.addObject("resEndTime", cmmnDetailService.selectCmmnDetailComboEtc(params));
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
			
			//크레딧 정보 사용 여부 확인 
			if (empInfoVO.getAuthorCode().equals("ROLE_USER")) {
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
			}
			LOGGER.debug("searchVO:" + searchVO.getTennCnt());
			
			int ret = resService.insertResManage(searchVO); 
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
		  		LOGGER.debug("resCalendar:---------------------------------------------------");
		  		Map<String, Object> params = new HashMap<String, Object>();
		  		if (util.NVL( params.get("centerId"), "").equals("") )
			  		params.put("centerId", "C21052601");
			  	HashMap<String, Object> reginfo = new HashMap<String, Object>();
			  	reginfo.put("centerId", params.get("centerId").toString());
			  	model.addObject(Globals.STATUS_REGINFO,  reginfo);
			  	
			  	List<Map<String,Object>> floorList = floorService.selectFloorInfoManageListByPagination(params);
			  	if (searchVO.getFloorSeq().equals(""))
			  		searchVO.setFloorSeq(floorList.get(0).get("floor_seq").toString());
			  	  
			  	model.addObject("floorinfo", floorList);
			  	//기초 정리 하기 
			  	String searchDay = util.reqDay(0);
			  	reginfo.put("floorSeq", searchVO.getFloorSeq());
			  	reginfo.put("centerId", params.get("centerId").toString());
			  	reginfo.put("searchResStartday", searchDay);
			  	
			  	
			  	model.addObject("selectMonthList", resService.selectCalenderInfo());
			  	String searchTxt =  searchVO.getSearchCalenderTitle().equals("") ? LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMM")) : searchVO.getSearchCalenderTitle();
			  	searchVO.setSearchCalenderTitle(searchTxt);
			  	searchVO.setFloorSeq(searchVO.getFloorSeq());
				List<ResInfoVO> calenderList =  resService.selectCalenderMeetingState(searchVO);
				
				
				int firstDay = Integer.parseInt(calenderList.get(0).getWeekTxt())-1;
				model.addObject("calenderInfo",  calenderList);
				model.addObject("frDay",  firstDay);
				
				model.addObject(Globals.STATUS_REGINFO,  searchVO);
				
		  	}		
		}catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		
		return model;
	}
	
	
	
}
