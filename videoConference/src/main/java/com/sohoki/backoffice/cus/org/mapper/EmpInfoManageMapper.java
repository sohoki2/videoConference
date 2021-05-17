package com.sohoki.backoffice.cus.org.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;

@Mapper
public interface EmpInfoManageMapper {
	
	public List<Map<String, Object>> selectEmpInfoList(@Param("params") Map<String, Object> params );

	public List<Map<String, Object>> selectMeetinngUserList(List list);
	
	public EmpInfoVO selectEmpInfoDetail(String empId);
	
	public EmpInfoVO selectEmpInfoDetailNo(String empno);
	
	public int insertEmpInfo (EmpInfo vo);
	
	public int updateAvayaUserUpdate(EmpInfoVO vo);
	
	public int deleteEaiEmpTmp();
}
