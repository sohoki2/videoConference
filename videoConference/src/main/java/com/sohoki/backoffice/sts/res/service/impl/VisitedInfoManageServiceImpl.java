package com.sohoki.backoffice.sts.res.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.NameList;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sohoki.backoffice.cus.kko.mapper.KkoMsgManageMapper;
import com.sohoki.backoffice.cus.kko.service.KkoMsgManageSevice;
import com.sohoki.backoffice.cus.kko.vo.KkoMsgInfo;
import com.sohoki.backoffice.cus.kko.vo.kkoMessageInfo;
import com.sohoki.backoffice.sts.res.mapper.VisitedInfoManageMapper;
import com.sohoki.backoffice.sts.res.service.VisitedInfoManageService;
import com.sohoki.backoffice.sts.res.vo.VisitedDetailInfo;
import com.sohoki.backoffice.sts.res.vo.VisitedInfo;
import com.sohoki.backoffice.sym.space.vo.OfficeSeatInfo;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;



@Service
public class VisitedInfoManageServiceImpl extends EgovAbstractServiceImpl implements VisitedInfoManageService {

	
	@Autowired
	private KkoMsgManageSevice kkoSerice;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
	private VisitedInfoManageMapper visitedMapper;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private KkoMsgManageMapper kkoMapper;

	@Override
	public List<Map<String, Object>> selectVisitedManageListByPagination(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return visitedMapper.selectVisitedManageListByPagination(params);
	}

	@Override
	public Map<String, Object> selectVisitedManageInfo(String visitedCode) throws Exception {
		// TODO Auto-generated method stub
		return visitedMapper.selectVisitedManageInfo(visitedCode);
	}

	@Override
	public int updateVisitedReqManageInfo(Map<String, Object> visitedInfo) throws Exception {
		// TODO Auto-generated method stub
		
		VisitedInfo info = new VisitedInfo();
		
		info.setVisitedReqName(visitedInfo.get("visitedReqName").toString());
		info.setVisitedReqCelphone(visitedInfo.get("visitedReqCelphone").toString());
		info.setVisitedReqOrg(visitedInfo.get("visitedReqOrg").toString());
		
		info.setCenterId(util.NVL(visitedInfo.get("centerId"), "").toString());
		info.setFloorSeq(util.NVL(visitedInfo.get("floorSeq"), "").toString());
		
		info.setVisitedEmpno(util.NVL(visitedInfo.get("visitedEmpno"), "").toString());
		info.setVisitedResday(util.NVL(visitedInfo.get("visitedResday"), "").toString());
		info.setVisitedRestime(util.NVL(visitedInfo.get("visitedRestime"),"").toString());
		info.setVisitedPurpose(util.NVL(visitedInfo.get("visitedPurpose"),"").toString());
		info.setVisitedRemark(util.NVL(visitedInfo.get("visitedRemark"),"").toString());
		info.setVisitedGubun(util.NVL(visitedInfo.get("visitedGubun"),"").toString());
		info.setVisitedStatus(util.NVL(visitedInfo.get("visitedStatus"),"").toString());
		info.setVisitedPerson(util.NVL(visitedInfo.get("visitedPerson"),"0").toString());
		info.setVisitedGroupName(util.NVL(visitedInfo.get("visitedGroupName"),"").toString());
		info.setVisitedGroupCheck(util.NVL(visitedInfo.get("visitedGroupCheck"),"").toString());
		
		//gson 으로 jsonlist 확인 
		
		//ObjectMapper mapper = new ObjectMapper();
		//List<VisitedDetailInfo> detailList = new ArrayList<>();
		//detailList = Arrays.asList(mapper.readValue(visitedInfo.get("visitedDetail").toString(), VisitedDetailInfo[].class));
		System.out.println("-----------------------------------------");
		System.out.println("visitedDetail:" + util.NVL(visitedInfo.get("visitedDetail"),"").toString());
		System.out.println("-----------------------------------------");
		if (!util.NVL(visitedInfo.get("visitedDetail"),"").toString().equals("") ){
			
			//JSONArray ja = new JSONArray(util.NVL(visitedInfo.get("visitedDetail"),"").toString());
			
			
			Gson gson = new GsonBuilder().create();
			List<VisitedDetailInfo> detailList = gson.fromJson(visitedInfo.get("visitedDetail").toString(), new TypeToken<List<VisitedDetailInfo>>(){}.getType());
			info.setDetailList(detailList );
			info.setVisitedPerson( Integer.toString(detailList.size() ));
		}
		
		
		int ret = visitedMapper.insertVisitedManageInfo(info);
		
		if (ret > 0) {
			// 예약 메세지 보내기 
			
			
			List<List<Object>> result = visitedMapper.selectVisitedDetailInfo(info);
			
			if (info.getVisitedGubun().equals("VISITED_GUBUN_1")) {
				ret = kkoSerice.kkoVisitedInsertService("RES", result, info.getVisitedGubun());
				ret = kkoSerice.kkoVisitedInsertService("REQ", result, info.getVisitedGubun()); 
			}
				
		}
		
		return ret;
	}

	@Override
	public int updateVisitedStateChangeInfoManage(VisitedInfo info) throws Exception {
		// TODO Auto-generated method stub
		//상대 변경후 QR코드 생성 
		if (info.getVisitedStatus().equals("VISITED_STATE_2") &&  info.getVisitedGubun().equals("VISITED_GUBUN_1") ) {
			//QR셍성 
			
			 EgovFileScrty fileScrty = new EgovFileScrty();
			 String path =  propertiesService.getString("Globals.qrPath");
			 String result =  util.getQrCode(path, fileScrty.encode(info.getVisitedCode()), 300, 300, info.getVisitedCode()); // qr코드 생성 및 이미지 생성
			 info.setVisitedQrcode(result);
			 fileScrty = null;
		}
		String _snedGubun = "";
		if (info.getVisitedGubun().equals("VISITED_GUBUN_1") ) {
			
			switch (info.getVisitedStatus() ) {
			    case  "VISITED_STATE_2":
			    	_snedGubun = "QRS";
			    	break;
			    case  "VISITED_STATE_4":
			    	_snedGubun = "CAN";
			    	break;
			    case  "VISITED_STATE_5":
			    	_snedGubun = "ARR";
			    	break;
			}
			
		}else {
			switch (info.getVisitedStatus()) {
			    case  "VISITED_STATE_2":
			    	_snedGubun = "RES";
			    	break;
			    case  "VISITED_STATE_4":
			    	_snedGubun = "CAN";
			    	break;
			    case  "VISITED_STATE_6":
			    	_snedGubun = "COV";
			    	break;
			}
		}
		
		int ret = visitedMapper.updateVisitedStateChangeInfoManage(info);		
		
		if (info.getVisitedGubun().equals("VISITED_GUBUN_1") && _snedGubun.equals("CAN") && info.getCancelReason().equals("") ) {
			
		}else {
			List<List<Object>> result_visited = visitedMapper.selectVisitedDetailInfo(info);
			kkoSerice.kkoVisitedInsertService(_snedGubun, result_visited, info.getVisitedGubun());
		}
		
		return ret;
	}

	@Override
	public List<Map<String, Object>> selecttourCombo() throws Exception {
		// TODO Auto-generated method stub
		return visitedMapper.selecttourCombo();
	}

	@Override
	public List<Map<String, Object>> selecttourInfo() throws Exception {
		// TODO Auto-generated method stub
		return visitedMapper.selecttourInfo();
	}

	@Override
	public Map<String, Object> selectTourCount(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return visitedMapper.selectTourCount(params);
	}

	@Override
	public List<List<Object>>  selectVisitedDetailInfo (VisitedInfo visitedInfo) throws Exception {
		// TODO Auto-generated method stub
		
		
		
		return visitedMapper.selectVisitedDetailInfo(visitedInfo);
	}

	@Override
	public List<Map<String, Object>> selectVisitedDetailInfoFront(String visitedCode) throws Exception {
		// TODO Auto-generated method stub
		return visitedMapper.selectVisitedDetailInfoFront(visitedCode);
	}

	@Override
	public int selectTourMessage() throws Exception {
		// TODO Auto-generated method stub
		//메세지 보내기 
		List<Map<String, Object>> tourMessages = visitedMapper.selectTourMessage();
		
		KkoMsgInfo vo = new KkoMsgInfo();
		kkoMessageInfo message = new kkoMessageInfo();
		Map<String, String> returnMsg = new HashMap<String, String>();
		int ret = 0;
		for (Map<String, Object> tourMessage : tourMessages) {
			String _snedGubun = tourMessage.get("dayGubun").equals("TOD") ? "stptr03":"stptr02";
					
			if (!util.NVL(tourMessage.get("visited_req_celphone"), "").toString().equals("")  ) {
				//case 할지 안할지 정리 하기
				message.tourMsg(_snedGubun, tourMessage) ;
				
				vo.setPhone(tourMessage.get("visited_req_celphone").toString());
				vo.setCallback("01021703122");
				
				vo.setMsg(returnMsg.get("resMessage"));
				vo.setTemplateCode(_snedGubun);
				
				vo.setFailedType("MMS");
				vo.setFailedSubject(returnMsg.get("title"));
				vo.setFailedMsg(returnMsg.get("resMessage"));
				ret = kkoMapper.kkoMsgInsertSevice(vo);
			}
			
		}
		returnMsg = null;
		vo = null;
		message = null;
		return ret;
	}
	
	
	
}
