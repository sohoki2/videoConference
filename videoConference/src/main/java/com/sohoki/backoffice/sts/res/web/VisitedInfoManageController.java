package com.sohoki.backoffice.sts.res.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.sts.res.service.VisitedInfoManageService;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sts.res.vo.VisitedInfo;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RestController
@RequestMapping("/backoffice/visitedManage")
public class VisitedInfoManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(VisitedInfoManageController.class);
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private VisitedInfoManageService visitedService;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
	private FloorInfoManageService floorService;
	
	@Autowired
	private CenterInfoManageService centerService;
	
	
	@RequestMapping(value="visitedList.do")
	public ModelAndView  selectVisitedList(@ModelAttribute("loginVO") AdminLoginVO loginVO,
			                               @ModelAttribute("visitedInfo") VisitedInfo visitedInfo 
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
		  String title = visitedInfo.getVisitedGubun().equals("VISITED_GUBUN_1") ? "방문자 예약 신청" : "투어 신청";
		  visitedInfo.setVisitedTitle(title);
		  
		  
		  model.addObject("centerInfo", centerService.selectCenterInfoManageCombo());
		  model.addObject(Globals.STATUS_REGINFO , visitedInfo);
		  //비용 관련 내용 넣기 
		 
	      model.setViewName("/backoffice/resManage/visitedList");
		  return model;	
	}
	@RequestMapping(value="visitedListAjax.do")
	public ModelAndView  selectVisitedListAjax(@ModelAttribute("loginVO") AdminLoginVO loginVO
                                               , @RequestBody Map<String, Object> searchVO
											   , HttpServletRequest request
											   , BindingResult bindingResult	) throws Exception {
		
		
		  ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		  Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		  if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
				return model;	
		  }else {
	    	   HttpSession httpSession = request.getSession(true);
	    	   loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
		  }
		  try {
			  PaginationInfo paginationInfo = new PaginationInfo();
			  paginationInfo.setCurrentPageNo( Integer.valueOf( util.NVL(searchVO.get("pageIndex"), "1")));
			  paginationInfo.setRecordCountPerPage(Integer.valueOf( util.NVL(searchVO.get("pageUnit"), propertiesService.getInt("pageUnit"))));
			  paginationInfo.setPageSize(Integer.valueOf( util.NVL(searchVO.get("pageSize"), propertiesService.getInt("pageSize"))));
			 
			  searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
			  searchVO.put("lastIndex", paginationInfo.getLastRecordIndex());
			  searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			
			 
	          String date1 = util.NVL(searchVO.get("searchStartDay"),  com.sohoki.backoffice.util.SmartUtil.reqDay(0)) ;
	          String date2 =  util.NVL(searchVO.get("searchEndDay"),  com.sohoki.backoffice.util.SmartUtil.reqDay(10)) ;
	          searchVO.put("searchStartDay", date1);
	          searchVO.put("searchEndDay", date2);
	          searchVO.put("SearchEmpno", loginVO.getAdminId());
	          
	  		  List<Map<String, Object>> reslist = visitedService.selectVisitedManageListByPagination(searchVO);
	  		  int totCnt = reslist.size() > 0 ?  Integer.valueOf(reslist.get(0).get("total_record_count").toString()) : 0;
		      model.addObject(Globals.JSON_RETURN_RESULTLISR,  reslist );
		      model.addObject(Globals.STATUS_REGINFO, searchVO);
		     
		     
		      paginationInfo.setTotalRecordCount(totCnt);
		      model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		      model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		      model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  }catch (Exception e) {
			  StackTraceElement[] ste = e.getStackTrace();
		      int lineNumber = ste[0].getLineNumber();
			  LOGGER.error("resPreCheckString error:"+ e.toString() + ":" + lineNumber);
			  model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		  }
		  return model;	
	}
	@RequestMapping(value="visitedStateChange.do")
	public ModelAndView visitedStateChange(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                               , @RequestBody VisitedInfo info
										   , HttpServletRequest request
										   , BindingResult bindingResult) throws Exception{
		
		   ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		   try{
			   Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			   if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					return model;	
			   }else {
		    	   HttpSession httpSession = request.getSession(true);
		    	   loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
			   }
			   info.setVisitedUpdateid(loginVO.getAdminId());
			   int ret = visitedService.updateVisitedStateChangeInfoManage(info) ;
			   if (ret > 0) {
				   model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.update"));
			   }else {
				   throw new Exception(); 
			   }
		   }catch (Exception e){
			   model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		   }
	       return model;
	}
	@RequestMapping(value="visitedDetailInfo.do")
	public ModelAndView visitedDetailInfo(@ModelAttribute("loginVO") AdminLoginVO loginVO
							               , @RequestBody VisitedInfo info
										   , HttpServletRequest request
										   , BindingResult bindingResult) throws Exception{

           ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		   try{
			   
				Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
				if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					return model;	
				}else {
					HttpSession httpSession = request.getSession(true);
					loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
				}
			    
			    List<List<Object>> visitedInfos =  visitedService.selectVisitedDetailInfo(info) ;
			   
			    
			    if (info.getVisitedGubun().equals("VISITED_GUBUN_1")) {
			    	//Map<String, Object> visitedInfo =  getDataset( visitedInfos , 0 );
			    	// getDataset 에서 확인 필요 
			    	
			    	//List<Object> obj1 =   getDataset( visitedInfos , 0 );
			    	
			    	//visitedInfos.stream().limit(1).collect(Collectors.toList()).get(0).forEach(System.out::println);
			    	//visitedInfos.stream().skip(1).collect(Collectors.toList()).get(0).forEach(System.out::println);
			    	
			    	/*
			    	LOGGER.debug("---0" + getDataset(visitedInfos,1).size());
			    	LOGGER.debug("---1" + getDataset(visitedInfos,0).size());
			    	
			    	LinkedHashMap<Object, List<HashMap<Object, Object>>> result = null;
			        result = visitedInfos.stream().collect( Collectors.groupingBy(arg-> arg.get("key"), LinkedHashMap::new, Collectors.toList()) );
			    	result.forEach( (key, value)->{
			            System.out.println(key + "  :  " + value);
			        });   
			        
			    	*/
			    	
			    	model.addObject("visitedInfo", visitedInfos.stream().limit(1).collect(Collectors.toList()).get(0).get(0) );
			    	model.addObject("visitedDetailInfo", visitedInfos.stream().skip(1).collect(Collectors.toList()).get(0));
			    }else {
			    	model.addObject("visitedInfo", visitedInfos.stream().limit(1).collect(Collectors.toList()).get(0));
			    }
			    
			    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			    model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.select"));
			    
			    
			}catch (Exception e){
				StackTraceElement[] ste = e.getStackTrace();
			    int lineNumber = ste[0].getLineNumber();
				LOGGER.error("resPreCheckString error:"+ e.toString() + ":" + lineNumber);
				
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
			}
			return model;
	}
	private Map<String, Object> getDataset(List<List<Object>> visitedInfos, int i) {
		// TODO Auto-generated method stub
		return null;
	}
}
