package com.sohoki.backoffice.sts.res.service.impl;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sts.res.vo.TimeInfo;
import com.sohoki.backoffice.sts.res.vo.TimeInfoVO;
import com.sohoki.backoffice.sts.res.service.TimeInfoManageService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sohoki.backoffice.sts.res.mapper.TimeInfoManageMapper;

@Service
public class TimeInfoManageServiceImpl extends EgovAbstractServiceImpl implements TimeInfoManageService {

	
	@Autowired
	private TimeInfoManageMapper timeMapper;

	//변경 
	@Override
	public List<Map<String, Object>> selectSTimeInfoBarList(Map<String, Object>  searchVO) throws Exception {
		return timeMapper.selectSTimeInfoBarList(searchVO);
	}

	@Override
	public List<TimeInfo> selectLTimeInfoBarList(TimeInfoVO searchVO) throws Exception {
		return timeMapper.selectLTimeInfoBarList(searchVO);
	}

	@Override
	public int updateTimeInfo(Map<String, Object> vo) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.updateTimeInfo(vo);
	}
	

	@Override
	public int selectResPreCheckInfoL(TimeInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.selectResPreCheckInfoL(searchVO);
	}

	@Override
	public int updateTimeInfoL(TimeInfo searchVO) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.updateTimeInfoL(searchVO);
	}

	@Override
	public int resTimeReset(TimeInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.resTimeReset(vo);
	}

	@Override
	public List<TimeInfo> selectSTimeInfoBarListKiosk(TimeInfoVO searchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.selectSTimeInfoBarListKiosk(searchVO);
	}

	@Override
	public String selectTimeUp(String endTime) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.selectTimeUp(endTime);
	}

	@Override
	public int multiResTimeReset() throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.multiResTimeReset();
	}

	@Override
	public int updateTimeInfoY(TimeInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.updateTimeInfoY(vo);
	}

	@Override
	public int inseretTimeCreate() throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.inseretTimeCreate();
	}

	@Override
	public int selectResPreCheckInfo(Map<String, Object> searchVO) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.selectResPreCheckInfo(searchVO);
	}

	@Override
	public List<Map<String, Object>> selectSeatStateInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.selectSeatStateInfo(params);
	}

	@Override
	public List<Map<String, Object>> selectSeatSearchResult(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.selectSeatSearchResult(params);
	}

	@Override
	public int selectResSeatPreCheckInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return timeMapper.selectResSeatPreCheckInfo(params);
	}

	
}
