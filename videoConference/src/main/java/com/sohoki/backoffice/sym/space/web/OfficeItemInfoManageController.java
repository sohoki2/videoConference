package com.sohoki.backoffice.sym.space.web;

import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.sohoki.backoffice.sym.space.service.QrcpdeInfoManageServie;
import com.sohoki.backoffice.sym.space.vo.DeviceInfo;
import com.sohoki.backoffice.sym.space.vo.MeetingRoomInfo;
import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;
import com.sohoki.backoffice.sym.space.vo.QrcodeInfo;
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

import javax.servlet.ServletContext;

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
	private QrcpdeInfoManageServie qrService;
	
	@Autowired
	private fileService uploadFile;
	
	@Autowired
    ServletContext servletContext;
	
	
	
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
		  //비용 관련 내용 넣기 
		  model.addObject("payGubun", cmmnDetailService.selectCmmnDetailCombo("PAY_CLASSIFICATION"));
		  model.addObject("seatGubun", cmmnDetailService.selectCmmnDetailCombo("SEAT_GUBUN"));
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
		    if (searchVO.get("searchFloorSeq") != null ) {
		    	 Map<String, Object> mapInfo = searchVO.get("searchPartSeq") != null ? floorService.selectFloorInfoManageDetail(searchVO.get("searchFloorSeq").toString()) : partService.selectFloorPartInfoManageDetail(searchVO.get("searchPartSeq").toString());
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
			  //삭제 관련 내용 수정 공용에서 수정으로 
			  int ret =  officeService.deleteOfficeSeatQrInfoManage(util.dotToList(seatId));
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
	/*
	 *  qr 이미지 생성 
	 * 
	 * 
	 */
	@RequestMapping (value="officeSpaceQrCreate.do")
	public ModelAndView selectFloorInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
									          , @RequestBody Map<String, Object> params	) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }
	    try {
	    	//qr 생성 (좌석/회의실) 사용유무 할지는 나중에 정리 
	    	Map<String, Object> search = new HashMap<String, Object>();
	    	search.put("searchQrplay", "Y");
	    	
	    	//추후 겁색 값으로 대처 필요 
	    	search.put("firstIndex", 0);
	    	search.put("lastRecordIndex", 1000);
	    	search.put("recordCountPerPage", 1000);
				  
	    	String qr_code = "";
	        String path = "";
	        //path = servletContext.getRealPath("/") + propertiesService.getString("qrCodePath") + "/";
	        path =  propertiesService.getString("Globals.qrPath");
	         
	    	List<Map<String, Object>> qrLists = params.get("qrMode").equals("Seat") ? officeService.selectOfficeSeatInfoManageListByPagination(search)
	    			                           : meetingService.selectMeetingRoomManageListByPagination(search);
	    	
	    	
	    	
	    	int ret = 0;
	    	for (Map<String, Object> qrList : qrLists) {
	    		 //추후 변경 예정
	    		if(params.get("qrMode").equals("Seat")) {
	    			 qr_code = qrList.get("seat_id").toString()+"_" + UUID.randomUUID().toString().replace("-", "").substring(0, 8);
		    		 String result =  util.getQrCode(path, qr_code, 200, 300, qrList.get("seat_id").toString()); // qr코드 생성 및 이미지 생성
		    		 if (!result.equals("FAIL")) {
		    			 QrcodeInfo info = new QrcodeInfo();
			    		 info.setItemId(qrList.get("seat_id").toString());
			    		 info.setMode("Ins");
			    		 info.setQrGubun("ITEM_GUBUN_2");
			    		 info.setQrCode(qr_code);
			             info.setQrFullPath(path + "/" + qrList.get("seat_id").toString() + ".png");
			             info.setQrPath("/" + propertiesService.getString("qrCodePath") + "/" + qrList.get("seat_id").toString() + ".png");
			             ret = qrService.updateQrcodeManage(info);
		    		 } 	
	    		}else {
	    			
	    			 qr_code = qrList.get("meeting_id").toString()+"_" + UUID.randomUUID().toString().replace("-", "").substring(0, 8);
		    		 String result =  util.getQrCode(path, qr_code, 200, 300, qrList.get("meeting_id").toString()); // qr코드 생성 및 이미지 생성
		    		 if (!result.equals("FAIL")) {
		    			 QrcodeInfo info = new QrcodeInfo();
			    		 info.setItemId(qrList.get("meeting_id").toString());
			    		 info.setMode("Ins");
			    		 
			    		 String itemGubun = qrList.get("room_type").toString().equals("SWC_GUBUN_1") ? "ITEM_GUBUN_1" : "ITEM_GUBUN_3";
			    		 info.setQrGubun(itemGubun);
			    		 //qr 등록 만들기 
			             info.setQrCode(qr_code);
			             info.setQrFullPath(path + "/" + qrList.get("meeting_id").toString() + ".png");
			             info.setQrPath("/" + propertiesService.getString("qrCodePath") + "/" + qrList.get("meeting_id").toString() + ".png");
			             ret = qrService.updateQrcodeManage(info);
		    		 } 
	    		}
	    		
	    	}
	    	
	    	model.addObject(Globals.STATUS_MESSAGE, "QR 코드가 정상적으로 생성 되었습니다.");
	    	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			
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
		  try {
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
			  //model.addObject("selectSwcGubun", cmmnDetailService.selectCmmnDetailCombo("SWC_GUBUN"));
			  
			  model.addObject("selectMail", msgService.selectMsgCombo("MSG_TYPE_1"));
			  model.addObject("selectSms", msgService.selectMsgCombo("MSG_TYPE_2"));
			  
			  
			  HashMap<String, Object> params = new HashMap<String, Object>();
			  params.put("code", "SWC_GUBUN");
			  params.put("notIn", "List");
			  params.put("notlist",  util.dotToList("SWC_GUBUN_4"));
			  model.addObject("selectSwcGubun", cmmnDetailService.selectCmmnDetailComboEtc(params));
		      
			  
		  }catch(Exception e) {
			  StackTraceElement[] ste = e.getStackTrace();
			  LOGGER.info(e.toString() + ':' + ste[0].getLineNumber());
			  model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		  }
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
			
			
			
			LOGGER.debug("---------------------------------------------------------------");
			int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
			searchVO.put("pageSize", propertiesService.getInt("pageSize"));
		          
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
		    if (searchVO.get("searchFloorSeq") != null ) {
		    	 Map<String, Object> mapInfo = searchVO.get("searchPartSeq") != null ? 
		    			 floorService.selectFloorInfoManageDetail(util.NVL(searchVO.get("searchFloorSeq"),"").toString()) : 
		    		     partService.selectFloorPartInfoManageDetail(util.NVL(searchVO.get("searchPartSeq"),"").toString());
		    	 model.addObject("seatMapInfo", mapInfo);
		    }
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info("ERROR" + e.toString() + "line" + ste[0].getLineNumber());
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
			vo.setMeetingImg3( uploadFile.uploadFileNm(mRequest.getFiles("meetingImg3"), propertiesService.getString("Globals.filePath")));
			vo.setMeetingFile01( uploadFile.uploadFileNm(mRequest.getFiles("meetingFile1"), propertiesService.getString("Globals.filePath")));
			vo.setMeetingFile02( uploadFile.uploadFileNm(mRequest.getFiles("meetingFile2"), propertiesService.getString("Globals.filePath")));
			
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
			  // 추가 수정 
			  int ret = 	meetingService.deleteMeetingRoomManage(util.dotToList(meetingId));
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
	
	
}
