package com.sohoki.backoffice.sym.space.service;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sym.space.vo.MeetingRoomInfo;

public interface MeetingRoomInfoManageService {

	
    List<Map<String, Object>> selectMeetingRoomManageListByPagination(@Param("params") Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMeetingRoomEmptyManageList(@Param("params") Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMeetingRoomEmptyIntervalStatus(@Param("params") Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMeetingRoomManageCombo(String centerId) throws Exception;
	
	List<Map<String, Object>> selectConferenceList(List meetingList) throws Exception;
	
	Map<String, Object> selectMeetingRoomDetailInfoManage(String meetingId) throws Exception;
	
	List<Map<String, Object>> selectMeetingRoomId(@Param("params") Map<String, Object> params) throws Exception;

	//회의실 담당자 메세지 전달 
    boolean sendMeetingEmpMessage(String meetingId, ResInfo info ) throws Exception;
    
    //회의실 참석자 메세지 전달 
    boolean sendMeetingUserMessage(Map<String, Object>  resInfo ) throws Exception;
    //입력/수정	
	int updateMeetingRoomManage(MeetingRoomInfo vo) throws Exception;
	
	int updateMeetingRoomAdminManage(MeetingRoomInfo vo) throws Exception;
	
	int updateMeetingRoomSync(MeetingRoomInfo vo) throws Exception;
	//삭제 구문 추가 
	int deleteMeetingRoomManage(List<String> meetinglist) throws Exception;
	
	
}
