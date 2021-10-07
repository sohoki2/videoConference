package com.sohoki.backoffice.sym.space.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface OfficeSeatInfoManageMapper {

	
	public List<Map<String, Object>> selectOfficeSeatInfoManageListByPagination(@Param("params") Map<String, Object> params);
	
	public Map<String, Object> selectOfficeSeatInfoManageDetail(String seatId);
	//사용자 리스트
	public Map<String, Object> selectOfficeSeatUserInfoManage(@Param("seatFixGubun") String seatFixGubun, @Param("seatFixUserId") String seatFixUserId);
	
	public List<Map<String, Object>>  selectCenterLabelInfo();
	
	public int insertOfficeSeatInfoManage(OfficeSeatInfo vo);
	
	public int insertFloorInfoOfficeSeatInfoManage(@Param("params") Map<String, Object> params);
	
	public int updateOfficeSeatInfoManage(OfficeSeatInfo vo);
	
	public int updateOfficeLabelSeatInfoManage(@Param("seatLabelStatus") String seatLabelStatus, @Param("seatId") String seatId  );
	
	public int updateOfficeSeatPositionInfoManage(@Param("list") List<OfficeSeatInfo> list, @Param("type") String type);
	
	public int deleteOfficeSeatQrInfoManage(@Param("seatList") List<String> seatList);
	
}
