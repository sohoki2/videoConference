package com.sohoki.backoffice.sts.hly.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface HolyworkInfoManageMapper {

	
    public List<Map<String, Object>> selectHolyManageListByPagination(@Param("params") Map<String, Object> params) throws Exception;
	
    public Map<String, Object> selectHolyManageView(String HolySeq) throws Exception;
	
    public int insertHolyManage(HolyworkInfo vo);
    
    public int updateHolyManage(HolyworkInfo vo);

	
}
