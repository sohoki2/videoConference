package com.sohoki.backoffice.sym.ccm.cde.service.impl;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sym.ccm.cde.mapper.EgovCmmnDetailCodeManageMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCode;
import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCodeVO;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;

@Service
public class EgovCcmCmmnDetailCodeManageServiceImpl extends EgovAbstractServiceImpl implements EgovCcmCmmnDetailCodeManageService {

	
	@Resource(name="CmmnDetailCodeManageMapper")
    private EgovCmmnDetailCodeManageMapper CmmnDetailCodeManageMapper;
	/**
	 * 공통상세코드를 삭제한다.
	 */
	@Override
	public int deleteCmmnDetailCode(String code) throws Exception {
		 return CmmnDetailCodeManageMapper.deleteCmmnDetailCode(code);		
	}
	
	@Override
	public CmmnDetailCode selectCmmnDetailCodeDetail(CmmnDetailCode vo) throws Exception {
    	return CmmnDetailCodeManageMapper.selectCmmnDetailCodeDetail(vo.getCode());    	
	}

	/**
	 * 공통상세코드 목록을 조회한다.
	 */
	@Override
	public List<?> selectCmmnDetailCodeList(String codeId) throws Exception {
        return CmmnDetailCodeManageMapper.selectCmmnDetailCodeListByPagination(codeId);
	}
	/**
	 * 공통상세코드 총 갯수를 조회한다.
	 */
	@Override
	public int selectCmmnDetailCodeListTotCnt(String codeId) throws Exception {
        return CmmnDetailCodeManageMapper.selectCmmnDetailCodeListTotCnt(codeId);
	}
	
	@Override
	public List<CmmnDetailCode> selectCmmnDetailCombo(String code) throws Exception {
		// TODO Auto-generated method stub
		return CmmnDetailCodeManageMapper.selectCmmnDetailCombo(code);
	}
	

	/**
	 * 공통상세코드를 수정한다.
	 */
	@Override
	public int updateCmmnDetailCode(CmmnDetailCode vo) throws Exception {
		int ret = 0;
		if (vo.getMode().equals("Ins")){
			ret = CmmnDetailCodeManageMapper.insertCmmnDetailCode(vo);
		}else {
			ret = CmmnDetailCodeManageMapper.updateCmmnDetailCode(vo);
		}
		return ret;
	}

	@Override
	public int selectCmmnDetailCodeIdCheck(String code) throws Exception {
		// TODO Auto-generated method stub
		return CmmnDetailCodeManageMapper.selectCmmnDetailCodeIdCheck(code);
	}

	@Override
	public CmmnDetailCode selectCmmnDetail(String code) throws Exception {
		// TODO Auto-generated method stub
		return CmmnDetailCodeManageMapper.selectCmmnDetail(code);
	}

	@Override
	public List<CmmnDetailCode> selectComboSwcCon() throws Exception {
		// TODO Auto-generated method stub
		return CmmnDetailCodeManageMapper.selectComboSwcCon();
	}

	@Override
	public List<CmmnDetailCode> selectCmmnDetailResTypeCombo(CmmnDetailCodeVO vo) throws Exception {
		// TODO Auto-generated method stub
		return CmmnDetailCodeManageMapper.selectCmmnDetailResTypeCombo(vo);
	}
	 
	@Override
	public List<CmmnDetailCode> selectCmmnDetailComboEtc(Map<String, Object> params)
			throws Exception {
		// TODO Auto-generated method stub
		return CmmnDetailCodeManageMapper.selectCmmnDetailComboEtc(params);
	}

	@Override
	public List<Map<String, Object>> selectCmmnDetailAjaxCombo(String code) throws Exception {
		// TODO Auto-generated method stub
		return CmmnDetailCodeManageMapper.selectCmmnDetailComboLamp(code);
	}

	
	

}
