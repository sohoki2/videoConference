package com.sohoki.backoffice.sym.space.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.apache.http.HttpResponse;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sohoki.backoffice.sym.space.mapper.OfficeSeatInfoManageMapper;
import com.sohoki.backoffice.sym.space.service.AimsService;
import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;
import com.sohoki.backoffice.sym.space.vo.StoreInfo;
import com.sohoki.backoffice.sym.space.vo.StoreSubInfo;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service
public class AimsServiceImpl implements AimsService {

	private static final Logger LOGGER = LoggerFactory.getLogger(AimsServiceImpl.class);
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private OfficeSeatInfoManageMapper officeSeatMapper;
	
	@Autowired
	private SmartUtil util;
	
	/**
     * 좌석라벨 초기화
     *
     * @param seatInfo
     */
	@Override
	public int setInitAimsLabel(Map<String, Object> seatInfo) throws Exception {
		// TODO Auto-generated method stub
		
		if (seatInfo == null) return 0;

        String storeId = propertiesService.getString("aims.storeId");
        String aimsServer = propertiesService.getString("aims.server");
        String api = "articles";

        StoreInfo storeInfo = new StoreInfo();
        StoreSubInfo subInfo = new StoreSubInfo();
        subInfo.setData(getEmptyLabelData(seatInfo));
        subInfo.setId(seatInfo.get("seat_id").toString() );
        subInfo.setName(seatInfo.get("seat_name").toString());
        subInfo.setStationCode(storeId);
        String to_json = parseAIMSLabel(storeInfo, subInfo);
        int ret = call_AIMS(aimsServer, api, to_json);
        
        if (ret > 0 && !seatInfo.get("label_template_txt").toString().equals("")) {
     	   ret = AIM_TEMPLEATEUPDAtelTE(seatInfo);
     	   String result = (ret > 0) ? "OK": "FAIL";
     	   officeSeatMapper.updateOfficeLabelSeatInfoManage(result, seatInfo.get("seat_id").toString());
	        	   
	    }else {
	    	LOGGER.error("[AIMS] Failed initialize label");
	    }
        return ret;
	}
	@Override
	public String parseAIMSLabel(StoreInfo info, StoreSubInfo subInfo) {
		List<StoreSubInfo> list = new ArrayList<>();
        String return_data = "";
        subInfo.setNfc("");
        list.add(subInfo);
        info.setDataList(list);

        ObjectMapper mapper = new ObjectMapper();

        try {
            return_data = mapper.writeValueAsString(info);
            return_data = new String(return_data.getBytes("UTF-8"));
            LOGGER.info("[AIMS] data : " + return_data);
        } catch (Exception e) {
        	LOGGER.error(e.getMessage());
        }

        return return_data;
	}
	private Map<String, String> getEmptyLabelData(Map<String, Object> seat) {
        Map<String, String> dataMap = new HashMap<>();
        dataMap.put("TYPE", seat.get("seat_name").toString()); // 좌석번호
        dataMap.put("ITEM_NAME", "빈좌석"); // 사원명
        dataMap.put("LIST_PRICE", " "); // 부서명
        dataMap.put("UNIT_PRICE", " "); // 근무시간
        dataMap.put("DISPLAY_TYPE", " "); // 근무상태

        return dataMap;
    }
	/*
	 *  업데이트시 사용자 테스트 해서 하기 
	 * 
	 * 
	 */
	@Override
	public int setAimsLabel(Map<String, Object> seatInfo) throws Exception {
		// TODO Auto-generated method stub
		if (seatInfo == null) return 0;
		int ret = 0;    
		try {
			
			String storeId = propertiesService.getString("aims.storeId");
		    String aimsServer = propertiesService.getString("aims.server");
	        String api = "articles";
	        

	        JSONObject  aim_data =  new JSONObject();
	        
	        
	        if (util.NVL(seatInfo.get("seat_fix_useryn"),"").toString().equals("Y") 
	        	&& !util.NVL(seatInfo.get("seat_fix_user_id"),"").toString().equals("")
	        	&& !util.NVL(seatInfo.get("empname"),"").toString().equals("") 
	        	&& !util.NVL(seatInfo.get("workinfo"),"").toString().equals("") ) {
	        	
	        	
	        	LOGGER.debug("------------------------" + seatInfo.get("empname").toString().equals("")  + ":" + seatInfo.get("workinfo").toString().equals("") );
        		aim_data.put("TYPE", seatInfo.get("seat_name").toString());
		 	    aim_data.put("ITEM_NAME", seatInfo.get("empname").toString());
		 	    aim_data.put("LIST_PRICE", seatInfo.get("deptname").toString());
		 	    aim_data.put("UNIT_PRICE", seatInfo.get("workinfo").toString());
		 	    aim_data.put("DISPLAY_TYPE", seatInfo.get("emptelphone").toString());
	        	 
	        }else if (util.NVL(seatInfo.get("seat_fix_useryn"),"").toString().equals("N") 
	        		  && !util.NVL(seatInfo.get("empname"),"").toString().equals("") 
	        		  && !util.NVL(seatInfo.get("workinfo"),"").toString().equals("")  ){
	        	
	        	LOGGER.debug("------------------------" + seatInfo.get("empname").toString().equals("")  + ":" + seatInfo.get("workinfo").toString().equals("") );
        		
	        	
	        	aim_data.put("TYPE", seatInfo.get("seat_name").toString());
		 	    aim_data.put("ITEM_NAME", seatInfo.get("empname").toString());
		 	    aim_data.put("LIST_PRICE", util.NVL(seatInfo.get("deptname"), "없음").toString());
		 	    aim_data.put("UNIT_PRICE", seatInfo.get("workinfo").toString());
		 	    aim_data.put("DISPLAY_TYPE", util.NVL(seatInfo.get("emptelphone"), "없음").toString());
	        	
	        }else {
        		aim_data.put("TYPE", seatInfo.get("seat_name").toString());
		 	    aim_data.put("ITEM_NAME", "빈좌석");
		 	    aim_data.put("LIST_PRICE", " ");
		 	    aim_data.put("UNIT_PRICE", " ");
		 	    aim_data.put("DISPLAY_TYPE", " ");
	        }
	        
	        JSONObject  AIM_JSON_ROOT = new JSONObject();
	        JSONObject  aimData =  new JSONObject();
	        JSONArray  aimDataArray =  new JSONArray();
	 	        
	 	    aimData.put("data", aim_data);
	 	    aimData.put("id", seatInfo.get("seat_id").toString());
	 	    aimData.put("name", " ");
	 	    aimData.put("stationCode", storeId);
	 	    aimDataArray.add(aimData);
	 	    AIM_JSON_ROOT.put("dataList", aimDataArray);
	 	       
	 	    String to_json =  new ObjectMapper().writeValueAsString(AIM_JSON_ROOT);
	 	    LOGGER.debug("TEMPLEATE:" + to_json);
	 	    ret = call_AIMS(aimsServer, api, to_json);
        	String result = (ret > 0) ? "OK": "FAIL";
        	officeSeatMapper.updateOfficeLabelSeatInfoManage(result, seatInfo.get("seat_id").toString());

		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info(e.toString() + ':' + ste[0].getLineNumber());
			LOGGER.error("setCheckAimsLabel error:" + e.toString());
		}
		return ret;
	}
	
	@Override
	public int setCheckAimsLabel(Map<String, Object> seatInfo) throws Exception {
		if (seatInfo == null) return 0;
		int ret = 0;    
		try {
			
			String storeId = propertiesService.getString("aims.storeId");
		    String aimsServer = propertiesService.getString("aims.server");
	        String api = "articles";
	        

	        JSONObject  aim_data =  new JSONObject();
	        
	        
	        if (seatInfo.get("seat_fix_useryn").toString().equals("Y") && !seatInfo.get("seat_fix_user_id").toString().equals("")) {
	        	Map<String, Object> data = officeSeatMapper.selectOfficeSeatUserInfoManage(seatInfo.get("seat_fix_gubun").toString(), seatInfo.get("seat_fix_user_id").toString());
	        	if (data.size() > 0) {
	        		aim_data.put("TYPE", seatInfo.get("seat_name").toString());
			 	    aim_data.put("ITEM_NAME", seatInfo.get("empname").toString());
			 	    aim_data.put("LIST_PRICE", data.get("dept_nm").toString());
			 	    aim_data.put("UNIT_PRICE", data.get("workinfo").toString());
			 	    aim_data.put("DISPLAY_TYPE", data.get("emptelphone").toString());
	        	}else {
	        		aim_data.put("TYPE", seatInfo.get("seat_name").toString());
			 	    aim_data.put("ITEM_NAME", "빈좌석");
			 	    aim_data.put("LIST_PRICE", " ");
			 	    aim_data.put("UNIT_PRICE", " ");
			 	    aim_data.put("DISPLAY_TYPE", " ");
	        	} 
	        }else {
        		aim_data.put("TYPE", seatInfo.get("seat_name").toString());
		 	    aim_data.put("ITEM_NAME", "빈좌석");
		 	    aim_data.put("LIST_PRICE", " ");
		 	    aim_data.put("UNIT_PRICE", " ");
		 	    aim_data.put("DISPLAY_TYPE", " ");
	        }
	        
	        JSONObject  AIM_JSON_ROOT = new JSONObject();
	        JSONObject  aimData =  new JSONObject();
	        JSONArray  aimDataArray =  new JSONArray();
	 	        
	 	    aimData.put("data", aim_data);
	 	    aimData.put("id", seatInfo.get("seat_id").toString());
	 	    aimData.put("name", " ");
	 	    aimData.put("stationCode", storeId);
	 	    aimDataArray.add(aimData);
	 	    AIM_JSON_ROOT.put("dataList", aimDataArray);
	 	       
	 	    String to_json =  new ObjectMapper().writeValueAsString(AIM_JSON_ROOT);
	 	    LOGGER.debug("TEMPLEATE:" + to_json);
	 	    ret = call_AIMS(aimsServer, api, to_json);
	        if (ret > 0 && !seatInfo.get("label_template_txt").toString().equals("")) {
        	   ret = AIM_TEMPLEATEUPDAtelTE(seatInfo);
        	   String result = (ret > 0) ? "OK": "FAIL";
        	   officeSeatMapper.updateOfficeLabelSeatInfoManage(result, seatInfo.get("seat_id").toString());
	        	   
	        } 
		}catch(Exception e) {
			StackTraceElement[] ste = e.getStackTrace();
			LOGGER.info(e.toString() + ':' + ste[0].getLineNumber());
			LOGGER.error("setCheckAimsLabel error:" + e.toString());
		}
		return ret;
        
	}
    private int AIM_TEMPLEATEUPDAtelTE(Map<String, Object> info) {
    	int ret = 0;
    	try {
    		//주소값 넣기 추후 환경 변수로 정리 하기 
    		String storeId = propertiesService.getString("aims.storeId");
	        String aimsServer = propertiesService.getString("aims.server");
	        String api = "labels/link/aten";
	        
    		
	        String templeateJson = "{\"articleIdList\":[\"" +info.get("seat_id").toString()+ "\"],"
    				      + "\"labelCode\":\"" +info.get("seat_label_code").toString()+"\","
    				      + "\"templateName\":\""+ info.get("label_template_txt").toString()+"\"}";
    		//String to_json = new ObjectMapper().writeValueAsString(templeateJson);
    		LOGGER.debug("TEMPLEATE:" + templeateJson);
    		ret = call_AIMS(aimsServer, api, templeateJson);
    		
    	}catch(Exception e) {
    		LOGGER.error("AIM_TEMPLEATEUPDAtelTE error:" + e.toString());
    	}
    	return ret;
    }
	@Override
	public String call_AIMS_IMG(String strUrl, String data) throws Exception {
		// TODO Auto-generated method stub
		String body = "";
        try (CloseableHttpClient httpClient = getHttpClient()) {
            HttpPost postRequest = new HttpPost(strUrl); //POST 메소드 URL 새성
            postRequest.setHeader("Accept", "application/json");
            postRequest.setHeader("Connection", "keep-alive");
            postRequest.setHeader("Content-Type", "application/json;text/plain;charset=UTF-8");

//			postRequest.addHeader("x-api-key", RestTestCommon.API_KEY); //KEY 입력
            //postRequest.addHeader("Authorization", token); // token 이용시

            postRequest.setEntity(new StringEntity(data, "UTF-8")); //json 메시지 입력

            HttpResponse response = httpClient.execute(postRequest);

            //Response 출력
            if (response.getStatusLine().getStatusCode() == 200) {
                ResponseHandler<String> handler = new BasicResponseHandler();
                body = handler.handleResponse(response);
                LOGGER.debug(body);

            } else {
            	LOGGER.info("[AIMS] response is error code: " + response.getStatusLine().getStatusCode());
            }
        } catch (Exception e) {
        	LOGGER.error(e.toString());
        }
        return body;
	}

	@Override
	public int call_AIMS(String strUrl, String api, String data) throws Exception {
		// TODO Auto-generated method stub
		String body = "";
        
        try (CloseableHttpClient httpClient = getHttpClient()) {
            HttpPost postRequest = new HttpPost(strUrl + api); //POST 메소드 URL 새성
            
            LOGGER.debug("url:" + strUrl + api);
            postRequest.setHeader("Accept", "application/json");
            postRequest.setHeader("Connection", "keep-alive");
            postRequest.setHeader("Content-Type", "application/json");

            postRequest.setEntity(new StringEntity(data, "UTF-8")); //json 메시지 입력
            HttpResponse response = httpClient.execute(postRequest);

            //Response 출력
            if (response.getStatusLine().getStatusCode() == 200) {
                ResponseHandler<String> handler = new BasicResponseHandler();
                body = handler.handleResponse(response);
                LOGGER.debug(body);
            } else {
            	LOGGER.error("[AIMS] response is error code : " + response.getStatusLine().getStatusCode());
                return 0;
            }
        } catch (Exception e) {
        	LOGGER.error(e.toString());
            return 0;
        }
        return 1;
	}

	@Override
	public void initBulkSeats(List<Map<String, Object>> seats) throws Exception {
		// TODO Auto-generated method stub
		/*
		if (seats == null || seats.size() == 0) {
			LOGGER.info("[AIMS] Target seats is empty");
            return;
        }

        String storeId = propertiesService.getString("aims.storeId");
        String aimsServer = propertiesService.getString("aims.server");
        String api = "articles";

        StoreInfo storeInfo = new StoreInfo();
        storeInfo.setDataList(new ArrayList<>());
        List<StoreSubInfo> dataList = storeInfo.getDataList();

        seats
            .stream()
            .forEach(seat -> {
                StoreSubInfo subInfo = new StoreSubInfo();
                subInfo.setId(seats.get(i) );
                subInfo.setName(getAimsArticleName(seat));
                subInfo.setNfc("");
                subInfo.setStationCode(storeId);

                Map<String, String> dataMap = new HashMap<>();
                dataMap.put("TYPE", getAimsArticleName(seat));    // 좌석번호
                dataMap.put("ITEM_NAME", "빈좌석");                    // 사원명
                dataMap.put("LIST_PRICE", "");                        // 부서명
                dataMap.put("UNIT_PRICE", "");           // 근무시간
                dataMap.put("DISPLAY_TYPE", "");                      // 근무상태
                subInfo.setData(dataMap);

                dataList.add(subInfo);
            });

        ObjectMapper mapper = new ObjectMapper();

        try {
        	LOGGER.info("[AIMS] Reset request: " + seats.size());
            String json = mapper.writeValueAsString(storeInfo);
            json = new String(json.getBytes("UTF-8"));
            boolean success = call_AIMS(aimsServer, api, json);
            LOGGER.info("[AIMS] Reset result: " + success);
        } catch (Exception e) {
        	LOGGER.error("[AIMS] Reset bulk seat data", e);
        }
        */
	}

	@Override
	public void updateBulkSeats(List<Map<String, Object>> seats) throws Exception {
		// TODO Auto-generated method stub
		
	}
	private CloseableHttpClient getHttpClient() {
        int connectionTimeout = propertiesService.getInt("aims.connectionTimeout", 5000);
        int socketTimeout = propertiesService.getInt("aims.socketTimeout", 5000);

        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(connectionTimeout)
                .setConnectionRequestTimeout(5000) // 5초
                .setSocketTimeout(socketTimeout)
                .build();
        HttpClientBuilder httpClientBuilder = HttpClients.custom().setDefaultRequestConfig(requestConfig);
        return httpClientBuilder.build();
    }
	
	
	

}
