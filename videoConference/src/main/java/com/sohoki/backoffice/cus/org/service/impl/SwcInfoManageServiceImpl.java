package com.sohoki.backoffice.cus.org.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.cus.org.mapper.SwcInfoManageMapper;
import com.sohoki.backoffice.cus.org.service.SwcInfoManageService;
import com.sohoki.backoffice.cus.org.vo.SwcInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class SwcInfoManageServiceImpl extends EgovAbstractServiceImpl implements SwcInfoManageService {

	
	@Autowired
	private SwcInfoManageMapper swcInfo;
	
	
	@Override
	public SwcInfo selectSwcInfoManageService() throws Exception {
		// TODO Auto-generated method stub
		return swcInfo.selectSwcInfoManageService();
	}

	@Override
	public int updateSwcInfoManageService(SwcInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return swcInfo.updateSwcInfoManageService(vo);
	}

}
