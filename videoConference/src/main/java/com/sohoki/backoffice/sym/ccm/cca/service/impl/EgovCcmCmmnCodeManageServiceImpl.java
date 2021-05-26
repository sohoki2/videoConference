package com.sohoki.backoffice.sym.ccm.cca.service.impl;

import java.util.List;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.com.mapper.EgovCmmnCodeManageMapper;
import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCode;
import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCodeVO;
import com.sohoki.backoffice.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;
import com.sohoki.backoffice.util.SmartUtil;


@Service
public class EgovCcmCmmnCodeManageServiceImpl extends EgovAbstractServiceImpl implements EgovCcmCmmnCodeManageService {

	@Autowired
	private EgovCmmnCodeManageMapper codeMapper;
	
	@Autowired
	private SmartUtil util;
	
	
	@Override
	public int deleteCmmnCode(String codeId) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.deleteCmmnCode(codeId);
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
	public int updateCmmnCode(CmmnCode cmmnCode) throws Exception {
		// TODO Auto-generated method stub
		return cmmnCode.getMode().equals("Ins") ?  codeMapper.insertCmmnCode(cmmnCode) : codeMapper.updateCmmnCode(cmmnCode);
	}

	
	@Override
	public List<CmmnCodeVO> selectCmmnCodeListByPagination(CmmnCodeVO vo) throws Exception {
		// TODO Auto-generated method stub
		return codeMapper.selectCmmnCodeListByPagination(vo);
	}

}
