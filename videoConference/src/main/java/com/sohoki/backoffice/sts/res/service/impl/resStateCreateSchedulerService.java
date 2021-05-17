package com.sohoki.backoffice.sts.res.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;
import com.sohoki.backoffice.sts.res.mapper.TimeInfoManageMapper;




@Service("resStateCreateSchedulerService")
public class resStateCreateSchedulerService {
	
	private static final Logger logger = Logger.getLogger(resStateCreateSchedulerService.class);
	
	
	@Autowired
	private TimeInfoManageMapper timeMapper;
	
	 @Autowired
	 private ResInfoManageMapper resMapper;
	  
	  
	public void resTimeCreateStateSchede() throws Exception{
		try{
			timeMapper.inseretTimeCreate();
		}catch (RuntimeException re) {
		       logger.error("resStateCreateSchedulerService run failed", re);
		      
		}catch (Exception e){
			   logger.error("resStateCreateSchedulerService failed", e);
			   
		}
	}
	//10분 단위로 입실 처리 없을때 배치 돌리기
    public void resRaiSchedule10Minute() throws Exception{
    	try{
    		// 10분 단위 취소 하기 
    		logger.debug("============================ 10 분 마다 실행");
    		int ret = resMapper.updateResCancel10MinLateEmpty();
    		
    		ret = resMapper.updateResCancel10_stepMinLateEmpty();
    	}catch(Exception e){
    		 logger.error("resRaiSchedule10Minute failed", e);
    	}
    	
	}
}
