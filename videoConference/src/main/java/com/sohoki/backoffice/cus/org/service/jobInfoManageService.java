package com.sohoki.backoffice.cus.org.service;

import java.util.List;
import com.sohoki.backoffice.cus.org.vo.jobInfo;

public interface jobInfoManageService {

	
    List<jobInfo> selectJobInfoCombo(String codeGubun);
	
	List<jobInfo> selectJobInfoComboSearch(String searchKeyword)  throws Exception;
	
	
}
