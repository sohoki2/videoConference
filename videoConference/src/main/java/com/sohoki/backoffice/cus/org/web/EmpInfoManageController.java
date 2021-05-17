package com.sohoki.backoffice.cus.org.web;



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

import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.OrgInfo;
import com.sohoki.backoffice.uat.uia.vo.AdminInfo;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.cus.org.service.jobInfoManageService;

@RestController
@RequestMapping("/backoffice/backoffice")
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
		private SmartUtil util;
		
		@Autowired
		private UniSelectInfoManageService  uniService;
		
		
		
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
				                               , @RequestBody Map<String, Object> searchVO
											   , HttpServletRequest request
											   , BindingResult bindingResult) throws Exception {
			ModelAndView model = new ModelAndView("/backoffice/companyManage/emList");
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
				/*
			    EmpInfo user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
				searchVO.put("empno", user.getEmpno());
				*/
			    
			    
			    
				//페이징 처리 할 부분 정리 하기 
				/*
				int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				  
				searchVO.put("pageSize", propertiesService.getInt("pageSize"));
				  
			    /** pageing        
			   	PaginationInfo paginationInfo = new PaginationInfo();
				paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
				paginationInfo.setRecordCountPerPage(pageUnit);
				paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

				searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
				searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
				searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
				 */
				//페이징 처리 하기 끝 부분  
				 
				
				if (util.NVL(searchVO.get("code"), "").equals("except")){
					searchVO.put("searchswcempno","swcCheck");
				}
				model.addObject(Globals.JSON_RETURN_RESULTLISR,   empService.selectEmpInfoList(searchVO)  );
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
	            model.addObject(Globals.STATUS_REGINFO, searchVO);
			}catch(Exception e) {
				StackTraceElement[] ste = e.getStackTrace();
				int lineNumber = ste[0].getLineNumber();
				LOGGER.info("e:" + e.toString() + ":" + lineNumber);
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
			}
			
			return model;
		}
		// 직원 삭제
		@RequestMapping(value="emDelete.do", method = {RequestMethod.POST})
		public ModelAndView deleteEmployInfo(@ModelAttribute("loginVO") AdminLoginVO loginVO
									   ,@RequestParam("empno") String empno
									   ,HttpServletRequest request) throws Exception {
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			try{
				  int ret = uniService.deleteUniStatement("", "tb_empInfo", "EMPNO=["+ empno+"[");
			      if (ret > 0 ) {	
			    	  //층 
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
		//직원 수정 삭
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
					model.addObject(Globals.STATUS_MESSAGE, "이미 등록된 사번 입니다.");		
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
		
		
}
