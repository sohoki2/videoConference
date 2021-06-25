package com.sohoki.backoffice.sym.batch;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sohoki.backoffice.cus.ten.mapper.TennantInfoManageMapper;
import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;
import com.sohoki.backoffice.sts.res.mapper.TimeInfoManageMapper;
import com.sohoki.backoffice.sym.log.service.ScheduleInfoManageService;


//spring 배치 서비스 정리 
@Component
public class Scheduler {

	
	private static final Logger LOGGER = Logger.getLogger(Scheduler.class);
	
 
	

	@Autowired
	private TimeInfoManageMapper timeMapper;
	
	@Autowired
	private ResInfoManageMapper resMapper;
	
	@Autowired
	private TennantInfoManageMapper tennantMapper;
	
	@Autowired
	private ScheduleInfoManageService  scheduleService;
	
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
			if ( "Active1".equals(serverInfo().toString())) {
				int ret = timeMapper.inseretTimeCreate();
				scheduleService.insertScheduleManage("resStateCreateSchedulerService", "OK", "");
			}   
		}catch (RuntimeException re) {
			scheduleService.insertScheduleManage("resStateCreateSchedulerService", "FAIL", re.toString());
			LOGGER.error("resStateCreateSchedulerService run failed", re);
		}catch (Exception e){
			scheduleService.insertScheduleManage("resStateCreateSchedulerService", "FAIL", e.toString());
			LOGGER.error("resStateCreateSchedulerService failed", e);
		}
	}
	//10분 단위로 입실 처리 없을때 배치 돌리기
	@Scheduled(cron = "0 0/10 * * * * ")
    public void resRaiSchedule10Minute() throws Exception{
		//LOGGER.debug("profile:" + System.getProperty("spring.profiles.active"));
		
    	try{
    		if ("Active1".equals(serverInfo().toString())) {
    			int ret = resMapper.updateResCancel10MinLateEmpty();
    			scheduleService.insertScheduleManage("RaiSchedule10Minute", "OK", "");
    		}
    	}catch(Exception e){
    		StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info(e.toString() + ':' + ste[0].getLineNumber());
			scheduleService.insertScheduleManage("RaiSchedule10Minute", "FAIL", e.toString());
    		LOGGER.error("resRaiSchedule10Minute failed", e);
    	}
    	
	}
	//매월 1일 크레딧 회사 적용
	@Scheduled(cron = "0 0 * 1 * * ")
    public void resTennchedule1Month() throws Exception{
		try{
    		if ( "Active1".equals(serverInfo().toString())) {
    			int ret = tennantMapper.insertTennantMonthManage();
    			scheduleService.insertScheduleManage("Tennchedule1Month", "OK", "");
    		}
    	}catch(Exception e){
    		StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info(e.toString() + ':' + ste[0].getLineNumber());
    		LOGGER.error("resTennchedule1Month failed", e);
    		scheduleService.insertScheduleManage("Tennchedule1Month", "FAIL", e.toString());
    	}
    	
	}
	
}
