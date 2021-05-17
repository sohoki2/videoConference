package com.sohoki.backoffice.cus.com.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.sohoki.backoffice.cus.com.vo.CompanyInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CompanyInfoManageMapper {

	
	    public List<Map<String, Object>> selectCompanyInfoManageListByPagination(@Param("params") Map<String, Object> params);
		
		public List<Map<String, Object>> selectCompanyInfoManageCombo (@Param("centerId") String comCode);
		
		public Map<String, Object> selectCompanyInfoManageDetail(String comCode);
			
		public int insertCompanyInfoManage(CompanyInfo vo);
		
		public int updateCompanyInfoManage(CompanyInfo vo);
}
