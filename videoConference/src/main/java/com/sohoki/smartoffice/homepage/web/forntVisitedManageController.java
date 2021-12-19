package com.sohoki.smartoffice.homepage.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.sts.res.service.VisitedInfoManageService;
import com.sohoki.backoffice.sts.res.vo.VisitedInfo;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.com.cmm.service.Globals;
import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;




@RestController
@RequestMapping("/visit")
public class forntVisitedManageController {

	
	private static final Logger LOGGER = LoggerFactory.getLogger(forntVisitedManageController.class);
	
	@Autowired
	private CenterInfoManageService centerService;
	
	@Autowired
	private VisitedInfoManageService visitedService;
	
	@Autowired
	private EmpInfoManageService empService;
	
	@Autowired
	private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	
	@Autowired
	private SmartUtil util;
	
	@NoLogging
	@RequestMapping(value="inc/top_inc.do")
	public ModelAndView visitedTop() throws Exception{		
		ModelAndView model = new ModelAndView();
		//다음주 설정 작업 예정 
		
		model.setViewName("/visited/inc/top_inc");
		return model;
	}
	
	@RequestMapping(value="Index.do")	
	public ModelAndView visitedIndex() throws Exception{				
		ModelAndView model = new ModelAndView();
		
		LOGGER.debug("=============================================================");
		String url = "/visited/index";
		model.setViewName(url);
		return model;		
	}
	//방문자 검색 
	@RequestMapping(value="VisitSearch.do")	
	public ModelAndView visitSearch(@RequestParam String  visitedGubun) throws Exception{				
		ModelAndView model = new ModelAndView();
		
		LOGGER.debug("=============================================================");
		String url = "/visited/visitSearch";
		
		//신규 추가 
		model.addObject("visitedGubun", visitedGubun);
	  	model.setViewName(url);
		return model;		
	}
	@RequestMapping(value="VisitSearchResult.do")	
	public ModelAndView visitSearchResult(@RequestBody Map<String, Object> params 
									, HttpServletRequest request
						            , BindingResult bindingResult)throws Exception{		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			
			params.put("firstIndex", 0);
			params.put("lastIndex", 1000);
			params.put("recordCountPerPage", 1000);

			String date1 =  com.sohoki.backoffice.util.SmartUtil.reqDay(0) ;
	        String date2 =  com.sohoki.backoffice.util.SmartUtil.reqDay(90) ;
	        params.put("searchStartDay", date1);
	        params.put("searchEndDay", date2);
	          
			List<Map<String, Object>> visitedList = visitedService.selectVisitedManageListByPagination(params);
			int totCnt = visitedList.size() > 0 ?  Integer.valueOf(visitedList.get(0).get("total_record_count").toString()) : 0;
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULTLISR, visitedList);
			
		}catch(Exception e) {
			LOGGER.debug("visitSearchResult error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		return model;		
	}
	@RequestMapping(value="VisitSearchDetailResult.do")	
	public ModelAndView visitSearchDetailResult(@RequestParam String  visitedCode)throws Exception{		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULTLISR, visitedService.selectVisitedDetailInfoFront(visitedCode));
			
		}catch(Exception e) {
			LOGGER.debug("visitSearchResult error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		return model;		
	}
	@RequestMapping(value="VisitCancel.do")	
	public ModelAndView visitCancel(@RequestBody VisitedInfo info)throws Exception{		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			int ret =  visitedService.updateVisitedStateChangeInfoManage(info);
			
			if (ret > 0) {
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, "정상적으로 취소 되었습니다.");
				
			}else {
				throw new Exception(); 
			}
		}catch(Exception e) {
			LOGGER.debug("visitSearchResult error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		return model;		
	}
	
	@RequestMapping(value="TourReser.do")	
	public ModelAndView tourReser(@ModelAttribute("VisitedInfo") VisitedInfo info) throws Exception{				
		ModelAndView model = new ModelAndView();
		String url = "/visited/tourReser";
		try {
			
			model.addObject("tourCombo", visitedService.selecttourCombo());  
			model.addObject("selectTourGubun", cmmnDetailService.selectCmmnDetailCombo("TOUR_TIME")); 
			model.addObject("tourInfo", visitedService.selecttourInfo());  
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		
	  	model.setViewName(url);
		return model;		
	}
	@RequestMapping(value="VisitReser.do")	
	public ModelAndView visitReser() throws Exception{				
		ModelAndView model = new ModelAndView();
		String url = "/visited/visitReser";
		try {
			model.addObject("centerInfo", centerService.selectCenterInfoManageCombo());  
			
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		
	  	model.setViewName(url);
		return model;		
	}
	@RequestMapping(value="VisitEmpsearch.do")	
	public ModelAndView userSearch (@RequestBody Map<String, Object> params 
									, HttpServletRequest request
						            , BindingResult bindingResult)throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			LOGGER.debug("--------------:" + params.get("searchCondition"));
			LOGGER.debug("--------------:" + params.get("searchKeyword"));
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULTLISR , empService.selectEmpInfoCombo(params));
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		return model;
	}
	@RequestMapping(value="VisitQrTest.do")	
	public ModelAndView visitQrTest ()throws Exception{
		
		ModelAndView model = new ModelAndView();
		String url = "/visited/qrTest";
		try {
			
			
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		
	  	model.setViewName(url);
		return model;	
	}
	@RequestMapping(value="VisitQrProcess.do")	
	public ModelAndView visitQrProcess (@RequestBody VisitedInfo visitedInfo)throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			EgovFileScrty fileScrty = new EgovFileScrty();	
			
			LOGGER.debug("======================================================");
			
			visitedInfo.setVisitedStatus("VISITED_STATE_5");
			visitedInfo.setVisitedGubun("VISITED_GUBUN_1");
			String visitedCode = fileScrty.decode(visitedInfo.getVisitedQrcode());
			fileScrty = null;
			
			String [] visitedCodes = visitedCode.split(":");
			
			
			Map<String, Object> searchVO = new HashMap<String, Object>();
			searchVO.put("visitedCode",  visitedCodes[0] );
			searchVO.put("visitedCelphone",  visitedCodes[1] );
			
			Map<String, Object> info =  visitedService.selectVisitedQrManageInfo(searchVO) ;
			//신규 추가 
			visitedInfo.setVisitedCode(info.get("visited_code").toString());
			visitedInfo.setVisitedSeq(info.get("visited_seq").toString());
			int ret = visitedService.updateVisitedStateChangeInfoManage(visitedInfo);
			
			if (ret > 0) {
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, "정상적으로 담당자에게 요청 되었습니다.");
			}else {
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, "잘못된 QR 이미지 이거나 예약되지 않는 정보 입니다.");
			}
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		return model;	
	}
	@RequestMapping(value="visitQrNewProcess.do")	
	public ModelAndView visitQrNewProcess (@RequestBody VisitedInfo visitedInfo)throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			EgovFileScrty fileScrty = new EgovFileScrty();	
			
			LOGGER.debug("======================================================");
			
			visitedInfo.setVisitedStatus("VISITED_STATE_5");
			visitedInfo.setVisitedGubun("VISITED_GUBUN_1");
			String visitedCode = fileScrty.decode(visitedInfo.getVisitedQrcode());
			fileScrty = null;
			
			String [] visitedCodes = visitedCode.split(":");
			
			
			Map<String, Object> searchVO = new HashMap<String, Object>();
			searchVO.put("visitedCode",  visitedCodes[0] );
			searchVO.put("visitedCelphone",  visitedCodes[1] );
			
			Map<String, Object> info =  visitedService.selectVisitedQrManageInfo(searchVO) ;
			//신규 추가 
			visitedInfo.setVisitedCode(info.get("visited_code").toString());
			visitedInfo.setVisitedSeq(info.get("visited_seq").toString());
			int ret = visitedService.updateVisitedStateChangeInfoManage(visitedInfo);
			
			if (ret > 0) {
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, "정상적으로 담당자에게 요청 되었습니다.");
			}else {
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, "잘못된 QR 이미지 이거나 예약되지 않는 정보 입니다.");
			}
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		return model;	
	}
	@RequestMapping(value="VisitQrImage.do")	
	public ModelAndView visitQrImage (@RequestParam String  visitedCode)throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULT, visitedService.selectVisitedManageInfo(visitedCode));
			
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		return model;	
	}
	@RequestMapping(value="VisitReserProcess.do")	
	public ModelAndView visitReserProcess(@RequestBody Map<String, Object> visitedInfo
			                              , HttpServletRequest request
					                      , BindingResult bindingResult) throws Exception{				
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
		try {
			 
			//Gson gson = new GsonBuilder().create();
			//List<VisitedDetailInfo> detailLists = gson.fromJson(visitedInfo.get("visitedDetail").toString(), new TypeToken<List<VisitedDetailInfo>>(){}.getType());
			if (visitedInfo.get("visitedGubun").equals("VISITED_GUBUN_2") ) {
				Map<String, Object> visitedCntInfo = visitedService.selectTourCount(visitedInfo);
				if ((int)visitedCntInfo.get("tour_allow_person") <  ((int)visitedCntInfo.get("tour_person") + Integer.valueOf(visitedInfo.get("visitedPerson").toString()) )) {
					model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
					model.addObject(Globals.STATUS_MESSAGE, "허용 신청 인원을 초과 하였습니다.");
					return model;
				}
			}
			int ret = visitedService.updateVisitedReqManageInfo(visitedInfo);
		    
			if (ret > 0) {
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			}else {
				throw new Exception(); 
			}
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		
		return model;		
	}
	@RequestMapping(value="VisitUpdaterProcess.do")	
	public ModelAndView updateVisitedStateChangeInfoManage(@RequestBody VisitedInfo visitedInfo
						                                   , HttpServletRequest request
								                           , BindingResult bindingResult) throws Exception{	
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			 
			
			int ret = visitedService.updateVisitedStateChangeInfoManage(visitedInfo);
			if (ret > 0) {
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, "정상적으로 처리 되었습니다.");
			}else {
				throw new Exception(); 
			}
		}catch(Exception e) {
			LOGGER.debug("visitReser error:"  + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, "시스템 장애 입니다. 관리자에게 문의 바랍니다.");
		}
		
		return model;		
	}
	
	
	
	
}
