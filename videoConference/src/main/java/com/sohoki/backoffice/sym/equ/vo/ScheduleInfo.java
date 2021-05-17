package com.sohoki.backoffice.sym.equ.vo;

import java.io.Serializable;

public class ScheduleInfo  implements Serializable  {

	
	private static final long serialVersionUID = 1L;
	
	private String schSeq = "";
	private String schResult = "";
	private String schResultmessage = "";
	private String schResultregdate = "";
	
	
	
	
	
	public String getSchSeq() {
		return schSeq;
	}
	public void setSchSeq(String schSeq) {
		this.schSeq = schSeq;
	}
	public String getSchResult() {
		return schResult;
	}
	public void setSchResult(String schResult) {
		this.schResult = schResult;
	}
	public String getSchResultmessage() {
		return schResultmessage;
	}
	public void setSchResultmessage(String schResultmessage) {
		this.schResultmessage = schResultmessage;
	}
	public String getSchResultregdate() {
		return schResultregdate;
	}
	public void setSchResultregdate(String schResultregdate) {
		this.schResultregdate = schResultregdate;
	}
	
	
	

}
