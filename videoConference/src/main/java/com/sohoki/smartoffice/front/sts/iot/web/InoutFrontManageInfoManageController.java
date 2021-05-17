package com.sohoki.smartoffice.front.sts.iot.web;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.Globals;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.sts.iot.service.InoutManageInfoManageService;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfoVO;
import com.sohoki.smartoffice.front.sts.iot.web.InoutFrontManageInfoManageController;


@Controller
public class InoutFrontManageInfoManageController {

	
	
	private static final Logger LOGGER = LoggerFactory.getLogger(InoutFrontManageInfoManageController.class);
	 

	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;

	
	
	
	@Autowired
	private InoutManageInfoManageService iotService;
	
	
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
	
	
	
	
	@RequestMapping(value="/front/mypage/roomInfoList.do")		
	public String resPreCheckString(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
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
      if (searchVO.getSearchCenterId() == null) {searchVO.setSearchCenterId(""); }      
      if (searchVO.getSearchcoworkerYn() == null) {searchVO.setSearchcoworkerYn(""); }
      if (searchVO.getSearchorgId() == null) {searchVO.setSearchorgId(""); }
      if (searchVO.getSearchOdr() == null) {searchVO.setSearchOdr("0"); }
      
      DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
      Date date = new Date();
      Calendar cal = Calendar.getInstance();
      cal.setTime(date);
      cal.add(Calendar.DATE, 0);
      String date1 = dateFormat.format(cal.getTime());
      cal.setTime(date);
      cal.add(Calendar.DATE, +7);
      String date2 = dateFormat.format(cal.getTime());
      if (searchVO.getSearchStartDay() == null) {searchVO.setSearchStartDay(date1);}
      if (searchVO.getSearchEndDay() == null) {searchVO.setSearchEndDay(date1); }
      //여기 부분 수정 외부인 리스트 안나옴
      searchVO.setCoworkerYn("0");
      
      EmpInfo user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
	  if (user == null){
	    	//나중에 주석 풀기 
		  LOGGER.debug("로그인 기록 없음");		    	
	    	return "/index.do";
	  }
      searchVO.setUserId(user.getEmpno());
      
      model.addAttribute("resultList",   iotService.selectAttendManageListByPagination(searchVO) );
      model.addAttribute("regist", searchVO);
       
      int totCnt = iotService.selectAttendManageListTotCnt_S(searchVO) ;       
	  paginationInfo.setTotalRecordCount(totCnt);
      model.addAttribute("paginationInfo", paginationInfo);
      model.addAttribute("totalCnt", totCnt);
		
	  return "/front/mypage/roomInfoList";
	}
	
	
}
