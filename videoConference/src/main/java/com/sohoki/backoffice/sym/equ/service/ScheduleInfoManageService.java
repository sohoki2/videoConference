package com.sohoki.backoffice.sym.equ.service;

import java.util.List;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfo;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfoVO;

public interface ScheduleInfoManageService {

	
	List<ScheduleInfoVO> selectScheduleManageListByPagination(ScheduleInfoVO searchVO) throws Exception;
	
	ScheduleInfoVO selectScheduleManageDetail(String schSeq) throws Exception;
	
    int insertScheduleManage(ScheduleInfo vo) throws Exception;
	
    int deleteScheduleManage(String  schSeq) throws Exception;
    
}
