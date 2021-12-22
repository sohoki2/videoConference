package com.sohoki.backoffice.sts.res.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sts.res.vo.VisitedDetailInfo;
import com.sohoki.backoffice.sts.res.vo.VisitedInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface VisitedInfoManageMapper {
	
	public List<Map<String, Object>> selectVisitedManageListByPagination(@Param("params") Map<String, Object> params);
	
	public List<List<Object>>  selectVisitedDetailInfo (VisitedInfo visitedInfo  );
	
	public List<Map<String, Object>> selectVisitedDetailInfoFront (String visitedCode );
	
	public Map<String, Object> selectVisitedDetailInfoDetail(String visitedSeq );
	
	public Map<String, Object> selectVisitedManageInfo(String visitedCode);
	
	//신규 추가 
	public Map<String, Object> selectVisitedQrManageInfo(@Param("params") Map<String, Object> params);
	
	//투어 일정 combo박스
	public List<Map<String, Object>> selecttourCombo();
	//투어 메세지 보내기
	public List<Map<String, Object>> selectTourMessage();
	
	public List<Map<String, Object>> selecttourInfo();
	
	public Map<String, Object> selectTourCount(@Param("params") Map<String, Object> params);
	
	public int insertVisitedManageInfo (VisitedInfo info);
	
	public int updateQrInfo(@Param("detailInfo") List<VisitedDetailInfo> detail );
	
	public int updateVisitedManageInfo (VisitedInfo info);
	
	public int updateVisitedStateChangeInfoManage (VisitedInfo info);
	//신규 추가
	public int updateVisitedDetailStateChangeInfoManage (String  visitedSeq);
	
	
}
