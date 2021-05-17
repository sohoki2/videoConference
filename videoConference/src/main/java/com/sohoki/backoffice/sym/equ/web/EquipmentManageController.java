package com.sohoki.backoffice.sym.equ.web;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.AdminLoginVO;

import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.sym.equ.vo.Equipment;
import com.sohoki.backoffice.sym.equ.vo.EquipmentVO;
import com.sohoki.backoffice.sym.equ.service.EquipmentManageService;
import com.sohoki.backoffice.sym.sat.service.SeatInfoManageService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/backoffice/basicManage")
public class EquipmentManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EquipmentManageController.class);
	
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private CenterInfoManageService centerService;
	
	@Autowired
	private EquipmentManageService equipService;
	
	@Autowired
	private EgovCcmCmmnDetailCodeManageService cmmnDetailService;

	@Autowired
	private SeatInfoManageService seatService;
	

	
	EgovStringUtil util = new EgovStringUtil();
	
	@RequestMapping(value="equpList.do")
	public ModelAndView  selectEqupInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
																			, @ModelAttribute("searchVO") EquipmentVO searchVO
																			, HttpServletRequest request
																			, BindingResult bindingResult	) throws Exception {
		   
		
		
		    ModelAndView model = new ModelAndView("/backoffice/basicManage/equpList");
		    
		    
		    
		    try{
			    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
				    if(!isAuthenticated) {
				        	model.addObject(Globals .STATUS, Globals.STATUS_LOGINFAIL);
				    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				    		return model;
				    }
		    	   //model.addObject("selectCodeTDM", cmmnDetailService.selectCmmnDetailCombo("swc_gubun"));
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
				  
		          if (searchVO.getSearchcenterId() == null) {searchVO.setSearchcenterId(""); }
		          
		          List<Map<String, Object>> list =  equipService.selectEqupManageListByPagination(searchVO);
		          int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
		        
		          
			       model.addObject("resultList",   list );
			       model.addObject( Globals.STATUS_REGINFO , searchVO);
			       
				   paginationInfo.setTotalRecordCount( Integer.valueOf(  totCnt ) );
			       model.addObject("paginationInfo", paginationInfo);
			       model.addObject( Globals.PAGE_TOTALCNT, totCnt);
			       model.addObject("selectCenter", centerService.selectCenterInfoManageCombo());
		    }catch(Exception e){
		    	   LOGGER.error("selectEqupInfoManageListByPagination error:" + e.toString());
		    }
			
		
		  
		   return model ;	
	}
	@RequestMapping (value="equpDetail.do")
	public ModelAndView selecSeatInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                             , @RequestBody EquipmentVO vo
			                                                             , HttpServletRequest request
			                                            			     , BindingResult bindingResult ) throws Exception{	
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
		        	model.addObject(Globals .STATUS, Globals.STATUS_LOGINFAIL);
		    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
		    		return model;
		    }	
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, equipService.selectEqupManageDetail(vo.getEqupCode()));	
		}catch(Exception e){
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.request"));		
		}
		
		return model ; 
	}
	@RequestMapping (value="equpView.do")
	public String selecEqupInfoManageView(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                         , @ModelAttribute("vo")  EquipmentVO vo
			                                                         , HttpServletRequest request
			                                            			 , BindingResult bindingResult
																	 , ModelMap model ) throws Exception{	
		
		
				
		model.addAttribute(Globals.STATUS_REGINFO, vo);
	    model.addAttribute("regist", equipService.selectEqupManageView(vo.getEqupCode()));
		return "/backoffice/basicManage/equpView";
	}
	@RequestMapping (value="equpDelete.do")
	public ModelAndView deleteEqupInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
			                                                        @RequestParam("equpCode") String equpCode  ) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			  Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		      if(!isAuthenticated) {
		        	model.addObject(Globals .STATUS, Globals.STATUS_LOGINFAIL);
		    		model.addObject(Globals.STATUS_MESSAGE  , egovMessageSource.getMessage("fail.common.login"));
		    		return model;
		      }
	        
		      int ret = 	equipService.deleteEqupManage(equpCode);		      
		      if (ret > 0 ) {		    	  
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
	@RequestMapping(value="equpListinfo.do")
	public ModelAndView selectEqupListInfoManage( @ModelAttribute("loginVO") AdminLoginVO loginVO,
																	    @RequestBody EquipmentVO searchVO	
															            , HttpServletRequest request                         				 
																		 , BindingResult result) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			/*Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
		        	model.addObject(Globals .STATUS  , Globals.STATUS_LOGINFAIL);
		    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
		    		return model;
		    }*/
		    model.addObject(Globals .STATUS, Globals.STATUS_SUCCESS);
		    searchVO.setFirstIndex(0);
		    searchVO.setRecordCountPerPage(100);
		    List<Map<String, Object>> list = equipService.selectEqupManageListByPagination(searchVO);
		    int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
		    model.addObject("equipList", list);
		    model.addObject("totCnt",totCnt); 
		    
		}catch(Exception e){
			LOGGER.error("error:" + e.toString());
			model.addObject(Globals .STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.select"));
		}
		return model;
		
	}
	@RequestMapping (value="equpUpdate.do")
	public ModelAndView updateequpInfoManage( @ModelAttribute("loginVO") AdminLoginVO loginVO,
																	 @RequestBody Equipment vo	
							                                         , HttpServletRequest request                         				 
																	 , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
		        	model.addObject(Globals .STATUS  , Globals.STATUS_LOGINFAIL);
		    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
		    		return model;
		    }
			String meesage = vo.getMode().equals("Ins") ?  "sucess.common.insert" : "sucess.common.update";
			
			vo.setEquipmentName( util.checkHtmlView(  vo.getEquipmentName().toString())  );
			vo.setEquipSerial( util.checkHtmlView(  vo.getEquipSerial().toString())   );
			vo.setCompany(util.checkHtmlView(  vo.getCompany().toString())  );
			vo.setRemark(  util.checkHtmlView(  vo.getRemark().toString())     );
			
			int ret  =equipService.updateEqupManage(vo) ; 
			if (ret >0){
				model.addObject(Globals .STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
						
			}else {
				throw new Exception();
			}
			
		}catch (Exception e){
			model.addObject(Globals .STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.update"));
		}
		return model;
	}
}
