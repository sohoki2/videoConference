package com.sohoki.backoffice.sym.avaya.service.impl;

import java.io.IOException;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.TimeZone;
import java.util.UUID;
import java.util.Base64.Encoder;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.StatusLine;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;
import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sym.avaya.service.virturalConerenceInfoService;
import com.sohoki.backoffice.sym.sat.vo.SeatInfoVO;
import com.sohoki.backoffice.sym.space.mapper.MeetingRoomInfoManageMapper;
import com.sohoki.backoffice.util.SmartUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service
public class virturalConerenceInfoServiceImpl extends EgovAbstractServiceImpl implements virturalConerenceInfoService {

	
	private static final Logger LOGGER = LoggerFactory.getLogger(virturalConerenceInfoServiceImpl.class);
			
			
	@Autowired
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private ResInfoManageMapper resMapper;
	
	@Autowired
	private MeetingRoomInfoManageMapper meetingMapper;
	
	@Autowired
	private SmartUtil util;
	
	@Override
	public String localTimeToUTC(String date) throws Exception{
		 String uctTime = null;		 
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 Date Stringdate = sdf.parse(date);
		 
		 SimpleDateFormat sdf_utc = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		 Calendar cal = Calendar.getInstance();		 
		 sdf_utc.setTimeZone(TimeZone.getTimeZone("UTC"));
		 
		 return sdf_utc.format(Stringdate) ;
		 
	}
	@Override
	public void XMLParse(String xmlData) throws ParserConfigurationException, SAXException, IOException {
		InputSource is = new InputSource(new StringReader(xmlData));
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document doc = documentBuilder.parse(is);
		
		Element root = doc.getDocumentElement();
		doc.getDocumentElement().normalize();
		
		LOGGER.debug(xmlData);
		
		NodeList n_list = root.getElementsByTagName("Response");
		Element el = null;
		Element el_sub = null;
		NodeList sub_n_list = null;
		    Element sub_el = null;
		    Node v_txt = null;
		    if (n_list.getLength() > 0){
		    	LOGGER.debug("값 있음");    	
		    	
		    	el = (Element) n_list.item(0).getChildNodes().item(0);
		    	LOGGER.debug(el.getNodeName());
		    	//스위치 구문으로 해서 전문값 처리 
		    	String response_date = el.getNodeName().toString();
		    	if (response_date.equals("Get_Conference_Response")){
		    		//회의 정보 결과 보여주기 
		    		sub_n_list = el.getChildNodes();
			    	
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면 
			    		if (sub_el.getNodeName().equals("ReturnValue") && sub_el.getFirstChild().getNodeValue().equals("OK")){
			    			
			    			
			    			NodeList n_list_conferenceDetail = root.getElementsByTagName("Conference").item(0).getChildNodes();
			    			Element confen_el = null;
			    			for (int a = 0; a < n_list_conferenceDetail.getLength(); a++ ){
			    				confen_el = (Element)n_list_conferenceDetail.item(a);
			    				try{
			    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
			    				}catch(Exception e){
			    				//	LOGGER.debug( "error:" + e.toString());
			    				}
			    				if (confen_el.getNodeName().equals("Attendee")){
			    					//참석자 처리 하기
			    					NodeList n_list_Attendee = n_list_conferenceDetail.item(a).getChildNodes();
			    					Element confen_attend = null;
			    					LOGGER.debug("Attendee Size:" + n_list_Attendee.getLength());
			    					for (int b =0; b < n_list_Attendee.getLength(); b++){
			    						//여기 부분이 참석자 
			    						confen_attend = (Element)n_list_Attendee.item(b);
			    						try{
					    					LOGGER.debug( confen_attend.getNodeName() +":"+ confen_attend.getFirstChild().getNodeValue().toString() );	
					    				}catch(Exception e){
					    				//	LOGGER.debug( "error:" + e.toString());
					    				}
			    					}
			    					
			    					
			    				}
			    			}
			    			 
			    			
			    		}
			    		
			    	}
		    		
		    	}else if (response_date.equals("Get_User_Response")){
		    	   // 사용자 아이디 확인 하기 
                 sub_n_list = el.getChildNodes();
			    	
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면 
			    		if (sub_el.getNodeName().equals("ReturnValue") && sub_el.getFirstChild().getNodeValue().equals("OK")){
			    			
			    			
			    			//NodeList n_list_conferenceDetail = root.getElementsByTagName("User").item(0).getChildNodes();
			    			NodeList n_list_conferenceDetail = root.getElementsByTagName("User");
			    			NodeList n_list_user = null;
			    			Element confen_el = null;
			    			for (int i = 0; i < n_list_conferenceDetail.getLength(); i++){
			    				
			    				n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
			    				LOGGER.debug("----------------------------------------------------");
			    				for (int a =0; a < n_list_user.getLength(); a++ ){
				    				//사용자 관련 내용 정리 해서 
			    					
				    				confen_el = (Element)n_list_user.item(a);
				    				try{
				    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
				    				}catch(Exception e){
				    					LOGGER.debug( confen_el.getNodeName() + ": null"); 
				    				//	LOGGER.debug( "error:" + e.toString());
				    				}
				    				
				    			}
			    				LOGGER.debug("----------------------------------------------------");
			    				
			    			}
			    			
			    			
			    			
			    		}
			    	}
			    			
		    	}	
		    	else if (response_date.equals("Get_Conference_Info_Response") ){
		    		//
                 sub_n_list = el.getChildNodes();
			    	
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면
			    		
			    		if (sub_el.getNodeName().equals("ConfGID")){
			    			LOGGER.debug(sub_el.getFirstChild().getNodeValue());	
			    		}
			    		
			    		
			    		if (sub_el.getNodeName().equals("ReturnValue") && sub_el.getFirstChild().getNodeValue().equals("OK")){
			    			
			    			
			    			//NodeList n_list_conferenceDetail = root.getElementsByTagName("User").item(0).getChildNodes();
			    			NodeList n_list_conferenceDetail = root.getElementsByTagName("Conf");
			    			NodeList n_list_user = null;
			    			Element confen_el = null;
			    			for (int i = 0; i < n_list_conferenceDetail.getLength(); i++){
			    				
			    				n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
			    				LOGGER.debug("----------------------------------------------------");
			    				for (int a =0; a < n_list_user.getLength(); a++ ){
				    				//사용자 관련 내용 정리 해서 
			    					
				    				confen_el = (Element)n_list_user.item(a);
				    				try{
				    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
				    				}catch(Exception e){
				    					LOGGER.debug( confen_el.getNodeName() + ": null"); 
				    				//	LOGGER.debug( "error:" + e.toString());
				    				}
				    				
				    			}
			    				LOGGER.debug("----------------------------------------------------");
			    				
			    			}
			    			
			    			
			    			
			    		}
			    	}
		    		
		    	}else if (response_date.equals("Get_Terminal_Response") ){
                 sub_n_list = el.getChildNodes();
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면
			    		
			    		
			    		
			    		if (sub_el.getNodeName().equals("ReturnValue") && sub_el.getFirstChild().getNodeValue().equals("OK")){
			    			
			    			
			    			//NodeList n_list_conferenceDetail = root.getElementsByTagName("User").item(0).getChildNodes();
			    			NodeList n_list_conferenceDetail = root.getElementsByTagName("Terminal");
			    			NodeList n_list_user = null;
			    			Element confen_el = null;
			    			for (int i = 0; i < n_list_conferenceDetail.getLength(); i++){
			    				
			    				n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
			    				LOGGER.debug("----------------------------------------------------");
			    				for (int a =0; a < n_list_user.getLength(); a++ ){
				    				//사용자 관련 내용 정리 해서 
			    					
				    				confen_el = (Element)n_list_user.item(a);
				    				try{
				    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
				    				}catch(Exception e){
				    					LOGGER.debug( confen_el.getNodeName() + ": null"); 
				    				//	LOGGER.debug( "error:" + e.toString());
				    				}
				    				
				    			}
			    				LOGGER.debug("----------------------------------------------------");
			    				
			    			}
			    			
			    			
			    			
			    		}
			    	}
		    	}else if (response_date.equals("Get_Organization_Response") ){
                 sub_n_list = el.getChildNodes();
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면
			    		
			    		
			    		
			    		if (sub_el.getNodeName().equals("ReturnValue") && sub_el.getFirstChild().getNodeValue().equals("OK")){
			    			
			    			
			    			//NodeList n_list_conferenceDetail = root.getElementsByTagName("User").item(0).getChildNodes();
			    			NodeList n_list_conferenceDetail = root.getElementsByTagName("Organization");
			    			NodeList n_list_user = null;
			    			Element confen_el = null;
			    			for (int i = 0; i < n_list_conferenceDetail.getLength(); i++){
			    				
			    				n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
			    				LOGGER.debug("----------------------------------------------------");
			    				for (int a =0; a < n_list_user.getLength(); a++ ){
				    				//사용자 관련 내용 정리 해서 
			    					
				    				confen_el = (Element)n_list_user.item(a);
				    				try{
				    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
				    				}catch(Exception e){
				    					LOGGER.debug( confen_el.getNodeName() + ": null"); 
				    				//	LOGGER.debug( "error:" + e.toString());
				    				}
				    				
				    			}
			    				LOGGER.debug("----------------------------------------------------");
			    				
			    			}
			    			
			    			
			    			
			    		}
			    	}
		    	}else if (response_date.equals("Schedule_Conference_Response") ){
                 sub_n_list = el.getChildNodes();
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면
			    		
			    		
			    		
			    		if (sub_el.getNodeName().equals("ReturnValue") ){
			    			
			    			LOGGER.debug(sub_el.getFirstChild().getNodeValue());
			    			//NodeList n_list_conferenceDetail = root.getElementsByTagName("User").item(0).getChildNodes();
			    			NodeList n_list_conferenceDetail = root.getElementsByTagName("Report");
			    			NodeList n_list_user = null;
			    			Element confen_el = null;
			    			for (int i = 0; i < n_list_conferenceDetail.getLength(); i++){
			    				
			    				n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
			    				LOGGER.debug("----------------------------------------------------");
			    				for (int a =0; a < n_list_user.getLength(); a++ ){
				    				//사용자 관련 내용 정리 해서 
			    					
				    				confen_el = (Element)n_list_user.item(a);
				    				try{
				    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
				    				}catch(Exception e){
				    					LOGGER.debug( confen_el.getNodeName() + ": null"); 
				    				//	LOGGER.debug( "error:" + e.toString());
				    				}
				    				
				    			}
			    				LOGGER.debug("----------------------------------------------------");
			    				
			    			}
			    			
			    			
			    			
			    		}
			    	}
		    	}else if (response_date.equals("Cancel_Conference_Response") ){
		    		sub_n_list = el.getChildNodes();
			    	for (int k =0; k < sub_n_list.getLength(); k++ ){
			    		sub_el = (Element) sub_n_list.item(k);
			    		//조회가 성공적으로 되었으면
			    		
			    		
			    		
			    		if (sub_el.getNodeName().equals("ReturnValue") ){
			    			
			    			LOGGER.debug(sub_el.getFirstChild().getNodeValue());
			    			//NodeList n_list_conferenceDetail = root.getElementsByTagName("User").item(0).getChildNodes();
			    			NodeList n_list_conferenceDetail = root.getElementsByTagName("Report");
			    			NodeList n_list_user = null;
			    			Element confen_el = null;
			    			for (int i = 0; i < n_list_conferenceDetail.getLength(); i++){
			    				
			    				n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
			    				LOGGER.debug("----------------------------------------------------");
			    				for (int a =0; a < n_list_user.getLength(); a++ ){
				    				//사용자 관련 내용 정리 해서 
			    					
				    				confen_el = (Element)n_list_user.item(a);
				    				try{
				    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
				    				}catch(Exception e){
				    					LOGGER.debug( confen_el.getNodeName() + ": null"); 
				    				//	LOGGER.debug( "error:" + e.toString());
				    				}
				    				
				    			}
			    				LOGGER.debug("----------------------------------------------------");
			    				
			    			}
			    			
			    			
			    			
			    		}
			    	}
		    	}
		    	
		    }else {
		    	LOGGER.debug("값 없음");
		    }	
	}

	@Override
	public void ayayaConnection() throws Exception {
		 DefaultHttpClient httpclient = new DefaultHttpClient();
		 String xmlData  = "";
		 try {
	     
		 HttpResponse response = execute(httpclient) ;
		 StatusLine statusLine = response.getStatusLine() ;		 
			 if ( statusLine.getStatusCode() == 302 ) {
				 response = execute(httpclient) ;
				 statusLine = response.getStatusLine() ;
			 }
		     xmlData = output(response) ;
		     
		 }
		 finally {
		    httpclient.getConnectionManager().shutdown();
		    XMLParse(xmlData);
		 }
	}

	@Override
	public String ayayaResSendMessage(String xmlMessage) throws Exception {
		// TODO Auto-generated method stub
		 DefaultHttpClient httpclient = new DefaultHttpClient();
		 String xmlData  = "";
		 try {
	     
		 HttpResponse response = executeString(httpclient, xmlMessage) ;
		 StatusLine statusLine = response.getStatusLine() ;		 
			 if ( statusLine.getStatusCode() == 302 ) {
				 response = executeString(httpclient, xmlMessage) ;
				 statusLine = response.getStatusLine() ;
			 }
		     xmlData = output(response) ;
		 }
		 finally {
		    httpclient.getConnectionManager().shutdown();
		 }		 
		 return xmlData;
	}

	@Override
	public HttpResponse executeString(DefaultHttpClient httpclient, String xmlMessage) throws Exception {
		
		//private static String SERVER_HOST =  "10.10.5.170"; //propertiesService.getString("avayaServer");
		//protected static int PORT = 8080; //propertiesService.getInt("avayaPort");
		//protected static String SERVICE_RUL = "http://" + SERVER_HOST + ":" + PORT +"/xmlservice/entry" ;
		//protected static String USER_NAME = "slc";// propertiesService.getString("avayaID") ;
		//protected static String PASSWORD = "Arisys123$";// propertiesService.getString("avayaPassword") ;
		
		
		 httpclient.getCredentialsProvider().setCredentials(
				 new AuthScope(propertiesService.getString("avayaServer"), propertiesService.getInt("avayaPort")),
				 new UsernamePasswordCredentials(propertiesService.getString("avayaID"), propertiesService.getString("avayaPassword")));
		 HttpResponse response = null;
		 
		 
         try{
	       	 HttpEntity body = new StringEntity(xmlMessage, "UTF-8") ;
	   		 HttpPost httpPost = new HttpPost(propertiesService.getString("avayaPullUrl")) ;
	   		 httpPost.setEntity(body);
	   		 response = httpclient.execute(httpPost);	 
         }catch(Exception e){
       	     LOGGER.debug("error:" + e.toString());
         }
		 return response ;
	}

	@Override
	public HttpResponse execute(DefaultHttpClient httpclient) throws Exception {
		// TODO Auto-generated method stub
		httpclient.getCredentialsProvider().setCredentials(
			  new AuthScope(propertiesService.getString("avayaServer"), propertiesService.getInt("avayaPort")),
		      new UsernamePasswordCredentials(propertiesService.getString("avayaID"), propertiesService.getString("avayaPassword")));
		 
		 String reqMsg1 = 
				 "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
				 "<MCU_XML_API>" +
				 " <Request>"+
				 "   <Get_Conference_List_Request>"+
				 "   <RequestID>20191129125031</RequestID>"+
				 "   <MemberId>999</MemberId>"+
				 "   <Verbose> true </Verbose>"+
				 "  </Get_Conference_List_Request>" +
				 " </Request>"+
				 "</MCU_XML_API>";	
		 HttpResponse response = null;
         try{
	       	 HttpEntity body = new StringEntity(reqMsg1, "UTF-8") ;
	   		 HttpPost httpPost = new HttpPost(propertiesService.getString("avayaPullUrl")) ;
	   		 httpPost.setEntity(body);
	   		 response = httpclient.execute(httpPost);	 
         }catch(Exception e){
       	   LOGGER.debug("error:" + e.toString());
         }
		 return response ;
		
	}

	@Override
	public String output(HttpResponse response) throws ParseException, IOException {
		// TODO Auto-generated method stub
		HttpEntity entity = response.getEntity();		 
		return EntityUtils.toString(entity).toString();
	}
	
    //결과값 정리 추후 수정 예정 
	@Override
	public int XMLParse(String xmlData, String resSeq) throws ParserConfigurationException, SAXException, IOException {
		// TODO Auto-generated method stub
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

	    if (n_list.getLength() > 0)
	    {
	      el = (Element)n_list.item(0).getChildNodes().item(0);
	      LOGGER.debug(el.getNodeName());

	      String response_date = el.getNodeName().toString();
	      String ConferenceId = null;
	      String Number = null;
	      String resSendResult = null;

	      if (response_date.equals("Schedule_Conference_Response")) {
	        sub_n_list = el.getChildNodes();
	        for (int k = 0; k < sub_n_list.getLength(); k++) {
	          sub_el = (Element)sub_n_list.item(k);

	          if (sub_el.getNodeName().equals("ReturnValue"))
	          {
	            if (sub_el.getFirstChild().getNodeValue().equals("OK")) {
	              NodeList n_list_conferenceDetail = root.getElementsByTagName("Report");
	              NodeList n_list_user = null;
	              Element confen_el = null;
	              for (int i = 0; i < n_list_conferenceDetail.getLength(); i++)
	              {
	                n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
		                for (int a = 0; a < n_list_user.getLength(); a++)
		                {
		                  confen_el = (Element)n_list_user.item(a);
		                  try {
		                    if (confen_el.getNodeName().equals("Success")) {
		                      resSendResult = confen_el.getFirstChild().getNodeValue().toString();
		                    }
		                    if (confen_el.getNodeName().equals("ConferenceId")) {
		                      ConferenceId = confen_el.getFirstChild().getNodeValue().toString();
		                    }
		                    if (confen_el.getNodeName().equals("Number")) {
		                      Number = confen_el.getFirstChild().getNodeValue().toString();
		                    }
		                  }
		                  catch (Exception localException1)
		                  {
		                  }
		                }
	              }
	              ResInfo resInfo = new ResInfo();
	              resInfo.setResSeq(resSeq);
	              resInfo.setConferenceId(ConferenceId);
	              resInfo.setConNumber(Number);
	              resInfo.setResSendResult(resSendResult);
	              this.resMapper.updateResManageChangeAvaya(resInfo);
	              ret = 1;
	            }
	          }
	        }

	      }
	      else if (response_date.equals("Cancel_Conference_Response")) {
	        sub_n_list = el.getChildNodes();
	        for (int k = 0; k < sub_n_list.getLength(); k++) {
	          sub_el = (Element)sub_n_list.item(k);

	          if (sub_el.getNodeName().equals("ReturnValue"))
	          {
	            if (sub_el.getFirstChild().getNodeValue().equals("OK"))
	            {
	              ret = 1;
	            }

	            NodeList n_list_conferenceDetail = root.getElementsByTagName("Report");
	            NodeList n_list_user = null;
	            Element confen_el = null;
	            for (int i = 0; i < n_list_conferenceDetail.getLength(); i++)
	            {
	              n_list_user = n_list_conferenceDetail.item(i).getChildNodes();

	              for (int a = 0; a < n_list_user.getLength(); a++) {
	                confen_el = (Element)n_list_user.item(a);
	                try {
	                  LOGGER.debug(confen_el.getNodeName() + ":" + confen_el.getFirstChild().getNodeValue().toString());
	                } catch (Exception e) {
	                  LOGGER.debug(confen_el.getNodeName() + ": null");
	                }
	              }
	            }
	          }
	        }
	      }
	    }
	    else {
	      LOGGER.debug("값 없음");
	      ret = 0;
	    }
	    return ret;
	}

	@Override
	public String generaterUuid(int num) throws Exception {
		// TODO Auto-generated method stub
		UUID uid = null;
	    for (int i = 1; i < num; i++) {
	      uid = UUID.randomUUID();
	    }
	    return uid.toString();
	}

	@Override
	public String avayaXmlString(String resSeq, String resGubun, String RequestID) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resInfo = resMapper.selectResManageView(resSeq);
	  	String reqReservationMessage = null;
	  	
	  	if (resGubun.equals("RES")){
	  	    
	  		LOGGER.debug("resInfo.getMeetingSeq().toString():" + resInfo.get("meeting_seq").toString());
	      	String[] attentInfo = resInfo.get("meeting_seq").toString().split(",");
	      	String BlockDialIn =  resInfo.get("con_blackdial").toString().equals("Y") ? "true" :"false";
	      	String SendingNotification = resInfo.get("con_sendnoti").equals("Y") ? "true" :"false";
	      	String AllowStreaming = resInfo.get("con_allowstream").equals("Y") ? "ON" :"OFF";
	      	String StreamingStatus = resInfo.get("con_allowstream").equals("Y") ? "ON" :"OFF";
	      	String RecordingMeetingWhenStart = resInfo.get("con_allowstream").equals("Y") ? "true" :"false";
	      	String servicePrefix = resInfo.get("meeting_name").toString().contains("가상") ? "72" : "71";
	      	
	  		reqReservationMessage =
	 				 "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
	 				 "<MCU_XML_API>" +
	 		         "<Request>"+
	 					 "<Schedule_Conference_Request>"+
	 					 "<RequestID>"+RequestID+"</RequestID>"+
	 					 "<Conference>"+
	 					 "	 <MemberId>999</MemberId>"+
	 					 "	 <UserId>"+ resInfo.get("avaya_confi_id") +"</UserId>"+
	 					 "	 <Number></Number>";
	  			            Encoder encoder = Base64.getEncoder(); 
	 				/*	if (!resInfo.getConPin().equals(""))
	 						reqReservationMessage +=  "	 <ConfPassword>"+resInfo.getConPin() +"</ConfPassword>";*/
	 					if (!resInfo.get("con_pin").equals("")){
	 						 byte[] targetBytes = resInfo.get("con_pin").toString().getBytes(); // Base64 인코딩 /////////////////////////////////////////////////// 
	 				  		String encodedString = encoder.encodeToString(targetBytes);
	 						reqReservationMessage +=   "	 <AccessPIN>"+encodedString +"</AccessPIN>";
	 					}
	 						
	 					if (! util.NVL(resInfo.get("con_virtual_pin"), "").equals("")){
	 						byte[]  targetBytesVir = resInfo.get("con_virtual_pin").toString().getBytes();
	 						String encodedStringVir = encoder.encodeToString(targetBytesVir);
	 						reqReservationMessage += "	  <ModeratorPIN>"+encodedStringVir+"</ModeratorPIN>";
	 					}
	 						
	 					
	 					reqReservationMessage +=   "	 <ServiceTemplateId>10001</ServiceTemplateId>"+		
	 					
	 					 //가상룸 일떄는 72 / 일반 71
	 					 "	 <ServicePrefix>"+servicePrefix+"</ServicePrefix>"+
	 					 "	 <Priority>DELAY</Priority>"+
	 				     //스트리밍 여부 ON/OFF/DISABLED
	 					 
	 				     
	 					 //"	 <AllowStreaming>"+ AllowStreaming +"</AllowStreaming>"+
	 					 "	 <StreamingStatus>"+ AllowStreaming +"</StreamingStatus> "+
	 					 /*"	 <AllowStreaming>OFF</AllowStreaming>"+
						 "	 <StreamingStatus>UNDEFINED</StreamingStatus> "+*/
	 				     //참석자 정보
	 				     //사용자 정보로 넣기 
	 				 /* "	 <Attendee>"+
						 "		 <TerminalId></TerminalId>"+
						 "		 <Protocol>H323</Protocol>"+
						 "		 <TerminalName></TerminalName>"+
						 "		 <TerminalNumber></TerminalNumber>"+
						 "		 <MaxBandwidth></MaxBandwidth>"+
						 "		 <MaxISDNBandwidth></MaxISDNBandwidth>"+
					     "		 <AreaCode></AreaCode>"+
						 "		 <CountryCode></CountryCode>"+
						 "		 <TelephoneNumber></TelephoneNumber>"+
						 "		 <RestrictedMode></RestrictedMode>"+
						 "		 <ThreeG>false</ThreeG>"+
						 "		 <VoiceOnly>false</VoiceOnly>"+
						 "		 <UserId>"+resInfo.getAvayaConfiId()+"</UserId>"+
						 "		 <FirstName></FirstName>"+
						 "		 <LastName>회의실</LastName>"+
						 "		 <Email>"+resInfo.getAvayaConfiId()+"@member999</Email>"+
						 "		 <Organizer>true</Organizer>"+
						 "		 <Host>true</Host>"+
						 "	 </Attendee>"+*/
	 				     "   <Attendee>"+
						 "		 <TerminalId>"+resInfo.get("terminal_id") +"</TerminalId>"+
						 "		 <Protocol>H323</Protocol>"+
						 "		 <TerminalName>"+ resInfo.get("avaya_userid") +"</TerminalName>"+
						 "		 <TerminalNumber>"+ resInfo.get("terminal_number") +"</TerminalNumber>"+
						"		 <MaxBandwidth>4096</MaxBandwidth>"+
						 "		 <MaxISDNBandwidth></MaxISDNBandwidth>"+
					     "		 <AreaCode></AreaCode>"+
						 "		 <CountryCode></CountryCode>"+
						 "		 <TelephoneNumber></TelephoneNumber>"+
						 "		 <RestrictedMode>false</RestrictedMode>"+
						 "		 <ThreeG>false</ThreeG>"+
						 "		 <VoiceOnly>false</VoiceOnly>"+
						 "		 <UserId></UserId>"+   					 
						"		 <FirstName>"+ resInfo.get("user_first_nm") +"</FirstName>"+
						 "		 <LastName>"+ resInfo.get("user_last_nm") +"</LastName>"+
						 "		 <Email>" + resInfo.get("user_email") + "</Email>"+
						 "		 <Host>false</Host>"+
						 "	 </Attendee>"+
	  		         "";
	  		
	 					
	     	             if (! util.NVL(resInfo.get("MEETING_SEQ"), "").equals("on") && !util.NVL(resInfo.get("MEETING_SEQ"), "").equals("")){
	     	            	 
		   					 for (int i =0; i < attentInfo.length; i ++){
		   					 Map<String, Object> meetingnfo = meetingMapper.selectMeetingRoomDetailInfoManage( attentInfo[i].toString() );
		   						 
		   					 
		                     reqReservationMessage +="	 <Attendee>"+
		   					 "		 <TerminalId>"+ meetingnfo.get("terminal_id") +"</TerminalId>"+
		   					 "		 <Protocol>H323</Protocol>"+
		   					 "		 <TerminalName>"+ meetingnfo.get("avaya_userid")  +"</TerminalName>"+
		   					 "		 <TerminalNumber>"+ meetingnfo.get("terminal_number") +"</TerminalNumber>"+
		   					 "		 <MaxBandwidth>4096</MaxBandwidth>"+
		   					 "		 <MaxISDNBandwidth></MaxISDNBandwidth>"+
		   				     "		 <AreaCode></AreaCode>"+
		   					 "		 <CountryCode></CountryCode>"+
		   					 "		 <TelephoneNumber></TelephoneNumber>"+
		   					 "		 <RestrictedMode>false</RestrictedMode>"+
		   					 "		 <ThreeG>false</ThreeG>"+
		   					 "		 <VoiceOnly>false</VoiceOnly>"+
		   					 "		 <UserId></UserId>"+
		   					 "		 <FirstName>"+ meetingnfo.get("user_first_nm") +"</FirstName>"+
		   					 "		 <LastName>"+ meetingnfo.get("user_last_nm")  +"</LastName>"+
		   					 "		 <Email>" + meetingnfo.get("USER_EMAIL") + "</Email>"+
		   					 "		 <Organizer>true</Organizer>"+
		   					 "		 <Host>false</Host>"+
		   					 "	 </Attendee>";
	                      }
	     	             }
	                     reqReservationMessage +="   <ReservedPorts>"+
	 					 "		<SD>0</SD>"+
	 					 "		<HD>0</HD>"+
	 					 "		<FullHD>0</FullHD>"+
	 					 "      <AudioOnlyWC>8</AudioOnlyWC>"+
	 					 "	</ReservedPorts>"+					 
	 					 "	<BlockDialIn>"+BlockDialIn+"</BlockDialIn>"+
	 					 //자동 연장 기본 기본 false"+ 
	 					 "	<AutoExtend>false</AutoExtend>"+
	 					 "	<WaitingRoom>false</WaitingRoom>"+					 
	 					 "	<AdvancedProperties>"+
	 					 "		<DurationAfterLeft>P0Y0M0DT0H10M0.000S</DurationAfterLeft>"+
	 					 "		<TerminationCondition>NORMAL</TerminationCondition>"+
	 			           //    최대 참가자 제한 "+					 
	 					 "		<MaxParticipants>250</MaxParticipants>"+
	 					 "		<MaxRoomParticipants>250</MaxRoomParticipants>"+
	 					 "	</AdvancedProperties>"+
	 					 //"	  핀코드 참가 허용  TRUE/false"+									 
	 					 "	<OneTimePINRequired>false</OneTimePINRequired>"+					 
	 					"	<Status></Status>"+
	 					"	<Subject>"+ resInfo.get("res_title") +"</Subject>"+
	 					"	<Description>"+ resInfo.get("res_title") +"</Description>"+
	 					
	 					"	<StartTime>"+ localTimeToUTC( resInfo.get("resdayinfo").toString())  +"</StartTime>"+
	 					//여기 부분 수정 
	 					/*"	<EventConference>"+RecordingMeetingWhenStart+"</EventConference> "+*/
	 					"	<TimeZoneId>Asia/Seoul</TimeZoneId>"+   					
	 					"	<Duration>"+ resInfo.get("resdurationt")  +"</Duration>"+
	 					"	<LocationId>0001</LocationId> "+										
	 					"	<TestOnly>false</TestOnly> "+				    
	 					//공지 여부 TRUE/false 
	 					"	<SendingNotification>"+SendingNotification+"</SendingNotification>"+ 
	 					//  자동 녹화 TRUE/false
	 					"	<RecordingMeetingWhenStart>"+RecordingMeetingWhenStart+"</RecordingMeetingWhenStart>"+
	 					/*"	<RecordingMeetingWhenStart>false</RecordingMeetingWhenStart>"+*/
	 					/*"	<Daily>"+
	 					"	 <NumberOfEveryDay>0</NumberOfEveryDay>"+
	 					"	 <EveryWeekDay>false</EveryWeekDay>"+
	 					"	</Daily>"+					
	 					"	<RecurrenceEnd>"+					
	 					"	 <EndOfOccurrences>10</EndOfOccurrences>"+
	 				          //종료 일자
	 					"	  <By>"+ localTimeToUTC( resInfo.getResDayEndInfo())  +"</By>"+
	 					"	 </RecurrenceEnd>"+*/
	 					"	 <TestRecurrConfScheduling>false</TestRecurrConfScheduling>"+
	 					"    <CSRSetting>" +
	 					"	   <Subject>"+ resInfo.get("res_title") +"</Subject>"+
	 					"	   <ProgrameId>"+generaterUuid(4)+"</ProgrameId>"+
	 					"	   <Public>false</Public>"+
	 					"	   <QandAEnabled>true</QandAEnabled>"+
	 					"      <AccessModeSetting>"+
	 					"      <AccessMode>AllUsers</AccessMode>"+
	 					"      </AccessModeSetting>"+
	 					"    </CSRSetting>" +
	 				    "</Conference>"+
	 				"</Schedule_Conference_Request>"+
	 		   "   </Request>"+
	         " </MCU_XML_API> ";    
	  	}else {
	  	  reqReservationMessage = 
	 				 "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
	 				 "<MCU_XML_API>" +
	 				 " <Request>"+
	 				 "   <Cancel_Conference_Request>"+
	 				 "   <RequestID>"+RequestID+"</RequestID>"+
	 				 "   <ConferenceId>"+ resInfo.get("conference_id") +"</ConferenceId>"+	
	 				 "   <Number>  </Number>"+		
	 				 "   <SendingNotification> false </SendingNotification>"+
	 				 "  </Cancel_Conference_Request>" +
	 				 " </Request>"+
	 				 "</MCU_XML_API>" ;
	  	}
	  	
	  	return reqReservationMessage;
	}
	
}
