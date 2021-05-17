package com.sohoki.backoffice.sts.iot.service.impl;


import java.util.List;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sts.iot.vo.InoutManageInfo;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfoVO;
import com.sohoki.backoffice.sts.iot.service.InoutManageInfoManageService;
import com.sohoki.backoffice.sts.iot.mapper.InoutManageInfoManageMapper;

@Service
public class InoutManageInfoManageServiceImpl  extends EgovAbstractServiceImpl implements InoutManageInfoManageService {
	
	
	@Autowired
	private InoutManageInfoManageMapper inoutMapper;

	@Override
	public List<InoutManageInfoVO> selectAttendManageListByPagination(
			InoutManageInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttendManageListByPagination(searchVO);
	}

	@Override
	public InoutManageInfoVO selectAttendManageDetail(String attSeq)
			throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttendManageDetail(attSeq);
	}

	@Override
	public InoutManageInfoVO selectAttendManageView(String attSeq)
			throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttendManageView(attSeq);
	}

	@Override
	public int selectAttendManageListTotCnt_S(InoutManageInfoVO searchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttendManageListTotCnt_S(searchVO);
	}

	@Override
	public int insertAttendManage(InoutManageInfo inoutVO) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.insertAttendManage(inoutVO);
	}

	@Override
	public int updateAttendManage(InoutManageInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.updateAttendManage(vo);
	}

	@Override
	public int deleteAttendManage(String resSeq) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.deleteAttendManage(resSeq);
	}

	@Override
	public int selectAttendCreateCheck(String resSeq) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttendCreateCheck(resSeq);
	}

	@Override
	public int updateAttPcPassChange(String resSeq) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.updateAttPcPassChange(resSeq);
	}

	@Override
	public String selectLoginCheck(String attSeq) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectLoginCheck(attSeq);
	}

	@Override
	public int selectPCAuthCheck(InoutManageInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectPCAuthCheck(searchVO);
	}

	@Override
	public int updateAttRoomState(InoutManageInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.updateAttRoomState(vo);
	}

	@Override
	public int updateAttLoginState(InoutManageInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.updateAttLoginState(vo);
	}
	

	@Override
	public int roomInTimeResINSeq(String userId) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.roomInTimeResINSeq(userId);
	}

	@Override
	public int roomInTimeResOTSeq(String userId) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.roomInTimeResOTSeq(userId);
	}

	@Override
	public InoutManageInfoVO selectKioskRoomIn(String resSeq) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectKioskRoomIn(resSeq);
	}

	@Override
	public int selectAttMax() throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttMax();
	}

	@Override
	public String selectRoomCheck(String attSeq) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectRoomCheck(attSeq);
	}
	
	@Override
	public int insertAttendManageByEsign(InoutManageInfo inoutVO) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.insertAttendManageByEsign(inoutVO);
	}

	@Override
	public int insertAttendManageIfs(InoutManageInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.insertAttendManageIfs(vo);
	}

	@Override
	public String selectAttendPassword() throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttendPassword();
	}
    //신규 추가분
	@Override
	public int selectAttendCnt(String resSeq) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.selectAttendCnt(resSeq);
	}

	@Override
	public int deleteAttDayChange(InoutManageInfo inoutVO) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.deleteAttDayChange(inoutVO);
	}
	//신규 추가 끝 부분 

	@Override
	public int deleteAttDayChange_IFS(InoutManageInfo inoutVO) throws Exception {
		// TODO Auto-generated method stub
		return inoutMapper.deleteAttDayChange_IFS(inoutVO);
	}
}
