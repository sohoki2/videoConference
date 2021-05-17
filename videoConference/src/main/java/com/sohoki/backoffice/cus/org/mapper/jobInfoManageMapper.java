package com.sohoki.backoffice.cus.org.mapper;

import java.util.List;

import com.sohoki.backoffice.cus.org.vo.jobInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface jobInfoManageMapper {
	
    public List<jobInfo> selectJobInfoCombo(String codeGubun);
	
    public List<jobInfo> selectJobInfoComboSearch(String searchKeyword);
    
    public int insertJobInfo(jobInfo job);
    
    public int deleteJobInfo();
}
