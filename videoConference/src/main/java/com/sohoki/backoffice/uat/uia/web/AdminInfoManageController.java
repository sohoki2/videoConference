package com.sohoki.backoffice.uat.uia.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.AdminLoginVO;

import com.sohoki.backoffice.uat.uia.vo.AdminInfo;
import com.sohoki.backoffice.uat.uia.vo.AdminInfoVO;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.uat.uia.service.AdminInfoManageService;
import com.sohoki.backoffice.sym.rnt.service.AuthorInfoManageService;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.sym.avaya.service.AvayMessageManageService;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.com.cmm.EgovMessageSource;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.Globals;

@RestController
@RequestMapping("/backoffice/basicManage")
public class AdminInfoManageController {

   private static final Logger LOGGER = LoggerFactory.getLogger(AdminInfoManageController.class);
	
   @Autowired
	private AdminInfoManageService userManagerService;
	
	@Autowired
	private AuthorInfoManageService authorInfoManageService;
	
	/** EgovPropertyService */
	@Autowired
    protected EgovPropertyService propertiesService;
    
    @Autowired
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;
    
    
    @Autowired
	protected EgovMessageSource egovMessageSource;

	@Autowired
	private EmpInfoManageService empService;
	
	@Autowired
	private UniSelectInfoManageService  uniService;
	
	@Autowired
	private AvayMessageManageService avayService;
	
	@Autowired
	private SmartUtil util;
	
	@RequestMapping(value="/intro.do")
	public String selectUserManagerList() throws Exception {
		return "/backoffice/intro";		
	}
	
	@RequestMapping(value="avayaUpdate.do")
	public ModelAndView avayaUpdate (@ModelAttribute("searchVO") EmpInfoVO searchVO
											, HttpServletRequest request
											, BindingResult bindingResult		) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			
			
			String message = (avayService.updateAvayaUserUpdate() > 0) ? Globals.STATUS_SUCCESS : Globals.PROCESS_STATE_NO;
			model.addObject(Globals.STATUS, message);
		}catch(Exception e){
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
		
		return model;
	}

	@RequestMapping(value="managerList.do")
	public ModelAndView selectManagerManagerList(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
											   , @ModelAttribute("searchVO") AdminInfoVO searchVO
											   , HttpServletRequest request
											   , BindingResult bindingResult) throws Exception {  
		
			ModelAndView model = new ModelAndView();
	       
		   try{
			   
			   Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			   if(!isAuthenticated) {
			   		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			   		model.setViewName("/backoffice/login");
			   		return model;
			   }
			   
			   if (searchVO.getUseYn() == null){ searchVO.setUseYn("");}
			   model.addObject("selectState", authorInfoManageService.selectAuthorIInfoManageCombo());	
			   model.addObject(Globals.STATUS_REGINFO, searchVO);	
			   model.setViewName("/backoffice/basicManage/empList");
			   
		   }catch (Exception e){
			   LOGGER.info("e:" + e.toString());
		   }
		   return model;
	}
	@RequestMapping(value="managerListAjax.do")
	public ModelAndView selectEmpManagerListAjax(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
														, @RequestBody Map<String,Object>  searchVO
														, HttpServletRequest request
														, BindingResult bindingResult) throws Exception {  
		
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
	       
		   try{
			   
			     Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			     if(!isAuthenticated) {
			    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			    		model.setViewName("/backoffice/login");
			    		return model;
			     }else{
			    	 HttpSession httpSession = request.getSession(true);
			    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
			    	 searchVO.put("authorCode", loginVO.getAuthorCode());
			     }
			     
			     int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				 searchVO.put("pageSize", propertiesService.getInt("pageSize"));
				 
				 /** pageing */       
			   	 PaginationInfo paginationInfo = new PaginationInfo();
				 paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
				 paginationInfo.setRecordCountPerPage(pageUnit);
				 paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

				 searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
				 searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
				 searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
				 
			     List<Map<String,Object>> list = userManagerService.selectAdminUserManageListByPagination(searchVO);
			     int totCnt = (list.size() > 0) ? Integer.valueOf( list.get(0).get("total_record_count").toString()) : 0;
		         model.addObject(Globals.JSON_RETURN_RESULTLISR,  list  );    
		         model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		         paginationInfo.setTotalRecordCount(totCnt);
		         model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		         model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	
		        
		   }catch (Exception e){
			   StackTraceElement[] ste = e.getStackTrace();
			   int lineNumber = ste[0].getLineNumber();
			   LOGGER.info("e:" + e.toString() + ":" + lineNumber);
		   }
		   return model;
	}
	@RequestMapping(value="managerDetail.do")
	public ModelAndView manageDetail(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
								, @RequestParam("adminId") String adminId
								, HttpServletRequest request
								, BindingResult bindingResult) throws Exception{
		
		
		 ModelAndView mav = new ModelAndView(Globals.JSONVIEW);
		 try {
			 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		     if(!isAuthenticated) {
		    	 mav.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
		    	 mav.setViewName("/backoffice/login");
		    		return mav;
		     }
		     Map<String, Object> vo = userManagerService.selectAdminUserManageDetail(adminId);
			 mav.addObject(Globals.STATUS_REGINFO, vo);			
			 mav.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	
			 
		 }catch(Exception e) {
			 StackTraceElement[] ste = e.getStackTrace();
			 int lineNumber = ste[0].getLineNumber();
			 LOGGER.info("e:" + e.toString() + ":" + lineNumber);
			 mav.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			 mav.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
		 }
		 
		 
		 return mav;
	}
	@RequestMapping(value="managerUpdate.do")
	public ModelAndView mangerUpdate ( @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
									   ,@RequestBody  AdminInfo vo 
									   , HttpServletRequest request
									   , BindingResult bindingResult) throws Exception{
		
		ModelAndView model = new ModelAndView();
		
		try{
			 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		     if(!isAuthenticated) {
		    	 model.addObject(Globals.STATUS_MESSAGE , egovMessageSource.getMessage("fail.common.login"));
		    	 model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    	 return model;
		     }
		     
			String meesage = vo.getMode().equals("Ins") ?  "sucess.common.insert" :   "sucess.common.update";
		    int ret = userManagerService.updateAdminUserManage(vo);
		    
		    if (ret >0){
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));			
			}else if (ret == -1) {
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, "이미 등록된 사번 입니다.");		
			}else {
				LOGGER.info("Error");
				throw new Exception();
			}
		}catch (Exception e){
			LOGGER.error("Exception:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));			
		}
		model.setViewName(Globals.JSONVIEW);
		return model;
	}
	@RequestMapping(value="managerDelete.do", method = {RequestMethod.POST})
	public ModelAndView deleteMber(@ModelAttribute("loginVO") AdminLoginVO loginVO
								   ,@RequestParam Map<String, String> params
								   ,HttpServletRequest request) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		String adminId =params.get("adminId");
		
		int ret = userManagerService.deleteAdminUserManage(adminId);
		if (ret> 0){
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}else {
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
		return model;
	}
	@RequestMapping(value="IdCheck.do")
	public ModelAndView selectUserMangerIDCheck(@RequestParam("adminId") String adminId) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		int IDCheck = uniService.selectIdDoubleCheck("ADMIN_ID", "tb_admin", "ADMIN_ID = ["+ adminId + "[" );
		String result =  (IDCheck> 0) ? Globals.STATUS_FAIL : Globals.STATUS_SUCCESS;
		model.addObject(Globals.STATUS, result);
		return model;
	}
}
