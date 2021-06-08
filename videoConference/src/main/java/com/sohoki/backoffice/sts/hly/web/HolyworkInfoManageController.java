package com.sohoki.backoffice.sts.hly.web;


import egovframework.com.cmm.AdminLoginVO;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfoVO;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.sts.hly.service.HolyworkInfoManageService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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


@RestController
@RequestMapping("/backoffice/resManage")
public class HolyworkInfoManageController {

	
    private static final Logger LOGGER = LoggerFactory.getLogger(HolyworkInfoManageController.class);
	
	
    @Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private HolyworkInfoManageService holyService;
		
	@Autowired
	private OrgInfoManageService orgService;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
	private UniSelectInfoManageService  uniService;
	
	@RequestMapping(value="holyList.do")
	public ModelAndView  selectholyInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
														, @ModelAttribute("searchVO") HolyworkInfoVO searchVO
														, HttpServletRequest request
														, BindingResult bindingResult) throws Exception {
		
		ModelAndView model = new ModelAndView("/backoffice/basicManage/holyList");
		
		

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
		   
		    model.addObject("orgInfo", orgService.selectOrgInfoCombo());
		}catch(Exception e) {
			
		}
		return model;
	}
	@RequestMapping(value="holyListAjax.do")
	public ModelAndView  selectholyInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @RequestBody Map<String, Object> searchVO
															, HttpServletRequest request
															, BindingResult bindingResult) throws Exception {
		
		ModelAndView model = new ModelAndView (Globals.JSONVIEW);
		
		
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
		    			  
			List<Map<String, Object>> list = holyService.selectHolyManageListByPagination(searchVO);
	        int totCnt =  list.size() > 0 ? Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
	   
			model.addObject(Globals.JSON_RETURN_RESULTLISR, list);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		    paginationInfo.setTotalRecordCount(totCnt);
		    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	    
		  
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
		
	}
	@RequestMapping (value="holyView.do")
	public ModelAndView selecholyInfoManageView(@ModelAttribute("loginVO") AdminLoginVO loginVO
                                                 , @RequestParam("holeSeq") String holeSeq
                                                 , HttpServletRequest request
                                    			 , BindingResult bindingResult) throws Exception{	
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }
	    try {
	    	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, holyService.selectHolyManageView(holeSeq));
	    }catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    }
	    return model;
		
	}
	@RequestMapping (value="holyDelete.do")
	public ModelAndView deleteholyInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                 , @RequestParam("holeSeq") String holeSeq
									         , HttpServletRequest request) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }	
		try{
			  int ret = 	uniService.deleteUniStatement("", "TB_HOLYWORKINFO", "HOLE_SEQ="+holeSeq);		      
		      if (ret > 0 ) {		
		    	  //층 삭제
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
	@RequestMapping (value="holyUpdate.do")
	public ModelAndView updateholyInfoManage( @ModelAttribute("loginVO") AdminLoginVO loginVO
										    , @RequestBody HolyworkInfo vo	
                                            , HttpServletRequest request                         				 
										    , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		String meesage = null;
		try{
			 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			 if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS,  Globals.STATUS_LOGINFAIL);
					return model;	
		     }
			 
			int ret  = holyService.updateHolyManage(vo);
			meesage = (vo.getMode().equals("Ins")) ? "sucess.common.insert" : "sucess.common.update";
			if (ret >0){
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
						
			}else {
				throw new Exception();
			}
		}catch (Exception e){
			meesage = (vo.getMode().equals("Ins")) ? "fail.common.insert" : "fail.common.update";
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));			
		}
		return model;
	}
	
	
}
