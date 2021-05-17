package com.sohoki.backoffice.cus.org.service;

import java.util.List;

import com.sohoki.backoffice.cus.org.vo.OrgInfo;

public interface OrgInfoManageService {

	List<OrgInfo> selectOrgInfoCombo();
	
	List<OrgInfo> selectOrgInfoComboSearch(OrgInfo SearchVO)  throws Exception;
	
	int deleteEaiOrgTmp() throws Exception;
}
