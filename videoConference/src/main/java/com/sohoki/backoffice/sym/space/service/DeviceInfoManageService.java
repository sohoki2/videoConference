package com.sohoki.backoffice.sym.space.service;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.servlet.ModelAndView;
import com.sohoki.backoffice.sym.space.vo.DeviceInfo;

public interface DeviceInfoManageService {

	
	List<Map<String, Object>> selectDevicePageInfoManageListByPagination(@Param("params") Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectDevicePageInfoManageDetail(String deviceId) throws Exception;
	
	Map<String, Object> selectDeviceInfo(String deviceId) throws Exception;
	
	int updateDevicePageInfoManage(DeviceInfo vo) throws Exception;
	
	int selectDeviceExist(String deviceId) throws Exception;
	
	int updateDeviceIpMac(DeviceInfo vo) throws Exception;
	
	int updateDeviceEndConnTime(DeviceInfo vo) throws Exception;
	
	int deleteDevieManage(String deviceId) throws Exception;
}
