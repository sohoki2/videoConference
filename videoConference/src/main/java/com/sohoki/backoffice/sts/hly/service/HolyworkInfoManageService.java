package com.sohoki.backoffice.sts.hly.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfoVO;

public interface HolyworkInfoManageService {

	List<Map<String, Object>> selectHolyManageListByPagination(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectHolyManageView(String HolySeq) throws Exception;
	
    int updateHolyManage(HolyworkInfo vo) throws Exception;
	
   

}
