package com.sohoki.backoffice.cus.ten.service;

import java.util.List;
import java.util.Map;
import com.sohoki.backoffice.cus.ten.vo.TennantInfo;

public interface TennantInfoManageService {

	List<Map<String, Object>> selectTennantInfoManageListByPagination(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectTennantSubInfoManageListByPagination(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectTennantInfoManageCombo (String comCode)throws Exception;
	
	Map<String, Object> selectTennantInfoManageDetail(String tennSeq)throws Exception;
	
	
	int insertTennantInfoManages(List<TennantInfo> list)throws Exception;
	//한달 1번 크레딧 배포
	int insertTennantMonthManage()throws Exception;
	//크레딧 reset
	int insertTennantReset(String comCode)throws Exception;
	//테넌트 사용 
	int insertTennantPlayManages(Map<String, Object> params)throws Exception;
	//테넌트 회수
	int updateRetireTennantInfoManage(Map<String, Object> params)throws Exception;
	
	int updateTennantInfoManage(TennantInfo vo)throws Exception;
	
	int cancelPlayTennantInfoManage (Map<String, Object> params)throws Exception;
	
	
}
