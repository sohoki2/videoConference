package com.sohoki.backoffice.sym.cnt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.sym.cnt.mapper.CentertInfoManagerMapper;
import com.sohoki.backoffice.sym.cnt.mapper.FloorInfoManageMapper;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.sym.cnt.vo.FloorInfo;
import com.sohoki.backoffice.sym.space.mapper.OfficeSeatInfoManageMapper;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service
public class FloorInfoManageServiceImpl extends EgovAbstractServiceImpl  implements FloorInfoManageService{

	
	@Autowired
	private FloorInfoManageMapper floorMapper;
	
	@Autowired
    private CentertInfoManagerMapper centerMapper;
	
	@Autowired
    private OfficeSeatInfoManageMapper officeSeatMapper;
	
	@Autowired
	private SmartUtil smartUtil;
	
	@Override
	public List<Map<String, Object>>  selectFloorInfoManageListByPagination(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return floorMapper.selectFloorInfoManageListByPagination(params);
	}

	@Override
	public List<Map<String, Object>> selectFloorInfoManageCombo(String centerId) {
		// TODO Auto-generated method stub
		return floorMapper.selectFloorInfoManageCombo(centerId);
	}

	@Override
	public Map<String, Object> selectFloorInfoManageDetail(String floorSeq) {
		// TODO Auto-generated method stub
		return floorMapper.selectFloorInfoManageDetail(floorSeq);
	}

	@Override
	public int updateFloorInfoManage(FloorInfo vo) {
		// TODO Auto-generated method stub
	
		centerMapper.updateCenterFloorInfoManage(smartUtil.checkItemList(smartUtil.dotToList(vo.getFloorInfos()), smartUtil.NVL(vo.getNowVal(), "0"), vo.getNewVal())  , vo.getCenterId());
		return vo.getMode().equals("Ins")? floorMapper.insertFloorInfoManage(vo) :  floorMapper.updateFloorInfoManage(vo);
	}

	@Override
	public int insertFloorSeatUpdate(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return officeSeatMapper.insertFloorInfoOfficeSeatInfoManage(params);
	}

}
