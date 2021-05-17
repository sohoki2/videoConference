package com.sohoki.backoffice.cus.org.vo;

import java.io.Serializable;

public class jobInfo implements Serializable  {
	
	private static final long serialVersionUID = 1L;
	
	
	private String empjikwcode = "";
	private String empjikw = "";
	private String sortOrde = "";

	
	
	public String getSortOrde() {
		return sortOrde;
	}
	public void setSortOrde(String sortOrde) {
		this.sortOrde = sortOrde;
	}
	public String getEmpjikwcode() {
		return empjikwcode;
	}
	public void setEmpjikwcode(String empjikwcode) {
		this.empjikwcode = empjikwcode;
	}
	public String getEmpjikw() {
		return empjikw;
	}
	public void setEmpjikw(String empjikw) {
		this.empjikw = empjikw;
	}
	
	
	
	
	
	
	
	
}
