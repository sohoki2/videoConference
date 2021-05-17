package com.sohoki.backoffice.cus.com.servie;

import java.util.List;
import java.util.Map;
import com.sohoki.backoffice.cus.com.vo.CompanyInfo;

public interface CompanyInfoManageService {

	 List<Map<String, Object>> selectCompanyInfoManageListByPagination(Map<String, Object> params) throws Exception;
		
	 List<Map<String, Object>> selectCompanyInfoManageCombo (String comCode ) throws Exception;
		
	 Map<String, Object> selectCompanyInfoManageDetail(String comCode) throws Exception;
			
	 int updateCompanyInfoManage(CompanyInfo vo) throws Exception;

}
