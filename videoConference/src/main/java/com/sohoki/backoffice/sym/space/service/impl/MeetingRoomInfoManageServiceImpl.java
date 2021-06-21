package com.sohoki.backoffice.sym.space.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.cus.org.mapper.EmpInfoManageMapper;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;
import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sym.space.mapper.MeetingRoomInfoManageMapper;
import com.sohoki.backoffice.sym.space.service.MeetingRoomInfoManageService;
import com.sohoki.backoffice.sym.space.vo.MeetingRoomInfo;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.mapper.UniSelectInfoManageMapper;
import com.sohoki.backoffice.util.service.fileService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;


@Service
public class MeetingRoomInfoManageServiceImpl  extends EgovAbstractServiceImpl implements MeetingRoomInfoManageService{

	private static final Logger LOGGER = LoggerFactory.getLogger(MeetingRoomInfoManageServiceImpl.class);
	
	
	@Autowired
	private MeetingRoomInfoManageMapper meetingMapper;
	
	@Autowired
	private EmpInfoManageMapper empMapper;
	
	@Autowired
	private ResInfoManageMapper resMapper;
	
	@Autowired
	private SmartUtil util;
	
	@Autowired
    protected EgovPropertyService propertiesService;
	
	@Autowired
	private UniSelectInfoManageMapper uniMapper;
	
	@Autowired
	private fileService fileservice;

	@Override
	public List<Map<String, Object>> selectMeetingRoomManageListByPagination(Map<String, Object> params)throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectMeetingRoomManageListByPagination(params);
	}
	//대관 시설 콤보 박스 
	@Override
	public List<Map<String, Object>> selectMeetingRoomTypeList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectMeetingRoomTypeList(params);
	}

	@Override
	public List<Map<String, Object>> selectMeetingRoomEmptyManageList(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectMeetingRoomEmptyManageList(params);
	}

	@Override
	public List<Map<String, Object>> selectMeetingRoomEmptyIntervalStatus(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectMeetingRoomEmptyIntervalStatus(params);
	}

	@Override
	public List<Map<String, Object>> selectMeetingRoomManageCombo(String centerId) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectMeetingRoomManageCombo(centerId);
	}

	@Override
	public List<Map<String, Object>> selectConferenceList(List meetingList) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectConferenceList(meetingList);
	}

	@Override
	public Map<String, Object> selectMeetingRoomDetailInfoManage(String meetingId) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectMeetingRoomDetailInfoManage(meetingId);
	}

	@Override
	public List<Map<String, Object>> selectMeetingRoomId(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.selectMeetingRoomId(params);
	}

	@Override
	public int updateMeetingRoomManage(MeetingRoomInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return vo.getMode().equals("Ins") ? meetingMapper.insertMeetingRoomManage(vo) : meetingMapper.updateMeetingRoomManage(vo);
	}

	@Override
	public int updateMeetingRoomAdminManage(MeetingRoomInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.updateMeetingRoomAdminManage(vo);
	}

	@Override
	public int updateMeetingRoomSync(MeetingRoomInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return meetingMapper.updateMeetingRoomSync(vo);
	}
    //회의실 담당자에게 메일 전송
	@Override
	public boolean sendMeetingEmpMessage( String meetingId, ResInfo info) throws Exception {
		// TODO Auto-generated method stub
		boolean result = false;
		try {
			Map<String, Object> meetingInfo = meetingMapper.selectMeetingRoomDetailInfoManage( meetingId );
			if (meetingInfo.get("meeting_confirmgubun").equals("Y") && !meetingInfo.get("meeting_adminid").equals("") && !meetingInfo.get("meeting_confirmgubun").equals("메세지 없음")) {
				 //메일 전송 
				 //담당자가 한명일찌 두명 일찌 확인 필요
				 List<String> empInIds = util.dotToList(meetingInfo.get("MEETING_ADMINID").toString());
				 for (String empId : empInIds ) {
					  EmpInfo adminInfo = empMapper.selectEmpInfoDetailNo(empId); 
		   		      
		   			  String strTitle = String.format(meetingInfo.get("resmessagemailtxt").toString(), info.getResTitle())  ;
		       		  String strMessage = String.format(meetingInfo.get("resmessagemailcontexttxt").toString(),  info.getResTitle() , info.getResStartday() , info.getResStarttime(), info.getResEndtime());
		       		  
		       		  LOGGER.debug("strTitle:" + strTitle + ":" +strMessage );
		       		  result = util.sendMail(strTitle ,  strMessage, adminInfo.getEmpmail(), adminInfo.getEmpname(), adminInfo.getEmpmail());
		       		  if (result == false)
		       			   break;
		         }
			}else {
				result = true;
			}
		}catch(Exception e) {
			LOGGER.error("sendMeetingEmpMessage error:" + e.toString());
		}
		return result;
	}

	@Override
	public boolean sendMeetingUserMessage(Map<String, Object>  resInfo) throws Exception {
		// TODO Auto-generated method stub
		boolean result = false;
		try {
			
			Map<String, Object> meetingInfo = meetingMapper.selectMeetingRoomDetailInfoManage( resInfo.get("item_id").toString() );
			String strTitle = "";
			String strMessage = "";
			String strSMS  = "";
			
			if ((resInfo.get("reserv_process_gubun").equals("PROCESS_GUBUN_1")) || 
				(resInfo.get("reserv_process_gubun").equals("PROCESS_GUBUN_2")) || 
				(resInfo.get("reserv_process_gubun").equals("PROCESS_GUBUN_4"))) {
		         //예약 메세지
				  strTitle = String.format(meetingInfo.get("resmessagemailtxt").toString(),resInfo.get("res_title").toString())  ;
	       		  strMessage = String.format(meetingInfo.get("resmessagemailcontexttxt").toString(), resInfo.get("res_title").toString() , resInfo.get("resstartday")  ,  resInfo.get("resstarttime"), resInfo.get("resendtime"));
	       		  strSMS =   String.format(meetingInfo.get("resmessagesmstxt").toString(),  resInfo.get("res_title").toString() , resInfo.get("resStartday") , resInfo.get("resStarttime") , resInfo.get("resendtime"));
	       		  
		      } else if ((resInfo.get("reserv_process_gubun").equals("PROCESS_GUBUN_3")) || 
		    		     (resInfo.get("reserv_process_gubun").equals("PROCESS_GUBUN_5")) || 
		                 (resInfo.get("reserv_process_gubun").equals("PROCESS_GUBUN_6")) || 
		                 (resInfo.get("reserv_process_gubun").equals("PROCESS_GUBUN_7"))){
		    	  
		    	  //취소 메세지 
		    	  strTitle = String.format(meetingInfo.get("canmessagemailtxt").toString(), resInfo.get("res_title").toString())  ;
		       	  strMessage = String.format(meetingInfo.get("resmessagemailcontexttxt").toString(), resInfo.get("res_title").toString() , resInfo.get("resstartday")  ,  resInfo.get("resstarttime"), resInfo.get("resendtime"));
		       	  strSMS =   String.format(meetingInfo.get("canmessagesmstxt").toString(),  resInfo.get("res_title").toString() , resInfo.get("resStartday") , resInfo.get("resStarttime") , resInfo.get("resendtime"));
		       	   
		     }
			
			 util.sendSMS(strTitle, strMessage, resInfo.get("empmail").toString(), resInfo.get("empname").toString(), 
						     resInfo.get("empmail").toString(),resInfo.get("mail_sendcheck").toString(), 
						     resInfo.get("emphandphone").toString(),  resInfo.get("emphandphone").toString(), 
						     resInfo.get("sms_sendcheck").toString(), strSMS);
				 
			 String[] messangetoUrlList = resInfo.get("res_attendlist").toString().split(",");
			 for (int a = 0; a < messangetoUrlList.length; a++) {
			    	 // 여기 부분 다시 확인 하기 
			    	 util.sendSMS(strTitle, strMessage, messangetoUrlList[a].toString(), resInfo.get("empname").toString(), 
							     resInfo.get("empmail").toString(),resInfo.get("mail_sendcheck").toString(), 
							     resInfo.get("emphandphone").toString(),  resInfo.get("emphandphone").toString(), 
							     resInfo.get("sms_sendcheck").toString(), strSMS);
			 }
				 
			
		}catch(Exception e) {
			LOGGER.error("sendMeetingEmpMessage error:" + e.toString());
		}
		return result;
	}

	@Override
	public int deleteMeetingRoomManage(List<String> meetinglist) throws Exception {
		// TODO Auto-generated method stub
		// 파일 삭제 구문 추가
		for (String meetingId : meetinglist) {
			Map<String, Object> fileInfo = uniMapper.selectFieldStatement("MEETING_IMG1, MEETING_IMG2", "tb_meeting_room", "MEETING_ID=["+ meetingId +"[");
			if (fileInfo != null ) {
				List column = util.dotToList("MEETING_IMG1, MEETING_IMG2");
				column.forEach(target->{
					if (fileInfo.get(target)!= null)
						try {
							fileservice.deleteFile(fileInfo.get(target).toString(), propertiesService.getString("Globals.filePath"));
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				});
			}
		}
		LOGGER.debug("size:" + meetinglist.size());
		return meetingMapper.deleteMeetingRoomManage(meetinglist);
	}

	
	
}
