package com.sohoki.backoffice.sym.sat.service.impl;

import java.io.StringReader;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import com.sohoki.backoffice.sym.avaya.mapper.AvayMessageManageMapper;
import com.sohoki.backoffice.sym.avaya.service.virturalConerenceInfo;
import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfo;
import com.sohoki.backoffice.sym.sat.vo.SeatInfo;
import com.sohoki.backoffice.sym.sat.vo.SeatInfoVO;
import com.sohoki.backoffice.sym.sat.service.SeatInfoManageService;
import com.sohoki.backoffice.sym.sat.mapper.SeatInfoManageMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class SeatInfoManageServiceImpl extends EgovAbstractServiceImpl implements SeatInfoManageService {

	@Autowired
	private SeatInfoManageMapper seatMapper;
	
	@Autowired
	private AvayMessageManageMapper avayaMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SeatInfoManageServiceImpl.class);
	
	
	@Override
	public List<SeatInfoVO> selectSeatManageListByPagination(SeatInfoVO searchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectSeatManageListByPagination(searchVO);
	}

	
	@Override
	public int selectSeatManageListTotCnt_S(SeatInfoVO searchVO)throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectSeatManageListTotCnt_S(searchVO);
	}

	@Override
	public int updateSeatManage(SeatInfo vo) throws Exception {
		// TODO Auto-generated method stub
		int ret = 0;
		if (vo.getMode().equals("Ins")){
			ret = seatMapper.insertSeatManage(vo);
		}else {
			ret = seatMapper.updateSeatManage(vo);
		}
		return ret;
	}
	@Override
	public int updateSeatAdminManage(SeatInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.updateSeatAdminManage(vo);
	}
	@Override
	public int deleteSeatManage(String seatId) throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.deleteSeatManage(seatId);
	}

	@Override
	public SeatInfoVO selectSeatManageView(String swcSeq) throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectSeatManageView(swcSeq);
	}

	@Override
	public List<SeatInfo> selectSeatManageCombo(SeatInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectSeatManageCombo(searchVO);
	}

	@Override
	public List<SeatInfoVO> selectSeatEmptyManageList(SeatInfoVO searchVO)
			throws Exception {
		// TODO Auto-generated method stub
		
		return seatMapper.selectSeatEmptyManageList(searchVO);
	}

	@Override
	public List<SeatInfoVO> selectSeatEmptyIntervalStatus(SeatInfoVO searchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectSeatEmptyIntervalStatus(searchVO);
	}

	@Override
	public List<SeatInfo> selectMeetingroomFloor() throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectMeetingroomFloor();
	}

	@Override
	public List<SeatInfoVO> selectRoomId(SeatInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectRoomId(searchVO);
	}
	
	@Override
	public List<SeatInfoVO> selectRoomSeat(SeatInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectRoomSeat(searchVO);
	}

	@Override
	public List<SeatInfoVO> selectRoomEquipmentList(SeatInfoVO searchVo)
			throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectRoomEquipmentList(searchVo);
	}


	@Override
	public List<SeatInfoVO> selectConferenceList(List swSeqList)
			throws Exception {
		// TODO Auto-generated method stub
		return seatMapper.selectConferenceList(swSeqList);
	}


	@Override
	public int updateSeatSycn() throws Exception {
		// TODO Auto-generated method stub
		virturalConerenceInfo conference = new virturalConerenceInfo();
		String RequestID = avayaMapper.selectRequestId();
		String xmlMessage = 
				"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
						 "<MCU_XML_API>" +
						 "<Request>"+
						 "<Get_Terminal_Request>"+
						 "<RequestID> "+RequestID+" </RequestID>"+
						 "<MemberId>999</MemberId>"+
						"</Get_Terminal_Request>"+
						 " </Request>"+
						 "</MCU_XML_API>" ;
						 
		String respomseMessage = conference.ayayaResSendMessage(xmlMessage);
		
		AvayaMessageInfo avaya = new AvayaMessageInfo();
		avaya.setRequestid(String.valueOf(RequestID));
		avaya.setReqMessage("Schedule_Conference_Request");
		avaya.setReqMessageTxt(xmlMessage);
		avaya.setResMessage("Schedule_Conference_Response");
		avaya.setResMessageTxt(respomseMessage);
		avayaMapper.insertAvayaInfoInsertManage(avaya);
	    int ret = XMLParse(respomseMessage);
		conference = null;
		
		return 0;
	}
	private int XMLParse(String xmlData )throws Exception{
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
			 sub_n_list = el.getChildNodes();
			 
			 for (int k =0; k < sub_n_list.getLength(); k++ ){
		    		sub_el = (Element) sub_n_list.item(k);
		    		//조회가 성공적으로 되었으면
		    		if (sub_el.getNodeName().equals("ReturnValue") && sub_el.getFirstChild().getNodeValue().equals("OK")){
		    			
		    			NodeList n_list_conferenceDetail = root.getElementsByTagName("Terminal");
		    			NodeList n_list_user = null;
		    			Element confen_el = null;
		    			for (int i = 0; i < n_list_conferenceDetail.getLength(); i++){
		    				
		    				n_list_user = n_list_conferenceDetail.item(i).getChildNodes();
		    				SeatInfo seatinfo = new SeatInfo(); 
		    				for (int a =0; a < n_list_user.getLength(); a++ ){
		    					
			    				confen_el = (Element)n_list_user.item(a);
			    				try{
			    					LOGGER.debug( confen_el.getNodeName() +":"+ confen_el.getFirstChild().getNodeValue().toString() );	
			    					if (confen_el.getNodeName().equals("TerminalId")){
			    						seatinfo.setTerminalId(confen_el.getFirstChild().getNodeValue().toString() );
			    					}else if (confen_el.getNodeName().equals("TerminalName")){
			    						seatinfo.setAvayaUserid(confen_el.getFirstChild().getNodeValue().toString());
			    					}else if (confen_el.getNodeName().equals("TerminalNumber")){
			    						seatinfo.setTerminalNumber(confen_el.getFirstChild().getNodeValue().toString());
			    					}
			    				}catch(Exception e){
			    					LOGGER.debug( confen_el.getNodeName() + ": null"); 
			    				}
			    				
			    			}
		    				ret = seatMapper.updateSeatSync(seatinfo);
		    				seatinfo = null;
		    				LOGGER.debug("----------------------------------------------------");   				
		    			}   			
		     	    }
		    	}
			 
		 }
		
    	
    return ret;	

	
	}
}
