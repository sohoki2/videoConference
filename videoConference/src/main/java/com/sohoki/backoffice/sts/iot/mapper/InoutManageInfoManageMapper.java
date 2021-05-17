package com.sohoki.backoffice.sts.iot.mapper;

import java.util.List;

import com.sohoki.backoffice.sts.iot.vo.InoutManageInfo;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfoVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface InoutManageInfoManageMapper {

	
	
	public List<InoutManageInfoVO> selectAttendManageListByPagination(InoutManageInfoVO searchVO) throws Exception;
	
	public InoutManageInfoVO selectAttendManageDetail(String attSeq) throws Exception;
	
	public InoutManageInfoVO selectAttendManageView(String attSeq) throws Exception;
	
	public int selectAttendManageListTotCnt_S(InoutManageInfoVO searchVO) throws Exception;
	
	public int selectAttendCreateCheck(String resSeq) throws Exception;
	
	
	public String  selectRoomCheck (String attSeq) throws Exception;
	
	public String  selectLoginCheck (String attSeq) throws Exception;
	
	public InoutManageInfoVO selectKioskRoomIn(String resSeq)throws Exception;
	
	public int  selectPCAuthCheck(InoutManageInfoVO searchVO) throws Exception;
	
	public int  selectAttMax() throws Exception;
	//신규 추가 분 
	public int  selectAttendCnt(String resSeq)throws Exception;
	//신규 추가분 끝 
	public int updateAttRoomState(InoutManageInfo vo) throws Exception;
	
	public int updateAttLoginState(InoutManageInfo vo) throws Exception;
	
	public int roomInTimeResINSeq(String userId)throws Exception;
	
	public int roomInTimeResOTSeq(String userId)throws Exception;
	
	public int insertAttendManage(InoutManageInfo inoutVO) throws Exception;
	
	public int updateAttendManage(InoutManageInfo vo) throws Exception;
	
	public int updateAttPcPassChange(String  resSeq) throws Exception;
	
	public int deleteAttendManage(String  resSeq) throws Exception;
	//신규 추가 분 
	public int deleteAttDayChange(InoutManageInfo inoutVO)throws Exception;
	
	public int deleteAttDayChange_IFS(InoutManageInfo inoutVO)throws Exception;
	//신규 추가분 끝 
	public int insertAttendManageByEsign(InoutManageInfo inoutVO) throws Exception;
	
	public int insertAttendManageIfs(InoutManageInfo vo) throws Exception;

	public String selectAttendPassword() throws Exception;
}
