package com.sohoki.backoffice.sts.hly.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sts.hly.mapper.HolyInfoManagerMapper;
import com.sohoki.backoffice.sts.hly.service.HolyInfoService;
import com.sohoki.backoffice.sts.hly.vo.HolyInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class HolyInfoServiceImpl extends EgovAbstractServiceImpl implements HolyInfoService{

	
	@Autowired
	private HolyInfoManagerMapper holyMapper;

	@Override
	public List<Map<String, Object>> selectHolyInfoManageListByPagination(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyInfoManageListByPagination(params);
	}

	@Override
	public Map<String, Object> selectHolyInfoManageView(String holyDay) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyInfoManageView(holyDay);
	}

	@Override
	public int updateHolyInfoManage(HolyInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return vo.getMode().equals("Ins") ? holyMapper.insertHolyInfoManage(vo) : holyMapper.updateHolyInfoManage(vo);
	}
	
	
}
