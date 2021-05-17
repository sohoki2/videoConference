package com.sohoki.backoffice.sym.cnt.mapper;

import java.util.List;
import java.util.Map;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sym.cnt.vo.FloorInfo;

@Mapper
public interface FloorInfoManageMapper {

	public List<Map<String, Object>> selectFloorInfoManageListByPagination(@Param("params") Map<String, Object> params);
	
	public List<Map<String, Object>> selectFloorInfoManageCombo (String centerId);
	
	public Map<String, Object> selectFloorInfoManageDetail(String floorSeq);
		
	public int insertFloorInfoManage(FloorInfo vo);
	
	public int updateFloorInfoManage(FloorInfo vo);
	
}
