package egovframework.com.mapper;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface LoginUsrManageMapper {
	
	public AdminLoginVO selectactionLogin(AdminLoginVO vo);	

}
