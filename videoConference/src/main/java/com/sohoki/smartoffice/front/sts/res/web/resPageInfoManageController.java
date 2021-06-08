package com.sohoki.smartoffice.front.sts.res.web;



import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.cus.org.service.jobInfoManageService;
import com.sohoki.backoffice.sts.brd.service.BoardInfoManageService;
import com.sohoki.backoffice.sts.brd.vo.BoardInfo;
import com.sohoki.backoffice.sts.res.service.ResInfoManageService;
import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sts.res.vo.TimeInfo;
import com.sohoki.backoffice.sts.res.service.TimeInfoManageService;
import com.sohoki.backoffice.sts.res.vo.TimeInfoVO;
import com.sohoki.backoffice.sts.res.service.impl.resMessageSendSchedulerService;
import com.sohoki.backoffice.sym.avaya.service.virturalConerenceInfo;
import com.sohoki.backoffice.sym.avaya.service.virturalConerenceInfoService;
import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCodeVO;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.equ.service.ScheduleInfoManageService;
import com.sohoki.backoffice.sym.sat.service.SeatInfoManageService;
import com.sohoki.backoffice.sym.sat.vo.SeatInfoVO;
import com.sohoki.backoffice.sym.space.service.MeetingRoomInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.smartoffice.front.sts.res.service.ResManageService;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.com.cmm.service.Globals;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorPartInfoManageService;

@RestController
@RequestMapping("/front/resInfo")
public class resPageInfoManageController {
	
	
    private static final Logger LOGGER = LoggerFactory.getLogger(resPageInfoManageController.class);

	
	//좌석 관련  추후 삭제
	//@Autowired
    //private SeatInfoManageService seatService;
	
	
	//회의실 관련 내용
	@Autowired
	private MeetingRoomInfoManageService meetingService;
	
	@Autowired
	private FloorInfoManageService floorService;
	
	@Autowired
	private FloorPartInfoManageService partService;
	
	//시간 관련 
	@Autowired
	private TimeInfoManageService timeService;
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	
	@Autowired
	private ResInfoManageService resService;
	
	@Autowired
	private EmpInfoManageService empInfo;
	
	@Autowired
	private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	
	@Autowired
	private CenterInfoManageService centerService;
	
	//공지사항 
	@Autowired
    protected BoardInfoManageService boardInfoService;
	
	@Autowired
    protected jobInfoManageService jobInfoService;
	
	@Autowired
	private resMessageSendSchedulerService resMessage;
	
	@Autowired
	private OrgInfoManageService orgService;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
	private ResManageService frontService;
	
	
	//추후 수정 예정 
	@RequestMapping(value="emSearchList.do")
	public ModelAndView selectEmList(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
                                     , @RequestBody Map<String,Object> searchVO
		    		                 , HttpServletRequest request
		    		                 , BindingResult bindingResult) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			//SSO 관련 내용 넣기  
	 		
			List<Map<String, Object>> emList = empInfo.selectEmpInfoList(searchVO);
			int totCnt = emList.size() > 0 ?  Integer.valueOf( emList.get(0).get("total_record_count").toString()) :0;
			
	    	model.addObject("emList", emList);
	    	model.addObject(Globals.PAGE_TOTALCNT, totCnt);
	    	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	 
			
		}catch(Exception e){
			LOGGER.error("selectEmList error:" + e.toString());
			model.addObject("message", egovMessageSource.getMessage("fail.common.msg"));
	    	model.addObject(Globals.STATUS, "FAIL");	 
		}
		return model;
	}
	
	
	@RequestMapping(value="/front/ssoLogin.do")
	public String actionSecurityLoginSSO(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO 
                                         , HttpServletResponse response
			    		                 , HttpServletRequest request
			    		                 , HttpSession session
			    		                 , BindingResult bindingResult
			    		                 , ModelMap model) throws Exception {
		
		String url = "";
		
    	
    	String userId = (String) request.getSession().getAttribute("SSO_ID");
		empInfoVO.setEmpno(userId);
    	
    	if(userId != null){
    		EmpInfo resultVO = empInfo.selectSmartOfficeLoginAction(empInfoVO.getEmpno());  
    		if (resultVO != null && resultVO.getEmpno() != null ) {
	        	
	        	// 2. spring security 연동        	
	        	request.getSession().setAttribute("empInfoVO", resultVO);
 	        	return "forward:/front/main.do";	// 성공 시 페이지.. (redirect 불가)
	        } else {
	        	LOGGER.debug("로그인 실패");
	        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
 	        	//일반이면 sso 인증 없으면 바로 닫기
 	        	
 	        }
    		url="/index";
    	}else{
    		url="/index";
    	}
    	return "/front/main";	
    }
	
	
	@RequestMapping (value="selectTimeInfo.do")
	public ModelAndView selectTimeInfo (@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
							            , @RequestBody Map<String,Object>  resSearch
							            , HttpServletRequest request
							    	    , BindingResult bindingResult) throws Exception{	
		
		
		
				ModelAndView model = new 	ModelAndView(Globals.JSONVIEW);
				JSONObject datas = new JSONObject();
		
		
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
					List<Map<String, Object>> seatListVOs = meetingService.selectMeetingRoomEmptyManageList(resSearch);
					//센터 아이디 값 넣기 
					
					for (Map<String, Object>  seatinfoVO : seatListVOs) {
						Map<String, Object> searchTime = new HashMap<String, Object>();
						searchTime.put("meetingId", seatinfoVO.get("meeting_id").toString());
						searchTime.put("swcResday", searchDay);
						List<Map<String, Object>> timeInfos = timeService.selectSTimeInfoBarList(searchTime);						
						seatinfoVO.put("timeInfo", timeInfos);
					}
					
					model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
					model.addObject("seatInfo", seatListVOs);
				}catch(Exception e){
					
					
					model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
					model.addObject(Globals.STATUS_MESSAGE, e.toString());
					model.addObject("seatInfo", null);
				}
				return model;
	}
	//영상 회의 정리 하기 
	@RequestMapping(value="meetingSeatList.do")
	public ModelAndView  selectSeatList(@ModelAttribute("loginVO") AdminLoginVO loginVO
										, @RequestBody Map<String, Object> searchVO
										, HttpServletRequest request
										, BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			//SSO 관련 내용 넣기  
			//추후 일반 하기 분류 해서 넣기 
			EmpInfoVO user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		   
				model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				return model;
			}
			searchVO.put("firstIndex", 0);
			searchVO.put("recordCountPerPage", 100);
				
			//수정 
			List<Map<String, Object>> list  = meetingService.selectMeetingRoomManageListByPagination(searchVO);
			int totCnt = list.size() > 0 ? Integer.valueOf( list.get(0).get("total_record_count").toString())  : 0;  
			
			model.addObject(Globals.JSON_RETURN_RESULTLISR,  list);
			model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			model.addObject(Globals.STATUS,   Globals.STATUS_SUCCESS);
		}catch(Exception e){
		   LOGGER.error("selectSeatList ERROR:" + e.toString());
		   model.addObject(Globals.STATUS,  Globals.STATUS_FAIL);
		   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
		
	}
	//여기 수정 하기 
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
			
			//크레딧 정보 사용 여부 확인 
			if (!empInfoVO.getAuthorCode().equals("ROLE_USER")) {
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
	
    /*
     *   일별 예약 현황 보기 
     * 
     */
	@RequestMapping(value="resDayInfo.do")
	public ModelAndView selectResDayListInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
											 , @RequestBody Map<String, Object> params
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
			model = frontService.selectResManageListByPagination(params);
		}catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		return model;
	}
	
	@RequestMapping(value="resNoticeView.do")
	public ModelAndView selectNoticeView(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
										  , @ModelAttribute("searchVO") BoardInfo searchVO
										  , HttpServletRequest request
										  , BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView("/front/noticeView");
		try{
			
			EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/front/noInfo");
				return model;
			}
			
			int hitCount = boardInfoService.updateBoardVisitedManage(searchVO.getBoardSeq());
			model.addObject(Globals.STATUS_REGINFO, searchVO);
		    model.addObject(Globals.STATUS_REGINFO, boardInfoService.selectBoardManageView(searchVO.getBoardSeq()));
		    
		    
		    
		}catch(Exception e){
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.list"));
			LOGGER.info(e.toString());
		}
		return model;
	}
	
	@RequestMapping(value="resNoticeList.do")
	public ModelAndView selectNotice (@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
									  , @ModelAttribute("searchVO") Map<String, Object> searchVO
									  , HttpServletRequest request
									  , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView("/front/noticeList");
		try{
			
			EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/front/noInfo");
				return model;
			}
			
			int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
			  
		    searchVO.put("pageSize", propertiesService.getInt("pageSize"));
		    LOGGER.info("pageUnit:" + pageUnit);
		  
	              
	   	    PaginationInfo paginationInfo = new PaginationInfo();
		    paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
		    paginationInfo.setRecordCountPerPage(pageUnit);
		    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));
		    searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
		    searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
		    searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		    searchVO.put("boardGubun","NOT");
		  
		    //공지사항의 경우, 공지기한이 지난 게시물은 board_notice_useyn을 N으로 변경
		    boardInfoService.updateBoardNoticeUseYn();
		  
		    List<Map<String, Object>> list =  boardInfoService.selectBoardManageListByPagination(searchVO) ;
		    int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) : 0;
			   
		    model.addObject(Globals.JSON_RETURN_RESULTLISR,   list );
		    model.addObject(Globals.STATUS_REGINFO, searchVO);
		    paginationInfo.setTotalRecordCount(totCnt);
		    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		       
		}catch(Exception e){
			  model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.list"));
			  LOGGER.info(e.toString());
		}
		return model;
	}
	@RequestMapping(value="messageInfo.do")
	public ModelAndView selectmessageInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
															  , @ModelAttribute("ResInfoVO") ResInfoVO searchVO
															  , HttpServletRequest request
															  , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			 resMessage.resMessageSendSchede();
			
		}catch(Exception e){
			LOGGER.debug("selectmessageInfo ERROR:" + e.toString());
		}
		return model;
		
	} 
	
	
	@RequestMapping(value="noInfo.do")
	public ModelAndView selectnoInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
			  , @ModelAttribute("ResInfoVO") ResInfoVO searchVO
			  , HttpServletRequest request
			  , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView("/front/noInfo");
		return model;
		
	}
	@RequestMapping(value="resMonthList.do")
	public ModelAndView selectResMonthListInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
											  , @ModelAttribute("ResInfoVO") ResInfoVO searchVO
											  , HttpServletRequest request
											  , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView("/front/resMonthInfo");
		try{
			//SSO 관련 내용 넣기  
			EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/front/noInfo");
				return model;
			}
			
			model.addObject("selectMonthList", resService.selectCalenderInfo());
	    	model.addObject("selectCenter", centerService.selectCenterInfoManageCombo());
			model.addObject("selectSeat", cmmnDetailService.selectCmmnDetailCombo("SWC_GUBUN"));
			

			String searchTxt =  searchVO.getSearchCalenderTitle().equals("") ? LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMM")) : searchVO.getSearchCalenderTitle();
			searchVO.setSearchCalenderTitle(searchTxt);
			List<ResInfoVO> calenderList =  resService.selectCalenderDetailInfo(searchVO);
			
			model.addObject(Globals.STATUS_REGINFO, searchVO);
			int firstDay = Integer.parseInt(calenderList.get(0).getWeekTxt())-1;
			model.addObject("calenderInfo",  calenderList);
			model.addObject("frDay",  firstDay);
			
		}catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		
		return model;
	}
	
	//2번째 페이지
	/*
	 *   일별 예약 현황 보기 
	 * 
	 */
	@RequestMapping(value="resList.do")
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
				model.setViewName("/front/noInfo");
				return model;
			}
			
			List<com.sohoki.backoffice.sym.cnt.vo.CenterInfo> list = centerService.selectCenterInfoManageCombo();
			String centerId =  searchVO.getSearchCenter().equals("") ? list.get(0).getCenterId() :  searchVO.getSearchCenter();
			//예약 리스트 가지고 오기 
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	params.put("pageIndx", searchVO.getPageIndex());
			params.put("pageUnit", searchVO.getPageUnit());
			params.put("pageSize", searchVO.getPageSize());
			params.put("searchCenterId", centerId);
			params.put("searchStartDay", LocalDateTime.now().minusMonths(2).format(DateTimeFormatter.ofPattern("yyyyMMdd")));
			params.put("searchEndDay", "20301231");
			model = frontService.selectResManageListByPagination(params);
			
			
			
			model.addObject(Globals.STATUS_REGINFO, searchVO);
	    	model.addObject("selectCenter", list);
	    	model.addObject("selectSeat", meetingService.selectMeetingRoomManageCombo(centerId) );
	    }catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	 
	    }
	    model.setViewName("/front/resList");
	    return model;
		
	}
	@RequestMapping(value="resMeetingUpdate.do")
	public ModelAndView meetingUpdateStateInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
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
			int ret = resService.updateResMeetingLog(searchVO);
			
			if (ret >0){
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE,    egovMessageSource.getMessage("sucess.common.meetinglog"));
			}else {
				throw new Exception();				
			}
		}catch(Exception e){
			LOGGER.error("resUpdateInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE,   egovMessageSource.getMessage("fail.common.meetinglog"));			
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
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE,   "정상적으로 처리 되었습니다.");
			}else {
				throw new Exception();
			}
			
			
		}catch(Exception e){
			
			LOGGER.error("resUpdateInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
	}
	/*
	 *  마이 페이지 가지고 오기 
	 * 
	 */
	@RequestMapping(value="resMypage.do")
	public ModelAndView selectMypagegListInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
											  , @ModelAttribute("ResInfoVO") ResInfoVO searchVO
											  , HttpServletRequest request
											  , BindingResult bindingResult	) throws Exception {
	
			ModelAndView model = new ModelAndView();
			
			try{
				
				
				EmpInfoVO user = new EmpInfoVO();
				user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
				if (user ==  null){
					LOGGER.debug("로그인 기록 없음");		    	
					model.setViewName("/front/noInfo");
					return model;
				}
				
				
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("pageIndx", searchVO.getPageIndex());
				params.put("pageUnit", searchVO.getPageUnit());
				params.put("pageSize", searchVO.getPageSize());
				params.put("searchUserId", user.getEmpno() );
				//params.put("searchStartDay", LocalDateTime.now().minusMonths(2).format(DateTimeFormatter.ofPattern("yyyyMMdd")));
				//params.put("searchEndDay", "20301231");
				model = frontService.selectResManageListByPagination(params);
				model.addObject(Globals.STATUS_REGINFO, searchVO);
				model.addObject("selectCancel", cmmnDetailService.selectCmmnDetailCombo("CANCEL_CODE") );
			
			}catch(Exception e){
				StackTraceElement[] ste = e.getStackTrace();
				LOGGER.info("error:" + e.toString() + ":" +  ste[0].getLineNumber());
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	 
			}
			model.setViewName("/front/resMyPage");
			return model;
	}
	@RequestMapping(value="resMeetingInfo.do")
	public ModelAndView selectMeetingResInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
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
			model.addObject("resInfo", resService.selectResManageView(searchVO.getResSeq()));
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("sucess.common.request"));
			
			
		}catch(Exception e){
			LOGGER.error("selectMeetingResInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
			
			
			
		}
		return model;
		
	}
	
	
	@RequestMapping(value="seatList.do")
	public ModelAndView selectSeatInfoList(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
										  , HttpServletRequest request
										  , BindingResult bindingResult	) throws Exception {
		
		
		ModelAndView model = new ModelAndView("/front/seatList");
		try{
			
			EmpInfoVO user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/front/noInfo");
			}
			model.addObject("selectCenter", centerService.selectCenterInfoManageCombo());
	    	
		}catch(Exception e){
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info("selectResInfo:" + e.toString() + ":" +  ste[0].getLineNumber());
			
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
		

	}
	@RequestMapping(value="seatListAjax.do" , produces = "application/json")
	public ModelAndView selectSeatInfoListAjax(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
										  , @RequestBody(required = false) Map<String,Object>  searchVO
										  , HttpServletRequest request
										  , BindingResult bindingResult	) throws Exception {
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			EmpInfoVO user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/front/noInfo");
			}
			
			
			
	    	model.addObject("selectCenter", centerService.selectCenterInfoManageCombo());
	    	//회의실 리스트
	    	if (searchVO == null)
	    		searchVO = new HashMap<String,Object>();
	    	int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
			  
		    searchVO.put("pageSize", propertiesService.getInt("pageSize"));
		    searchVO.put("mode", "list");
		  
		    LOGGER.info("pageUnit:" + pageUnit + ":searchVO" + searchVO.get("pageIndex"));
		  
	              
	   	    PaginationInfo paginationInfo = new PaginationInfo();
		    paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
		    paginationInfo.setRecordCountPerPage(pageUnit);
		    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

		    searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
		    searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
		    searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			  
			List<Map<String, Object>> seatList = meetingService.selectMeetingRoomEmptyManageList(searchVO);
			int totCnt = seatList.size() > 0 ?  Integer.valueOf( seatList.get(0).get("total_record_count").toString()) :0;
			
		    searchVO.put("pageIndex", util.NVL(searchVO.get("pageIndex"), "1"));
		    
		    model.addObject(Globals.JSON_RETURN_RESULTLISR, seatList);
		    model.addObject(Globals.STATUS_REGINFO, searchVO);
		    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		    paginationInfo.setTotalRecordCount(totCnt);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, searchVO);
			
		}catch(Exception e){
			
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info("selectResInfo:" + e.toString() + ":" +  ste[0].getLineNumber());
			
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
		

	}
	@RequestMapping(value="Index.do")
	public ModelAndView selectMgIndexInfo(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
									     , @RequestBody Map<String, Object> resInfo
									     , HttpServletRequest request
									     , BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView("/front/index");
		try{
			
			
          
			LOGGER.debug("-----------------------------------  로그인 페이지로 넘기기");
			EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/front/noInfo");
			}
			     
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULTLISR, resService.selectIndexList(resInfo));
			//신규 수정 
			model.addObject("boardList", boardInfoService.selectIndexBoardTitle());
			
		}catch(Exception e){
			LOGGER.error("selectResInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
		
	}
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
					model.addObject("resUserList", empInfo.selectMeetinngUserList(empNoList));
					
				}
				//영상회의 이면 
				if (resInfo.get("res_gubun").toString().equals("SWC_GUBUN_2") && !util.NVL(resInfo.get("meeting_seq"), "").equals("")){
					LOGGER.debug("resInfo.getMeetingSeq():" + resInfo.get("meeting_seq"));
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

	
	//부서별로 변경 
	@RequestMapping (value="resjobPst.do")
	public ModelAndView resjobPst (@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
                                   , @ModelAttribute("ResInfoVO")  ResInfoVO resSearch
			                       , HttpServletRequest request
                                   , BindingResult bindingResult) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
		try{
			
			model.addObject("jobPst", orgService.selectOrgInfoCombo());	
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			
		}catch(Exception e){
			LOGGER.debug("error:" + e.toString());
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.request.msg"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		return model;
	}
	 //아이디로 수정 
	@RequestMapping (value="resSsoTInfo.do")
	public ModelAndView resSsoTInfo (@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
                                     , @RequestParam("empno") String empno
                                     , HttpServletRequest request
                                     , BindingResult bindingResult) throws Exception{
		
		
		
		LOGGER.debug("sso 로그인 시작");
		ModelAndView model = new ModelAndView("/front/index");
		try{
			
			if(!util.NVL(empno, "").equals("")){
    			//로그인 수정 
				EmpInfoVO resultVO = empInfo.selectSmartOfficeLoginAction(empno);        
        		
        		if (resultVO != null && resultVO.getEmpno() != null ) {
    	        	Map<String, Object> resInfo = new HashMap<String, Object>();
        			model.addObject(Globals.JSON_RETURN_RESULTLISR, resService.selectIndexList(resInfo));
        			model.addObject("boardList", boardInfoService.selectIndexBoardTitle());
        			       			
        			//
    	        	// 2. spring security 연동        
        			//LOGGER.debug("user:" + resultVO.toString() +  resultVO.getEmpno());
    	        	request.getSession().setAttribute("empInfoVO", resultVO);
    	        	
    	        	LOGGER.debug("getsession:" + request.getSession().getAttribute("empInfoVO").toString());
    	        	
    	        	empInfoVO = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
    	        	LOGGER.debug("user:" + empInfoVO.toString());
    	        	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
    	        } else {
    	        	LOGGER.debug("로그인 실패");
    	        	model.setViewName("/front/noInfo");
    	        	model.addObject(Globals.STATUS_MESSAGE,   egovMessageSource.getMessage("page.login.alert04"));
    	        	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
	 	        }
        	}else{
        		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
    	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);		
    	    	model.setViewName("/front/noInfo");
        	}
		}catch(Exception e){
			LOGGER.debug("error:" + e.toString());
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.request.msg"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		return model;
	}
	
	
	
	
	@RequestMapping (value="resListInfo.do")
	public ModelAndView selecCenterSeatView(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
                                            , @ModelAttribute("ResInfoVO")  ResInfoVO resSearch
                                            , HttpServletRequest request
                                    		, BindingResult bindingResult) throws Exception{	
		
        ModelAndView model = new ModelAndView("/front/resListInfo");
		
	    try{
	    	//SSO 관련 내용 넣기  
	    	EmpInfoVO user = new EmpInfoVO();
			user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
			if (user ==  null){
				LOGGER.debug("로그인 기록 없음");		    	
				model.setViewName("/front/noInfo");
			}
	    	
			if (resSearch.getSearchResStartday().equals("")){
				resSearch.setSearchResStartday(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")));	
			}
			//지점이 없을 경우 
			//디폴트로 최근값 넣기 
			model.addObject("selectCenter", centerService.selectCenterInfoManageCombo());
	    	model.addObject(Globals.STATUS_REGINFO, resSearch);
	    	
	 	    	 
	    }catch(Exception e){
	    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));
	    	model.addObject(Globals.STATUS,  Globals.STATUS_FAIL);	 
	    }
	    return model;
	}
	@RequestMapping(value="resPadInfo.do")
	public ModelAndView selecKioskPop (@ModelAttribute("ResInfoVO")  ResInfoVO resSearch
			                                              , @RequestParam("swcSeq") String swcSeq
														  , HttpServletRequest request
														  , BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView("/front/kiosk/meetingR");
		try{
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject("regist", meetingService.selectMeetingRoomDetailInfoManage(swcSeq));
			//신규 수정 
			
           
			
		}catch(Exception e){
			LOGGER.error("selectResInfo ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));
		}
		return model;
		
	}
	@RequestMapping(value="resPadInfoAjax.do")
	public ModelAndView selecKioskPopAjax (@RequestBody Map<String, Object> resSearch
                                           , @RequestParam("swcSeq") String swcSeq
										   , HttpServletRequest request
										   , BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			resSearch.put("swcSeq", swcSeq);
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			
			
			List<Map<String, Object>> resInfos =  resService.selectIndexList(resSearch);
			model.addObject(Globals.JSON_RETURN_RESULTLISR , resInfos);
			//
			//신규 수정 
			
			String searchDay = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			
			model.addObject("dayInfo",    searchDay.substring(0,10));
			model.addObject("timeInfo",    searchDay.substring(11,19));
			
			List<Map<String, Object>> timeLists = resService.selectKioskCalendarList(swcSeq);
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
			int i = 0;
			for (Map<String, Object>  resInfo :   resInfos ){
				if (! util.NVL(resInfo.get("resattendlist"), "").equals("")  && i ==0){
					List<String> empNoList =  Arrays.asList(resInfo.get("resattendlist").toString().split("\\s*,\\s*"));
					LOGGER.debug("empNoList:" + empNoList.size());
					model.addObject("resUserList", empInfo.selectMeetinngUserList(empNoList));					
				}	
				i++;
			}
			
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
						LOGGER.debug("=======ret" + ret);
						LOGGER.debug("=======ret" + resinfo.getResState());
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
							EmpInfo resultVO = empInfo.selectSmartOfficeLoginAction(empInfoVO.getEmpid());        
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
