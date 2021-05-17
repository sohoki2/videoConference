package com.sohoki.backoffice.sym.avaya.mapper;

import java.util.List;

import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfo;
import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfoVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AvayMessageManageMapper {
	
    public int  selectAvayaMessageManageListTotCnt_S(AvayaMessageInfoVO SearchVO) ;
	
    public List<AvayaMessageInfoVO>   selectAvayaInfoManageListByPagination(AvayaMessageInfoVO SearchVO);
		
    public String selectRequestId();
    
    public AvayaMessageInfoVO selectAvayaInfoManageDetail(String requestid);
		
    public int insertAvayaInfoInsertManage(AvayaMessageInfo vo);
    
    public int insertAvayaInfoInsertManageList(List<AvayaMessageInfo> list);
	
    public int deleteAvayaInfoManage(String requestid);
}
