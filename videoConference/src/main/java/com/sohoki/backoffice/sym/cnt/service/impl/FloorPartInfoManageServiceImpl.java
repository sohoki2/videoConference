package com.sohoki.backoffice.sym.cnt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sym.cnt.mapper.FloorPartInfoManageMapper;
import com.sohoki.backoffice.sym.cnt.service.FloorPartInfoManageService;
import com.sohoki.backoffice.sym.cnt.vo.FloorPartInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class FloorPartInfoManageServiceImpl extends EgovAbstractServiceImpl  implements FloorPartInfoManageService{

	
	
	@Autowired
	private FloorPartInfoManageMapper partMapper;

	@Override
	public List<Map<String, Object>> selectFloorPartInfoManageListByPagination(Map<String, Object> params)
			throws Exception {
		// TODO Auto-generated method stub
		return partMapper.selectFloorPartInfoManageListByPagination(params);
	}

	@Override
	public List<Map<String, Object>> selectFloorPartInfoManageCombo( String centerId, String floorSeq) throws Exception {
		// TODO Auto-generated method stub
		return partMapper.selectFloorPartInfoManageCombo(centerId, floorSeq);
	}

	@Override
	public Map<String, Object> selectFloorPartInfoManageDetail(String partSeq) throws Exception {
		// TODO Auto-generated method stub
		return partMapper.selectFloorPartInfoManageDetail(partSeq);
	}

	@Override
	public int updateFloorPartInfoManage(FloorPartInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return vo.getMode().equals("Ins") ? partMapper.insertFloorPrartInfoManage(vo) : partMapper.updateFloorPrartInfoManage(vo);
	}
	
	
}
