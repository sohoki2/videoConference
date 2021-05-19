package com.sohoki.backoffice.sym.space.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sym.space.mapper.OfficeSeatInfoManageMapper;
import com.sohoki.backoffice.sym.space.service.OfficeSeatInfoManageService;
import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service
public class OfficeSeatInfoManageServiceImpl extends EgovAbstractServiceImpl implements OfficeSeatInfoManageService{

	
	@Autowired
	private OfficeSeatInfoManageMapper officeSeatMapper;

	@Override
	public List<Map<String, Object>> selectOfficeSeatInfoManageListByPagination(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return officeSeatMapper.selectOfficeSeatInfoManageListByPagination(params);
	}

	@Override
	public Map<String, Object> selectOfficeSeatInfoManageDetail(String seatId) throws Exception {
		// TODO Auto-generated method stub
		return officeSeatMapper.selectOfficeSeatInfoManageDetail(seatId);
	}

	@Override
	public int updateOfficeSeatInfoManage(OfficeSeatInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return vo.getMode().equals("Ins") ?  officeSeatMapper.insertOfficeSeatInfoManage(vo) :  officeSeatMapper.updateOfficeSeatInfoManage(vo);
	}

	@Override
	public int updateOfficeSeatPositionInfoManage(List<OfficeSeatInfo> list, String type) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("type:" + type);
		return officeSeatMapper.updateOfficeSeatPositionInfoManage(list, type);
	}

	@Override
	public int deleteOfficeSeatQrInfoManage(List<String> seatList) throws Exception {
		// TODO Auto-generated method stub
		return officeSeatMapper.deleteOfficeSeatQrInfoManage(seatList);
	}

	
}
