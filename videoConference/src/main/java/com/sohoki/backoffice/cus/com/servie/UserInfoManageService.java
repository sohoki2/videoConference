package com.sohoki.backoffice.cus.com.servie;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.cus.com.vo.UserInfo;

public interface UserInfoManageService {

    List<Map<String, Object>> selectUserInfoManageListByPagination(@Param("params") Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectUserInfoManageCombo (@Param("empNo") String userNo) throws Exception;
	
	Map<String, Object> selectUserInfoManageDetail(String userNo) throws Exception;
	
	Map<String, Object> selectUserLogin(@Param("params") Map<String, Object> params) throws Exception;
		
	int updateUserInfoManage(UserInfo vo) throws Exception;
	
	int excelUpload(HttpServletRequest request) throws Exception;
	
	int deleteUserInfoManage(String userNo,String comCode)throws Exception;
}
