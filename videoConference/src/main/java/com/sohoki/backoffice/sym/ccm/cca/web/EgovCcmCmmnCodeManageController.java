package com.sohoki.backoffice.sym.ccm.cca.web;


import egovframework.com.cmm.AdminLoginVO;

import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCode;
import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCodeVO;
import com.sohoki.backoffice.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;
import com.sohoki.backoffice.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;


@RestController 
public class EgovCcmCmmnCodeManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovCcmCmmnCodeManageController.class);
	
	@Autowired
    private EgovCcmCmmnCodeManageService cmmnCodeManageService;

	@Autowired
    private EgovCcmCmmnClCodeManageService cmmnClCodeManageService;

	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;

	
	@Autowired
	private UniSelectInfoManageService  uniService;
	
	/**
	 * 공통코드를 삭제한다.
	 * @param AdminLoginVO
	 * @param cmmnCode
	 * @param model
	 * @return "forward:/sym/ccm/cca/EgovCcmCmmnCodeList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/backoffice/basicManage/codeDelete.do")
	public ModelAndView deleteCmmnCode (@ModelAttribute("adminLoginVO") AdminLoginVO adminLoginVO
									    , CmmnCode cmmnCode
									    , HttpServletRequest request
									    , BindingResult bindingResult	) throws Exception {
    	
    	ModelAndView model = new ModelAndView("redirect:/backoffice/basicManage/codeList.do");
    	try {
    		int ret = cmmnCodeManageService.deleteCmmnCode(cmmnCode.getCodeId());
    		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_MESSAGE,   egovMessageSource.getMessage("success.common.delete"));    		
        	
    	}catch(Exception e) {
    		LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));
    	}
        return model;
	}

	
	
    @RequestMapping(value="/backoffice/basicManage/codeList.do")
	public ModelAndView selectCmmnCodeList (@ModelAttribute("adminLoginVO") AdminLoginVO adminLoginVO
										   , @ModelAttribute("searchVO") CmmnCodeVO searchVO
										   , HttpServletRequest request
										   , BindingResult bindingResult	) throws Exception {
    	ModelAndView model = new ModelAndView("/backoffice/basicManage/codeList");
    	try {
    		model.addObject(Globals.STATUS_REGINFO, searchVO);
        	
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
    		
    		List<CmmnCodeVO> list =  cmmnCodeManageService.selectCmmnCodeListByPagination(searchVO);

            model.addObject(Globals.JSON_RETURN_RESULTLISR, list);
            
            int totCnt =  list.size() > 0 ? list.get(0).getTotalRecordCount() : 0;
            LOGGER.debug("totCnt:" + totCnt);
            model.addObject(Globals.PAGE_TOTALCNT, totCnt);
            
    		paginationInfo.setTotalRecordCount(totCnt);
            model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
    	}catch(Exception e) {
    		StackTraceElement[] ste = e.getStackTrace();
    		LOGGER.info("codeList.do error:" + e.toString() + " : error line =" +  ste[0].getLineNumber());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
    	}
    	

        return model;
	}
   
    //ID 체크 
    @NoLogging
    @RequestMapping (value="/backoffice/basicManage/codeIDCheck.do")
    public ModelAndView selectIdCheck(HttpServletRequest request
    		                          , @RequestParam("codeId") String codeId )throws Exception{
    	
    	ModelAndView model = new ModelAndView(Globals.JSONVIEW);
    	try {
    		String result = uniService.selectIdDoubleCheck("CODE_ID", "lettccmmncode", "CODE_ID = ["+ codeId + "[") > 0 ? "FAIL" : "OK";
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
  	public ModelAndView selectGroupDetail(@RequestParam("codeId") String codeId) throws Exception{
  	    //	    
  		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
  		CmmnCode cmmCode  =(CmmnCode) cmmnCodeManageService.selectCmmnCodeDetail(codeId);
  		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
  		model.addObject(Globals.STATUS_REGINFO, cmmCode);
  	 	return model;
  	}
  	@RequestMapping (value="/backoffice/basicManage/codeUpdate.do")
  	public ModelAndView  updateCmmCode (@ModelAttribute("adminLoginVO") AdminLoginVO adminLoginVO
                                        , @ModelAttribute("cmmnCode") CmmnCode vo
                                        , HttpServletRequest request
                          			    , BindingResult bindingResult) throws Exception {
  		ModelAndView model = new ModelAndView();
  		try {
  			model.addObject("regist", vo);
  			String meesage = "";
  			int ret  = 0;  	    	
  	        meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update";
  	        ret = cmmnCodeManageService.updateCmmnCode(vo);
			if (ret >0){
				model.addObject("status", Globals.STATUS_SUCCESS);
				model.addObject("message", egovMessageSource.getMessage(meesage));				
			}else {
				throw new Exception();
			}
  		}catch(Exception e) {
  			LOGGER.debug("error:"+ e.toString()  );
	  	    model.addObject("status", Globals.STATUS_FAIL);
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));	
  		}
  		
  		model.setViewName("redirect:/backoffice/basicManage/codeList.do");
  		return model;
  	}
}
