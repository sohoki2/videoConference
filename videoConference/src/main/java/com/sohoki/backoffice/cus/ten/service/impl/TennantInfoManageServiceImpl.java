package com.sohoki.backoffice.cus.ten.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sohoki.backoffice.cus.ten.mapper.TennantInfoManageMapper;
import com.sohoki.backoffice.cus.ten.service.TennantInfoManageService;
import com.sohoki.backoffice.cus.ten.vo.TennantInfo;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class TennantInfoManageServiceImpl extends EgovAbstractServiceImpl implements TennantInfoManageService {

	private static final Logger LOGGER = LoggerFactory.getLogger(TennantInfoManageServiceImpl.class);
	
	@Autowired
	private TennantInfoManageMapper tennantMapper;
	
	@Autowired
	private UniSelectInfoManageService  uniService;
	
	@Override
	public List<Map<String, Object>> selectTennantInfoManageListByPagination(Map<String, Object> params)
			throws Exception {
		// TODO Auto-generated method stub
		return tennantMapper.selectTennantInfoManageListByPagination(params);
	}
	
	@Override
	public List<Map<String, Object>> selectTennantSubInfoManageListByPagination(Map<String, Object> params)
			throws Exception {
		// TODO Auto-generated method stub
		return tennantMapper.selectTennantSubInfoManageListByPagination(params);
	}

	@Override
	public List<Map<String, Object>> selectTennantInfoManageCombo(String comCode) throws Exception {
		// TODO Auto-generated method stub
		return tennantMapper.selectTennantInfoManageCombo(comCode);
	}

	@Override
	public Map<String, Object> selectTennantInfoManageDetail(String tennSeq) throws Exception {
		// TODO Auto-generated method stub
		return tennantMapper.selectTennantInfoManageDetail(tennSeq);
	}

	@Override
	public int updateTennantInfoManage(TennantInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return vo.getMode().equals("Ins") ? tennantMapper.insertTennantInfoManage(vo): tennantMapper.updateTennantInfoManage(vo);
	}

	@Override
	public int insertTennantInfoManages(List<TennantInfo> list) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("------------------------------------------------------------------");
		System.out.println(list.size());
		return tennantMapper.insertTennantInfoManages(list);
	}

	@Override
	public int insertTennantPlayManages(Map<String, Object> params) throws Exception {
		
		String userId = params.get("userId").toString();
		Map<String, Object> comInfo = uniService.selectFieldStatement("COM_CODE", "tb_userinfo", "USER_NO="+userId+"");
		String comCode = comInfo.get("com_code").toString();
		String resSeq = params.get("resSeq").toString();
		int tennCnt = Integer.valueOf(params.get("tennCnt").toString());
		
		
		params.put("comCode", comCode);
		params.put("tennRecEnd", "Y");
		params.put("firstIndex", "0");
		params.put("recordCountPerPage", "100");
		
		Map<String, Object> tennInfo = new HashMap<String, Object>();
		
		
		try {
			int nowCnt = 0;
			List<Map<String, Object>> tennLists = tennantMapper.selectTennantInfoManageListByPagination(params);
			
			
			for (Map<String, Object> tenninfo : tennLists) {
				tennInfo.put("comCode", comCode);
				tennInfo.put("userId", userId);
				
				tennInfo.put("resSeq", resSeq);
				tennInfo.put("tennSeq", tenninfo.get("tenn_seq").toString());
				nowCnt = Integer.valueOf(tenninfo.get("tenn_rec_now_cnt").toString());
				if ( nowCnt >  tennCnt ) {
					tennInfo.put("tennCnt", tennCnt);
					LOGGER.debug("tennInfo:" + tennInfo.get("tennSeq"));
					tennantMapper.updatePlayTennantInfoManage(tennInfo);
					break;
				}else {
					tennInfo.put("tennCnt", nowCnt);
					tennantMapper.updatePlayTennantInfoManage(tennInfo);
					tennCnt -= nowCnt;
				}
			}
			return 1;
		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
		    int lineNumber = ste[0].getLineNumber();
			LOGGER.error("insertTennantPlauManages error:" + e.toString() + ":" + lineNumber );
			return -1;
		}
		
	}

	@Override
	public int updateRetireTennantInfoManage(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		try {
			int ret = tennantMapper.updateRetireTennantInfoManage(params);
			return ret; 
		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
		    int lineNumber = ste[0].getLineNumber();
			LOGGER.error("insertTennantPlauManages error:" + e.toString() + ":" + lineNumber );
			return -1;
		}
	}

	@Override
	public int insertTennantMonthManage() {
		// TODO Auto-generated method stub
		return tennantMapper.insertTennantMonthManage();
	}
	

}
