package com.sohoki.backoffice.sts.iot.service;

import java.util.List;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfo;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfoVO;

public interface InoutManageInfoManageService {

	
	
	    List<InoutManageInfoVO> selectAttendManageListByPagination(InoutManageInfoVO searchVO) throws Exception;
		
	    InoutManageInfoVO selectAttendManageDetail(String attSeq) throws Exception;
		
	    InoutManageInfoVO selectAttendManageView(String attSeq) throws Exception;
	    
	    InoutManageInfoVO selectKioskRoomIn(String resSeq)throws Exception;
		
	    int selectAttendCreateCheck(String resSeq) throws Exception;
	    
	    int selectAttendManageListTotCnt_S(InoutManageInfoVO searchVO) throws Exception;
	    
	    int  selectAttMax() throws Exception;
	    //신규 추가분
	    int  selectAttendCnt(String resSeq)throws Exception;
	    // 신규 추가 끝 부분
	    String  selectRoomCheck (String attSeq) throws Exception;
	    
	    String  selectLoginCheck (String attSeq) throws Exception;
		
		int  selectPCAuthCheck(InoutManageInfoVO searchVO) throws Exception;
		
		int updateAttRoomState(InoutManageInfo vo) throws Exception;
		
		int updateAttLoginState(InoutManageInfo vo) throws Exception;
		
	    int insertAttendManage(InoutManageInfo inoutVO) throws Exception;
	    
	    int roomInTimeResINSeq(String userId)throws Exception;
		
		int roomInTimeResOTSeq(String userId)throws Exception;
		
	    int updateAttendManage(InoutManageInfo vo) throws Exception;
		
	    int updateAttPcPassChange(String  resSeq) throws Exception;
	    
	    int deleteAttendManage(String  resSeq) throws Exception;
	    //신규 추가분
	    int deleteAttDayChange(InoutManageInfo inoutVO)throws Exception;
	    
	    int deleteAttDayChange_IFS(InoutManageInfo inoutVO)throws Exception;
	    // 신규 추가 끝 부분
		int insertAttendManageByEsign(InoutManageInfo inoutVO) throws Exception;
		
		int insertAttendManageIfs(InoutManageInfo vo) throws Exception;

		String selectAttendPassword() throws Exception;

}
