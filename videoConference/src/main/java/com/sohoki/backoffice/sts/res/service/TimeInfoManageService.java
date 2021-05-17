package com.sohoki.backoffice.sts.res.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sts.res.vo.TimeInfo;
import com.sohoki.backoffice.sts.res.vo.TimeInfoVO;

public interface TimeInfoManageService {

	    //단일 예약
	    List<Map<String, Object>> selectSTimeInfoBarList(Map<String, Object>  searchVO) throws Exception;
		//장기 예약 
		List<TimeInfo> selectLTimeInfoBarList(TimeInfoVO searchVO) throws Exception;
	    //키오스크
		List<TimeInfo> selectSTimeInfoBarListKiosk(TimeInfoVO searchVO) throws Exception;
		
		String selectTimeUp(String endTime) throws Exception;
		// 장기 예약 
		int selectResPreCheckInfoL(TimeInfoVO searchVO) throws Exception;
		
		int selectResPreCheckInfo(Map<String, Object> searchVO) throws Exception;
		//시간바 업데이트 
		int inseretTimeCreate() throws Exception;
		
		int updateTimeInfoL(TimeInfo searchVO) throws Exception;
		
		int updateTimeInfo(Map<String, Object> vo) throws Exception;
		
		int updateTimeInfoY(TimeInfo vo) throws Exception;
		
		int resTimeReset(TimeInfo vo) throws Exception;
		
		int multiResTimeReset() throws Exception;
}
