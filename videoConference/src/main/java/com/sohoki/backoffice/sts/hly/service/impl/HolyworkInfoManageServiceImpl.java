package com.sohoki.backoffice.sts.hly.service.impl;

import java.util.List;
import java.util.Map;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sohoki.backoffice.sts.hly.mapper.HolyworkInfoManageMapper;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import com.sohoki.backoffice.sts.hly.service.HolyworkInfoManageService;

@Service
public class HolyworkInfoManageServiceImpl extends EgovAbstractServiceImpl implements HolyworkInfoManageService {
	
	
	
	@Autowired
	private HolyworkInfoManageMapper holyMapper;

	@Override
	public List<Map<String, Object>> selectHolyManageListByPagination(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyManageListByPagination(params);
	}

	

	@Override
	public Map<String, Object> selectHolyManageView(String HolySeq) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyManageView(HolySeq);
	}


	@Override
	public int updateHolyManage(HolyworkInfo vo) throws Exception {
		// TODO Auto-generated method stub
		
		return  vo.getMode().equals("Ins") ? holyMapper.insertHolyManage(vo): holyMapper.updateHolyManage(vo);
	}

	
}
