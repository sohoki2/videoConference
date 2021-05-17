package com.sohoki.backoffice.sym.sat.vo;

import java.io.Serializable;
import java.util.List;

import com.sohoki.backoffice.sym.sat.vo.SeatInfo;

public class SeatInfoVO extends SeatInfo implements Serializable {

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
    private String roomTypeTxt = "";
    private String centerPartidTxt = "";;
    private String searchRoomType = "";
    private String searchCenterId = "";
    
    private String notSearchSeq = "";
    private List swSeqList ;
    
    private String searchRoomView = "";
    
    private String weektxt = "";
    
    private String searchSwcUseyn = "";
    
    private String searchSeatView = "";
    private String searchAdminid = "";
    private String seatAdminTxt = "";
    private String searchMainview = "";
    private String seatAdminidTxt = "";
    
    private String resMessageMailTxt = "";
    private String resMessageMailContextTxt = "";
    private String resMessageSmsTxt = "";
    private String canMessageMailTxt = "";
    private String canMessageMailContextTxt = "";
    private String canMessageSmsTxt = "";
    
    
    
    
    
    

	public String getResMessageMailContextTxt() {
		return resMessageMailContextTxt;
	}

	public void setResMessageMailContextTxt(String resMessageMailContextTxt) {
		this.resMessageMailContextTxt = resMessageMailContextTxt;
	}

	public String getCanMessageMailContextTxt() {
		return canMessageMailContextTxt;
	}

	public void setCanMessageMailContextTxt(String canMessageMailContextTxt) {
		this.canMessageMailContextTxt = canMessageMailContextTxt;
	}

	public String getResMessageMailTxt() {
		return resMessageMailTxt;
	}

	public void setResMessageMailTxt(String resMessageMailTxt) {
		this.resMessageMailTxt = resMessageMailTxt;
	}

	public String getResMessageSmsTxt() {
		return resMessageSmsTxt;
	}

	public void setResMessageSmsTxt(String resMessageSmsTxt) {
		this.resMessageSmsTxt = resMessageSmsTxt;
	}

	public String getCanMessageMailTxt() {
		return canMessageMailTxt;
	}

	public void setCanMessageMailTxt(String canMessageMailTxt) {
		this.canMessageMailTxt = canMessageMailTxt;
	}

	public String getCanMessageSmsTxt() {
		return canMessageSmsTxt;
	}

	public void setCanMessageSmsTxt(String canMessageSmsTxt) {
		this.canMessageSmsTxt = canMessageSmsTxt;
	}

	public String getSeatAdminidTxt() {
		return seatAdminidTxt;
	}

	public void setSeatAdminidTxt(String seatAdminidTxt) {
		this.seatAdminidTxt = seatAdminidTxt;
	}

	public String getSearchMainview() {
		return searchMainview;
	}

	public void setSearchMainview(String searchMainview) {
		this.searchMainview = searchMainview;
	}

	public String getSeatAdminTxt() {
		return seatAdminTxt;
	}

	public void setSeatAdminTxt(String seatAdminTxt) {
		this.seatAdminTxt = seatAdminTxt;
	}

	public String getSearchAdminid() {
		return searchAdminid;
	}

	public void setSearchAdminid(String searchAdminid) {
		this.searchAdminid = searchAdminid;
	}

	public String getSearchSeatView() {
		return searchSeatView;
	}

	public void setSearchSeatView(String searchSeatView) {
		this.searchSeatView = searchSeatView;
	}

	public String getSearchSwcUseyn() {
		return searchSwcUseyn;
	}

	public void setSearchSwcUseyn(String searchSwcUseyn) {
		this.searchSwcUseyn = searchSwcUseyn;
	}

	public String getWeektxt() {
		return weektxt;
	}

	public void setWeektxt(String weektxt) {
		this.weektxt = weektxt;
	}

	public String getSearchRoomView() {
		return searchRoomView;
	}

	public void setSearchRoomView(String searchRoomView) {
		this.searchRoomView = searchRoomView;
	}

	public List getSwSeqList() {
		return swSeqList;
	}

	public void setSwSeqList(List swSeqList) {
		this.swSeqList = swSeqList;
	}

	public String getNotSearchSeq() {
		return notSearchSeq;
	}

	public void setNotSearchSeq(String notSearchSeq) {
		this.notSearchSeq = notSearchSeq;
	}

	public String getSearchCenterId() {
		return searchCenterId;
	}

	public void setSearchCenterId(String searchCenterId) {
		this.searchCenterId = searchCenterId;
	}

	public String getSearchRoomType() {
		return searchRoomType;
	}

	public void setSearchRoomType(String searchRoomType) {
		this.searchRoomType = searchRoomType;
	}

	public int getTotalRecordCount() {
		return totalRecordCount;
	}

	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}

	public String getCenterNm() {
		return centerNm;
	}

	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}

	public String getRoomTypeTxt() {
		return roomTypeTxt;
	}

	public void setRoomTypeTxt(String roomTypeTxt) {
		this.roomTypeTxt = roomTypeTxt;
	}

	public String getCenterPartidTxt() {
		return centerPartidTxt;
	}

	public void setCenterPartidTxt(String centerPartidTxt) {
		this.centerPartidTxt = centerPartidTxt;
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
