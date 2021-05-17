package com.sohoki.backoffice.sym.equ.mapper;

import java.util.List;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfo;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfoVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;



@Mapper
public interface ScheduleInfoManageMapper {
	
	public List<ScheduleInfoVO> selectScheduleManageListByPagination(ScheduleInfoVO searchVO);
	
	public ScheduleInfoVO selectScheduleManageDetail(String schSeq);
	
	public int insertScheduleManage(ScheduleInfo vo);
	
	public int deleteScheduleManage(String  schSeq);
}
