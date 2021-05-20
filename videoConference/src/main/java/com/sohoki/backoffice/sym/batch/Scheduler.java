package com.sohoki.backoffice.sym.batch;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;
import com.sohoki.backoffice.sts.res.mapper.TimeInfoManageMapper;

//spring 배치 서비스 정리 
@Component
public class Scheduler {

	
	private static final Logger LOGGER = Logger.getLogger(Scheduler.class);
	


	@Autowired
	private TimeInfoManageMapper timeMapper;
	
	@Autowired
	private ResInfoManageMapper resMapper;
	
	/*
	 *  23:50 분 타임 스케줄러 생성
	 * 
	 */
	private String serverInfo () {
		return System.getProperty("spring.profiles.active");
	}
	@Scheduled(cron = "0 50 23 * * * ")
	public void resTimeCreateStateSchede() throws Exception{
		try{
			int ret = 0;
			if ( "Active1".equals(serverInfo().toString()))
    		    ret = timeMapper.inseretTimeCreate();
		     	
			
		}catch (RuntimeException re) {
			LOGGER.error("resStateCreateSchedulerService run failed", re);
		      
		}catch (Exception e){
			LOGGER.error("resStateCreateSchedulerService failed", e);
			   
		}
	}
	//10분 단위로 입실 처리 없을때 배치 돌리기
	@Scheduled(cron = "0 0/10 * * * * ")
    public void resRaiSchedule10Minute() throws Exception{
		//LOGGER.debug("profile:" + System.getProperty("spring.profiles.active"));
    	try{
    		// 10분 단위 취소 하기 
    		//LOGGER.debug("============================ 10 분 마다 실행");
    		int ret = 0;
    		if ( "Active1".equals(serverInfo().toString()))
    		    ret = resMapper.updateResCancel10MinLateEmpty();
    		
    		//배치 스케줄 기록 
    		
    	}catch(Exception e){
    		LOGGER.error("resRaiSchedule10Minute failed", e);
    	}
    	
	}
	
	
}
