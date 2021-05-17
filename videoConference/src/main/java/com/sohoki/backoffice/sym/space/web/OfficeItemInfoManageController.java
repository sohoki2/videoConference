package com.sohoki.backoffice.sym.space.web;

import java.io.BufferedReader;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser.Feature;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.sts.msg.service.MessageInfoManageService;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorPartInfoManageService;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfo;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfoVO;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.sym.space.service.DeviceInfoManageService;
import com.sohoki.backoffice.sym.space.service.MeetingRoomInfoManageService;
import com.sohoki.backoffice.sym.space.service.OfficeSeatInfoManageService;
import com.sohoki.backoffice.sym.space.vo.DeviceInfo;
import com.sohoki.backoffice.sym.space.vo.MeetingRoomInfo;
import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.util.service.fileService;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.google.gson.reflect.TypeToken;



@RestController
@RequestMapping("/backoffice/basicManage")
public class OfficeItemInfoManageController {

	
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OfficeItemInfoManageController.class);
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;

	@Autowired
	private SmartUtil util;
	
	@Autowired
	private UniSelectInfoManageService  uniService;
	
	@Autowired
	private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	
	@Autowired
	private OfficeSeatInfoManageService  officeService;
	
	@Autowired
	private MeetingRoomInfoManageService meetingService;
	
	@Autowired
	private FloorInfoManageService floorService;
	
	@Autowired
	private FloorPartInfoManageService partService;
	
	@Autowired
	private CenterInfoManageService centerInfoManageService;
	
	@Autowired
	private OrgInfoManageService orgService;
	
	@Autowired
	private DeviceInfoManageService deviceService;
	
	@Autowired
	private MessageInfoManageService msgService;
	
	@Autowired
	private fileService uploadFile;
	
	
	
	@RequestMapping(value="officeSeatList.do")
	public ModelAndView  selectCenterInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		
		
		  ModelAndView model = new ModelAndView(); 
		  Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		  if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
		  }else {
	    	   HttpSession httpSession = request.getSession(true);
	    	   loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
		  }
		  model.addObject("centerInfo", centerInfoManageService.selectCenterInfoManageCombo());
		  model.addObject("orgInfo", orgService.selectOrgInfoCombo());
	      model.setViewName("/backoffice/basicManage/officeSeatList");
		  return model;	
	}
	
	
	@NoLogging
	@RequestMapping (value="officeSeatUpdate.do")
	public ModelAndView updateOfficeSeatInfoManage(HttpServletRequest request
				                                   , @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
												   , @RequestBody OfficeSeatInfo vo
												   , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
		}else {
	    	 HttpSession httpSession = request.getSession(true);
	    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
	    	 vo.setUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
	    }
		
		try{
			model.addObject(Globals.STATUS_REGINFO , vo);
			String meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update" ;
			int ret = officeService.updateOfficeSeatInfoManage(vo);
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
						
			}else {
				throw new Exception();
			}
			
		}catch (Exception e){
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
	}
	//구역 리스트 보여 주기 
	@RequestMapping(value="officeSeatListAjax.do")
	public ModelAndView  selectOfficeSeatAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @RequestBody Map<String,Object>  searchVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		try {
			
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
			  
			List<Map<String, Object>> seatList = officeService.selectOfficeSeatInfoManageListByPagination(searchVO);
			int totCnt = seatList.size() > 0 ?  Integer.valueOf( seatList.get(0).get("total_record_count").toString()) :0;
			model.addObject(Globals.JSON_RETURN_RESULTLISR, seatList);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		    paginationInfo.setTotalRecordCount(totCnt);
		    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		    //지도 이미지 
		    if (searchVO.get("floorSeq") != null ) {
		    	 Map<String, Object> mapInfo = searchVO.get("partSeq") != null ? floorService.selectFloorInfoManageDetail(searchVO.get("floorSeq").toString()) : partService.selectFloorPartInfoManageDetail(searchVO.get("partSeq").toString());
		    	 model.addObject("seatMapInfo", mapInfo);
		    }
		   
		    
		    
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    
		    
		    
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
	}
	/*
	 * 좌석 삭제 
	 * 
	 */
	@RequestMapping (value="officeSeatDelete.do")
	public ModelAndView deleteOfficeSeatInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
			                                       @RequestParam("seatId") String seatId)throws Exception{
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }	
		try{
			  int ret = 	uniService.deleteUniStatement("", "tb_seatinfo", "SEAT_ID=["+seatId+"[");		      
		      if (ret > 0 ) {		
		    	  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    	  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.delete") );		    	 
		      }else {
		    	  throw new Exception();		    	  
		      }
		}catch (Exception e){
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));			
		}		
		return model;
	}
	/*
	 * 좌석 정보 상세 조회 
	 * 
	 */
	@RequestMapping (value="officeSeatDetail.do")
	public ModelAndView selectFloorInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
									           , @RequestParam("seatId") String seatId	) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }
	    try {
	    	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, officeService.selectOfficeSeatInfoManageDetail(seatId));
	    }catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    }
	    return model;
	}
	@NoLogging
	@RequestMapping(value="officeSeatGuiUpdate.do", method=RequestMethod.POST)
	public ModelAndView  updateSeatGuiPosition (@RequestBody Map<String, Object> params
			                                    , HttpServletRequest request
			                                    , BindingResult bindingResult) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
		try {
			
			Gson gson = new GsonBuilder().create();
			List<OfficeSeatInfo> seatInfos = gson.fromJson(params.get("data").toString(), new TypeToken<List<OfficeSeatInfo>>(){}.getType());
			//좌석/ 회의실 정리 하기 
			LOGGER.debug("========================================");
			LOGGER.debug("==type===" + params.get("type"));
			
			int result = officeService.updateOfficeSeatPositionInfoManage(seatInfos, params.get("type").toString());
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
            //model.addObject("resutlCnt", result);
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.update"));
		}
		return model;
		
	}
	@RequestMapping(value="officeMeetingList.do")
	public ModelAndView  selectMeetingInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		
		
		  ModelAndView model = new ModelAndView(); 
		  Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		  if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
		  }else {
	    	   HttpSession httpSession = request.getSession(true);
	    	   loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
		  }
		  model.addObject("centerInfo", centerInfoManageService.selectCenterInfoManageCombo());
		  model.addObject("orgInfo", orgService.selectOrgInfoCombo());
		  model.addObject("payGubun", cmmnDetailService.selectCmmnDetailCombo("PAY_CLASSIFICATION"));
		  model.addObject("selectSwcGubun", cmmnDetailService.selectCmmnDetailCombo("SWC_GUBUN"));
		  
		  model.addObject("selectMail", msgService.selectMsgCombo("MSG_TYPE_1"));
		  model.addObject("selectSms", msgService.selectMsgCombo("MSG_TYPE_2"));
		  
	      model.setViewName("/backoffice/basicManage/officeMeetingList");
		  return model;	
	}
	//구역 리스트 보여 주기 
	@RequestMapping(value="officeMeetingListAjax.do")
	public ModelAndView  selectOfficeMeetingAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
																			, @RequestBody Map<String,Object>  searchVO
																			, HttpServletRequest request
																			, BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		try {
			
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
			  
			List<Map<String, Object>> meetingList = meetingService.selectMeetingRoomManageListByPagination(searchVO);
			int totCnt = meetingList.size() > 0 ?  Integer.valueOf( meetingList.get(0).get("total_record_count").toString()) :0;
			model.addObject(Globals.JSON_RETURN_RESULTLISR, meetingList);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		    paginationInfo.setTotalRecordCount(totCnt);
		    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		    //지도 이미지 
		    if (searchVO.get("floorSeq") != null ) {
		    	 Map<String, Object> mapInfo = searchVO.get("partSeq") != null ? floorService.selectFloorInfoManageDetail(searchVO.get("floorSeq").toString()) : partService.selectFloorPartInfoManageDetail(searchVO.get("partSeq").toString());
		    	 model.addObject("seatMapInfo", mapInfo);
		    }
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
	}
	/*
	 * 회의실 정보 상세 조회 
	 * 
	 */
	@RequestMapping (value="officeMeetingDetail.do")
	public ModelAndView selectMeetingInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
									           , @RequestParam("meetingId") String meetingId) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }
	    try {
	    	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, meetingService.selectMeetingRoomDetailInfoManage(meetingId));
	    }catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    }
	    return model;
	}
	@NoLogging
	@RequestMapping (value="officeMeetingUpdate.do")
	public ModelAndView updateMeetingInfoManage(HttpServletRequest request
			                                    , MultipartRequest mRequest
				                                , @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
												, @ModelAttribute("MeetingRoomInfo") MeetingRoomInfo vo
												, BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
		}else {
	    	 HttpSession httpSession = request.getSession(true);
	    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
	    	 vo.setUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
	    }
		
		try{
			
			vo.setMeetingImg1( uploadFile.uploadFileNm(mRequest.getFiles("meetingImg1"), propertiesService.getString("Globals.filePath")));
			vo.setMeetingImg2( uploadFile.uploadFileNm(mRequest.getFiles("meetingImg2"), propertiesService.getString("Globals.filePath")));
			
			
			model.addObject(Globals.STATUS_REGINFO , vo);
			String meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update" ;
			int ret = meetingService.updateMeetingRoomManage(vo);
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
			}else {
				throw new Exception();
			}
		}catch (Exception e){
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
	}
	/*
	 * 좌석 삭제 
	 * 
	 */
	@RequestMapping (value="officeMeetingDelete.do")
	public ModelAndView deleteOfficeMeetingInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
			                                       @RequestParam("meetingId") String meetingId)throws Exception{
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }	
		try{
			  int ret = 	uniService.deleteUniStatement("MEETING_IMG1, MEETING_IMG2", "tb_meeting_room", "MEETING_ID=["+meetingId+"[");	
			  
			  
		      if (ret > 0 ) {	
		    	  //층 
		    	  uniService.updateUniStatement("MEET_CNT = MEET_CNT - 1", "tb_floorinfo", "FLOOR_SEQ = (SELECT FLOOR_SEQ FROM tb_meeting_room WHERE MEETING_ID=["+meetingId+"[)");
		    	  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    	  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.delete") );		    	 
		      }else {
		    	  throw new Exception();		    	  
		      }
		}catch (Exception e){
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));			
		}		
		return model;
	}
	@RequestMapping(value = "devicelist.do")
	public ModelAndView selectDeviceList(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                             , HttpServletRequest request
			                             , BindingResult bindingResult) throws Exception {
		ModelAndView model = new ModelAndView("/backoffice/basicManage/devicelist");
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
		}
		try {
			model.addObject("selectCenter", centerInfoManageService.selectCenterInfoManageCombo());
			model.setViewName("/backoffice/basicManage/devicelist");
		} catch (Exception e) {
			LOGGER.error("DeviceInfoManageListByPagination ERROR : " + e.toString());
		}
		return model;
	}
	@RequestMapping(value = "devicelistAjax.do")
	public ModelAndView selectDeviceListAjax(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                 , @RequestBody Map<String,Object>  searchVO
			                                 , HttpServletRequest request
			                                 , BindingResult bindingResult) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
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
		    

			
			List<Map<String, Object>> deviceList = deviceService.selectDevicePageInfoManageListByPagination(searchVO);
			model.addObject(Globals.JSON_RETURN_RESULTLISR, deviceList);
			int totCnt = deviceList.size() > 0 ?  Integer.valueOf( deviceList.get(0).get("total_record_count").toString()) :0;
			model.addObject(Globals.JSON_RETURN_RESULTLISR, deviceList);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		    paginationInfo.setTotalRecordCount(totCnt);
		    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    
			
		} catch (Exception e) {
			LOGGER.error("DeviceInfoManageListByPagination ERROR : " + e.toString());
		}
		return model;
	}
	
	@RequestMapping(value = "deviceInfoDetail.do")
	public ModelAndView selectDeviceDetailInfo(@RequestBody DeviceInfo vo 
			                                   , HttpServletRequest request 
			                                   , BindingResult bindingResult)  throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject("deviceInfo", deviceService.selectDevicePageInfoManageDetail(vo.getDeviceId()));
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.select"));	
		}
		
 
		return model;
	}
	
	@RequestMapping(value = "deviceInfoUpdate.do")
	public ModelAndView updateDeviceInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                   , @RequestBody DeviceInfo vo
			                                   , HttpServletRequest request
			                                   , BindingResult result) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
		}else {
	    	   vo.setUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
		}
		String meesage = "";
		
		try {
			int ret = 0;
			meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update";
			
			ret = deviceService.updateDevicePageInfoManage(vo);
			if (ret > 0) {
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject("deviceId", vo.getDeviceId());
				model.addObject(Globals.STATUS_MESSAGE,egovMessageSource.getMessage(meesage));
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			LOGGER.error("updateDeviceInfoManage ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE,egovMessageSource.getMessage("fail.common.update"));
		}
		return model;
	}
	
	@RequestMapping(value = "deviceInfoDelete.do")
	public ModelAndView deleteDeviceInfoManage(@RequestParam("deviceId") String deviceId) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			int ret = deviceService.deleteDevieManage(deviceId); 
			if (ret > 0) {
				model.addObject(Globals.STATUS_MESSAGE,egovMessageSource.getMessage("success.common.delete"));
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			LOGGER.error("deleteDeviceInfoManage ERROR : " + e.toString());
			model.addObject(Globals.STATUS_MESSAGE,egovMessageSource.getMessage("fail.common.delete"));
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
		return model;
	}
	
	//디바이스 통신
	@RequestMapping(value = "regist_device.do")
	public ModelAndView registDevice(@RequestParam("device_id") String device_id
			                         , HttpServletRequest request) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
        try {
    		String ip = "";
    		String mac  = "";    		
    		LOGGER.debug("device_id:" + device_id +":" + ip + ":" + mac);
    		try {
    			DeviceInfo vo = new DeviceInfo();
    			vo.setDeviceMac(mac);
    			vo.setDeviceId(device_id);
    			vo.setDeviceIp(ip);
    			int ret = deviceService.updateDeviceIpMac(vo);
    			JSONObject jsonResult1 = new JSONObject();
    			if (ret > 0){
    				jsonResult1.put("code", "OK");
    				jsonResult1.put("device_id", device_id);
    			}else {
    				jsonResult1.put("code", "fail");
    				jsonResult1.put("msg", "처리 도중 문제가 발생 하였습니다.");
    			}
    			model.addObject(jsonResult1);
    			
    		} catch (Exception e) {
    			LOGGER.error("registDevice ERROR : " + e.toString());
    		}
    		
        }catch(Exception e) {
        	System.out.println(e.toString());
        }
		return model;
	}
	
	@RequestMapping(value = "device_info.do")
	public ModelAndView selectDeviceStatus(@RequestParam("device_id") String device_id
			                               , HttpServletRequest request) throws Exception {
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		JSONObject jsonResult1 = new JSONObject();
		try {
			
			Map<String, Object> deviceInfo = deviceService.selectDeviceInfo(device_id);
			if (deviceInfo != null){
				jsonResult1.put("code", "OK");
				jsonResult1.put("url", "/front/resInfo/resPadInfo.do?swcSeq=" + deviceInfo.get("swc_seq"));
				jsonResult1.put("start_time",  deviceInfo.get("device_starttime") );
				jsonResult1.put("end_time",  deviceInfo.get("device_endtime") );
				jsonResult1.put("status",  deviceInfo.get("status"));
			}else {
				jsonResult1.put("code", "fail");
				jsonResult1.put("msg", "처리 도중 문제가 발생 하였습니다.");
			}
			
		} catch (Exception e) {
			jsonResult1.put("code", "fail");
			jsonResult1.put("msg", "처리 도중 문제가 발생 하였습니다.");
			LOGGER.error("selectDeviceStatus ERROR : " + e.toString());
		}
		model.addObject(jsonResult1);
		return model;
	}
	
}
