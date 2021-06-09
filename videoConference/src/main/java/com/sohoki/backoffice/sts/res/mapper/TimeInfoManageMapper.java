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
	public List<Map<String, Object>> selectSTimeInfoBarList(@Param("params") Map<String, Object> params);
	
	public List<TimeInfo> selectSTimeInfoBarListKiosk(TimeInfoVO searchVO);
	//좌석 검색 리스트 
	public List <Map<String, Object>> selectSeatSearchResult(@Param("params") Map<String, Object> params);
	//좌석 예약 리스트 
	public List <Map<String, Object>> selectSeatStateInfo(@Param("params") Map<String, Object> params);
	//장기 예약 
	public List<TimeInfo> selectLTimeInfoBarList(TimeInfoVO searchVO);
	//예약 체크
	public int selectResPreCheckInfo(@Param("params") Map<String, Object> params);
	//좌석 동일 시간때 중복 예약 체크
	public int selectResSeatPreCheckInfo(@Param("params") Map<String, Object> params);
	//장기 일반
	public int selectResPreCheckInfoL(@Param("params") Map<String, Object> params);
	//장기 시작일 시작 시간 부터 종료일 끝 시간 까지 
	public int selectResPreCheckInfoL1(@Param("params") Map<String, Object> params);
	
	public int inseretTimeCreate();
	
	public String selectTimeUp(String endTime);
	//단기 예약
	public int updateTimeInfo(@Param("params") Map<String, Object> params);
    //장기 일반
	public int updateTimeInfoL(@Param("params") Map<String, Object> params);
	//장기 시작일 시작 시간 부터 종료일 끝 시간 까지 
	public int updateTimeInfoL1(@Param("params") Map<String, Object> params);
	
	public int updateTimeInfoY(TimeInfo vo); 
	//예약 시간 정리 
	public int resTimeReset(TimeInfo searchVO);

	public int multiResTimeReset();
	
	
}
