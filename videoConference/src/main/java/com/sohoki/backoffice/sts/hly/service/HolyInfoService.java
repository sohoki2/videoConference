package com.sohoki.backoffice.sts.hly.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sts.hly.vo.HolyInfo;

public interface HolyInfoService {
	
    List<Map<String, Object>> selectHolyInfoManageListByPagination(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectHolyInfoManageView(String holyDay) throws Exception;
	
    int updateHolyInfoManage(HolyInfo vo) throws Exception;

}
