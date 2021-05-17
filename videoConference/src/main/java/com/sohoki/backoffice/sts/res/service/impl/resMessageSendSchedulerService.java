package com.sohoki.backoffice.sts.res.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

//import com.sds.acube.ep.linkage.messenger.AtMessengerCommunicator;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfo;
import com.sohoki.backoffice.sym.equ.service.ScheduleInfoManageService;
import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;

import egovframework.rte.fdl.property.EgovPropertyService;


@Service("resMessageSendSchedulerService")
public class resMessageSendSchedulerService {

	private static final Logger logger = Logger.getLogger(resMessageSendSchedulerService.class);
	
	
	@Autowired
	private ResInfoManageMapper resMapper;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	            
	@Autowired
	private ScheduleInfoManageService schService;
	
	public void resMessageSendSchede() throws Exception{
		
		
		try{
		    List<ResInfoVO> resInfo	 = resMapper.selectMessagentList();	
		    
		    for (int i =0; i < resInfo.size(); i ++){
		       //해당 관련 메일 보내기
		    	
              /*  AtMessengerCommunicator amc = new AtMessengerCommunicator(propertiesService.getString("mgMessageIP"), propertiesService.getInt("mgMessagePort"));
				
				String fromUid = resInfo.get(i).getUserId();
				String strMessage = "[회의 초대] " + resInfo.get(i).getResTitle() + " 회의 방번호:" + resInfo.get(i).getMeetingTel() +" 예약 일자:" + resInfo.get(i).getResStartday() + " 회의 시간:" + resInfo.get(i).getResStarttime() + "~" + resInfo.get(i).getResEndtime();
				String[] messangetoUrlList = resInfo.get(i).getResAttendlist().split(",");
				
				for (int a = 0; a < messangetoUrlList.length; a++){
					//메세지 보내기
					amc.addMessage(fromUid, messangetoUrlList[a].toString(), strMessage, "", strMessage);
				}
				amc.send();*/
		    	
		    }
            ScheduleInfo shcinfo = new ScheduleInfo();
			
			shcinfo.setSchResult("Message Send");
			shcinfo.setSchResultmessage("message send");
			schService.insertScheduleManage(shcinfo);
			
		    
		    
		}catch (RuntimeException re) {
		       logger.error("resMessageSendScheduler run failed", re);
		      
		}catch (Exception e){
			   logger.error("resMessageSendScheduler failed", e);
			   
		}
		
		
		
		
	}
	
}
