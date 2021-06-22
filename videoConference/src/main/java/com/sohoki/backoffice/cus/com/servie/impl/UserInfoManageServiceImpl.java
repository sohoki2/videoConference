package com.sohoki.backoffice.cus.com.servie.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;


import com.sohoki.backoffice.cus.com.mapper.UserInfoManageMapper;
import com.sohoki.backoffice.cus.com.servie.UserInfoManageService;
import com.sohoki.backoffice.cus.com.vo.UserInfo;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.com.cmm.ExcelUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class UserInfoManageServiceImpl extends EgovAbstractServiceImpl implements UserInfoManageService {

	
	@Autowired
	private UserInfoManageMapper userMapper;
	
	@Autowired
	private SmartUtil util;
	
	@Override
	public List<Map<String, Object>> selectUserInfoManageListByPagination(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.selectUserInfoManageListByPagination(params);
	}

	@Override
	public List<Map<String, Object>> selectUserInfoManageCombo(String comCode) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.selectUserInfoManageCombo(comCode);
	}

	@Override
	public Map<String, Object> selectUserInfoManageDetail(String userNo) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.selectUserInfoManageDetail(userNo);
	}

	@Override
	public int updateUserInfoManage(UserInfo vo) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("userid:"+vo.getUserId());
		if (vo.getUserId().equals("") )
			vo.setUserId(vo.getUserNo());
		//일반 사용자 일때
		if (vo.getComCode().equals("C_00000004") )
			vo.setUserNo(vo.getUserId());
		if (vo.getUserPassword().equals("") )
			vo.setUserPassword("sto3877#*&&"); 
		return vo.getMode().equals("Ins") ?  userMapper.insertUserInfoManage(vo) :  userMapper.updateUserInfoManage(vo);
		//return 0;
	}

	@Override
	@SuppressWarnings("unchecked")
	public int excelUpload(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		int ret = 0;
        MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
		//파일 정보
		CommonsMultipartFile file = (CommonsMultipartFile)multiRequest.getFile("excelFile");
		//엑셀정보
		ExcelUtil eu = new ExcelUtil();

		int sheetNum = 0;		//1번째 시트 읽음 
		int strartRowNum = 1;	//2번째 줄부터 읽음
		int startCelNum = 2; 	//3번째 줄부터 읽음(지역ID)
		List<HashMap<Integer, String>> excelList = eu.excelReadSetValue(file, sheetNum, strartRowNum, startCelNum);

		//테이블 Key 정보
		UserInfo userinfo = null;

   

		//엑셀 Row 수 만큼 For문 조회 

		for(Object obj : excelList) {

			Map<Integer, String> mp = (Map<Integer, String>)obj;

			Set<Integer> keySet = mp.keySet();
			Iterator<Integer> iterator = keySet.iterator();
			userinfo = new UserInfo();

			while(iterator.hasNext()) {
				int key = iterator.next();
				String value = util.nullConvert(mp.get(key));
				/*
				switch(key) {
				
				case 2 :
					deviceBaseVO.setAreaId(value);
					break;
				case 4 :
					deviceBaseVO.setFacilityId(value);
					break;
				case 5 :
					deviceBaseVO.setDeviceNm(value);
					break;
				case 6 :
					deviceBaseVO.setDeviceId(value);
					break;
				case 7 :
					deviceBaseVO.setInstDt(value);
					break;
				case 8 :
					deviceBaseVO.setUseYn(value);
					break;
				}
				*/
			}
			if(!"".equals(userinfo.getComCode()) && userinfo.getUserNo() != null) {
                //등록 
				//cfgMapper.updateCfgInfo(deviceBaseVO);

			}

		}
		return ret;
	}

	@Override
	public int deleteUserInfoManage(String userNo, String comCode) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.deleteUserInfoManage(userNo, comCode);
	}
    //사용자 로그인  
	@Override
	public Map<String, Object> selectUserLogin(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.selectUserLogin(params);
	}

	@Override
	public int updatePasswordChange(UserInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updatePasswordChange(vo);
	}

}
