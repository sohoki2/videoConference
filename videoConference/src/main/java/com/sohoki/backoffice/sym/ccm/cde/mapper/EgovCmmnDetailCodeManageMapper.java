package com.sohoki.backoffice.sym.ccm.cde.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCode;
import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCodeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("CmmnDetailCodeManageMapper")
public interface EgovCmmnDetailCodeManageMapper {

    public List<CmmnDetailCodeVO> selectCmmnDetailCodeListByPagination(String codeId);
	
	public List<CmmnDetailCode> selectCmmnDetailCombo (String code);
	
	public List<Map<String, Object>> selectCmmnDetailComboLamp (String code);
	
	public List<CmmnDetailCode> selectCmmnDetailComboEtc(@Param("params") Map<String, Object> params);
	
	public CmmnDetailCode selectCmmnDetailCodeDetail(String code);
	
	public CmmnDetailCode selectCmmnDetail(String code);
	
	public List<CmmnDetailCode> selectComboSwcCon();
		
	public int insertCmmnDetailCode(CmmnDetailCode vo);
	               
	public int updateCmmnDetailCode(CmmnDetailCode vo);
	
	public int deleteCmmnDetailCode(String code);
	
	public int deleteCmmnDetailCodeId(String value);
		
	public int selectCmmnDetailCodeListTotCnt(String  codeId);
	
	public int selectCmmnDetailCodeIdCheck(String code);
	
	public List<CmmnDetailCode> selectCmmnDetailResTypeCombo (CmmnDetailCodeVO vo);

}
