package com.sohoki.backoffice.sym.avaya.service;


import java.io.IOException;
import java.io.StringReader;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.StatusLine;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.NTLMSchemeFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import egovframework.rte.fdl.property.EgovPropertyService;
import java.net.URL;
import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.security.cert.CertificateEncodingException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;


public class virturalConerenceInfo {

	
	
	@Autowired
	protected static EgovPropertyService propertiesService;
	
	
	//propertiesService.get
	;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(virturalConerenceInfo.class);
	
	
	// 외 그런지 한번 확인 필요
	 //주소
	private static String SERVER_HOST =  "10.10.5.170"; //propertiesService.getString("avayaServer");
	protected static int PORT = 8080; //propertiesService.getInt("avayaPort");
	protected static String SERVICE_RUL = "http://" + SERVER_HOST + ":" + PORT +"/xmlservice/entry" ;
	protected static String USER_NAME = "slc";// propertiesService.getString("avayaID") ;
	protected static String PASSWORD = "Arisys123$";// propertiesService.getString("avayaPassword") ;

	
	public static void XMLParse(String xmlData) throws ParserConfigurationException, SAXException, IOException{
		
		
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
	
	public static void ayayaConnection () throws Exception{
		
		
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
	public static String ayayaResSendMessage (String xmlMessage ) throws Exception{
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
	private static HttpResponse executeString(DefaultHttpClient httpclient, String xmlMessage) throws Exception {
		 
		 httpclient.getCredentialsProvider().setCredentials(
				 new AuthScope(SERVER_HOST, PORT),new UsernamePasswordCredentials(USER_NAME, PASSWORD));
		 HttpResponse response = null;
        try{
       	 HttpEntity body = new StringEntity(xmlMessage, "UTF-8") ;
   		 HttpPost httpPost = new HttpPost(SERVICE_RUL) ;
   		 httpPost.setEntity(body);
   		 response = httpclient.execute(httpPost);	 
        }catch(Exception e){
       	 LOGGER.debug("error:" + e.toString());
        }
		 
		 return response ;
	}
	private static HttpResponse execute(DefaultHttpClient httpclient) throws Exception {
		 httpclient.getCredentialsProvider().setCredentials(
				 new AuthScope(SERVER_HOST, PORT),new UsernamePasswordCredentials(USER_NAME, PASSWORD));
		 
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
    		 HttpPost httpPost = new HttpPost(SERVICE_RUL) ;
    		 httpPost.setEntity(body);
    		 response = httpclient.execute(httpPost);	 
         }catch(Exception e){
        	 LOGGER.debug("error:" + e.toString());
         }
		 
		 return response ;
	}
	private static String output(HttpResponse response) throws ParseException, IOException {
		 HttpEntity entity = response.getEntity();		 
		 return EntityUtils.toString(entity).toString();
		
	}
	
}
