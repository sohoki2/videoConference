package com.sohoki.backoffice.cus.com.web;

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
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sohoki.backoffice.cus.com.servie.CompanyInfoManageService;
import com.sohoki.backoffice.cus.com.servie.UserInfoManageService;
import com.sohoki.backoffice.cus.com.vo.CompanyInfo;
import com.sohoki.backoffice.cus.com.vo.UserInfo;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.sym.space.service.OfficeSeatInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.util.service.fileService;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RestController
@RequestMapping("/backoffice/companyManage")
public class CompanyInfoManageController {

	 private static final Logger LOGGER = LoggerFactory.getLogger(CompanyInfoManageController.class);
	
	 @Autowired
	 private fileService uploadFile;
	 
     @Autowired
	 protected EgovMessageSource egovMessageSource;
		
	 @Autowired
	 protected EgovPropertyService propertiesService;
	 
	 @Autowired
	 private CompanyInfoManageService companyService;
	 
	 @Autowired
	 private UserInfoManageService    userService;
	 
	 @Autowired
	 private UniSelectInfoManageService  uniService;
	 
	 @Autowired
	 private SmartUtil util;
		
	 @Autowired
	 private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	 
	 @Autowired
     private CenterInfoManageService centerInfoService;
	 
	 @Autowired
	 private OfficeSeatInfoManageService  officeService;
	 
	 @RequestMapping(value="companyList.do")
	 public ModelAndView  selectCompanyInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @ModelAttribute("searchVO") CompanyInfo searchVO
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
		  model.addObject("searchCenter", centerInfoService.selectCenterInfoManageCombo());
		  model.addObject("comState", cmmnDetailService.selectCmmnDetailCombo("COM_STATE"));
		  model.addObject("comGubun", cmmnDetailService.selectCmmnDetailCombo("COM_GUBUN"));
		  model.addObject("userState", cmmnDetailService.selectCmmnDetailCombo("USER_STATE"));
	      model.setViewName("/backoffice/companyManage/companyList");
		  return model;	
	 }
	 
	 @RequestMapping(value="batchTest.do")
	 public ModelAndView  selectbatchTest(@ModelAttribute("loginVO") AdminLoginVO loginVO
										  , @ModelAttribute("searchVO") CompanyInfo searchVO
										  , HttpServletRequest request
										 , BindingResult bindingResult	) throws Exception {
		
		
		 ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
         try {
        	 officeService.selectLableSchedule();
        	 
        	 model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
         }catch (Exception e) {
 			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
 			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
         }
		 
		  return model;	
	 }
	 
	 
	 
	 
	 @RequestMapping(value="companyListAjax.do")
	 public ModelAndView  selectCompanyAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
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
			  paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
			  paginationInfo.setRecordCountPerPage(pageUnit);
			  paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

			  searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
			  searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
			  searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			  
			  List<Map<String, Object>> list = companyService.selectCompanyInfoManageListByPagination(searchVO);
		      model.addObject(Globals.JSON_RETURN_RESULTLISR,  list );
		      model.addObject(Globals.STATUS_REGINFO, searchVO);
		      int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
		      
		      paginationInfo.setTotalRecordCount(totCnt);
		      model.addObject("paginationInfo", paginationInfo);
		      model.addObject("totalCnt", totCnt);
		      
	
			  
		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info("error:" + e.toString() + ":" +  ste[0].getLineNumber());
			
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
	 }
	 //센터 정보 상세
	 @RequestMapping (value="companyDetail.do")
	 public ModelAndView selectCompanyInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
		                                               , @RequestParam("comCode") String comCode
		                                               , HttpServletRequest request
		                                			   , BindingResult bindingResult) throws Exception{	
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
				return model;	
	    }	
		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		model.addObject(Globals.STATUS_REGINFO, companyService.selectCompanyInfoManageDetail(comCode));	     	
		return model;
	 }
	 @NoLogging
	 @RequestMapping (value="companyUpdate.do")
	 public ModelAndView updateCompanyInfoManage(HttpServletRequest request
			                                   , MultipartRequest mRequest
											   , @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
											   , @ModelAttribute("CompanyInfo") CompanyInfo vo
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
				String meesage = "";
				vo.setComZipcode("");     	  
				
		    	vo.setComLogo(uploadFile.uploadFileNm(mRequest.getFiles("comLogo"), propertiesService.getString("Globals.filePath")));
				meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update" ;
				int ret = companyService.updateCompanyInfoManage(vo);
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
		@RequestMapping (value="companyDelete.do")
		public ModelAndView deleteCompanyInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
				                                   @RequestParam("comCode") String comCode)throws Exception{
			
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.setViewName("/backoffice/login");
					return model;	
		    }	
			try{
				  // 이미지 삭제 먼저 하기 
				
			      int ret = 	uniService.deleteUniStatement("COM_LOGO", "tb_companyinfo", "COM_CODE=["+comCode+"[");	
			      
			      if (ret > 0 ) {		
			    	  //관련 사용자 삭제 
			    	  userService.deleteUserInfoManage("", comCode);
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
		@RequestMapping(value="userList.do")
		public ModelAndView  selectUserInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
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
			  String comCode = request.getParameter("comCode") != "" ? request.getParameter("comCode") : "";
			 
			  model.addObject("searchCenter", centerInfoService.selectCenterInfoManageCombo());
			  model.addObject("userState", cmmnDetailService.selectCmmnDetailCombo("USER_STATE"));
			  model.addObject("comCode",comCode);
			  
			  model.setViewName("/backoffice/companyManage/userList");
			  return model;	
		}
		@RequestMapping(value="userListAjax.do")
		public ModelAndView  selectUserAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
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
				  paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
				  paginationInfo.setRecordCountPerPage(pageUnit);
				  paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

				  searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
				  searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
				  searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
				  
				  List<Map<String, Object>> list = userService.selectUserInfoManageListByPagination(searchVO);
				  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			      model.addObject(Globals.JSON_RETURN_RESULTLISR,  list );
			      model.addObject(Globals.STATUS_REGINFO, searchVO);
			      int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
			      
			      paginationInfo.setTotalRecordCount(totCnt);
			      model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
			      model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			      
				  
			}catch(Exception e) {
				StackTraceElement[] ste = e.getStackTrace();
				LOGGER.info("error:" + e.toString() + ":" +  ste[0].getLineNumber());
				
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
			}
			return model;
		}
		@NoLogging
		@RequestMapping (value="userUpdate.do")
		public ModelAndView updateUserInfoManage(HttpServletRequest request
				                                 , @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
												 , @RequestBody UserInfo vo
												 , BindingResult result) throws Exception{
				
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			
			if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.setViewName("/backoffice/login");
			}else {
		    	 HttpSession httpSession = request.getSession(true);
		    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
		    	 vo.setUpdateId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
		    }
			
			try{
				
				model.addObject(Globals.STATUS_REGINFO , vo);
				String meesage = "";
				
				meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update" ;
				int ret = userService.updateUserInfoManage(vo);
				if (ret >0){
					model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
							
				}else {
					throw new Exception();
				}
				
			}catch (Exception e){
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.update"));	
			}	
			LOGGER.debug("model:" + model.toString());
			return model;
		}
		@RequestMapping (value="userDelete.do")
		public ModelAndView deleteUserInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO
					                             , @RequestParam("userNo") String userNo)throws Exception{
				
			ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.setViewName("/backoffice/login");
					return model;	
		    }	
			try{
				  // 이미지 삭제 먼저 하기 
				  int ret = 	userService.deleteUserInfoManage(userNo, "");		      
			      if (ret > 0 ) {		
			    	  //층 삭제
			    	  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			    	  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.delete") );
			      }else if (ret == -1){
			    	  //중복 사번 일떄 처리 
			    	  
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
		@RequestMapping (value="userDetail.do")
		public ModelAndView selectUserInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
		                                               , @RequestParam("userNo") String userNo
		                                               , HttpServletRequest request
		                                			   , BindingResult bindingResult) throws Exception{	
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					return model;	
		    }	
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, userService.selectUserInfoManageDetail(userNo));	     	
			return model;
		}
		/*
		 *  사번 중복 체크 
		 *  userNo : 사번 
		 *  결과값 : SUCCESS/FAIL
		 *  기존 user 에서 사용자로 변경 통합 사용자 관리 변경 
		 */
		@RequestMapping (value="userUniCheck.do")
		public ModelAndView selectUserUniCheck(@ModelAttribute("loginVO") AdminLoginVO loginVO
                                               , @RequestParam("userNo") String userNo
                                               , HttpServletRequest request
                                			   , BindingResult bindingResult) throws Exception{	
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					return model;	
		    }	
			String result =  uniService.selectIdDoubleCheck("EMPNO", "tb_empInfo", "EMPNO=["+userNo+"[") > 0 ? Globals.STATUS_FAIL : Globals.STATUS_SUCCESS;
			model.addObject(Globals.STATUS, result);
			return model;
		}
		@RequestMapping (value="userUpload.do")
		public ModelAndView updateUserExcel(@ModelAttribute("loginVO") AdminLoginVO loginVO
				                            , HttpServletRequest request
				                            , RedirectAttributes redirectAttributes) throws Exception{	
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					return model;	
		    }	
			// 엑셀 업로드 이후 
			// redirectAttributes url에 값 전달 
			try {
				userService.excelUpload(request);
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.insert") );
			} catch (Exception ex) {
				LOGGER.info(ex.toString());
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
			}
			return model;
		}
		
}
