package com.sohoki.backoffice.sym.cnt.service.impl;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sym.cnt.mapper.CentertInfoManagerMapper;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfo;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfoVO;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class CenterInfoManagerServiceImpl extends EgovAbstractServiceImpl implements CenterInfoManageService{

	
	@Autowired
    private CentertInfoManagerMapper centerMapper;
	
	@Autowired
	private SmartUtil util;

	@Override
	public List<Map<String, Object>> selectCenterInfoManageListByPagination(Map<String, Object> SearchVO) throws Exception {
		// TODO Auto-generated method stub
		return centerMapper.selectCenterInfoManageListByPagination(SearchVO);
	}

	@Override
	public List<CenterInfo> selectCenterInfoManageCombo()throws Exception {
		// TODO Auto-generated method stub
		return centerMapper.selectCenterInfoManageCombo();
	}

	@Override
	public Map<String, Object> selectCenterInfoManageDetail(String centerId)
			throws Exception {
		// TODO Auto-generated method stub
		return centerMapper.selectCenterInfoManageDetail(centerId);
	}

	
	@Override
	@Transactional
	public int updateCenterInfoManage(CenterInfo vo) throws Exception {
		// TODO Auto-generated method stub
		int ret = 0;
		if (vo.getMode().equals("Ins")){
			List floorLists =  vo.getFloorInfo().equals("") ? null : util.dotToList(vo.getFloorInfo());
			vo.setFloorlist(floorLists);
			ret =  centerMapper.insertCenterInfoManage(vo);
		}else{
			ret =  centerMapper.updateCenterInfoManage(vo);
		}
		return ret;
	}

	@Override
	public int updateCenterFloorInfoManage(String floorInfo, String centerId) throws Exception {
		// TODO Auto-generated method stub
		return centerMapper.updateCenterFloorInfoManage(floorInfo, centerId);
	}

}
