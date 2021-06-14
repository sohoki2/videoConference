package com.sohoki.backoffice.sts.hly.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sts.hly.vo.HolyInfo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface HolyInfoManagerMapper {

    public List<Map<String, Object>> selectHolyInfoManageListByPagination(@Param("params") Map<String, Object> params);
	
    public Map<String, Object> selectHolyInfoManageView(String holyDay);
	
    public int updateHolyInfoManage(HolyInfo vo);
    
    public int insertHolyInfoManage(HolyInfo vo);
}
