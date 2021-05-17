package com.sohoki.backoffice.sym.equ.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sym.equ.vo.Equipment; 
import com.sohoki.backoffice.sym.equ.vo.EquipmentVO; 
public interface EquipmentManageService {

	List<Map<String, Object>> selectEqupManageListByPagination(EquipmentVO searchVO) throws Exception;
	
	Equipment selectEqupManageDetail(String equpId) throws Exception;
	
    EquipmentVO selectEqupManageView(String equpId) throws Exception;
	
    int updateEqupManage(Equipment vo) throws Exception;
	
    int deleteEqupManage(String  equpId) throws Exception;
}
