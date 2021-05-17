package com.sohoki.backoffice.sts.hly.service;

import java.util.List;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfoVO;

public interface HolyworkInfoManageService {

	
	
    List<HolyworkInfoVO> selectHolyManageListByPagination(HolyworkInfoVO searchVO) throws Exception;
	
    HolyworkInfoVO selectHolyManageDetail(String HolySeq) throws Exception;
	
    HolyworkInfoVO selectHolyManageView(String HolySeq) throws Exception;
	
    int selectHolyManageListTotCnt_S(HolyworkInfoVO searchVO) throws Exception;
	
    int insertHolyManage(HolyworkInfo vo) throws Exception;
	
    int updateHolyManage(HolyworkInfo vo) throws Exception;
	
    int deleteHolyManage(String  HolySeq) throws Exception;

	int smartBatch() throws Exception;
	
	int timeBatch() throws Exception;

}
