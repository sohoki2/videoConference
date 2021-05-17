package com.sohoki.backoffice.cus.org.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.cus.org.vo.jobInfo;
import com.sohoki.backoffice.cus.org.service.jobInfoManageService;
import com.sohoki.backoffice.cus.org.mapper.jobInfoManageMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service
public class jobInfoManageServiceImpl extends EgovAbstractServiceImpl implements jobInfoManageService{

	
	@Autowired
	private  jobInfoManageMapper jobMapper;
	
	@Override
	public List<jobInfo> selectJobInfoCombo(String codeGubun) {
		// TODO Auto-generated method stub
		return jobMapper.selectJobInfoCombo(codeGubun);
	}

	@Override
	public List<jobInfo> selectJobInfoComboSearch(String searchKeyword)
			throws Exception {
		// TODO Auto-generated method stub
		return jobMapper.selectJobInfoComboSearch(searchKeyword);
	}

	
}
