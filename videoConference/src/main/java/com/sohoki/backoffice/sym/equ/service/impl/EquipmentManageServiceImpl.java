package com.sohoki.backoffice.sym.equ.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.sohoki.backoffice.sym.equ.vo.Equipment;
import com.sohoki.backoffice.sym.equ.vo.EquipmentVO;
import com.sohoki.backoffice.sym.equ.service.EquipmentManageService;
import com.sohoki.backoffice.sym.equ.mapper.EquipmentManageMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service
public class EquipmentManageServiceImpl extends EgovAbstractServiceImpl implements EquipmentManageService {

	@Autowired
	private EquipmentManageMapper equpMapper;
	
	@Resource(name="egovEqupIdGnrService")
	private EgovIdGnrService egovEqupIdGnrService;
	
	
	@Override
	public List<Map<String, Object>> selectEqupManageListByPagination(EquipmentVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return equpMapper.selectEqupManageListByPagination(searchVO);
	}

	@Override
	public Equipment selectEqupManageDetail(String equpId) throws Exception {
		// TODO Auto-generated method stub
		Equipment  vo=  null;
		try{
			vo = equpMapper.selectEqupManageDetail(equpId);
		}catch(Exception e){
			System.out.println("ERROR:" + e.toString());
		}
		return vo;
	}

	@Override
	public EquipmentVO selectEqupManageView(String equpId) throws Exception {
		// TODO Auto-generated method stub
		return equpMapper.selectEqupManageView(equpId);
	}
	
	@Override
	public int updateEqupManage(Equipment vo) throws Exception {
		// TODO Auto-generated method stub
		int ret = 0;
		if (vo.getMode().equals("Ins")){
			
			vo.setEqupCode(egovEqupIdGnrService.getNextStringId());
			ret = equpMapper.insertEqupManage(vo);
		}else{
			ret = equpMapper.updateEqupManage(vo);
		}
		return ret;
	}

	@Override
	public int deleteEqupManage(String equpId) throws Exception {
		// TODO Auto-generated method stub
		return equpMapper.deleteEqupManage(equpId);
	}
	

}
