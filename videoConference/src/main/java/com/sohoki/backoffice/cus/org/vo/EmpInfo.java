package com.sohoki.backoffice.cus.org.vo;

import java.io.Serializable;

import lombok.Data;


@Data
public class EmpInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
    private String empid = "";
    private String empno = "";
    private String empname = "";
    private String deptname = "";
    private String deptcode = "";
    private String empgrad = "";
    private String empgradcode = "";
    private String empjikw = "";
    private String empjikwcode = "";
    private String emphandphone = "";
    private String emptelphone = "";
    private String empmail = "";
    private String adminGubun = "";
    private String updateDate = "";
    private String avayaUserid = "";
    private String dtCoent = "";
    private String cdLvlgrd = "";
    private int cnt = 0;
    private String mode = "";
    private String authorCode = "";
    private String comCode = "";
    private String emp_state = "";
   

}
