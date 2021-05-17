package com.sohoki.backoffice.sym.cnt.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.servlet.ModelAndView;
import com.sohoki.backoffice.sym.cnt.vo.FloorInfo;

public interface FloorInfoManageService {

	List<Map<String, Object>> selectFloorInfoManageListByPagination(@Param("params") Map<String, Object> params)throws Exception;
	
	List<Map<String, Object>> selectFloorInfoManageCombo (String centerId)throws Exception;
	
	Map<String, Object> selectFloorInfoManageDetail(String floorSeq)throws Exception;
	
	int updateFloorInfoManage(FloorInfo vo)throws Exception;
	
	int insertFloorSeatUpdate(@Param("params") Map<String, Object> params)throws Exception;
	
}
