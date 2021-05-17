package com.sohoki.smartoffice.front.sts.res.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.smartoffice.front.sts.res.service.ResManageService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class ResManageServiceImpl extends EgovAbstractServiceImpl implements ResManageService{

	 
	 private static final Logger LOGGER = LoggerFactory.getLogger(ResManageServiceImpl.class);
	 
	 @Autowired
	 private ResInfoManageMapper resMapper;
	 
	 @Autowired
	 protected EgovMessageSource egovMessageSource;
	 
	 @Autowired
	 protected EgovPropertyService propertiesService;
	 
	 @Autowired
	 private SmartUtil util;

	 @Override
	 public ModelAndView selectResManageListByPagination(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		ModelAndView model = new ModelAndView();
		try {
			
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(params.get("pageIndx"), "1") ) );
			paginationInfo.setRecordCountPerPage(Integer.valueOf( util.NVL(params.get("pageUnit"), propertiesService.getInt("pageUnit"))));
			paginationInfo.setPageSize(Integer.valueOf( util.NVL(params.get("pageSize"), propertiesService.getInt("pageSize"))));
			
			params.put("firstIndex", paginationInfo.getFirstRecordIndex());
			params.put("lastIndex", paginationInfo.getLastRecordIndex());
			params.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			
	        List<Map<String,Object>> listRes = resMapper.selectResManageListByPagination(params);
	        int totCnt = listRes.size() > 0 ?  Integer.valueOf(listRes.get(0).get("total_record_count").toString()) : 0;
	        paginationInfo.setTotalRecordCount(totCnt);
	        
	        model.addObject(Globals.JSON_RETURN_RESULTLISR,  listRes);
		    model.addObject(Globals.STATUS_REGINFO, params);
		    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    
		}catch(Exception e) {
			LOGGER.error("selectResManageListByPagination error:" + e.toString());
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));
	    	model.addObject(Globals.STATUS, Globals.STATUS_FAIL);	
		}
		return model;
	 }
	 
}
