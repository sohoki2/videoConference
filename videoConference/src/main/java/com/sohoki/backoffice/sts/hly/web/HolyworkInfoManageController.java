package com.sohoki.backoffice.sts.hly.web;


import egovframework.com.cmm.AdminLoginVO;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfoVO;
import com.sohoki.backoffice.sts.hly.service.HolyworkInfoManageService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class HolyworkInfoManageController {

	
private static final Logger LOGGER = LoggerFactory.getLogger(HolyworkInfoManageController.class);
	
	
    @Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private HolyworkInfoManageService holyService;
		
	
	
	@RequestMapping(value="/backoffice/basicManage/holyList.do")
	public String  selectholyInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
			, @ModelAttribute("searchVO") HolyworkInfoVO searchVO
			, HttpServletRequest request
			, BindingResult bindingResult						
			, ModelMap model) throws Exception {
		
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
		  searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		  
		  
          
	       model.addAttribute("resultList",   holyService.selectHolyManageListByPagination(searchVO) );
	       model.addAttribute("regist", searchVO);
	       
	       int totCnt = holyService.selectHolyManageListTotCnt_S(searchVO) ;       
		   paginationInfo.setTotalRecordCount(totCnt);
	       model.addAttribute("paginationInfo", paginationInfo);
	       model.addAttribute("totalCnt", totCnt);
		
		   return "/backoffice/basicManage/holyList";	
	}
	@RequestMapping (value="/backoffice/basicManage/holyDetail.do")
	public String selecSeatInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                          , @ModelAttribute("vo")  HolyworkInfoVO vo
			                                                          , HttpServletRequest request
			                                            			  , BindingResult bindingResult
																	  , ModelMap model ) throws Exception{	
		
				
		model.addAttribute("regist", vo);
		
		if (!vo.getMode().equals("Ins")){			
	     	model.addAttribute("regist", holyService.selectHolyManageDetail(vo.getHolySeq()));	     	
		}		
		return "/backoffice/basicManage/holyDetail";
	}
	@RequestMapping (value="/backoffice/basicManage/holyView.do")
	public String selecholyInfoManageView(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                         , @ModelAttribute("vo")  HolyworkInfoVO vo
			                                                         , HttpServletRequest request
			                                            			 , BindingResult bindingResult
																	 , ModelMap model ) throws Exception{	
		
		
		model.addAttribute("regist", vo);
	    model.addAttribute("regist", holyService.selectHolyManageView(vo.getHolySeq()));
		return "/backoffice/basicManage/holyView";
	}
	@RequestMapping (value="/backoffice/basicManage/holyDelete.do")
	@ResponseBody
	public String deleteholyInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
									    HttpServletRequest request			                                                                
							  			) throws Exception {
		String holySeq = request.getParameter("holySeq") != null ? request.getParameter("holySeq") : "";
		
		String result = "F";
		try{
		      int ret = 	holyService.deleteHolyManage(holySeq);		      
		      if (ret > 0 ) {		    	  
		    	  result = "T";	    	  
		      }else {
		    	  throw new Exception();		    	  
		      }
		}catch (Exception e){
			LOGGER.info(e.toString());
			result = "F";
						
		}		
		
		return result;
	}
	@RequestMapping (value="/backoffice/basicManage/holyUpdate.do")
	@SuppressWarnings("finally")
	public String updateholyInfoManage( @ModelAttribute("loginVO") AdminLoginVO loginVO,
										 @ModelAttribute("vo") HolyworkInfo vo	
                                         , HttpServletRequest request                         				 
										 , BindingResult result,
										 ModelMap model) throws Exception{
		
		model.addAttribute("regist", vo);
		String meesage = "";
		String url = "/backoffice/basicManage/holyList";
		
		
		try{
			//vo.getEquipmentStat();
			AdminLoginVO user = (AdminLoginVO) request.getSession().getAttribute("AdminLoginVO");
		  /*  if (user == null){
		    	LOGGER.debug("로그인 기록 없음");		    	
		    	return "/backoffice/login";
		    }*/
			int ret  = 0;
			if (vo.getMode().equals("Ins")){
				
				
			    vo.setHolyRegId(user.getAdminId());
				ret = holyService.insertHolyManage(vo);
				meesage = "sucess.common.insert";
				url = "redirect:/backoffice/basicManage/holyList.do";				
			}else {
				vo.setHolyUpdateId(user.getAdminId());
				ret = holyService.updateHolyManage(vo);
				meesage = "sucess.common.update";
				url = "redirect:/backoffice/basicManage/holyList.do";
			}			
			if (ret >0){
				model.addAttribute("status", Globals.STATUS_SUCCESS);
				model.addAttribute("message", egovMessageSource.getMessage(meesage));
						
			}else {
				throw new Exception();
			}			
		}catch (Exception e){
			model.addAttribute("status", Globals.STATUS_FAIL);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.insert"));			
			url = "redirect:/backoffice/basicManage/holyList.do";
		}
		return url;
	}
	
	@RequestMapping (value="/backoffice/basicManage/smartBatch.do")
	public Boolean holyDayBatch(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                         , @ModelAttribute("vo")  HolyworkInfoVO vo
			                                                         , HttpServletRequest request
			                                            			 , BindingResult bindingResult
																	 , ModelMap model ) throws Exception{	
		
		try{
			
			int smartBatch = holyService.smartBatch();
			
			int timeBatch = holyService.timeBatch();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
				
		
		return true;
	}
	
}
