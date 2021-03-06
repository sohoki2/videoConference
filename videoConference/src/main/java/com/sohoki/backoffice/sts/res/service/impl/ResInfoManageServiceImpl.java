package com.sohoki.backoffice.sts.res.service.impl;

import com.sohoki.backoffice.cus.kko.service.KkoMsgManageSevice;
import com.sohoki.backoffice.cus.org.mapper.EmpInfoManageMapper;
import com.sohoki.backoffice.cus.ten.service.TennantInfoManageService;
import com.sohoki.backoffice.sts.res.mapper.ResInfoManageMapper;
import com.sohoki.backoffice.sts.res.mapper.TimeInfoManageMapper;
import com.sohoki.backoffice.sts.res.service.ResInfoManageService;
import com.sohoki.backoffice.sts.res.vo.ResInfo;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sts.res.vo.TimeInfoVO;
import com.sohoki.backoffice.sym.avaya.mapper.AvayMessageManageMapper;
import com.sohoki.backoffice.sym.avaya.service.virturalConerenceInfoService;
import com.sohoki.backoffice.sym.avaya.vo.AvayaMessageInfo;
import com.sohoki.backoffice.sym.equ.mapper.EquipmentManageMapper;
import com.sohoki.backoffice.sym.equ.vo.EquipmentVO;
import com.sohoki.backoffice.sym.space.mapper.MeetingRoomInfoManageMapper;
import com.sohoki.backoffice.sym.space.service.MeetingRoomInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.transaction.Transactional;
import org.apache.commons.collections4.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResInfoManageServiceImpl extends EgovAbstractServiceImpl implements ResInfoManageService{
	
	
	
	
	  private static final Logger LOGGER = LoggerFactory.getLogger(ResInfoManageServiceImpl.class);
	
	  @Autowired
	  private ResInfoManageMapper resMapper;
	
	  @Autowired
	  private TimeInfoManageMapper timeMapper;
	
	  @Autowired
	  private AvayMessageManageMapper avayaMapper;
	
	  @Autowired
	  private EmpInfoManageMapper empMapper;
	  
	  @Autowired
	  private MeetingRoomInfoManageMapper meetingMapper;
	  
	  @Autowired
	  private MeetingRoomInfoManageService meetingService;
	  
	  @Autowired
	  private EquipmentManageMapper equpMapper;
	  
	  @Autowired
	  private SmartUtil util;
	  
	  @Autowired
	  private virturalConerenceInfoService conference;
	  
	  @Autowired
	  private TennantInfoManageService tennService;
	  
	  @Autowired
	  private UniSelectInfoManageService  uniService;
	  
	  @Autowired
	  private KkoMsgManageSevice kkoSerice;
	  
	  @Override
	  public List<Map<String, Object>> selectResManageListByPagination(Map<String, Object> searchVO)   throws Exception  {
		  return this.resMapper.selectResManageListByPagination(searchVO);
	  }
	  
	  // ?????? ?????? ?????????
	  @Override
	  public List<Map<String, Object>> selectIndexList( Map<String, Object> params)   throws Exception  {
	      return this.resMapper.selectIndexList(params);
	  }
	 
	  
	  
	  //?????? ??????  
	  @Transactional
	  @Override
	  public int insertResManage(ResInfoVO vo)   throws Exception{
		    
		    
		     
		  
		    int resSeq = 0;
		    Map<String, Object> timeinfo = new HashMap<String, Object>();
		    timeinfo.put("timeStartDay", vo.getResStartday());
		    timeinfo.put("strTime", vo.getResStarttime());
		    timeinfo.put("endTime",  vo.getResEndtime());
		    timeinfo.put("meetingId", vo.getItemId());
		    timeinfo.put("resGubun", vo.getResGubun());
		    
		    if (vo.getResGubun().equals("SWC_GUBUN_2")){
		    	//?????? ?????? ?????? ?????? ????????? ?????? ?????? ????????? ????????? ?????? ?????? ?????? 
		    	timeinfo.put("meetingSeq", util.dotToList(vo.getItemId() + "," + vo.getMeetingSeq())); 	
		    }
		    int resCnt  = 0;
		    
		    LOGGER.debug("vo.getResGubun()" + vo.getResGubun());
		    //??????/?????? ?????? ?????? ?????? 
		    if (vo.getResGubun().equals("SWC_GUBUN_3")) {
		    	//?????? ?????? ?????? ?????? 
		    	timeinfo.put("timeEndDay", vo.getResEndday());
		    	resCnt = this.timeMapper.selectResPreCheckInfoL1(timeinfo);
		    	
		    }else {
		    	resCnt = this.timeMapper.selectResPreCheckInfo(timeinfo);
		    }
		    // ?????? ?????? ?????? 
		    
		    int ret = 0;
		    
		    
		    if (resCnt == 0){
		    	
			    if (vo.getMeetingSeq().toString().equals("on")) {
			        vo.setMeetingSeq("");
			    }
			    // ?????? ????????? FLOOR_SEQ ?????? ?????? 
			    //?????? ???????????? ??? ?????? ???????????? ???????????? ????????????
			    
			    Map<String, Object> floorInfo = !vo.getItemGubun().equals("ITEM_GUBUN_2") ? uniService.selectFieldStatement("FLOOR_SEQ", "tb_meeting_room", "MEETING_ID=[" +vo.getItemId()+"[" )
			    		                                                                  : uniService.selectFieldStatement("FLOOR_SEQ", "tb_seatinfo", "SEAT_ID=[" +vo.getItemId()+"[" );
		        vo.setFloorSeq(floorInfo.get("floor_seq").toString());
			    ret = this.resMapper.insertResManage(vo);
			    resSeq = Integer.valueOf(vo.getResSeq()).intValue();
		        if (ret > 0){
			        vo.setResSeq(String.valueOf(resSeq));
			        //?????? ?????? ????????????
			        timeinfo.put("resSeq", String.valueOf(resSeq));
			        timeinfo.put("apprival", "R");
			        if (vo.getResGubun().equals("SWC_GUBUN_3")) {
		        	    this.timeMapper.updateTimeInfoL1(timeinfo);
			        }else {
			        	this.timeMapper.updateTimeInfo(timeinfo);
			        }
			        
			        
		        	if (vo.getSeatConfirmgubun().equals("Y")) {
			        	//????????? ?????? ?????? ?????? ?????? ?????? 
			        	boolean sendCk =   meetingService.sendMeetingEmpMessage(vo.getItemId(), vo);
			        	//?????? ?????? ????????? 
			        	
			        	//Map<String, Object> resInfo = resMapper.selectResManageView(vo.getResSeq());
			        	
			        }else {
			        	vo.setReservProcessGubun("PROCESS_GUBUN_2");
			        	vo.setResSeq(String.valueOf(resSeq));
			        	ret = updateResManageChange(vo);
			        }
			        
			    }else {
			    	 this.resMapper.errorResDateStep01(resSeq);
				     this.resMapper.errorResDateStep02(resSeq);
				     ret = -1;
			    }
	    }
	    else {
	    	// ????????? ?????????
	        //this.resMapper.errorResDateStep01(resSeq);
	        //this.resMapper.errorResDateStep02(resSeq);
	        ret = -3;
	    }
	    return ret;
	  }
	 
	  public int resEquipStateChange(ResInfoVO vo)   throws Exception{
		  
		    int ret = 0;
		    Map<String, Object> resInfo = resMapper.selectResManageView( vo.getResSeq());
			String resEqupcheck = "";
			EquipmentVO equpinfo = new EquipmentVO();
			List<String>preEquipList =  Arrays.asList(resInfo.get("res_equpinfo").toString().split("\\s*,\\s*"));  
			if (vo.getResEqupcheck().equals("EQUIP_STATE_5")){
				
				
				List<String>nowEquipList =  Arrays.asList(vo.getResEqupinfo().split("\\s*,\\s*"));  
				//?????? ?????? ?????? ?????? ?????? ??????
				
				
				equpinfo.setEquipState("EQUIP_STATE_1");
				equpinfo.setEqupList(nowEquipList);		
				equpinfo.setUserId("");
				equpinfo.setSwcSeq("0");
				equpinfo.setEqupOtdate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
				equpMapper.updateEqupManage_State(equpinfo);
				
				Collection<String>nowColls = CollectionUtils.subtract(preEquipList, nowEquipList);
				String equpList = "";
				for (String delList : nowColls){
					equpList += ","+delList;
				}
				vo.setResEqupinfo(equpList.substring(1));
				resEqupcheck = equpList.equals("") ? "RES_EQUPCHECK_1" : resInfo.get("RES_EQUPCHECK") .toString();
				vo.setResEqupcheck(resEqupcheck);
				ret = resMapper.updateResEquipChnageManage(vo);
				// ?????? ?????? ?????? 
				
			}else {
				//?????? ??????
				EquipStateChange(resInfo, vo.getResEqupcheck());
				equpinfo.setEquipState(vo.getResEqupcheck());
				equpinfo.setEqupList(preEquipList);
				int cnt = equpMapper.selectResEquipCnt(equpinfo);
				if (cnt <1){
					resEqupcheck = vo.getResEqupcheck().equals("EQUIP_STATE_2") ? "RES_EQUPCHECK_4" : "RES_EQUPCHECK_3";
					vo.setResEqupcheck(resEqupcheck);
					resMapper.updateResEquipChnageManage(vo);
				}	
			}
			
			//????????? ????????? ?????? ??? ????????? ??????
			return ret;
	}
	@Transactional
	@Override
	public int updateResManageChange(ResInfo vo) throws Exception {
		// TODO Auto-generated method stub
		TimeInfoVO info = new TimeInfoVO();
		info.setResSeq(vo.getResSeq());
		
		int ret = 0;
		String resCode = "";
		Map<String, Object> resInfo = null;
		try {
			
			Map<String, Object> tennInfo = new HashMap<String, Object>();
			LOGGER.debug("===============service" + vo.getReservProcessGubun());
			
			
			
			
			
			if (vo.getReservProcessGubun().equals("PROCESS_GUBUN_2") || vo.getReservProcessGubun().equals("PROCESS_GUBUN_4")){
					info.setApprival("Y");
					timeMapper.updateTimeInfoY(info);
					resCode = "RES";
					//?????? ?????????
					
					ret = resMapper.updateResManageChange(vo);
					//?????? ?????? ?????? ??????
					LOGGER.debug("?????? ??????  ------");
					LOGGER.debug("---------------- ????????? ?????? ?????? ??????  ------" + util.NVL(vo.getTennCnt(), "0"));
					if (ret > 0 && Integer.valueOf(util.NVL(vo.getTennCnt(), "0")) > 0) {
						
						
						tennInfo.put("userId",  vo.getUserId());
						tennInfo.put("resSeq",  vo.getResSeq());
						tennInfo.put("tennCnt",  vo.getTennCnt());
						
						LOGGER.debug("????????? ??????  ??????  ------");
						ret = tennService.insertTennantPlayManages(tennInfo);
						if (ret < 0) {
							throw new Exception();  
						}
					}
					resInfo = resMapper.selectResManageView(vo.getResSeq() );
					
					if (resInfo.get("send_message").equals("Y") ) {
						//????????? ????????? ????????? 
						kkoSerice.kkoMsgInsertSevice("RES", resInfo);
					}
					
			}else if (vo.getReservProcessGubun().equals("PROCESS_GUBUN_3") || vo.getReservProcessGubun().equals("PROCESS_GUBUN_5")
					|| vo.getReservProcessGubun().equals("PROCESS_GUBUN_6") || vo.getReservProcessGubun().equals("PROCESS_GUBUN_7")){
				
				    resCode = "CANCEL";
					info.setApprival("N");
					ret = resMapper.updateResManageChange(vo);
					//?????? ?????? ?????? ??????
					LOGGER.debug("?????? ??????  ------1");
					
					if (ret > 0) {
						resInfo = resMapper.selectResManageView(vo.getResSeq() );
						if (! util.NVL(resInfo.get("RES_EQUPINFO") , "").equals("")){
							EquipStateChange( resInfo, "EQUIP_STATE_1");
						}
						LOGGER.debug("?????? ??????  ------2");
						timeMapper.resTimeReset(info);
						//????????? ?????? ????????? ?????? ??? ??????
						if ( Integer.valueOf( util.NVL(resInfo.get("tenn_cnt"), "0")) > 0) {
							tennInfo.put("userId",  vo.getUserId());
						    tennInfo.put("resSeq",  vo.getResSeq());
						    ret = tennService.updateRetireTennantInfoManage(tennInfo);
						}
						LOGGER.debug("?????? ??????  ------3");
					}
					if (resInfo.get("send_message").equals("Y") && resInfo.get("item_gubun").equals("ITEM_GUBUN_3") ) {
						//????????? ????????? ????????? 
						kkoSerice.kkoMsgInsertSevice("CAN", resInfo);
					}
			}else if (vo.getReservProcessGubun().equals("PROCESS_GUBUN_8")) {
					info.setApprival("V");
					timeMapper.updateTimeInfoY(info);
					resCode = "VIEW";
					ret = resMapper.updateResManageChange(vo);
					resInfo = resMapper.selectResManageView(vo.getResSeq() );
			}
			// ???????????? ?????? ?????? 
			LOGGER.debug("------------------------------------------------------1");
			if (vo.getResGubun().equals("SWC_GUBUN_2")){
				//?????? ?????? ?????? ???????????? ????????? ??? ?????????
				int result = 0;
				String RequestID = avayaMapper.selectRequestId();
				String resXmlMessage = conference.avayaXmlString(String.valueOf( vo.getResSeq()), resCode, RequestID);
				String respomseMessage = conference.ayayaResSendMessage(resXmlMessage);
				AvayaMessageInfo avaya = new AvayaMessageInfo();
				avaya.setRequestid(String.valueOf(RequestID));
				avaya.setReqMessage("Schedule_Conference_Request");
				avaya.setReqMessageTxt(resXmlMessage);
				avaya.setResMessage("Schedule_Conference_Response");
				avaya.setResMessageTxt(respomseMessage);
				avayaMapper.insertAvayaInfoInsertManage(avaya);
				result = conference.XMLParse(respomseMessage, String.valueOf( vo.getResSeq()));
				if (result == 0 && vo.getResGubun().equals("SWC_GUBUN_2")){
					//????????? ?????? ??????(?????? ?????? ?????? ??????)
					//?????? ?????? ?????? ??? ?????? 
				}				
			}	
			LOGGER.debug("------------------------------------------------------2");
			//?????? ??? ????????? ??????(?????? ????????? ?????????
			//meetingService.sendMeetingUserMessage(resInfo);
			
			
		}catch(Exception e) {
			ret = -1;
			StackTraceElement[] ste = e.getStackTrace();
		    int lineNumber = ste[0].getLineNumber();
			LOGGER.error("updateResManageChange error:" + e.toString() + ":" + lineNumber );
			//?????? ?????? ?????? ?????? ?????? 
			if (resCode.equals("RES"))
			   this.resMapper.deleteResManage(vo.getResSeq());
		}
		
		return ret;
	}
	
	@Override
	public int deleteResManage(String resSeq) throws Exception{
	      return this.resMapper.deleteResManage(resSeq);
	}
	
	  
	// ?????? ??????  
	private int EquipStateChange(Map<String, Object> vo, String stateInfo) {
		    int ret = 0;
		    List equpList = util.dotToList(util.NVL(vo.get("res_equpinfo").toString(), ""));
		    EquipmentVO equpinfo = new EquipmentVO();
		    equpinfo.setEquipState(stateInfo);
		    equpinfo.setEqupList(equpList);
		    if (stateInfo.equals("EQUIP_STATE_1")) {
		      equpinfo.setUserId("");
		      equpinfo.setSwcSeq("0");
		      equpinfo.setEqupOtdate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		    } else {
		      equpinfo.setUserId(vo.get("user_id").toString());
		      equpinfo.setSwcSeq(vo.get("item_id").toString());
		      equpinfo.setEqupIndate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		    }
		    try
		    {
		      return this.equpMapper.updateEqupManage_State(equpinfo);
		    }
		    catch (Exception e) {
		      e.printStackTrace();
		    }
		    return ret;
	}
	
	@Override
	public int updateCancelReason(ResInfo vo)  throws Exception {
	    return this.resMapper.updateCancelReason(vo);
	}
	@Override
	public ResInfoVO selectCancelReason(String resSeq)  throws Exception{
	    return this.resMapper.selectCancelReason(resSeq);
	}
	@Override
	public int updateResManageDateChange(String resSeq) throws Exception{
	    return this.resMapper.updateResManageDateChange(resSeq);
	}
	@Override
	public ResInfoVO selectResUserInfo(String resSeq) throws Exception {
	    return this.resMapper.selectResUserInfo(resSeq);
	}
	@Override
	public int updateDayChange(ResInfo resInfo)  throws Exception {
	    return this.resMapper.updateDayChange(resInfo);
	}
	@Override 
	public Map<String, Object> selectResManageView(String resSeq) throws Exception {
	    return this.resMapper.selectResManageView(resSeq);
	}
	@Override
	public int updateResMeetingLog(ResInfo vo)  throws Exception {
	    return this.resMapper.updateResMeetingLog(vo);
	}
	
	@Override
	public List<ResInfoVO> selectCalenderInfo()  throws Exception  {
	    return this.resMapper.selectCalenderInfo();
	}
	@Override
	public List<ResInfoVO> selectCalenderDetailInfo(ResInfoVO searchVO)  throws Exception {
		  return this.resMapper.selectCalenderDetailInfo(searchVO);
	}
	  // ???????????? ?????? ?????? ??? ?????? ?????? 
	@Override
	public int updateResManageChangeAvaya(ResInfo vo) throws Exception{
	    return this.resMapper.updateResManageChangeAvaya(vo);
	}
	  
	  
	@Override
	public List<ResInfoVO> selectMessagentList()  throws Exception {
	    return this.resMapper.selectMessagentList();
	}
	
	@Override
	public int resStateChagenCheck(ResInfoVO resInfo) throws Exception {
		// TODO Auto-generated method stub
		return resMapper.resStateChagenCheck(resInfo);
	}
	
	@Override
	public List<Map<String, Object>> selectKioskCalendarList(String meetingId) {
		// TODO Auto-generated method stub
		return resMapper.selectKioskCalendarList(meetingId);
	}

	@Override
	public String selectTennInfo(ResInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return resMapper.selectTennInfo(vo);
	}

	@Override
	public List<ResInfoVO> selectCalenderMeetingState(ResInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return resMapper.selectCalenderMeetingState(searchVO);
	}
    //?????? ??????
	@Override
	public List<Map<String, Object>> selectNameplate() throws Exception {
		// TODO Auto-generated method stub
		return resMapper.selectNameplate();
	}

	@Override
	public Map<String, Object> selectTodayResSeatInfo(String empNo) throws Exception {
		// TODO Auto-generated method stub
		return resMapper.selectTodayResSeatInfo(empNo);
	}
	  
}