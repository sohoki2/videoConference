package egovframework.com.cmm.service;

import java.io.Serializable;

public class LoginLog  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String logId;
	private String connectId;
	private String connectIp;
	private String connectMthd;
	private String errorOccrrAt;
	private String errorCode;
	private String creatDt;	
	private String searchStartdday;
	private String searchEndday;
	private int pageIndex = 1;
	private int pageUnit = 10;
	private int pageSize = 10;
	private int firstIndex = 1;
	private int lastIndex = 1;
	private int recordCountPerPage = 10;
	private String searchCondition = "";
	private String searchKeyword = "";
	private String loginMthd = "";
	 
	
	
	
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getCreatDt() {
		return creatDt;
	}
	public void setCreatDt(String creatDt) {
		this.creatDt = creatDt;
	}
	public String getSearchStartdday() {
		return searchStartdday;
	}
	public void setSearchStartdday(String searchStartdday) {
		this.searchStartdday = searchStartdday;
	}
	public String getSearchEndday() {
		return searchEndday;
	}
	public void setSearchEndday(String searchEndday) {
		this.searchEndday = searchEndday;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public String getConnectId() {
		return connectId;
	}
	public void setConnectId(String connectId) {
		this.connectId = connectId;
	}
	public String getConnectIp() {
		return connectIp;
	}
	public void setConnectIp(String connectIp) {
		this.connectIp = connectIp;
	}
	public String getConnectMthd() {
		return connectMthd;
	}
	public void setConnectMthd(String connectMthd) {
		this.connectMthd = connectMthd;
	}
	public String getErrorOccrrAt() {
		return errorOccrrAt;
	}
	public void setErrorOccrrAt(String errorOccrrAt) {
		this.errorOccrrAt = errorOccrrAt;
	}
	
	
	@Override
	public String toString() {
		return "LoginLog [logId=" + logId + ", connectId=" + connectId
				+ ", connectIp=" + connectIp + ", connectMthd=" + connectMthd
				+ ", errorOccrrAt=" + errorOccrrAt + ", errorCode=" + errorCode
				+ ", creatDt=" + creatDt + ", searchStartdday="
				+ searchStartdday + ", searchEndday=" + searchEndday
				+ ", pageIndex=" + pageIndex + ", pageUnit=" + pageUnit
				+ ", pageSize=" + pageSize + ", firstIndex=" + firstIndex
				+ ", lastIndex=" + lastIndex + ", recordCountPerPage="
				+ recordCountPerPage + ", getLogId()=" + getLogId()
				+ ", getErrorCode()=" + getErrorCode() + ", getCreatDt()="
				+ getCreatDt() + ", getSearchStartdday()="
				+ getSearchStartdday() + ", getSearchEndday()="
				+ getSearchEndday() + ", getPageIndex()=" + getPageIndex()
				+ ", getPageUnit()=" + getPageUnit() + ", getPageSize()="
				+ getPageSize() + ", getFirstIndex()=" + getFirstIndex()
				+ ", getLastIndex()=" + getLastIndex()
				+ ", getRecordCountPerPage()=" + getRecordCountPerPage()
				+ ", getConnectId()=" + getConnectId() + ", getConnectIp()="
				+ getConnectIp() + ", getConnectMthd()=" + getConnectMthd()
				+ ", getErrorOccrrAt()=" + getErrorOccrrAt() + "]";
	}
	
	
	
	
	
	
	
	
	
	
	

}
