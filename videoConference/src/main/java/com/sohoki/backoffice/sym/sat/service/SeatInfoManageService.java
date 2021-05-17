package com.sohoki.backoffice.sym.sat.service;

import java.util.List;
import com.sohoki.backoffice.sym.sat.vo.SeatInfo; 
import com.sohoki.backoffice.sym.sat.vo.SeatInfoVO;

public interface SeatInfoManageService {

	
    List<SeatInfoVO> selectSeatManageListByPagination(SeatInfoVO searchVO) throws Exception;
    
    List<SeatInfoVO> selectSeatEmptyManageList(SeatInfoVO searchVO) throws Exception;
	
    List<SeatInfoVO> selectSeatEmptyIntervalStatus(SeatInfoVO searchVO) throws Exception;
    
    List<SeatInfoVO> selectConferenceList(List swSeqList)throws Exception;
    
	SeatInfoVO selectSeatManageView(String swcSeq) throws Exception;
	
	List<SeatInfo> selectSeatManageCombo(SeatInfoVO searchVO) throws Exception;
	
	int selectSeatManageListTotCnt_S(SeatInfoVO searchVO) throws Exception;
	
	int updateSeatManage(SeatInfo vo) throws Exception;
	
	int updateSeatSycn() throws Exception;
	
	int updateSeatAdminManage(SeatInfo vo) throws Exception;
	
	int deleteSeatManage(String  seatId) throws Exception;
	
	List<SeatInfo> selectMeetingroomFloor() throws Exception;

	List<SeatInfoVO> selectRoomId(SeatInfoVO searchVo)  throws Exception;

	List<SeatInfoVO> selectRoomSeat(SeatInfoVO searchVo)  throws Exception;

	List<SeatInfoVO> selectRoomEquipmentList(SeatInfoVO searchVo)  throws Exception;

}
