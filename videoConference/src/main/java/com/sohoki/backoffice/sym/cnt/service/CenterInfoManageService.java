package com.sohoki.backoffice.sym.cnt.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sym.cnt.vo.CenterInfo;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfoVO;

public interface CenterInfoManageService {

	List<Map<String, Object>>  selectCenterInfoManageListByPagination(Map<String, Object> SearchVO) throws Exception;
		
	List<CenterInfo> selectCenterInfoManageCombo () throws Exception;
	
	Map<String, Object> selectCenterInfoManageDetail(String centerId) throws Exception;
	
	int updateCenterInfoManage(CenterInfo vo) throws Exception;
	
	int updateCenterFloorInfoManage (String floorInfo, String centerId) throws Exception;
	//int deleteCenterInfoManage(String conSeq) throws Exception;
}
