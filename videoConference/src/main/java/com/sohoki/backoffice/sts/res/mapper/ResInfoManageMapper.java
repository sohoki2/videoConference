package com.sohoki.backoffice.sts.res.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCode;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ResInfoManageMapper {
	//예약 리스트 조회 
    public List<Map<String, Object>> selectResManageListByPagination(@Param("params") Map<String, Object> params);
    
    public List<Map<String, Object>> selectIndexList(@Param("params") Map<String, Object> params );
    
    public List<ResInfoVO> selectCalenderInfo();
    //월별 예약 상세 리스트
    public List<ResInfoVO> selectCalenderDetailInfo(ResInfoVO searchVO);
    //월별 회의실 상태
    public List<ResInfoVO> selectCalenderMeetingState(ResInfoVO searchVO);
    
    //메일 보내는 구문 
    public List <ResInfoVO> selectMessagentList();
    
    public List<Map<String, Object>> selectKioskCalendarList(String swcSeq);
    
    public Map<String, Object> selectResManageView(String resSeq);
	
    public String selectTennInfo(ResInfo vo);
    
    public int insertResManage(ResInfo vo);
	
    public int updateResManageChange(ResInfo vo);
    
    public int updateResManageChangeAvaya(ResInfo vo);
    
    public int updateResEquipChnageManage(ResInfo vo);
    
    public int deleteResManage(String  resSeq);
    //회의록 작성
	public int updateResMeetingLog(ResInfo vo);
	// 예약 취소 및 시간 타입 원복
	public int updateResCancel10MinLateEmpty();
	
	public int updateCancelReason(ResInfo vo);
	//에러 일때 사용 하기 
	public int errorResDateStep01(int resSeq);
	
	public int errorResDateStep02(int resSeq);
	
	public ResInfoVO selectCancelReason(String resSeq);
	
	public int updateResManageDateChange(String resSeq);
	//신규 추가 분
	public int updateDayChange(ResInfo resInfo);
	//신규 추가 끝 부분
	public ResInfoVO selectResUserInfo(String resSeq);
	//입/퇴실
	public int resStateChagenCheck(ResInfoVO resInfo);

}
