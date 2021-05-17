package com.sohoki.backoffice.uat.uia.service;



import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.uat.uia.vo.AdminInfo;
import com.sohoki.backoffice.uat.uia.vo.AdminInfoVO;

public interface AdminInfoManageService {
	
	List<Map<String, Object>> selectAdminUserManageListByPagination(Map<String, Object> searchVO) throws Exception;  
	
	Map<String, Object> selectAdminUserManageDetail(String adminId) throws Exception;

	int deleteAdminUserManage(String mberId) throws Exception;
	
	int updateAdminUserManage(AdminInfo gnrmber) throws Exception;
	
	int updateAdminUserLockManage(String adminId) throws Exception;
	
		
	  
	
}
