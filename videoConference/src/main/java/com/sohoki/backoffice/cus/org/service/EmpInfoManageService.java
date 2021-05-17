package com.sohoki.backoffice.cus.org.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;

public interface EmpInfoManageService {

	List<Map<String, Object>> selectEmpInfoList(Map<String, Object> params)  throws Exception;
	
	List<Map<String, Object>> selectMeetinngUserList(List empNoList)throws Exception;
	
	EmpInfoVO selectEmpInfoDetail(String empId) throws Exception;
	
	EmpInfoVO selectEmpInfoDetailNo(String empno) throws Exception;
	
	EmpInfoVO selectSmartOfficeLoginAction(String empNo) throws Exception;
	
	int insertEmployInfoManage (EmpInfo vo);
	
	int EaiEmpinfoUpdate() throws Exception;
	
	int deleteEaiEmpTmp()throws Exception;
}
