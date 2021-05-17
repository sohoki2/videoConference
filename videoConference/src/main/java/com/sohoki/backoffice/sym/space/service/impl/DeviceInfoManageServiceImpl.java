package com.sohoki.backoffice.sym.space.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.sym.cnt.mapper.CentertInfoManagerMapper;
import com.sohoki.backoffice.sym.space.mapper.DeviceInfoManageMapper;
import com.sohoki.backoffice.sym.space.service.DeviceInfoManageService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import com.sohoki.backoffice.sym.space.vo.DeviceInfo;

@Service
public class DeviceInfoManageServiceImpl extends EgovAbstractServiceImpl implements DeviceInfoManageService {

	
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DeviceInfoManageServiceImpl.class);

	@Resource(name = "egovEqupIdGnrService")
	private EgovIdGnrService egovEqupIdGnrService;
	
	@Autowired
	private DeviceInfoManageMapper deviceMapper;

	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    private CentertInfoManagerMapper centerMapper;

	@Override
	public List<Map<String, Object>> selectDevicePageInfoManageListByPagination(Map<String, Object> params) throws Exception {
		return deviceMapper.selectDevicePageInfoManageListByPagination(params);
	}
	
	@Override
	public Map<String, Object> selectDevicePageInfoManageDetail(String deviceId) throws Exception {
		// TODO Auto-generated method stub
		return deviceMapper.selectDevicePageInfoManageDetail(deviceId);
	}
	
	@Override
	public int selectDeviceExist(String deviceId) throws Exception {
		// TODO Auto-generated method stub
		return deviceMapper.selectDeviceExist(deviceId);
	}
	
	@Override
	public int updateDevicePageInfoManage(DeviceInfo vo) throws Exception {
		// TODO Auto-generated method stub
		if (vo.getMode().equals("Ins")) 
			vo.setDeviceId(egovEqupIdGnrService.getNextStringId());
			
		return vo.getMode().equals("Ins") ? deviceMapper.insertDevicePageInfoManage(vo) : deviceMapper.updateDevicePageInfoManage(vo);
	}
	
	@Override
	public int updateDeviceIpMac(DeviceInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return deviceMapper.updateDeviceIpMac(vo);
	}
	
	@Override
	public int updateDeviceEndConnTime(DeviceInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return deviceMapper.updateDeviceEndConnTime(vo);
	}

	@Override
	public int deleteDevieManage(String deviceId) throws Exception {
		// TODO Auto-generated method stub
		return deviceMapper.deleteDevieManage(deviceId);
	}

	@Override
	public Map<String, Object> selectDeviceInfo(String deviceId)
			throws Exception {
		// TODO Auto-generated method stub
		return deviceMapper.selectDeviceInfo(deviceId);
	}
}
