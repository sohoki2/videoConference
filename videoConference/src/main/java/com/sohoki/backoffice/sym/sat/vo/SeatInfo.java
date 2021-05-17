package com.sohoki.backoffice.sym.sat.vo;


import java.io.Serializable;
public class SeatInfo implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	private String swcSeq;
	private String seatName;	
	private String centerId;
	private String centerPartid;
	
	private String roomName;
	               
	private String roomType;
	private String maxCnt;
	private String mode;
	private String swcUseyn;
	
	private String equipmentState;	
    private String frstRegisterId = "";
    private String frstRegistPnttm = "";
    
    private String lastUpdusrId   = "";
    private String lastUpdtPnttm   = "";
    
    private String userId = "";
    
    private String seatImg1 = "";
    private String seatImg2 = "";
    
    private String avayaConfiId = "";
    
    private String avayaUserid = "";
    private String terminalId = "";
    private String endName = "";
    private String terminalNumber = "";
    private String terminalTel = "";
    
    private String userFirstNm = "";
    private String userLastNm = "";
    private String userEmail = "";
    
    private String seatView = "";
    private String seatOrder = "";
   
    private String seatEqupgubun = "";
    private String seatConfirmgubun = "";
    private String seatAdminid = "";
    private String mailSendcheck = "";
    private String smsSendcheck = "";
    private String seatMainview = "";
    
    private String resMessageMail = "";
    private String resMessageSms = "";
    private String canMessageMail = "";
    private String canMessageSms = "";
    
    
    
    
    
 
	public String getResMessageMail() {
		return resMessageMail;
	}
	public void setResMessageMail(String resMessageMail) {
		this.resMessageMail = resMessageMail;
	}
	public String getResMessageSms() {
		return resMessageSms;
	}
	public void setResMessageSms(String resMessageSms) {
		this.resMessageSms = resMessageSms;
	}
	public String getCanMessageMail() {
		return canMessageMail;
	}
	public void setCanMessageMail(String canMessageMail) {
		this.canMessageMail = canMessageMail;
	}
	public String getCanMessageSms() {
		return canMessageSms;
	}
	public void setCanMessageSms(String canMessageSms) {
		this.canMessageSms = canMessageSms;
	}
	public String getSeatMainview() {
		return seatMainview;
	}
	public void setSeatMainview(String seatMainview) {
		this.seatMainview = seatMainview;
	}
	public String getMailSendcheck() {
		return mailSendcheck;
	}
	public void setMailSendcheck(String mailSendcheck) {
		this.mailSendcheck = mailSendcheck;
	}
	public String getSmsSendcheck() {
		return smsSendcheck;
	}
	public void setSmsSendcheck(String smsSendcheck) {
		this.smsSendcheck = smsSendcheck;
	}
	public String getSeatAdminid() {
		return seatAdminid;
	}
	public void setSeatAdminid(String seatAdminid) {
		this.seatAdminid = seatAdminid;
	}
	public String getSeatEqupgubun() {
		return seatEqupgubun;
	}
	public void setSeatEqupgubun(String seatEqupgubun) {
		this.seatEqupgubun = seatEqupgubun;
	}
	public String getSeatConfirmgubun() {
		return seatConfirmgubun;
	}
	public void setSeatConfirmgubun(String seatConfirmgubun) {
		this.seatConfirmgubun = seatConfirmgubun;
	}
	public String getSeatView() {
		return seatView;
	}
	public void setSeatView(String seatView) {
		this.seatView = seatView;
	}
	public String getSeatOrder() {
		return seatOrder;
	}
	public void setSeatOrder(String seatOrder) {
		this.seatOrder = seatOrder;
	}
	public String getAvayaUserid() {
		return avayaUserid;
	}
	public void setAvayaUserid(String avayaUserid) {
		this.avayaUserid = avayaUserid;
	}
	public String getTerminalId() {
		return terminalId;
	}
	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId;
	}
	public String getEndName() {
		return endName;
	}
	public void setEndName(String endName) {
		this.endName = endName;
	}
	public String getTerminalNumber() {
		return terminalNumber;
	}
	public void setTerminalNumber(String terminalNumber) {
		this.terminalNumber = terminalNumber;
	}
	public String getTerminalTel() {
		return terminalTel;
	}
	public void setTerminalTel(String terminalTel) {
		this.terminalTel = terminalTel;
	}
	public String getUserFirstNm() {
		return userFirstNm;
	}
	public void setUserFirstNm(String userFirstNm) {
		this.userFirstNm = userFirstNm;
	}
	public String getUserLastNm() {
		return userLastNm;
	}
	public void setUserLastNm(String userLastNm) {
		this.userLastNm = userLastNm;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getAvayaConfiId() {
		return avayaConfiId;
	}
	public void setAvayaConfiId(String avayaConfiId) {
		this.avayaConfiId = avayaConfiId;
	}
	public String getSeatImg1() {
		return seatImg1;
	}
	public void setSeatImg1(String seatImg1) {
		this.seatImg1 = seatImg1;
	}
	public String getSeatImg2() {
		return seatImg2;
	}
	public void setSeatImg2(String seatImg2) {
		this.seatImg2 = seatImg2;
	}
	public String getSwcSeq() {
		return swcSeq;
	}
	public void setSwcSeq(String swcSeq) {
		this.swcSeq = swcSeq;
	}
	public String getFrstRegistPnttm() {
		return frstRegistPnttm;
	}
	public void setFrstRegistPnttm(String frstRegistPnttm) {
		this.frstRegistPnttm = frstRegistPnttm;
	}
	public String getLastUpdtPnttm() {
		return lastUpdtPnttm;
	}
	public void setLastUpdtPnttm(String lastUpdtPnttm) {
		this.lastUpdtPnttm = lastUpdtPnttm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSeatName() {
		return seatName;
	}
	public void setSeatName(String seatName) {
		this.seatName = seatName;
	}
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getCenterPartid() {
		return centerPartid;
	}
	public void setCenterPartid(String centerPartid) {
		this.centerPartid = centerPartid;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public String getMaxCnt() {
		return maxCnt;
	}
	public void setMaxCnt(String maxCnt) {
		this.maxCnt = maxCnt;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getSwcUseyn() {
		return swcUseyn;
	}
	public void setSwcUseyn(String swcUseyn) {
		this.swcUseyn = swcUseyn;
	}
	public String getEquipmentState() {
		return equipmentState;
	}
	public void setEquipmentState(String equipmentState) {
		this.equipmentState = equipmentState;
	}
	public String getFrstRegisterId() {
		return frstRegisterId;
	}
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}
	
	
	
}
