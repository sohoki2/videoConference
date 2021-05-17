package com.sohoki.backoffice.sym.cnt.mapper;

import java.util.List;
import java.util.Map;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import org.apache.ibatis.annotations.Param;
import com.sohoki.backoffice.sym.cnt.vo.FloorPartInfo;;

@Mapper
public interface FloorPartInfoManageMapper {

	
    public List<Map<String, Object>> selectFloorPartInfoManageListByPagination(@Param("params") Map<String, Object> params);
	
	public List<Map<String, Object>> selectFloorPartInfoManageCombo (@Param("centerId") String centerId, @Param("floorSeq") String floorSeq );
	
	public Map<String, Object> selectFloorPartInfoManageDetail(String partSeq);
		
	public int insertFloorPrartInfoManage(FloorPartInfo vo);
	
	public int updateFloorPrartInfoManage(FloorPartInfo vo);
}
