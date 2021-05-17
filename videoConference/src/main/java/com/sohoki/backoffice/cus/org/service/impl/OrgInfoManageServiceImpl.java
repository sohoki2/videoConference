package com.sohoki.backoffice.cus.org.service.impl;

import java.util.List;

import com.sohoki.backoffice.cus.org.mapper.OrgInfoManagerMapper;
import com.sohoki.backoffice.cus.org.vo.OrgInfo;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class OrgInfoManageServiceImpl extends EgovAbstractServiceImpl implements OrgInfoManageService {

	@Autowired 
	private OrgInfoManagerMapper orgMapper;

	@Override
	public List<OrgInfo> selectOrgInfoCombo() {
		// TODO Auto-generated method stub
		return orgMapper.selectOrgInfoCombo();
	}

	@Override
	public List<OrgInfo> selectOrgInfoComboSearch(OrgInfo SearchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return orgMapper.selectOrgInfoComboSearch(SearchVO);
	}


	@Override
	public int deleteEaiOrgTmp() throws Exception {
		// TODO Auto-generated method stub
		return orgMapper.deleteEaiOrgTmp();
	}	
}
