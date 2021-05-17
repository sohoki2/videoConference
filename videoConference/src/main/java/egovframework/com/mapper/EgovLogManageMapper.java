package egovframework.com.mapper;

import java.util.List;
import java.util.Map;
import egovframework.com.cmm.service.LoginLog;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EgovLogManageMapper {	
	
	
	public List<Map<String, Object>> selectLoginLogInfo (LoginLog searchVO);
	
	public int logInsertLoginLog(LoginLog vo);
}
