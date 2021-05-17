package com.sohoki.backoffice.uat.uia.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class AdminInfo implements Serializable {

	
	private String adminId;
	private String adminName;
	private String adminPassword;
	private String adminEmail;
	private String adminTel;
	private String regDate;
	private String updatePassword;
	private String authorCode = "";
	private String lockYn;
	private String useYn;
	private String mode;
	private String empNo;
	private String deptId = "";
	private String deptName = "";
	private String empjikw = "";
	private String empjkwcode = "";

	
	
}
