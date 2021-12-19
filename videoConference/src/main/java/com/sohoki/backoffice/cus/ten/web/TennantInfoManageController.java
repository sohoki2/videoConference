package com.sohoki.backoffice.cus.ten.web;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sohoki.backoffice.cus.com.servie.CompanyInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.cus.ten.service.TennantInfoManageService;
import com.sohoki.backoffice.cus.ten.vo.TennantInfo;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfoVO;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RestController
@RequestMapping("/backoffice/companyManage")
public class TennantInfoManageController {

	
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TennantInfoManageController.class);
	
	@Autowired
	private TennantInfoManageService tennService;
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private CompanyInfoManageService companyService;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
    private CenterInfoManageService centerInfoService;
	
	
	@RequestMapping(value="tennUpdate.do", method=RequestMethod.POST)
	public ModelAndView tennUpdate (@ModelAttribute("searchVO") EmpInfoVO searchVO
			                        , @RequestBody Map<String, Object> params   
									, HttpServletRequest request
									, BindingResult bindingResult) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }
		try{
			Gson gson = new GsonBuilder().create();
			List<TennantInfo> tennantInfos = gson.fromJson(params.get("data").toString(), new TypeToken<List<TennantInfo>>(){}.getType());
			//좌석/ 회의실 정리 하기 
			List<TennantInfo> Infos = tennantInfos.stream().map(p-> { 
				                           p.setTennRecDate(util.reqDay(0));
				                           p.setUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
				                           p.setTennRecPlayCnt("0");
				                           p.setTennRecNowCnt(p.getTennRecCount());
				                           return p;
				                           }
			).collect(Collectors.toList());
			//값 넣기 
			LOGGER.debug("Info"+  Infos.size() );
			int ret = tennService.insertTennantInfoManages(Infos);
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULT, ret);
		}catch(Exception e){
			LOGGER.debug("ERROR:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));
		}
		return model;
	}
	
	
	@RequestMapping(value="tennList.do")
	public ModelAndView  selectTennInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @ModelAttribute("searchVO") CenterInfoVO searchVO
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
		  
		  
		  model.addObject(Globals.STATUS_REGINFO , searchVO);
		  //model.addObject("floorInfo", companyService.selectCompanyInfoManageCombo("COM_STATE_1") );
		  model.addObject("searchCenter", centerInfoService.selectCenterInfoManageCombo());
	      model.setViewName("/backoffice/companyManage/tennList");
		  return model;	
	}
	
	
	@RequestMapping(value="tennListAjax.do")
	public ModelAndView  selectTennAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @RequestBody Map<String,Object>  searchVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		try {
			
			  int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
			  
			  searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			  
			  LOGGER.info("pageUnit:" + pageUnit);
			  
		       /** pageing */       
		   	  PaginationInfo paginationInfo = new PaginationInfo();
			  paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex").toString(), "1") ) );
			  paginationInfo.setRecordCountPerPage(pageUnit);
			  paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

			  searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
			  searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
			  searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			  
			  
			  List<Map<String, Object>> list = tennService.selectTennantInfoManageListByPagination(searchVO);
		      model.addObject(Globals.JSON_RETURN_RESULTLISR,  list );
		      model.addObject(Globals.STATUS_REGINFO, searchVO);
		      int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
		      
		      paginationInfo.setTotalRecordCount(totCnt);
		      model.addObject("paginationInfo", paginationInfo);
		      model.addObject("totalCnt", totCnt);
		      
	
			  
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));	
		}
		return model;
	}
	@RequestMapping(value="tennSubListAjax.do")
	public ModelAndView  selectTennSubAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @RequestBody Map<String,Object>  searchVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		try {
			
			  int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
			  
			  searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			  
			  LOGGER.info("pageUnit:" + pageUnit);
			  
		       /** pageing */       
		   	  PaginationInfo paginationInfo = new PaginationInfo();
			  paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1").toString()));
			  paginationInfo.setRecordCountPerPage(pageUnit);
			  paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

			  searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
			  searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
			  searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			  //추후 리스트 아닐겨우 확인 필요 
			  searchVO.put("mode", "list");
			  
			  
			  List<Map<String, Object>> list = tennService.selectTennantSubInfoManageListByPagination(searchVO);
		      model.addObject(Globals.JSON_RETURN_RESULTLISR,  list );
		      model.addObject(Globals.STATUS_REGINFO, searchVO);
		      int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
		      
		      paginationInfo.setTotalRecordCount(totCnt);
		      model.addObject("paginationInfo", paginationInfo);
		      model.addObject("totalCnt", totCnt);
		      
	
			  
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));	
		}
		return model;
	}
	@RequestMapping(value="tennCancel.do")
	public ModelAndView  updateTennInfoChange(@ModelAttribute("loginVO") AdminLoginVO loginVO
												, @RequestBody Map<String, Object> searchVO
												, HttpServletRequest request
												, BindingResult bindingResult	) throws Exception {
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
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
			
			LOGGER.debug("searchVO.get(\"gubun\"):"+ searchVO.get("hisSeq"));
			
			int ret =  (util.NVL(searchVO.get("gubun"), "R").toString().equals("R")) ? tennService.updateRetireTennantInfoManage(searchVO) 
					                                                                 : tennService.cancelPlayTennantInfoManage(searchVO);
			
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULT, ret);
			
		}catch (Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.update"));	
		}
		
		return model;	
	}
	@RequestMapping(value="tennReset.do")
	public ModelAndView resTenncheduleReset(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                , @RequestBody Map<String, Object> resetVO
											, HttpServletRequest request
											, BindingResult bindingResult) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		try{
    		
			//LOGGER.debug("comCode:" + resetVO.get("comCode").toString().replace("[", "").replace("]", ""));
			int ret = tennService.insertTennantReset(resetVO.get("comCode").toString().replace("[", "").replace("]", "").replace("\"", ""));
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}catch(Exception e){
    		LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.update"));	
    	}
    	return model;
	}
	
}
