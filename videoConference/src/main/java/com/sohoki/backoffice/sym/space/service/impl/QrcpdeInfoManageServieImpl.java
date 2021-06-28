package com.sohoki.backoffice.sym.space.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sym.space.mapper.QrcodeInfoManageMapper;
import com.sohoki.backoffice.sym.space.service.QrcpdeInfoManageServie;
import com.sohoki.backoffice.sym.space.vo.QrcodeInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service
public class QrcpdeInfoManageServieImpl extends EgovAbstractServiceImpl implements  QrcpdeInfoManageServie{

	
	@Autowired
	private QrcodeInfoManageMapper qrmapper;

	@Override
	public List<Map<String, Object>> selectQrCodeList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return qrmapper.selectQrCodeList(params);
	}

	@Override
	public Map<String, Object> selectQrCodeDetail(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return qrmapper.selectQrCodeDetail(params);
	}

	@Override
	public int updateQrcodeManage(QrcodeInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return vo.getMode().equals("Ins") ? qrmapper.insertQrcodeManage(vo) : qrmapper.updateQrcodeManage(vo);
	}
}
