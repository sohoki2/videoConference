package com.sohoki.backoffice.sts.res.vo;

import java.io.Serializable;

import com.sohoki.backoffice.sts.res.vo.TimeInfo;

public class TimeInfoVO extends TimeInfo implements Serializable {
	
	
	
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
    
    
    private String timeEmpty;
    private String timeStartDay;
    private String timeEndDay;
    
    private String strTime;    
    private String endTime;
    private String resPossible;
    private String holDtYn;
    private String endTimeR;
    private String seatEqupgubun = "";
    private String seatConfirmgubun = ""; 
    
    
    

    
	public String getSeatEqupgubun() {
		return seatEqupgubun;
	}

	public void setSeatEqupgubun(String seatEqupgubun) {
		this.seatEqupgubun = seatEqupgubun;
	}

	public String getSeatConfirmgubun() {
		return seatConfirmgubun;
	}

	public void setSeatConfirmgubun(String seatConfirmgubun) {
		this.seatConfirmgubun = seatConfirmgubun;
	}

	public String getEndTimeR() {
		return endTimeR;
	}

	public void setEndTimeR(String endTimeR) {
		this.endTimeR = endTimeR;
	}

	public String getHolDtYn() {
		return holDtYn;
	}

	public void setHolDtYn(String holDtYn) {
		this.holDtYn = holDtYn;
	}

	public String getResPossible() {
		return resPossible;
	}

	public void setResPossible(String resPossible) {
		this.resPossible = resPossible;
	}

	public String getStrTime() {
		return strTime;
	}

	public void setStrTime(String strTime) {
		this.strTime = strTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getTimeEmpty() {
		return timeEmpty;
	}

	public void setTimeEmpty(String timeEmpty) {
		this.timeEmpty = timeEmpty;
	}

	public String getTimeStartDay() {
		return timeStartDay;
	}

	public void setTimeStartDay(String timeStartDay) {
		this.timeStartDay = timeStartDay;
	}

	public String getTimeEndDay() {
		return timeEndDay;
	}

	public void setTimeEndDay(String timeEndDay) {
		this.timeEndDay = timeEndDay;
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
    
    
    

}
