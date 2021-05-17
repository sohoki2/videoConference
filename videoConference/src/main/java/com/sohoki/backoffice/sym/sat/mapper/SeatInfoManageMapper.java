package com.sohoki.backoffice.sym.sat.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

import java.util.List;

import com.sohoki.backoffice.sym.sat.vo.SeatInfo;
import com.sohoki.backoffice.sym.sat.vo.SeatInfoVO;

@Mapper
public interface SeatInfoManageMapper {
	
	public List<SeatInfoVO> selectSeatManageListByPagination(SeatInfoVO searchVO) throws Exception;
	
	public List<SeatInfoVO> selectSeatEmptyManageList(SeatInfoVO searchVO) throws Exception;
	
	public List<SeatInfoVO> selectSeatEmptyIntervalStatus(SeatInfoVO searchVO) throws Exception;
	
	
	public SeatInfoVO selectSeatManageView(String swcSeq) throws Exception;
	
	public List<SeatInfo> selectSeatManageCombo(SeatInfoVO searchVO) throws Exception;
	
	public List<SeatInfoVO> selectConferenceList(List list);
	
	public int selectSeatManageListTotCnt_S(SeatInfoVO searchVO) throws Exception;
	
	public int insertSeatManage(SeatInfo vo) throws Exception;
	
	public int updateSeatManage(SeatInfo vo) throws Exception;
	
	public int updateSeatSync(SeatInfo vo) throws Exception;
	
	public int updateSeatAdminManage(SeatInfo vo) throws Exception;
	
	public int deleteSeatManage(String seatId) throws Exception;

	public List<SeatInfo> selectMeetingroomFloor() throws Exception;

	public List<SeatInfoVO> selectRoomId(SeatInfoVO searchVO) throws Exception;

	public List<SeatInfoVO> selectRoomSeat(SeatInfoVO searchVO) throws Exception;

	public List<SeatInfoVO> selectRoomEquipmentList(SeatInfoVO searchVo);

}
