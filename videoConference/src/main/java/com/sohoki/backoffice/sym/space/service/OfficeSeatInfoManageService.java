package com.sohoki.backoffice.sym.space.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;

public interface OfficeSeatInfoManageService {

    List<Map<String, Object>> selectOfficeSeatInfoManageListByPagination(@Param("params") Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectOfficeSeatInfoManageDetail(String seatId) throws Exception;
	
	int updateOfficeSeatInfoManage(OfficeSeatInfo vo) throws Exception;
	
	int updateOfficeSeatPositionInfoManage(List<OfficeSeatInfo> list , String type) throws Exception;
}
