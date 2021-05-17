package com.sohoki.backoffice.cus.com.servie.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sohoki.backoffice.cus.com.mapper.CompanyInfoManageMapper;
import com.sohoki.backoffice.cus.com.servie.CompanyInfoManageService;
import com.sohoki.backoffice.cus.com.vo.CompanyInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service
public class CompanyInfoManageServiceImpl extends EgovAbstractServiceImpl implements CompanyInfoManageService{
	
	
	@Autowired
	private CompanyInfoManageMapper companyMapper;
	
	@Resource(name = "egovComIdGnrService")
	private EgovIdGnrService egovComIdGnrService;

	@Override
	public List<Map<String, Object>> selectCompanyInfoManageListByPagination(Map<String, Object> params)
			throws Exception {
		// TODO Auto-generated method stub
		return companyMapper.selectCompanyInfoManageListByPagination(params);
	}

	@Override
	public List<Map<String, Object>> selectCompanyInfoManageCombo(String comCode) throws Exception {
		// TODO Auto-generated method stub
		return companyMapper.selectCompanyInfoManageCombo(comCode);
	}

	@Override
	public Map<String, Object> selectCompanyInfoManageDetail(String comCode) throws Exception {
		// TODO Auto-generated method stub
		return companyMapper.selectCompanyInfoManageDetail(comCode);
	}
	@Override
	public int updateCompanyInfoManage(CompanyInfo vo) throws Exception {
		// TODO Auto-generated method stub
		if (vo.getMode().equals("Ins")) 
		     vo.setComCode(egovComIdGnrService.getNextStringId());
		if (vo.getFloorSeq().isBlank())
			vo.setFloorSeq("0");
		return vo.getMode().equals("Ins") ? companyMapper.insertCompanyInfoManage(vo) : companyMapper.updateCompanyInfoManage(vo);
	}

}
