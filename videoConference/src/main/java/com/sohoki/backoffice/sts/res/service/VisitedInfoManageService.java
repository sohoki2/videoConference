package com.sohoki.backoffice.sts.res.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sts.res.vo.VisitedInfo;

public interface VisitedInfoManageService {

	
    List<Map<String, Object>> selectVisitedManageListByPagination(@Param("params") Map<String, Object> params) throws Exception;
    
    List<List<Object>>  selectVisitedDetailInfo(VisitedInfo visitedInfo )throws Exception;
    
    List<Map<String, Object>> selectVisitedDetailInfoFront (String visitedCode )throws Exception;
    
    Map<String, Object> selectTourCount(@Param("params") Map<String, Object> params)throws Exception;
	
    List<Map<String, Object>> selecttourCombo() throws Exception;
    
    List<Map<String, Object>> selecttourInfo() throws Exception;
    
	Map<String, Object> selectVisitedManageInfo(String visitedCode) throws Exception;
	
	int updateVisitedReqManageInfo (Map<String, Object> visitedInfo) throws Exception;
	
	int updateVisitedStateChangeInfoManage (VisitedInfo info) throws Exception;
}
