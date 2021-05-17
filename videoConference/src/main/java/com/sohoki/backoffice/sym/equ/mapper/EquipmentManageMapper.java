package com.sohoki.backoffice.sym.equ.mapper;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sym.equ.vo.Equipment;
import com.sohoki.backoffice.sym.equ.vo.EquipmentVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EquipmentManageMapper {

    public List<Map<String, Object>> selectEqupManageListByPagination(EquipmentVO searchVO) throws Exception;
	
    public Equipment selectEqupManageDetail(String equpId);
	
    public EquipmentVO selectEqupManageView(String equpId) throws Exception;
    
    public List<Map<String, Object>> selectResEquipList(Equipment vo) throws Exception;
    
    public int selectResEquipCnt(Equipment vo) throws Exception;
    
    public int insertEqupManage(Equipment vo) throws Exception;
	
    public int updateEqupManage(Equipment vo) throws Exception;
    
    public int updateEqupManage_State(Equipment vo) throws Exception;
	
    public int deleteEqupManage(String  equpId) throws Exception;
}
