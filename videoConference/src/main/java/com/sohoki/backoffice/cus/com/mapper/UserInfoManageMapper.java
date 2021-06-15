package com.sohoki.backoffice.cus.com.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.sohoki.backoffice.cus.com.vo.UserInfo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface UserInfoManageMapper {

    public List<Map<String, Object>> selectUserInfoManageListByPagination(@Param("params") Map<String, Object> params);
	
	public List<Map<String, Object>> selectUserInfoManageCombo (@Param("comCode") String comCode);
	
	public Map<String, Object> selectUserInfoManageDetail(String userNo);
	//사용자 아이디 설정 
	public Map<String, Object> selectUserInfoManageDetailId(String userId);
	//사용자 로그인 
	public Map<String, Object> selectUserLogin(@Param("params") Map<String, Object> params);
		
	public int insertUserInfoManage(UserInfo vo);
	
	public int updateUserInfoManage(UserInfo vo);
	
	public int updatePasswordChange(UserInfo vo);
	
	public int deleteUserInfoManage(@Param("userNo") String userNo , @Param("comCode") String comCode);
}
