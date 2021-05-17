package com.sohoki.backoffice.sts.res.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sts.res.vo.TimeInfo;
import com.sohoki.backoffice.sts.res.vo.TimeInfoVO;

@Mapper
public interface TimeInfoManageMapper {
    //단일 예약
	public List<Map<String, Object>> selectSTimeInfoBarList(@Param("params") Map<String, Object> params) throws Exception;
	
	public List<TimeInfo> selectSTimeInfoBarListKiosk(TimeInfoVO searchVO) throws Exception;
	//장기 예약 
	public List<TimeInfo> selectLTimeInfoBarList(TimeInfoVO searchVO) throws Exception;
	//예약 체크
	public int selectResPreCheckInfo(@Param("params") Map<String, Object> params) throws Exception;
	
	public int selectResPreCheckInfoL(TimeInfoVO searchVO) throws Exception;
	
	public int inseretTimeCreate();
	
	public String selectTimeUp(String endTime) throws Exception;
	
	public int updateTimeInfoL(TimeInfo searchVO) throws Exception;
	
	public int updateTimeInfo(@Param("params") Map<String, Object> params) throws Exception;
	
	public int updateTimeInfoY(TimeInfo vo); 

	//예약 시간 정리 
	public int resTimeReset(TimeInfo searchVO) throws Exception;

	public int multiResTimeReset() throws Exception;
	
	
}
