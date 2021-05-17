package com.sohoki.backoffice.sym.equ.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sohoki.backoffice.sym.equ.service.ScheduleInfoManageService;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfo;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfoVO;
import com.sohoki.backoffice.sym.equ.mapper.ScheduleInfoManageMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class ScheduleInfoManageServiceImpl extends EgovAbstractServiceImpl implements ScheduleInfoManageService {
	
	
	@Autowired
	private ScheduleInfoManageMapper schMapper;

	@Override
	public List<ScheduleInfoVO> selectScheduleManageListByPagination(
			ScheduleInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return schMapper.selectScheduleManageListByPagination(searchVO);
	}

	@Override
	public ScheduleInfoVO selectScheduleManageDetail(String schSeq)
			throws Exception {
		// TODO Auto-generated method stub
		return schMapper.selectScheduleManageDetail(schSeq);
	}

	@Override
	public int insertScheduleManage(ScheduleInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return schMapper.insertScheduleManage(vo);
	}

	@Override
	public int deleteScheduleManage(String schSeq) throws Exception {
		// TODO Auto-generated method stub
		return schMapper.deleteScheduleManage(schSeq);
	}
	
	
	

}
