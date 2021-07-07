package com.sohoki.backoffice.sym.space.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sym.space.vo.DeviceInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper
public interface DeviceInfoManageMapper {

	public List<Map<String, Object>>  selectDevicePageInfoManageListByPagination(@Param("params") Map<String, Object> params);
	
	public Map<String, Object> selectDevicePageInfoManageDetail(String deviceId);
	
	public Map<String, Object> selectDeviceInfo(String deviceId);
	
	public int selectDeviceExist(String deviceId);
	
	public int insertDevicePageInfoManage(DeviceInfo vo);
	
	public int updateDevicePageInfoManage(DeviceInfo vo);

	public int updateDeviceIpMac(DeviceInfo vo);
	
	public int updateDeviceEndConnTime(String deviceId);
	
	public int deleteDevieManage(String deviceId);
}
