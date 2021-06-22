package com.sohoki.backoffice.sts.res.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sts.res.vo.ResInfo;

public interface ResInfoManageService {

	
	List<Map<String, Object>> selectResManageListByPagination(Map<String, Object> searchVO) throws Exception;
    // 메인 회의실 리스트 보여 주기 
    List<Map<String, Object>> selectIndexList(Map<String, Object> params)throws Exception;
    
    Map<String, Object> selectTodayResSeatInfo(String empNo)throws Exception;
    
    List<ResInfoVO> selectCalenderInfo()throws Exception;
    
    List<ResInfoVO> selectCalenderDetailInfo(ResInfoVO searchVO)throws Exception;
    
    List<ResInfoVO> selectCalenderMeetingState(ResInfoVO searchVO)throws Exception;
    
    List <ResInfoVO> selectMessagentList()throws Exception;
    
    List<Map<String, Object>> selectKioskCalendarList(String swcSeq) throws Exception;
    //전자 명패 리스트
    List<Map<String, Object>> selectNameplate() throws Exception;
    
    Map<String, Object> selectResManageView(String resSeq) throws Exception;
	//테넌트 확인
    String selectTennInfo(ResInfo vo) throws Exception;
    
    int resEquipStateChange (ResInfoVO vo) throws Exception;
    //최초 입력
	int insertResManage(ResInfoVO vo) throws Exception;
	// 예약 수정 변경 
    int updateResManageChange(ResInfo vo) throws Exception;
   
	int deleteResManage(String  resSeq) throws Exception;

	int updateCancelReason(ResInfo vo) throws Exception;
	
	int updateResManageChangeAvaya(ResInfo vo) throws Exception;
	
	int updateResMeetingLog(ResInfo vo) throws Exception;

	ResInfoVO selectCancelReason(String resSeq) throws Exception;

	int updateResManageDateChange(String resSeq) throws Exception;
	//신규 추가분
	int updateDayChange(ResInfo resInfo)throws Exception;

	ResInfoVO selectResUserInfo(String resSeq) throws Exception;
	
	int resStateChagenCheck(ResInfoVO resInfo)throws Exception;

}
