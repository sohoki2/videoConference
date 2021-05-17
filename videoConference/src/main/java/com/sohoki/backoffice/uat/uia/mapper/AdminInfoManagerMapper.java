package com.sohoki.backoffice.uat.uia.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.uat.uia.vo.AdminInfo;
import com.sohoki.backoffice.uat.uia.vo.AdminInfoVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AdminInfoManagerMapper {
	
	public List<Map<String, Object>> selectAdminUserManageListByPagination(@Param("params") Map<String, Object> params);

	public Map<String, Object> selectAdminUserManageDetail(String adminId);
	
	public int deleteAdminUserManage(String mberId);
	
	public int insertAdminUserManage(AdminInfo vo);
	
	public int updateAdminUserManage(AdminInfo adminInfo);
	
	public int updateAdminUserLockManage(String adminId);
	
	public int selectAdminUserMangerIDCheck(String code) throws Exception;
	
}
