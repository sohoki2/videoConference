package com.sohoki.backoffice.sym.cnt.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sym.cnt.vo.FloorPartInfo;

public interface FloorPartInfoManageService {

	
    List<Map<String, Object>> selectFloorPartInfoManageListByPagination(@Param("params") Map<String, Object> params)throws Exception;
	
	List<Map<String, Object>> selectFloorPartInfoManageCombo (String centerId, String floorSeq)throws Exception;
	
	Map<String, Object> selectFloorPartInfoManageDetail(String partSeq)throws Exception;
	
	int updateFloorPartInfoManage(FloorPartInfo vo)throws Exception;
}
