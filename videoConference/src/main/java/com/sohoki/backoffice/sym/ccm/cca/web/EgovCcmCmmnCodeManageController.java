package com.sohoki.backoffice.sym.ccm.cca.web;


import egovframework.com.cmm.AdminLoginVO;

import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCode;
import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCodeVO;
import com.sohoki.backoffice.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;
import com.sohoki.backoffice.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;



import com.sohoki.backoffice.sym.cnt.web.CenterInfoManageController;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller 
public class EgovCcmCmmnCodeManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovCcmCmmnCodeManageController.class);
	
	@Autowired
    private EgovCcmCmmnCodeManageService cmmnCodeManageService;

	@Autowired
    private EgovCcmCmmnClCodeManageService cmmnClCodeManageService;

	
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	
    /** EgovPropertyService */
	@Autowired
    protected EgovPropertyService propertiesService;

	
	/**
	 * 공통코드를 삭제한다.
	 * @param AdminLoginVO
	 * @param cmmnCode
	 * @param model
	 * @return "forward:/sym/ccm/cca/EgovCcmCmmnCodeList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/backoffice/basicManage/codeDelete.do")
	public String deleteCmmnCode (@ModelAttribute("adminLoginVO") AdminLoginVO adminLoginVO
			, CmmnCode cmmnCode
			, HttpServletRequest request
			, BindingResult bindingResult			
			, ModelMap model
			) throws Exception {
    	int ret = cmmnCodeManageService.deleteCmmnCode(cmmnCode.getCodeId());
    	if (ret > 0){
			model.addAttribute("status", Globals.STATUS_SUCCESS);
			model.addAttribute("message",   egovMessageSource.getMessage("success.common.delete"));    		
    	}else {
    		throw new Exception();    		
    	}
    	
        return "forward:/backoffice/basicManage/codeList.do";
	}

	
	
    @RequestMapping(value="/backoffice/basicManage/codeList.do")
	public String selectCmmnCodeList (@ModelAttribute("adminLoginVO") AdminLoginVO adminLoginVO
			, @ModelAttribute("searchVO") CmmnCodeVO searchVO
			, HttpServletRequest request
			, BindingResult bindingResult			
			, ModelMap model
			) throws Exception {
    	
    	model.addAttribute("regist", searchVO);
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        model.addAttribute("resultList", cmmnCodeManageService.selectCmmnCodeList(searchVO));

        int totCnt =cmmnCodeManageService.selectCmmnCodeListTotCnt(searchVO);
        
        model.addAttribute("totalCnt", totCnt);
        
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "/backoffice/basicManage/codeList";
	}
   
    //ID 체크 
    @NoLogging
    @RequestMapping (value="/backoffice/basicManage/codeIDCheck.do")
    public ModelAndView selectIdCheck(HttpServletRequest request
    		                    , @RequestParam("codeId") String codeId )throws Exception{
    	
    	ModelAndView model = new ModelAndView(Globals.JSONVIEW);
    	try {
    		String result = cmmnCodeManageService.selectIDCheck(codeId) > 0 ? "FAIL" : "OK";
    		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
    		model.addObject(Globals.JSON_RETURN_RESULT, result);
    	}catch(Exception e) {
    		model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
    	}
    	return model;
    	
    }
  //ajax 로 값 보내기 
  	@RequestMapping ("/backoffice/basicManage/codeDetail.do")
  	public ModelAndView selectGroupDetail(HttpServletRequest request) throws Exception{
  	    //	    
  		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
  		
  		String codeId = request.getParameter("codeId") != null ? request.getParameter("codeId") : "";
  		
  		CmmnCode  cmmCode  =	(CmmnCode) cmmnCodeManageService.selectCmmnCodeDetail(codeId);
  		model.addObject("codeDetail", cmmCode);
  	 	return model;
  	}
  	@RequestMapping (value="/backoffice/basicManage/codeUpdate.do")
  	@SuppressWarnings("finally")	
  	public String  updateCmmCode (@ModelAttribute("adminLoginVO") AdminLoginVO adminLoginVO
  			                                          , @ModelAttribute("cmmnCode") CmmnCode vo
  			                                          , HttpServletRequest request
  			                          			      , BindingResult bindingResult						                          			
  			                          			      , ModelMap model
  			                          			  ) throws Exception {
  		model.addAttribute("regist", vo);
		String meesage = "";
		String url = "redirect:/backoffice/basicManage/codeList.do";  		
		
  	    try{
  	    	int ret  = 0;
  	    	LOGGER.debug("mode:"+ vo.getMode()  );
  	    	LOGGER.debug("mode:"+ vo.getCodeId()  );
  	    	LOGGER.debug("mode:"+ vo.getCodeIdNm()  );
  	    	
			if (vo.getMode().equals("Ins")){				
				ret = cmmnCodeManageService.insertCmmnCode(vo);
				meesage = "sucess.common.insert";
				url = "redirect:/backoffice/basicManage/codeList.do";				
			}else {
				 ret = cmmnCodeManageService.updateCmmnCode(vo);
				 meesage = "sucess.common.update";
				 url = "redirect:/backoffice/basicManage/codeList.do";
			}			
			if (ret >0){
				model.addAttribute("status", Globals.STATUS_SUCCESS);
				model.addAttribute("message", egovMessageSource.getMessage(meesage));				
			}else {
				throw new Exception();
			}
  	    	
  	    	
  	    }catch (Exception e){
  	    	LOGGER.debug("error:"+ e.toString()  );
  	    	model.addAttribute("status", Globals.STATUS_FAIL);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.insert"));			
			url = "redirect:/backoffice/basicManage/codeList.do";
  	    }
  	    return url;
  	}
}
