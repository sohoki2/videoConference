package com.sohoki.backoffice.sym.avaya.service;

import java.util.List;
import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfo;
import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfoVO;

public interface AvayMessageManageService {

    int  selectAvayaMessageManageListTotCnt_S(AvayaMessageInfoVO SearchVO) throws Exception;
	
	List<AvayaMessageInfoVO>   selectAvayaInfoManageListByPagination(AvayaMessageInfoVO SearchVO) throws Exception;
	
	String selectRequestId()throws Exception;
		
	AvayaMessageInfoVO selectAvayaInfoManageDetail(String requestid) throws Exception;
		
	int insertAvayaInfoInsertManage(AvayaMessageInfo vo) throws Exception;
	
	int updateAvayaUserUpdate() throws Exception;
	
	int deleteAvayaInfoManage(String requestid) throws Exception;
	
	
	String sendAvayaMessage (String _messageGubun) throws Exception;
	
}
