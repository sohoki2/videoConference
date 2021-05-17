package com.sohoki.backoffice.sts.hly.service.impl;

import java.util.List;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sohoki.backoffice.sts.hly.mapper.HolyworkInfoManageMapper;

import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfoVO;
import com.sohoki.backoffice.sts.hly.service.HolyworkInfoManageService;

@Service
public class HolyworkInfoManageServiceImpl extends EgovAbstractServiceImpl implements HolyworkInfoManageService {

	
	
	
	@Autowired
	private HolyworkInfoManageMapper holyMapper;

	@Override
	public List<HolyworkInfoVO> selectHolyManageListByPagination(
			HolyworkInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyManageListByPagination(searchVO);
	}

	@Override
	public HolyworkInfoVO selectHolyManageDetail(String HolySeq)
			throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyManageDetail(HolySeq);
	}

	@Override
	public HolyworkInfoVO selectHolyManageView(String HolySeq) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyManageView(HolySeq);
	}

	@Override
	public int selectHolyManageListTotCnt_S(HolyworkInfoVO searchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.selectHolyManageListTotCnt_S(searchVO);
	}

	@Override
	public int insertHolyManage(HolyworkInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.insertHolyManage(vo);
	}

	@Override
	public int updateHolyManage(HolyworkInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.updateHolyManage(vo);
	}

	@Override
	public int deleteHolyManage(String HolySeq) throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.deleteHolyManage(HolySeq);
	}

	@Override
	public int smartBatch() throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.smartBatch();
	}
	
	@Override
	public int timeBatch() throws Exception {
		// TODO Auto-generated method stub
		return holyMapper.timeBatch();
	}
}
