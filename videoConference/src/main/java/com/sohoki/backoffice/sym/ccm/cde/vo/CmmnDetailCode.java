package com.sohoki.backoffice.sym.ccm.cde.vo;

import java.io.Serializable;

public class CmmnDetailCode implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/*
	 * 분류코드
	 */
	private String clCode = "";

	/*
	 * 분류코드명
	 */
	private String clCodeNm = "";
	
	/*
	 * 코드ID
	 */
    private String codeId = "";

    /*
     * 코드ID명
     */
    private String codeIdNm = "";

    /*
     * 코드
     */
	private String code = "";

	/*
	 * 코드명
	 */
    private String codeNm = "";

    /*
     * 코드설명
     */
    private String codeDc = "";

    /*
     * 사용여부
     */
    private String useAt = "";

    /*
     * 최초등록자ID
     */
    private String frstRegisterId = "";

    /*
     * 최종수정자ID
     */
    private String lastUpdusrId   = "";

    
    private String mode = "";
    
    private String menuGubun = "";	
    
    private String searchCodedc = "";
    
    
    
    
    
	public String getSearchCodedc() {
		return searchCodedc;
	}

	public void setSearchCodedc(String searchCodedc) {
		this.searchCodedc = searchCodedc;
	}

	public String getMenuGubun() {
		return menuGubun;
	}

	public void setMenuGubun(String menuGubun) {
		this.menuGubun = menuGubun;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * codeId attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeId() {
		return codeId;
	}

	/**
	 * codeId attribute 값을 설정한다.
	 * @param codeId String
	 */
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}

	/**
	 * codeIdNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeIdNm() {
		return codeIdNm;
	}

	/**
	 * codeIdNm attribute 값을 설정한다.
	 * @param codeIdNm String
	 */
	public void setCodeIdNm(String codeIdNm) {
		this.codeIdNm = codeIdNm;
	}

	/**
	 * code attribute 를 리턴한다.
	 * @return String
	 */
	public String getCode() {
		return code;
	}

	/**
	 * code attribute 값을 설정한다.
	 * @param code String
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * codeNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeNm() {
		return codeNm;
	}

	/**
	 * codeNm attribute 값을 설정한다.
	 * @param codeNm String
	 */
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}

	/**
	 * codeDc attribute 를 리턴한다.
	 * @return String
	 */
	public String getCodeDc() {
		return codeDc;
	}

	/**
	 * codeDc attribute 값을 설정한다.
	 * @param codeDc String
	 */
	public void setCodeDc(String codeDc) {
		this.codeDc = codeDc;
	}

	/**
	 * useAt attribute 를 리턴한다.
	 * @return String
	 */
	public String getUseAt() {
		return useAt;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt String
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * frstRegisterId attribute 를 리턴한다.
	 * @return String
	 */
	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId String
	 */
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	/**
	 * lastUpdusrId attribute 를 리턴한다.
	 * @return String
	 */
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId String
	 */
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	/**
	 * clCode attribute 를 리턴한다.
	 * @return String
	 */
	public String getClCode() {
		return clCode;
	}

	/**
	 * clCode attribute 값을 설정한다.
	 * @param clCode String
	 */
	public void setClCode(String clCode) {
		this.clCode = clCode;
	}

	/**
	 * clCodeNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getClCodeNm() {
		return clCodeNm;
	}

	/**
	 * clCodeNm attribute 값을 설정한다.
	 * @param clCodeNm String
	 */
	public void setClCodeNm(String clCodeNm) {
		this.clCodeNm = clCodeNm;
	}

}
