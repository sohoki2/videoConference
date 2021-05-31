package com.sohoki.backoffice.sts.msg.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.LoginVO;

import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;



import com.sohoki.backoffice.sts.hly.web.HolyworkInfoManageController;
import com.sohoki.backoffice.sts.msg.vo.MessageInfo;
import com.sohoki.backoffice.sts.msg.vo.MessageInfoVO;
import com.sohoki.backoffice.sts.msg.service.MessageInfoManageService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;


@RestController
@RequestMapping("/backoffice/basicManage")
public class MessageInfoManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MessageInfoManageController.class);
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;

	@Autowired
    protected MessageInfoManageService msgService;
		
	@Autowired
    protected EgovCcmCmmnDetailCodeManageService detailService;
	
	EgovStringUtil util = new EgovStringUtil();
	
	
	@RequestMapping(value="msgList.do")
	public ModelAndView  selectMsgInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
																			, @ModelAttribute("searchVO") MessageInfoVO searchVO
																			, HttpServletRequest request
																			, BindingResult bindingResult) throws Exception {
		
		   ModelAndView model = new ModelAndView();
		   model.addObject("regist", searchVO);
		   model.addObject("selectMsgGubun", detailService.selectCmmnDetailCombo("MSG_TYPE"));
		   if(  searchVO.getPageUnit() > 0  ){    	   
	    	   searchVO.setPageUnit(searchVO.getPageUnit());
		   }else {
				   searchVO.setPageUnit(propertiesService.getInt(Globals.PAGE_UNIT));   
		   }
		   searchVO.setPageSize(propertiesService.getInt(Globals.PAGE_SIZE));
	      
		   model.setViewName("/backoffice/basicManage/msgList");
		   return model;	
	}
	@RequestMapping(value="msgListAjax.do")
	public ModelAndView selectMsgInfoManageListAjax (@ModelAttribute("loginVO") AdminLoginVO loginVO
																				, @RequestBody MessageInfoVO searchVO
																				, HttpServletRequest request
																				, BindingResult bindingResult) throws Exception {
		
		    ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		    try{
		    	 if(  searchVO.getPageUnit() > 0  ){    	   
			    	   searchVO.setPageUnit(searchVO.getPageUnit());
				  }else {
						   searchVO.setPageUnit(propertiesService.getInt(Globals.PAGE_UNIT));   
				  }
				  searchVO.setPageSize(propertiesService.getInt(Globals.PAGE_SIZE));
			       /** pageing */       
			   	  PaginationInfo paginationInfo = new PaginationInfo();
				  paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
				  paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
				  paginationInfo.setPageSize(searchVO.getPageSize());
		
				  searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
				  searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
				  //수정
				  searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); 
			      List<Map<String, Object>> list =  msgService.selectMsgManageListByPagination(searchVO);   	
			      int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
			      paginationInfo.setTotalRecordCount(totCnt);
			      LOGGER.debug("page check:" + paginationInfo.getCurrentPageNo() + ":"+ paginationInfo.getTotalPageCount() );
			      model.addObject(Globals.JSON_PAGEINFO,   paginationInfo);
			      model.addObject(Globals.JSON_RETURN_RESULTLISR,   list);
			      model.addObject(Globals.PAGE_TOTALCNT,   totCnt);
			      model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			      
		    }catch(Exception e){
		    	LOGGER.error("selectMsgInfoManageListAjax ERROR:"  + e.toString());
		    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		    }
		    return model;
	}
	@RequestMapping (value="msgDetail.do")
	public ModelAndView selecMsgInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                          ,  @RequestParam("msgSeq") String msgSeq  
			                                                          , HttpServletRequest request
			                                            			  , BindingResult bindingResult ) throws Exception{	
		
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			try{
				Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
				 if(!isAuthenticated) {
						model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
						model.addObject(Globals.STATUS,  Globals.STATUS_LOGINFAIL);
						return model;	
			    }
				model.addObject(Globals.STATUS,  Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_REGINFO, msgService.selectMsgManageDetail(msgSeq));	    
			}catch(Exception e){
				LOGGER.error("selectMsgInfoManageListAjax ERROR:"  + e.toString());
		    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			}
			
			return model;
	}
	@RequestMapping (value="msgDelete.do")
	public ModelAndView deletemsgInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
			                                                       @RequestParam("msgSeq") String msgSeq   ) throws Exception {
		
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			try{
				 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
				 if(!isAuthenticated) {
						model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
						model.addObject(Globals.STATUS,  Globals.STATUS_LOGINFAIL);
						return model;	
			     }
				 
			     int ret = 	msgService.deleteMsgManage(msgSeq);		      
			      if (ret > 0 ) {		    	  
			    	     model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
						model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.delete"));
			      }else {
			    	  throw new Exception();		    	  
			      }
			}catch (Exception e){
				LOGGER.info(e.toString());
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
			}		
			return model;
	}
	@RequestMapping (value="msgUpdate.do")
	public ModelAndView updatemsgInfoManage( @ModelAttribute("loginVO") AdminLoginVO loginVO,
																	 @RequestBody MessageInfo vo	                				 
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
			 
			int ret  = msgService.updateMsgManage(vo);
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
