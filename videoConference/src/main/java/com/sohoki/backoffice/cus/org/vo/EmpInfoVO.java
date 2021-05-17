package com.sohoki.backoffice.cus.org.vo;

import com.sohoki.backoffice.cus.org.vo.EmpInfo;

import java.io.Serializable;
import java.util.List;

public class EmpInfoVO extends EmpInfo implements  Serializable{

	
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
    
    
    
	private String posGrdNm = "";
    private String cdDept = "";
    private String code = "";
    private String returnUrl = "";
    private String mode = "";
    private String admin = "";
    private String totalRecordCount = "";
    private String searchAvayaCheck = "";
    private String searchJobpst = "";
    private String jobNm = "";
    private String orgName = "";
    private String searchSwcEmpNo = "";
    private String searchcenterId = "";
    private String sortOrde = ""; // SORT_ORDE
    
    
	public String getSortOrde() {
		return sortOrde;
	}

	public void setSortOrde(String sortOrde) {
		this.sortOrde = sortOrde;
	}

	public String getSearchcenterId() {
		return searchcenterId;
	}

	public void setSearchcenterId(String searchcenterId) {
		this.searchcenterId = searchcenterId;
	}

	public String getSearchSwcEmpNo() {
		return searchSwcEmpNo;
	}

	public void setSearchSwcEmpNo(String searchSwcEmpNo) {
		this.searchSwcEmpNo = searchSwcEmpNo;
	}

	public String getJobNm() {
		return jobNm;
	}

	public void setJobNm(String jobNm) {
		this.jobNm = jobNm;
	}

	

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getSearchJobpst() {
		return searchJobpst;
	}

	public void setSearchJobpst(String searchJobpst) {
		this.searchJobpst = searchJobpst;
	}

	public String getSearchAvayaCheck() {
		return searchAvayaCheck;
	}

	public void setSearchAvayaCheck(String searchAvayaCheck) {
		this.searchAvayaCheck = searchAvayaCheck;
	}

	public String getCdDept() {
		return cdDept;
	}

	public void setCdDept(String cdDept) {
		this.cdDept = cdDept;
	}

	public String getTotalRecordCount() {
		return totalRecordCount;
	}

	public void setTotalRecordCount(String totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}

	public String getReturnUrl() {
		return returnUrl;
	}

	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}
    
    
    
    
}
