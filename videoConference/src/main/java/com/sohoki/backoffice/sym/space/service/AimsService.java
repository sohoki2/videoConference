package com.sohoki.backoffice.sym.space.service;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;
import com.sohoki.backoffice.sym.space.vo.StoreInfo;
import com.sohoki.backoffice.sym.space.vo.StoreSubInfo;

public interface AimsService {

	
	int setInitAimsLabel(Map<String, Object> seatInfo) throws Exception;
	
	int setCheckAimsLabel(Map<String, Object> seatInfo) throws Exception;
	
	int setAimsLabel(Map<String, Object> seatInfo)throws Exception;
	//String parseAIMSImageLabel(ContentsInfo s2, Contents s4, String amisUrl) throws Exception;
	
	String call_AIMS_IMG(String strUrl, String data) throws Exception;
	
	String parseAIMSLabel(StoreInfo info, StoreSubInfo subInfo)throws Exception;
	
	int call_AIMS(String strUrl, String api, String data) throws Exception;
	
	void initBulkSeats(List<Map<String, Object>> seats)throws Exception;
	
	void updateBulkSeats(List<Map<String, Object>> seats) throws Exception;
	
	
	
	
}
