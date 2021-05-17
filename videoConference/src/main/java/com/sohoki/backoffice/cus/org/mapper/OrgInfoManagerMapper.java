package com.sohoki.backoffice.cus.org.mapper;

import java.util.List;
import com.sohoki.backoffice.cus.org.vo.OrgInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface OrgInfoManagerMapper {

	public List<OrgInfo> selectOrgInfoCombo();
	
	public List<OrgInfo> selectOrgInfoComboSearch(OrgInfo searchVO);
	
	public int insertOrgInfo();
	
	public int deleteEaiOrgTmp();
}
