package com.sohoki.backoffice.cus.org.vo;

import java.io.Serializable;
public class OrgInfo implements Serializable {

	
	private static final long serialVersionUID = 1L;
	private String deptcode = "";
	private String deptname = "";
	private String searchKeyword = "";
	
	
	
	public String getDeptcode() {
		return deptcode;
	}
	public void setDeptcode(String deptcode) {
		this.deptcode = deptcode;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	
	
	
	
	
	
}
