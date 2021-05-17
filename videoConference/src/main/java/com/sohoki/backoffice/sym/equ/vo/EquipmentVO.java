package com.sohoki.backoffice.sym.equ.vo;

import com.sohoki.backoffice.sym.equ.vo.Equipment;

import java.io.Serializable;
import java.util.List;

public class EquipmentVO extends Equipment implements Serializable  {


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
    
    private int totalRecordCount = 0;
    
    
    private String centerNm = "";
    private String empname = "";
    
    private String searchcenterId = "";
    private String searchRoomId = "";
    private String seatNm = "";
    private String searchEquipState = "";
    private List equpList = null;
    
      
    
	public List getEqupList() {
		return equpList;
	}
	public void setEqupList(List equpList) {
		this.equpList = equpList;
	}
	public String getSearchEquipState() {
		return searchEquipState;
	}
	public void setSearchEquipState(String searchEquipState) {
		this.searchEquipState = searchEquipState;
	}
	public int getTotalRecordCount() {
		return totalRecordCount;
	}
	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}
	public String getSeatNm() {
		return seatNm;
	}
	public void setSeatNm(String seatNm) {
		this.seatNm = seatNm;
	}
	public String getSearchRoomId() {
		return searchRoomId;
	}
	public void setSearchRoomId(String searchRoomId) {
		this.searchRoomId = searchRoomId;
	}
	public String getSearchcenterId() {
		return searchcenterId;
	}
	public void setSearchcenterId(String searchcenterId) {
		this.searchcenterId = searchcenterId;
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
	public String getCenterNm() {
		return centerNm;
	}
	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}
	public String getEmpname() {
		return empname;
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	@Override
	public String toString() {
		return "EquipmentVO [searchCondition=" + searchCondition
				+ ", searchKeyword=" + searchKeyword + ", searchUseYn="
				+ searchUseYn + ", pageIndex=" + pageIndex + ", pageUnit="
				+ pageUnit + ", pageSize=" + pageSize + ", firstIndex="
				+ firstIndex + ", lastIndex=" + lastIndex
				+ ", recordCountPerPage=" + recordCountPerPage + ", centerNm="
				+ centerNm + ", empname=" + empname + ", searchcenterId="
				+ searchcenterId + ", searchRoomId=" + searchRoomId
				+ ", seatNm=" + seatNm + ", totalRecordCount="
				+ totalRecordCount + ", getTotalRecordCount()="
				+ getTotalRecordCount() + ", getSeatNm()=" + getSeatNm()
				+ ", getSearchRoomId()=" + getSearchRoomId()
				+ ", getSearchcenterId()=" + getSearchcenterId()
				+ ", getSearchCondition()=" + getSearchCondition()
				+ ", getSearchKeyword()=" + getSearchKeyword()
				+ ", getSearchUseYn()=" + getSearchUseYn()
				+ ", getPageIndex()=" + getPageIndex() + ", getPageUnit()="
				+ getPageUnit() + ", getPageSize()=" + getPageSize()
				+ ", getFirstIndex()=" + getFirstIndex() + ", getLastIndex()="
				+ getLastIndex() + ", getRecordCountPerPage()="
				+ getRecordCountPerPage() + ", getCenterNm()=" + getCenterNm()
				+ ", getEmpname()=" + getEmpname() + "]";
	}
	
    
    
    
}
