package com.sohoki.backoffice.sym.ccm.cca.service.impl;

import java.util.List;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.mapper.EgovCmmnCodeManageMapper;
import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCode;
import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCodeVO;
import com.sohoki.backoffice.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;


@Service("CmmnCodeManageService")
public class EgovCcmCmmnCodeManageServiceImpl extends EgovAbstractServiceImpl implements EgovCcmCmmnCodeManageService {

	@Resource(name="CmmnCodeManageMapper")
	private EgovCmmnCodeManageMapper codeMapper;
	
	
	@Override
	public int deleteCmmnCode(String codeId) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.deleteCmmnCode(codeId);
	}

	@Override
	public int insertCmmnCode(CmmnCode cmmnCode) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.insertCmmnCode(cmmnCode);
	}

	@Override
	public CmmnCode selectCmmnCodeDetail(String codeId) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.selectCmmnCodeDetail(codeId);
	}

	@Override
	public List<?> selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.selectCmmnCodeList(searchVO.getCodeId());
	}

	@Override
	public int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.selectCmmnCodeListTotCnt(searchVO);
	}

	@Override
	public int updateCmmnCode(CmmnCode cmmnCode) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.updateCmmnCode(cmmnCode);
	}

	@Override
	public int selectIDCheck(String codeId) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.selectIDCheck(codeId);
	}

}
