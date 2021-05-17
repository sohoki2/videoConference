package com.sohoki.backoffice.sym.cnt.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfo;
@Mapper
public interface CentertInfoManagerMapper {
	
	public List<Map<String, Object>> selectCenterInfoManageListByPagination(@Param("params") Map<String, Object> params);
		
	public List<CenterInfo> selectCenterInfoManageCombo ();
	
	public Map<String, Object> selectCenterInfoManageDetail(String centerId);
		
	public int insertCenterInfoManage(CenterInfo vo);
	
	public int updateCenterInfoManage(CenterInfo vo);
	
	public int updateCenterFloorInfoManage(@Param("floorInfo") String floorInfo, @Param("centerId") String centerId );
	
	public int deleteCenterInfoManage(String conSeq);

}
