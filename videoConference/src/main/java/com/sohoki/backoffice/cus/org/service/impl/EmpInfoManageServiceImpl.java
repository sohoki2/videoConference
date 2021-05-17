package com.sohoki.backoffice.cus.org.service.impl;


import java.io.StringReader;
import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sym.avaya.mapper.AvayMessageManageMapper;
import com.sohoki.backoffice.cus.org.mapper.EmpInfoManageMapper;
import com.sohoki.backoffice.cus.org.mapper.OrgInfoManagerMapper;
import com.sohoki.backoffice.cus.org.mapper.jobInfoManageMapper;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.cus.org.vo.jobInfo;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfo;
import com.sohoki.backoffice.sym.avaya.service.virturalConerenceInfo;

import javax.annotation.Resource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;



@Service
public class EmpInfoManageServiceImpl extends EgovAbstractServiceImpl implements EmpInfoManageService {

	private static final Logger LOGGER = LoggerFactory.getLogger(EmpInfoManageServiceImpl.class);
	 
	 
	@Autowired
	private EmpInfoManageMapper empMapper;
	
	
	@Autowired
	private jobInfoManageMapper jobMapper;
	
	@Autowired
	private OrgInfoManagerMapper orgMapper;
	

	@Override
	public List<Map<String, Object>> selectEmpInfoList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return empMapper.selectEmpInfoList(params);
	}
	@Override
	public List<Map<String, Object>> selectMeetinngUserList(List empNoList)
			throws Exception {
		// TODO Auto-generated method stub
		return empMapper.selectMeetinngUserList(empNoList);
	}
	
	
    //로그인 
	@Override
	public EmpInfoVO selectSmartOfficeLoginAction(String empno) throws Exception {
		EmpInfoVO userInfo = empMapper.selectEmpInfoDetailNo(empno); 
		
    	// 3. 결과를 리턴한다.
    	if (userInfo != null && !userInfo.getEmpno().equals("") ) {    		
    		return userInfo;
    	} else {    
    		System.out.println("==========================  해당 아이디 없음");
    		userInfo = 	null;
    	}
    	return userInfo;
	}
	
	@Override
	public EmpInfoVO selectEmpInfoDetail(String empNo) throws Exception {
		// TODO Auto-generated method stub
		return empMapper.selectEmpInfoDetail(empNo);
	}
	@Override
	public EmpInfoVO selectEmpInfoDetailNo(String empno) throws Exception {
		// TODO Auto-generated method stub
		return empMapper.selectEmpInfoDetailNo(empno);
	}

	//결과 저장 
	

	@Override
	public int deleteEaiEmpTmp() throws Exception {
		// TODO Auto-generated method stub
		return empMapper.deleteEaiEmpTmp();
	}
	@Override
	public int insertEmployInfoManage(EmpInfo vo) {
		// TODO Auto-generated method stub
		return empMapper.insertEmpInfo(vo);
	}


	@Override
	public int EaiEmpinfoUpdate() throws Exception {
	    /*
		List<EmpInfoVO >  empInfos =  empAppMapper.selectOracleEmpInfoList();
		for (EmpInfoVO empInfo : empInfos){
			empMapper.insertEmpInfo(empInfo);
		}
		jobMapper.deleteJobInfo();
		
		
		List<EmpInfoVO >  jobInfos =  empAppMapper.selectJobInfoList();
		//직위 정보
		for (EmpInfoVO empInfo : jobInfos){
			jobInfo info = new jobInfo();
			info.setEmpjikw(empInfo.getEmpjikw());
			info.setEmpjikwcode(empInfo.getEmpjikwcode());
			info.setSortOrde(empInfo.getSortOrde());
			jobMapper.insertJobInfo(info);
		}
		*/
		
		
		orgMapper.deleteEaiOrgTmp();
		orgMapper.insertOrgInfo();
		
		return 0;
	}
	
	
}
