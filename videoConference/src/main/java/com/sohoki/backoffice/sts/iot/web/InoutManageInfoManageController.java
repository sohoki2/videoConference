package com.sohoki.backoffice.sts.iot.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfo;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfoVO;


import com.sohoki.backoffice.sts.iot.service.InoutManageInfoManageService;
import com.sohoki.backoffice.sts.res.service.ResInfoManageService;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;

@Controller
public class InoutManageInfoManageController {

	    private static final Logger LOGGER = LoggerFactory.getLogger(InoutManageInfoManageController.class);
	
		
	    @Autowired
		protected EgovMessageSource egovMessageSource;
		
		@Autowired
	    protected EgovPropertyService propertiesService;

		
		@Autowired
		private InoutManageInfoManageService iotService;
		
		@Autowired
		private ResInfoManageService resService;
		
		@Autowired
		private EmpInfoManageService empInfo;
		
		@Autowired
		private UniSelectInfoManageService uniInfo;
		
		@Autowired
		private CenterInfoManageService centerService;
		
		@Autowired
		private OrgInfoManageService orgService;
		
		@Autowired
		private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
		
		
		@RequestMapping(value="/backoffice/resManage/roomAccList.do")		
		public String resPreCheckString(@ModelAttribute("loginVO") AdminLoginVO loginVO
										, @ModelAttribute("searchVO") InoutManageInfoVO searchVO
										, HttpServletRequest request
										, BindingResult bindingResult						
										, ModelMap model) throws Exception{
			
		   if(  searchVO.getPageUnit() > 0  ){    	   
	    	   searchVO.setPageUnit(searchVO.getPageUnit());
		  }else {
				   searchVO.setPageUnit(propertiesService.getInt("pageUnit"));   
		  }
		  searchVO.setPageSize(propertiesService.getInt("pageSize"));
		  
	       /** pageing */       
	   	  PaginationInfo paginationInfo = new PaginationInfo();
		  paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		  paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		  paginationInfo.setPageSize(searchVO.getPageSize());

		  searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		  searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		  //수정
		  //searchcoworkerYn
		  searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		  if (searchVO.getSearchDayGubun() == null) {searchVO.setSearchDayGubun("2"); }
		  if (searchVO.getSearchOdr() == null) {searchVO.setSearchOdr("0"); }
          if (searchVO.getSearchCenterId() == null) {searchVO.setSearchCenterId(""); }
          if (searchVO.getSearchcoworkerYn() == null) {searchVO.setSearchcoworkerYn(""); }
          if (searchVO.getSearchorgId() == null) {searchVO.setSearchorgId(""); }
          //if (searchVO.getSearchStartDay() == null) {searchVO.setSearchStartDay(""); }
         // if (searchVO.getSearchEndDay() == null) {searchVO.setSearchEndDay(""); }
          
          if (searchVO.getSearchStartDay() == null) {searchVO.setSearchStartDay(com.sohoki.backoffice.util.SmartUtil.reqDay(0)); }
          if (searchVO.getSearchEndDay() == null) {searchVO.setSearchEndDay(com.sohoki.backoffice.util.SmartUtil.reqDay(0)); }
	    
          LOGGER.debug(searchVO.getSearchStartDay());
          LOGGER.debug(searchVO.getSearchEndDay());
          
          //관리자 강제로 사용
          searchVO.setUserId("");
          
          model.addAttribute("selectCenter", centerService.selectCenterInfoManageCombo());          
  		  //부서1
  		  model.addAttribute("selectOrg", orgService.selectOrgInfoCombo());
  		  
  		  model.addAttribute("selectResType", cmmnDetailService.selectCmmnDetailCombo("swc_gubun"));  		  
  		  model.addAttribute("selectProcessType", cmmnDetailService.selectCmmnDetailCombo("resProcess"));
  		  
          
	      model.addAttribute("resultList",   iotService.selectAttendManageListByPagination(searchVO) );
	      model.addAttribute("regist", searchVO);
	       
	      int totCnt = iotService.selectAttendManageListTotCnt_S(searchVO) ;       
		  paginationInfo.setTotalRecordCount(totCnt);
	      model.addAttribute("paginationInfo", paginationInfo);
	      model.addAttribute("totalCnt", totCnt);
			
		  return "/backoffice/resManage/roomAccList";
		}
		
		
		//입실/퇴실
		@RequestMapping(value="/backoffice/resManage/roomIn.do")
		@ResponseBody
		public String updateRoomInChnage(@ModelAttribute("searchVO") InoutManageInfo vo, 
                                         HttpServletRequest request, 
                                         BindingResult bindingResult,						
 										 ModelMap model)throws Exception {
			String attSeq = request.getParameter("attSeq") != null ? request.getParameter("attSeq") : "";
			String mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
			vo.setMode(mode);
			vo.setAttSeq(attSeq);
						
			int ret = iotService.updateAttRoomState(vo);
			if(ret > 0 ){
				ret = iotService.insertAttendManageIfs(vo);
			}
			return ret > 0 ? "T" : "F";
		}
		//로그인
		@RequestMapping(value="/backoffice/resManage/loginState.do")
		@ResponseBody
		public String updateLoginState(@ModelAttribute("searchVO") InoutManageInfo vo, 
                                         HttpServletRequest request, 
                                         BindingResult bindingResult,						
 										 ModelMap model)throws Exception {
						
			int ret = iotService.updateAttLoginState(vo);
			return ret > 0 ? "T" : "F";
		}
		//PC인증 후 로그인 하기 
		@RequestMapping(value="/backoffice/resManage/PCloginState.do")
		@ResponseBody
		public String selectPCLoginState(@ModelAttribute("searchVO") InoutManageInfoVO searchVO, 
                                         HttpServletRequest request, 
                                         BindingResult bindingResult,						
 										 ModelMap model)throws Exception {
			try{
				int ret = iotService.selectPCAuthCheck(searchVO);
				
				if (ret > 0){
				   String result =	iotService.selectLoginCheck( String.valueOf(ret));
				   InoutManageInfo vo = new InoutManageInfo();
				   
				   if (result.equals("T")){
					   vo.setMode("IN");
					   vo.setAttSeq(String.valueOf(ret));
				   }else {
					   vo.setMode("OT");
					   vo.setAttSeq(String.valueOf(ret));
				   }
				   ret = iotService.updateAttLoginState(vo);
				   return ret > 0 ? "T" : "F";	   				   
				}else {
					return "F";	
				}
				
			}catch (Exception e){
				return "F";
			}
			
		}
		//PC인증 후 로그인 하기 
		@RequestMapping(value="/backoffice/resManage/PCloginState_PCRec.do")
		@ResponseBody
		public String selectPCLoginStateRec(@ModelAttribute("searchVO") InoutManageInfoVO searchVO, 
                                         HttpServletRequest request, 
                                         BindingResult bindingResult,						
 										 ModelMap model)throws Exception {
			try{
				
				String empNo = request.getParameter("empNo") != null ? request.getParameter("empNo") : "";
				
				if (searchVO.getMode() == null ) {  
					String mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
					String seatId = request.getParameter("seatId") != null ? request.getParameter("seatId") : "";
					String pcPassword = request.getParameter("pcPassword") != null ? request.getParameter("pcPassword") : "";
					
					searchVO.setMode(mode);
					searchVO.setSeatId(seatId);
					searchVO.setUserId(empNo);					
					searchVO.setPcPassword(pcPassword);					
				}
				
				if (searchVO.getUserId() == null ){searchVO.setUserId(empNo);		}
				searchVO.setResDay(com.sohoki.backoffice.util.SmartUtil.reqDay(0)); 
				
				// 
				int ret = iotService.selectPCAuthCheck(searchVO);
				if (ret > 0){
				   String result =	iotService.selectLoginCheck( String.valueOf(ret));
				   
				   InoutManageInfo vo = new InoutManageInfo();
				   if (result.equals("T")){
					   vo.setMode("IN");
					   vo.setAttSeq(String.valueOf(ret));
					   
					   
					   String result_RoomIn =	iotService.selectLoginCheck( String.valueOf(ret));
					 //입실 확인 후 입실 안되어 있으면 입실 체크 
					  /* if (result_RoomIn.equals("T")){
						    vo.setMode("IN");
							vo.setAttSeq(String.valueOf(ret));
							ret = iotService.updateAttRoomState(vo);
						   
					   }*/
					   
					   
					   
					   
				   }else {
					   vo.setMode("OT");
					   vo.setAttSeq(String.valueOf(ret));
				   }
				   LOGGER.debug("attSeq:" + vo.getAttSeq());
				   
				   ret = iotService.updateAttLoginState(vo);
				   return ret > 0 ? "S" : "F";	   				   
				}else {
					return "F";	
				}
				
			}catch (Exception e){
				LOGGER.debug(e.toString());
				return "F";
			}			
		}
		@RequestMapping("/backoffice/resManage/iotListExcel.do")
    	public ModelAndView selectInotExcelList (@ModelAttribute("searchVO") InoutManageInfoVO searchVO)throws Exception{
    		
			 if (searchVO.getSearchDayGubun() == null) {searchVO.setSearchDayGubun("1"); }
			 if (searchVO.getSearchOdr() == null) {searchVO.setSearchOdr("0"); }
			 if (searchVO.getSearchCenterId() == null) {searchVO.setSearchCenterId(""); }
             if (searchVO.getSearchcoworkerYn() == null) {searchVO.setSearchcoworkerYn(""); }
             if (searchVO.getSearchorgId() == null) {searchVO.setSearchorgId(""); }
             if (searchVO.getSearchStartDay() == null) {searchVO.setSearchStartDay(""); }
             if (searchVO.getSearchEndDay() == null) {searchVO.setSearchEndDay(""); }           
            //관리자 강제로 사용
            searchVO.setUserId("");
            
            PaginationInfo paginationInfo = new PaginationInfo();
  		    paginationInfo.setCurrentPageNo(0);
  		    paginationInfo.setRecordCountPerPage(10000);
  		    paginationInfo.setPageSize(10000);
  		    
  		    
  		    
  		    searchVO.setFirstIndex(0); 
  		    searchVO.setRecordCountPerPage(1000);
  		    
    		List<InoutManageInfoVO> resReport =  iotService.selectAttendManageListByPagination(searchVO);
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("resReport", resReport);
    		
    		return new ModelAndView("IotReportExcelView", map);
    		
    	}
		
		
}
