package com.sohoki.backoffice.sym.space.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sym.space.vo.MeetingRoomInfo;
import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MeetingRoomInfoManageMapper {

	
	public List<Map<String, Object>> selectMeetingRoomManageListByPagination(@Param("params") Map<String, Object> params);
	
	public List<Map<String, Object>> selectMeetingRoomEmptyManageList(@Param("params") Map<String, Object> params);
	
	public List<Map<String, Object>> selectMeetingRoomEmptyIntervalStatus(@Param("params") Map<String, Object> params);
	
	public List<Map<String, Object>> selectMeetingRoomManageCombo(String searchCenterId);
	
	public List<Map<String, Object>> selectConferenceList(List meetingList);
	
	public Map<String, Object> selectMeetingRoomDetailInfoManage(String meetingId);
	
	public List<Map<String, Object>> selectMeetingRoomId(@Param("params") Map<String, Object> params);
	
	public int insertMeetingRoomManage(MeetingRoomInfo vo);
	
	public int updateMeetingRoomAdminManage(MeetingRoomInfo vo);

	public int updateMeetingRoomSync(MeetingRoomInfo vo);
	
	public int updateMeetingRoomManage(MeetingRoomInfo vo);
}
