package com.sohoki.smartoffice.homepage.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.sym.space.service.DeviceInfoManageService;
import com.sohoki.backoffice.sym.space.vo.DeviceInfo;

import egovframework.com.cmm.service.Globals;


@RestController
public class DeviecInfoController {

	private static final Logger LOGGER = LoggerFactory.getLogger(DeviecInfoController.class);
	
	
	@Autowired
	private DeviceInfoManageService deviceService;
	
	@NoLogging
	@RequestMapping(value="regist_device.do")
	public ModelAndView registDevice(@RequestParam("device_id") String device_id
			                         , HttpServletRequest request) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
        try {
    		String ip = "";
    		String mac  = "";    		
    		LOGGER.debug("device_id:" + device_id +":" + ip + ":" + mac);
    		try {
    			DeviceInfo vo = new DeviceInfo();
    			vo.setDeviceMac(mac);
    			vo.setDeviceId(device_id);
    			vo.setDeviceIp(ip);
    			int ret = deviceService.updateDeviceIpMac(vo);
    			JSONObject jsonResult1 = new JSONObject();
    			if (ret > 0){
    				jsonResult1.put("code", "OK");
    				jsonResult1.put("device_id", device_id);
    			}else {
    				jsonResult1.put("code", "fail");
    				jsonResult1.put("msg", "처리 도중 문제가 발생 하였습니다.");
    			}
    			model.addObject(jsonResult1);
    			
    		} catch (Exception e) {
    			LOGGER.error("registDevice ERROR : " + e.toString());
    		}
    		
        }catch(Exception e) {
        	System.out.println(e.toString());
        }
		return model;
	}
	@NoLogging
	@RequestMapping(value="device_info.do")
	public ModelAndView selectDeviceStatus(@RequestParam("device_id") String device_id
			                               , HttpServletRequest request) throws Exception {
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		JSONObject jsonResult1 = new JSONObject();
		JSONArray jsonPhotoArray = new JSONArray();
				
/*		LOGGER.info(device_id);
		LOGGER.info("getRequestURI() : " + request.getRequestURI());
		LOGGER.info("getRequestURL() : " + request.getRequestURL());
		LOGGER.info("getRemotePort() : " + request.getRemotePort());
		LOGGER.info("getLocalPort() : " + request.getLocalPort());*/

				 
				 
		String url = request.getRequestURL().toString();
		url = url.replace(request.getRequestURI(), "");
		LOGGER.info(url);
		
		try {
			Map<String, Object> deviceInfo = deviceService.selectDeviceInfo(device_id);
			if (deviceInfo != null){
				jsonResult1.put("code", "ok");
				jsonResult1.put("url", url + "/web/resPadInfo.do?meetingId=" + deviceInfo.get("meeting_id"));
				jsonResult1.put("floor", deviceInfo.get("floor_name"));
				jsonResult1.put("status", deviceInfo.get("status"));
				jsonResult1.put("restart_flag", deviceInfo.get("device_restart"));
				jsonResult1.put("reload_flag", deviceInfo.get("device_reload"));
				jsonResult1.put("reset_flag", "N");
				jsonResult1.put("close_time", deviceInfo.get("device_endtime"));
				jsonResult1.put("photo_list", jsonPhotoArray);
				jsonResult1.put("photo_delay_seconds","10");
			} else {
				jsonResult1.put("code", "error");
				jsonResult1.put("msg", "해당 디바이스 아이디값에 대한 정보가 존재하지 않습니다.");
			}
		} catch (Exception e) {
			jsonResult1.put("code", "error");
			jsonResult1.put("msg", "처리 도중 문제가 발생 하였습니다.");
			LOGGER.error("selectDeviceStatus ERROR : " + e.toString());
		}
		
		deviceService.updateDeviceEndConnTime(device_id);
		model.addObject(jsonResult1);
		return model;
	}
}
