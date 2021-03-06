package com.sohoki.backoffice.cus.org.web;



import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.OrgInfo;
import com.sohoki.backoffice.cus.org.vo.SwcInfo;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.uat.uia.vo.AdminInfo;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.cus.org.service.SwcInfoManageService;
import com.sohoki.backoffice.cus.org.service.jobInfoManageService;



	
	
@RestController
@RequestMapping("/backoffice/orgManage")
public class EmpInfoManageController {

	    private static final Logger LOGGER = LoggerFactory.getLogger(EmpInfoManageController.class);
		
		
		@Autowired
		private OrgInfoManageService orgervice;
		
		
		@Autowired
		private EmpInfoManageService empService;
		
		@Autowired
		protected EgovMessageSource egovMessageSource;
		
		@Autowired
	    protected EgovPropertyService propertiesService;
		
		@Autowired
	    protected jobInfoManageService jobService;
		
		@Autowired
	    protected SwcInfoManageService swcService;

		@Autowired
		private SmartUtil util;
		
		@Autowired
		private UniSelectInfoManageService  uniService;
		
		@Autowired
		private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
		
		@RequestMapping(value="empSearchList.do")
		public ModelAndView  selectEmpinfoSearchList(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
				                               , @RequestBody Map<String, Object> searchVO
											   , HttpServletRequest request
											   , BindingResult bindingResult) throws Exception {
			ModelAndView model = new ModelAndView("/backoffice/popup/empSearchList");
			return model;
		}
		@RequestMapping(value="empList.do")
		public ModelAndView  selectEmpinfoList(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
				                               , @ModelAttribute("EmpInfo") EmpInfo info
											   , HttpServletRequest request
											   , BindingResult bindingResult) throws Exception {
			ModelAndView model = new ModelAndView("/backoffice/companyManage/emList");
			
			model.addObject(Globals.STATUS_REGINFO , info);
			
			model.addObject("empstate", cmmnDetailService.selectCmmnDetailCombo("USER_STATE"));
			model.addObject("preworkstate", cmmnDetailService.selectCmmnDetailCombo("WORK_INFO"));
			model.addObject("nowworkstate", cmmnDetailService.selectCmmnDetailCombo("WORK_INFO"));
			return model;
		}
		@RequestMapping(value="empDetail.do")
		public ModelAndView  selectEmpinfoDetail(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
				                               , @RequestParam("empno") String empno
											   , HttpServletRequest request
											   , BindingResult bindingResult) throws Exception {
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			try{
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			    model.addObject(Globals.STATUS_REGINFO, empService.selectEmpInfoDetailNo(empno));			    	 
			}catch (Exception e){
				LOGGER.info(e.toString());
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));			
			}	
			return model;			
		}		
		@RequestMapping(value="empListAjax.do")
		public ModelAndView  selectEmpinfoSearchListAjax(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
					                                    , @RequestBody Map<String,Object> searchVO
												        , HttpServletRequest request) throws Exception {
			  
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			try {
				
				Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			    if(!isAuthenticated) {
			    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			    		model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
			    		return model;
			    }else{
			    	 HttpSession httpSession = request.getSession(true);
			    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
			    }
				
				//????????? ?????? ??? ?????? ?????? ?????? 
				int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			   	PaginationInfo paginationInfo = new PaginationInfo();
				paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
				paginationInfo.setRecordCountPerPage(pageUnit);
				paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

				searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
				searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
				searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
				//????????? ?????? ?????? ??? ??????  
				 
				
				if (util.NVL(searchVO.get("code"), "").equals("except")){
					searchVO.put("searchswcempno","swcCheck");
				}
				if (util.NVL(searchVO.get("mode"), "").equals(""))
				   searchVO.put("mode", "list");
				List<Map<String, Object>> list =  empService.selectEmpInfoList(searchVO) ;
				int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
				
				model.addObject(Globals.JSON_RETURN_RESULTLISR,  list );
			    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			    paginationInfo.setTotalRecordCount(totCnt);
			    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
	           
			}catch(Exception e) {
				StackTraceElement[] ste = e.getStackTrace();
				int lineNumber = ste[0].getLineNumber();
				LOGGER.info("e:" + e.toString() + ":" + lineNumber);
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
			}
			
			return model;
		}
		// ?????? ??????
		@RequestMapping(value="emDelete.do", method = {RequestMethod.POST})
		public ModelAndView deleteEmployInfo(@ModelAttribute("loginVO") AdminLoginVO loginVO
									   ,@RequestParam("empno") String empno
									   ,HttpServletRequest request) throws Exception {
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			try{
				  int ret = uniService.deleteUniStatement("", "tb_empInfo", "EMPNO=["+ empno+"[");
			      if (ret > 0 ) {	
			    	  //??? 
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
		//?????? ?????? ???
		@RequestMapping(value="employUpdate.do")
		public ModelAndView employUpdate (@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
										   , @RequestBody  EmpInfo vo 
										   , HttpServletRequest request
										   , BindingResult bindingResult) throws Exception{
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			
			try{
				Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			     if(!isAuthenticated) {
			    	 model.addObject(Globals.STATUS_MESSAGE , egovMessageSource.getMessage("fail.common.login"));
			    	 model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			    	 return model;
			     }
			     
				String meesage = vo.getMode().equals("Ins") ?  "sucess.common.insert" :   "sucess.common.update";
			    int ret = empService.insertEmployInfoManage(vo);
			    
			    if (ret >0){
					model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));			
				}else if (ret == -1) {
					model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
					model.addObject(Globals.STATUS_MESSAGE, "?????? ????????? ?????? ?????????.");		
				}else {
					LOGGER.info("Error");
					throw new Exception();
				}
			}catch (Exception e){
				LOGGER.error("Exception:" + e.toString());
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));			
			}
			return model;
		}
		/*
		@RequestMapping(value="/backoffice/popup/deptSearchList.do")
		public String  selectDeptinfoSearchList(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
				, @ModelAttribute("searchVO") OrgInfo searchVO
				, HttpServletRequest request
				, BindingResult bindingResult						
				, ModelMap model) throws Exception {
			
			
              if (!searchVO.getSearchKeyword().equals("")){
            	model.addAttribute("resultList",  orgervice.selectOrgInfoComboSearch(searchVO)  );
              }
	          model.addAttribute(Globals.STATUS_REGINFO, searchVO);
	          
			return "/backoffice/popup/deptSearchList";
		}
		*/
		@RequestMapping(value="swcInfo.do")
		public ModelAndView  selectSwcInfo(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
								           , @ModelAttribute("SwcInfo") SwcInfo info
										   , HttpServletRequest request
										   , BindingResult bindingResult) throws Exception {
			ModelAndView model = new ModelAndView("/backoffice/basicManage/swcInfo");
					
		  	model.addObject(Globals.STATUS , Globals.STATUS_SUCCESS);
		  	model.addObject(Globals.STATUS_REGINFO, swcService.selectSwcInfoManageService());	
			return model;
		}
		@RequestMapping(value="swcInfoUpdate.do")
		public ModelAndView swcInfoUpdate (@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
										   , @RequestBody  SwcInfo vo 
										   , HttpServletRequest request
										   , BindingResult bindingResult) throws Exception{
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			
			try{
				Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			    if(!isAuthenticated) {
			    	 model.addObject(Globals.STATUS_MESSAGE , egovMessageSource.getMessage("fail.common.login"));
			    	 model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			    	 return model;
			    }
				
			    int ret = swcService.updateSwcInfoManageService(vo);
			    if (ret >0){
					model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("sucess.common.update"));			
				}else {
					LOGGER.info("Error");
					throw new Exception();
				}
			}catch (Exception e){
				LOGGER.error("Exception:" + e.toString());
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.update"));			
			}
			return model;
		}
		@RequestMapping(value="IdCheck.do")
		public ModelAndView selectUserMangerIDCheck(@RequestParam("empno") String empno) throws Exception {
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			int IDCheck = uniService.selectIdDoubleCheck("EMPNO", "TB_EMPINFO", "EMPNO = ["+ empno + "[" );
			String result =  (IDCheck> 0) ? Globals.STATUS_FAIL : Globals.STATUS_SUCCESS;
			model.addObject(Globals.STATUS, result);
			return model;
		}
		
}
