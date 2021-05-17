package com.sohoki.backoffice.sym.equ.vo;

import java.io.Serializable;

public class Equipment implements Serializable  {

	
	private static final long serialVersionUID = 1L;
	
	
	private String equpCode = "";
	private String equipmentId = "";
	private String equipmentName = "";
	private String centerId = "";
	private String swcSeq = "";
	private String userId = "";
	private String regDate = "";
	private String company = "";
	private String remark = "";
	private String useYn = "";
	private String mode = "";
	private String equpIndate = "";
	private String equpOtdate = "";
	private String equipState = "";
	private String equipImg = "";
	private String equipSerial = "";
	
	
	
	
	
	public String getEquipSerial() {
		return equipSerial;
	}
	public void setEquipSerial(String equipSerial) {
		this.equipSerial = equipSerial;
	}
	public String getEquipImg() {
		return equipImg;
	}
	public void setEquipImg(String equipImg) {
		this.equipImg = equipImg;
	}
	
	public String getEquipState() {
		return equipState;
	}
	public void setEquipState(String equipState) {
		this.equipState = equipState;
	}
	public String getEqupOtdate() {
		return equpOtdate;
	}
	public void setEqupOtdate(String equpOtdate) {
		this.equpOtdate = equpOtdate;
	}
	public String getEqupIndate() {
		return equpIndate;
	}
	public void setEqupIndate(String equpIndate) {
		this.equpIndate = equpIndate;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getEqupCode() {
		return equpCode;
	}
	public void setEqupCode(String equpCode) {
		this.equpCode = equpCode;
	}
	public String getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}
	public String getEquipmentName() {
		return equipmentName;
	}
	public void setEquipmentName(String equipmentName) {
		this.equipmentName = equipmentName;
	}
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getSwcSeq() {
		return swcSeq;
	}
	public void setSwcSeq(String swcSeq) {
		this.swcSeq = swcSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	
}
