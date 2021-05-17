package com.sohoki.backoffice.sts.res.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.cus.org.mapper.EmpInfoManageMapper;
import com.sohoki.backoffice.cus.org.mapper.OrgInfoManagerMapper;
import com.sohoki.backoffice.cus.org.mapper.jobInfoManageMapper;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.cus.org.vo.jobInfo;
import com.sohoki.backoffice.sts.res.mapper.TimeInfoManageMapper;
import com.sohoki.backoffice.sym.equ.vo.ScheduleInfo;
import com.sohoki.backoffice.sym.equ.service.ScheduleInfoManageService;
import com.sohoki.backoffice.sym.sat.mapper.SeatInfoManageMapper;
import egovframework.let.utl.sim.service.ShellScript;
import egovframework.rte.fdl.property.EgovPropertyService;


@Service
public class resEaiScheduleService {

	
	private static final Logger logger = Logger.getLogger(resMessageSendSchedulerService.class);
	
	
	
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	//인사 정보 서비스 
	/*@Autowired
	private EmpInfoAppManageMapper empAppMapper;*/
	
	@Autowired
	private jobInfoManageMapper jobMapper;
	
	@Autowired
	private OrgInfoManagerMapper orgMapper;
	
	@Autowired
	private EmpInfoManageMapper empMapper;
	
	@Autowired
	private TimeInfoManageMapper timeMapper;
	
	
	
	
	
	public void resEaiScheduleSchede() throws Exception{
		
		
    try{
    	logger.debug("배치 시작 ---------------------------------------------------------------------------------------------");			
    	logger.debug("인사 정보 시작 ---------------------------------------------------------------------------------------------");	
    	/*List<EmpInfoVO >  empInfos =  empAppMapper.selectOracleEmpInfoList();
		for (EmpInfoVO empInfo : empInfos){
			empMapper.insertEmpInfo(empInfo);
		}
		jobMapper.deleteJobInfo();
		
		List<EmpInfoVO >  jobInfos = empAppMapper.selectJobInfoList();
		
		
		for (EmpInfoVO info : jobInfos){
			jobInfo job = new jobInfo();
			job.setEmpjikw(info.getEmpjikw());
			job.setEmpjikwcode(info.getEmpjikcode());
			job.setSortOrde(info.getSortOrde());
			jobMapper.insertJobInfo(job);
			job = null;
		}
		orgMapper.deleteEaiOrgTmp();
		orgMapper.insertOrgInfo();*/
		
		logger.debug("회의실 크리에이트 하기  ---------------------------------------------------------------------------------------------");	
		timeMapper.inseretTimeCreate();
		logger.debug("배치 끝 ---------------------------------------------------------------------------------------------");			
		}catch(Exception e){
			logger.error("resEmpInfoEai error:" + e.toString());
		}
		
	}
}
