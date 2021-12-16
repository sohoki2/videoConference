package com.sohoki.backoffice.cus.kko.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sohoki.backoffice.cus.kko.mapper.KkoMsgManageMapper;
import com.sohoki.backoffice.cus.kko.service.KkoMsgManageSevice;
import com.sohoki.backoffice.cus.kko.vo.KkoMsgInfo;
import com.sohoki.backoffice.cus.kko.vo.kkoMessageInfo;
import com.sohoki.backoffice.sts.res.service.VisitedInfoManageService;
import com.sohoki.backoffice.sts.res.vo.VisitedDetailInfo;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class KkoMsgManageSeviceImpl extends EgovAbstractServiceImpl implements KkoMsgManageSevice  {

	
	@Autowired
	private KkoMsgManageMapper kkoMapper;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
	private VisitedInfoManageService visitedService;

	@Override
	public List<Map<String, Object>> selectKkoMsgInfoList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return kkoMapper.selectKkoMsgInfoList(params);
	}

	@Override
	public Map<String, Object> selectKkoMsgInfoDetail(String msgkey) throws Exception {
		// TODO Auto-generated method stub
		return kkoMapper.selectKkoMsgInfoDetail(msgkey);
	}

	@Override
	public int kkoMsgInsertSevice(String _sendGubun, Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		KkoMsgInfo vo = new KkoMsgInfo();
		kkoMessageInfo message = new kkoMessageInfo();
		Map<String, String> returnMsg = new HashMap<String, String>();
		
		
		if (params.get("item_gubun").equals("ITEM_GUBUN_1")) {
			returnMsg = message.meetingMsg(_sendGubun, params);
		}else if  (params.get("item_gubun").equals("ITEM_GUBUN_3")) {
			returnMsg = message.coregMsg(_sendGubun, params);
		}
		int ret = 0;
		if (!util.NVL(params.get("emphandphone"), "").toString().equals("")  ) {
			vo.setPhone(  params.get("emphandphone").toString());
			vo.setCallback("01021703122");
			vo.setMsg(returnMsg.get("resMessage"));
			vo.setTemplateCode(returnMsg.get("templeCode"));
			vo.setFailedType("MMS");
			vo.setFailedSubject(returnMsg.get("title"));
			vo.setFailedMsg(returnMsg.get("resMessage"));
			kkoMapper.kkoMsgInsertSevice(vo);
		}
		
		return ret;
	}

	@Override
	public int kkoVisitedInsertService(String _snedGubun,  List<List< Object>> params, String _visitedGubun) throws Exception {
		
				
		
		kkoMessageInfo message = new kkoMessageInfo();
		Map<String, Object> visitedInfo = null;
		if (_visitedGubun.equals("VISITED_GUBUN_1")) {
			visitedInfo = (Map<String, Object>) params.stream().limit(1).collect(Collectors.toList()).get(0).get(0);
		}else {
			visitedInfo = (Map<String, Object>) params.stream().limit(1).collect(Collectors.toList()).get(0);
		}
		
		
		
		
		Map<String, String> returnMsg =  visitedInfo.get("visited_gubun").toString().equals("VISITED_GUBUN_1") ?
				                         message.visitedMsg(_snedGubun, visitedInfo): 
				                         message.tourMsg(_snedGubun, visitedInfo) ;
		
		int ret = 0;
		
		if (!util.NVL(visitedInfo.get("visited_req_celphone"), "").toString().equals("")  ) {
			//case 할지 안할지 정리 하기
			if (!_snedGubun.equals("REQ") && !_snedGubun.equals("ARR") && visitedInfo.get("visited_gubun").toString().equals("VISITED_GUBUN_1")) {
				
				List<VisitedDetailInfo> info =  new ArrayList<VisitedDetailInfo>() ;
				EgovFileScrty fileScrty = new EgovFileScrty();
				
				ObjectMapper objectMapper = new ObjectMapper();
				List<Map<String, Object>> map = (List<Map<String, Object>>) objectMapper.convertValue(params.stream().collect(Collectors.toList()).get(1), new TypeReference<List<Map<String, Object>>>(){});
				
				
				
				map.forEach(x ->{
					VisitedDetailInfo detail = new VisitedDetailInfo();
					String qrCode = "";
					try {
						qrCode = fileScrty.encode(x.get("visited_code").toString()+":"+x.get("visited_celphone").toString());
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					detail.setVisitedSeq(x.get("visited_seq").toString());
					detail.setVisitedQrcode(qrCode);
					info.add(detail);
					detail = null;
				});
				
				
				visitedService.updateQrInfo(info);
				
				
				List<Map<String, Object>> details  = visitedService.selectVisitedDetailInfoFront(visitedInfo.get("visited_code").toString());
				
				for(Map<String, Object> detail : details) {
					KkoMsgInfo vo = new KkoMsgInfo();
					
					vo.setPhone(  detail.get("visited_celphone").toString().replaceAll("-", ""));
					vo.setCallback(visitedInfo.get("emphandphone").toString().replaceAll("-", ""));
					returnMsg  =  message.visitedMsg(_snedGubun, detail);
					vo.setButtonJson(returnMsg.get("buttonJson"));
					vo.setMsg(returnMsg.get("resMessage"));
					vo.setTemplateCode(returnMsg.get("templeCode"));
					vo.setFailedType("MMS");
					vo.setFailedSubject(returnMsg.get("title"));
					vo.setFailedMsg(returnMsg.get("resMessage"));
					ret = kkoMapper.kkoMsgInsertSevice(vo);
					vo = null;
				}
				
				fileScrty = null;
				
				return ret;
				
			}else if (visitedInfo.get("visited_gubun").toString().equals("VISITED_GUBUN_1")) {
                List<Map<String, Object>> details  = visitedService.selectVisitedDetailInfoFront(_visitedGubun);
				
				for(Map<String, Object> detail : details) {
					KkoMsgInfo vo = new KkoMsgInfo();
					vo.setPhone(  detail.get("visited_celphone").toString().replaceAll("-", ""));
					vo.setCallback(visitedInfo.get("emphandphone").toString().replaceAll("-", ""));
					returnMsg  =  message.visitedMsg(_snedGubun, detail);
					vo.setButtonJson(returnMsg.get("buttonJson"));
					vo.setMsg(returnMsg.get("resMessage"));
					vo.setTemplateCode(returnMsg.get("templeCode"));
					
					vo.setFailedType("MMS");
					vo.setFailedSubject(returnMsg.get("title"));
					vo.setFailedMsg(returnMsg.get("resMessage"));
					ret = kkoMapper.kkoMsgInsertSevice(vo);
					
					vo = null;
					
				}
				return ret;
				
			}else if (visitedInfo.get("visited_gubun").toString().equals("VISITED_GUBUN_2")) {
				//투어 신청 
				KkoMsgInfo vo = new KkoMsgInfo();
				vo.setPhone(visitedInfo.get("visited_req_celphone").toString());
				vo.setCallback("01021703122");
				
				vo.setButtonJson(returnMsg.get("buttonJson"));
				vo.setMsg(returnMsg.get("resMessage"));
				vo.setTemplateCode(returnMsg.get("templeCode"));
				
				vo.setFailedType("MMS");
				vo.setFailedSubject(returnMsg.get("title"));
				vo.setFailedMsg(returnMsg.get("resMessage"));
				ret = kkoMapper.kkoMsgInsertSevice(vo);
				vo = null;
				return ret;
			}
			
			
		}
		
		return ret;
	}


	
	
}
