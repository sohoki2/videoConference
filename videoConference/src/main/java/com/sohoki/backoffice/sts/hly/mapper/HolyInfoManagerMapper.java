package com.sohoki.backoffice.sts.hly.mapper;

import java.util.List;
import java.util.Map;
import com.sohoki.backoffice.sts.hly.vo.HolyInfo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface HolyInfoManagerMapper {

    public List<Map<String, Object>> selectHolyInfoManageListByPagination(Map<String, Object> params) throws Exception;
	
    public Map<String, Object> selectHolyInfoManageView(String holyDay) throws Exception;
	
    public int updateHolyInfoManage(HolyInfo vo) throws Exception;
    
    public int insertHolyInfoManage(HolyInfo vo) throws Exception;
}
