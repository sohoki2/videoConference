package com.sohoki.backoffice.sts.iot.vo;


import java.io.Serializable;
public class InoutManageInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String resSeq;
	private String attSeq;
	private String userId;
	private String resDay;
	private String roomIntime;
	private String roomOttime;	
	private String login;
	private String logout;
	private String pcPassword;
	private String mode;
	private String seatId;
	private String empNo;
	private String empNm;
	
	
	
	
	
	public String getEmpNm() {
		return empNm;
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getSeatId() {
		return seatId;
	}
	public void setSeatId(String seatId) {
		this.seatId = seatId;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getResSeq() {
		return resSeq;
	}
	public void setResSeq(String resSeq) {
		this.resSeq = resSeq;
	}
	public String getAttSeq() {
		return attSeq;
	}
	public void setAttSeq(String attSeq) {
		this.attSeq = attSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getResDay() {
		return resDay;
	}
	public void setResDay(String resDay) {
		this.resDay = resDay;
	}
	public String getRoomIntime() {
		return roomIntime;
	}
	public void setRoomIntime(String roomIntime) {
		this.roomIntime = roomIntime;
	}
	public String getRoomOttime() {
		return roomOttime;
	}
	public void setRoomOttime(String roomOttime) {
		this.roomOttime = roomOttime;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getLogout() {
		return logout;
	}
	public void setLogout(String logout) {
		this.logout = logout;
	}
	public String getPcPassword() {
		return pcPassword;
	}
	public void setPcPassword(String pcPassword) {
		this.pcPassword = pcPassword;
	}
	
	
	
	
	
	
	
	
}
