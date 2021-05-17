package com.sohoki.backoffice.sym.avaya.service.impl;

import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.sohoki.backoffice.cus.org.mapper.EmpInfoManageMapper;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.sym.avaya.mapper.AvayMessageManageMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfo;
import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfoVO;
import com.sohoki.backoffice.sym.avaya.service.AvayMessageManageService;
import com.sohoki.backoffice.sym.avaya.service.virturalConerenceInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service
public class AvayMessageManageServiceImpl extends EgovAbstractServiceImpl implements AvayMessageManageService {

	
	private static final Logger LOGGER = LoggerFactory.getLogger(AvayMessageManageServiceImpl.class);
	
	@Autowired
	private AvayMessageManageMapper avayaMapper;
	
	@Autowired
	private EmpInfoManageMapper empMapper;
	
	virturalConerenceInfo conference = new virturalConerenceInfo();

	@Override
	public int selectAvayaMessageManageListTotCnt_S(AvayaMessageInfoVO SearchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return avayaMapper.selectAvayaMessageManageListTotCnt_S(SearchVO);
	}

	@Override
	public List<AvayaMessageInfoVO> selectAvayaInfoManageListByPagination(
			AvayaMessageInfoVO SearchVO) throws Exception {
		// TODO Auto-generated method stub
		return avayaMapper.selectAvayaInfoManageListByPagination(SearchVO);
	}

	@Override
	public AvayaMessageInfoVO selectAvayaInfoManageDetail(String requestid)
			throws Exception {
		// TODO Auto-generated method stub
		return avayaMapper.selectAvayaInfoManageDetail(requestid);
	}

	@Override
	public int insertAvayaInfoInsertManage(AvayaMessageInfo vo)throws Exception {
		// TODO Auto-generated method stub
		return avayaMapper.insertAvayaInfoInsertManage(vo);
	}

	@Override
	public int deleteAvayaInfoManage(String requestid) throws Exception {
		// TODO Auto-generated method stub
		return avayaMapper.deleteAvayaInfoManage(requestid);
	}

	@Override
	public String selectRequestId() throws Exception {
		// TODO Auto-generated method stub
		return avayaMapper.selectRequestId();
	}

	@Override
	public String sendAvayaMessage(String _messageGubun) throws Exception {
		// 
		switch (_messageGubun){
		    
		}
		return null;
	}
	
	/*
	 *  Avaya 사용자 업데이트 
	 * 
	 * 
	 */

	@Override
	public int updateAvayaUserUpdate() throws Exception {
		// TODO Auto-generated method stub
		int ret = 0;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("searchAvayaCheck", "null");
		
		List<Map<String, Object>> empLists = empMapper.selectEmpInfoList(params);
		int result = 0;
		//전문 저장 
		List<AvayaMessageInfo> avayalist = null;
		for (Map<String, Object> empInfo : empLists) {
			String RequestID = avayaMapper.selectRequestId();
			String resXmlMessage = xmlUserInfo(empInfo , RequestID);
			String respomseMessage = conference.ayayaResSendMessage(resXmlMessage);
			AvayaMessageInfo avaya = new AvayaMessageInfo();
			avaya.setRequestid(String.valueOf(RequestID));
			avaya.setReqMessage("Schedule_Conference_Request");
			avaya.setReqMessageTxt(resXmlMessage);
			avaya.setResMessage("Schedule_Conference_Response");
			avaya.setResMessageTxt(respomseMessage);
			avayalist.add(avaya);
			ret += XMLParse(respomseMessage, empInfo.get("empno").toString());
		}
		avayaMapper.insertAvayaInfoInsertManageList(avayalist);
			
		return ret;
	}
    private String xmlUserInfo (Map<String, Object> param , String RequestId) throws Exception{
		//사용자 생성 전문
		byte[] encodedBytes = Base64.encodeBase64(param.get("empno").toString().getBytes());
		String xmlMessage = 
				"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
				 "<MCU_XML_API>" +
				 "<Request>"+
				 "<Create_User_Request>"+
				 " <RequestID>"+RequestId+"</RequestID>"+
				 "  <User>"+
				 "    <MemberId>999</MemberId>"+
				 "    <FirstName></FirstName>"+
				 "    <LastName>"+param.get("empname").toString()+"</LastName>"+
				 "    <LoginID>"+param.get("empno").toString()+"</LoginID>"+
				 "    <Password>"+new String(encodedBytes) +"</Password>"+
				 "    <TelephoneOffice></TelephoneOffice>"+
				 "    <TelephoneMobile></TelephoneMobile>"+
				 "    <TimeZoneId></TimeZoneId>"+
				 "    <DefaultTerminalId></DefaultTerminalId>"+
				 "    <LocationId>0001</LocationId>"+
				 "    <UserProfileId>3</UserProfileId>"+
				 "    <Schedulable>false</Schedulable>"+
				 "    <Reservable>false</Reservable>"+
				 "    <AllowStreaming>OFF</AllowStreaming>"+
				 "    <AllowRecording>OFF</AllowRecording>"+
				 "    <EMail>"+param.get("empmail").toString()+"</EMail>"+
				 "    <MemberName></MemberName>"+
				 "    <VoicePromptLanguage> ko_kr </VoicePromptLanguage>"+
				 "  </User>"+
				 "  </Create_User_Request>"+
				 " </Request>"+
				 "</MCU_XML_API>" ;
		return xmlMessage;
	}
    private int XMLParse(String xmlData, String noEmp)throws Exception{
		//xml 파싱 데이터 
		int ret = 0;
	    InputSource is = new InputSource(new StringReader(xmlData));
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document doc = documentBuilder.parse(is);
		
		Element root = doc.getDocumentElement();
		doc.getDocumentElement().normalize();
		
		NodeList n_list = root.getElementsByTagName("Response");
		Element el = null;
		NodeList sub_n_list = null;
		    Element sub_el = null;
		    
		    if (n_list.getLength() > 0){
		    	
		    	el = (Element) n_list.item(0).getChildNodes().item(0);
		    	LOGGER.debug(el.getNodeName());
		    	String response_date = el.getNodeName().toString();
		    	
		    	String ConferenceId = null;
		    	String Number = null;
		    	String resSendResult = null;
		    	if (response_date.equals("Create_User_Response") ){
		    		sub_n_list = el.getChildNodes();
		    		String userId =  null;
		    		String returnVal = null;
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면
			    		
			    		if (sub_el.getNodeName().equals("ReturnValue")  ){
			    			returnVal = sub_el.getFirstChild().getNodeValue();
			    			
			    		}
			    		if (sub_el.getNodeName().equals("UserId")){
			    			userId  = sub_el.getFirstChild().getNodeValue();
			    		}
			    	}
			    	LOGGER.debug("값:" + returnVal + ":" + userId);	
			    	
			    	EmpInfoVO  empInfo = new EmpInfoVO();
			    	empInfo .setAvayaUserid(userId);
			    	empInfo.setEmpno(noEmp);
			    	//사용자 정보 업데이트
			    	empMapper.updateAvayaUserUpdate(empInfo);
			    	ret = 1;
		    	}
		    	
		    }else {
		    	
		    }
		return ret;
	}
	
	
}
