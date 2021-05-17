package com.sohoki.backoffice.sts.iot.vo;


import java.io.Serializable;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfo;


public class InoutManageInfoVO extends InoutManageInfo implements Serializable  {

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    private String empNm;
    private String empNo;
    private String centerId;
    private String centerNm;
    private String coworkerYn;
    private String deptId;
    private String orgName;
    private String posGrdNm;
    private String seatName;
    
    private String searchCenterId;
    private String searchcoworkerYn;
    private String searchorgId;
    private String userId;
    private String searchStartDay;
    private String searchEndDay;
    private String resStarttime;
	private String resEndtime;
	private String regDate;
	private String resSeq;
	
	private String outUserNm;
	private String outUserTel;
	private String outUserOrgNm;
	
	private String searchDayGubun;
	private String searchOdr;
	
	private String proxyUserNm;
	private String proxyYn;
	
    
    //신규 추가 분
	private String resStartDay;
	private String resEndDay;
    
	
	
	
	
	public String getResStartDay() {
		return resStartDay;
	}
	public void setResStartDay(String resStartDay) {
		this.resStartDay = resStartDay;
	}
	public String getResEndDay() {
		return resEndDay;
	}
	public void setResEndDay(String resEndDay) {
		this.resEndDay = resEndDay;
	}
	public String getOutUserNm() {
		return outUserNm;
	}
	public void setOutUserNm(String outUserNm) {
		this.outUserNm = outUserNm;
	}
	public String getOutUserTel() {
		return outUserTel;
	}
	public void setOutUserTel(String outUserTel) {
		this.outUserTel = outUserTel;
	}
	public String getOutUserOrgNm() {
		return outUserOrgNm;
	}
	public void setOutUserOrgNm(String outUserOrgNm) {
		this.outUserOrgNm = outUserOrgNm;
	}
	public String getResSeq() {
		return resSeq;
	}
	public void setResSeq(String resSeq) {
		this.resSeq = resSeq;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getCenterNm() {
		return centerNm;
	}
	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}
	public String getResStarttime() {
		return resStarttime;
	}
	public void setResStarttime(String resStarttime) {
		this.resStarttime = resStarttime;
	}
	public String getResEndtime() {
		return resEndtime;
	}
	public void setResEndtime(String resEndtime) {
		this.resEndtime = resEndtime;
	}
	public String getSearchStartDay() {
		return searchStartDay;
	}
	public void setSearchStartDay(String searchStartDay) {
		this.searchStartDay = searchStartDay;
	}
	public String getSearchEndDay() {
		return searchEndDay;
	}
	public void setSearchEndDay(String searchEndDay) {
		this.searchEndDay = searchEndDay;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSearchCenterId() {
		return searchCenterId;
	}
	public void setSearchCenterId(String searchCenterId) {
		this.searchCenterId = searchCenterId;
	}
	public String getSearchcoworkerYn() {
		return searchcoworkerYn;
	}
	public void setSearchcoworkerYn(String searchcoworkerYn) {
		this.searchcoworkerYn = searchcoworkerYn;
	}
	public String getSearchorgId() {
		return searchorgId;
	}
	public void setSearchorgId(String searchorgId) {
		this.searchorgId = searchorgId;
	}
	public String getSeatName() {
		return seatName;
	}
	public void setSeatName(String seatName) {
		this.seatName = seatName;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getPosGrdNm() {
		return posGrdNm;
	}
	public void setPosGrdNm(String posGrdNm) {
		this.posGrdNm = posGrdNm;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSearchUseYn() {
		return searchUseYn;
	}
	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
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
	public String getEmpNm() {
		return empNm;
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getCoworkerYn() {
		return coworkerYn;
	}
	public void setCoworkerYn(String coworkerYn) {
		this.coworkerYn = coworkerYn;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getSearchDayGubun() {
		return searchDayGubun;
	}
	public void setSearchDayGubun(String searchDayGubun) {
		this.searchDayGubun = searchDayGubun;
	}
	public String getSearchOdr() {
		return searchOdr;
	}
	public void setSearchOdr(String searchOdr) {
		this.searchOdr = searchOdr;
	}
	public String getProxyUserNm() {
		return proxyUserNm;
	}
	public void setProxyUserNm(String proxyUserNm) {
		this.proxyUserNm = proxyUserNm;
	}
	public String getProxyYn() {
		return proxyYn;
	}
	public void setProxyYn(String proxyYn) {
		this.proxyYn = proxyYn;
	}
    
    
}
