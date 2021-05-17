package com.sohoki.backoffice.sym.avaya.service;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.impl.client.DefaultHttpClient;
import org.xml.sax.SAXException;

public interface virturalConerenceInfoService {

	//어바이어 UUID 생성
	String generaterUuid(int num)throws Exception;
	//어바이어 예약 전문 보내기 
	String avayaXmlString(String resSeq, String resGubun, String RequestID) throws Exception;
	//UTC 존 변경 
	String localTimeToUTC(String date) throws Exception;
	
	void XMLParse(String xmlData) throws ParserConfigurationException, SAXException, IOException;
	
	int XMLParse(String xmlData, String resSeq)  throws ParserConfigurationException, SAXException, IOException;
	
	void ayayaConnection () throws Exception;
	
	String ayayaResSendMessage (String xmlMessage ) throws Exception;
	
	HttpResponse executeString(DefaultHttpClient httpclient, String xmlMessage) throws Exception;
	
	HttpResponse execute(DefaultHttpClient httpclient) throws Exception;
	
	String output(HttpResponse response) throws ParseException, IOException ;
}
