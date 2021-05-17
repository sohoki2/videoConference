package com.sohoki.backoffice.sts.res.vo;

import java.io.Serializable;

import com.sohoki.backoffice.sts.res.vo.ResInfo;
public class ResInfoVO extends ResInfo implements Serializable {

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
    
    
    private String searchCenterId = "";
    private String searchRoomType = "";
    private String searchResStartday = "";
    
    private String resGubunTxt = "";
    private String reservProcessGubunTxt = "";
    private String cancelCodeTxt = "";
    private String adminCancelcodeTxt = "";
    

    
    private String seatName = "";
    private String proxyYnTxt = "";
    
    private String searchStartDay = "";
    private String searchEndDay = "";
    private String searchDayGubun = "";
    private String searchProxyYn = "";
    private String searchUserId = "";
    private String searchResSeq = "";
    
    private String searchReservProcessGubun = "";
    private int totalRecordCount = 0;
    private String attendListTxt = "";
    
    private String searchSeatSeq = "";
    private String searchOrgId = "";
   
    private String swcSeqPop = "";
    
    private String timeSeq= "";
    private String swcTime = "";
    private String centerNm = "";
    private String delResSeq = "";
    
    private String resPassTxt = "";
    
    private String calenderTitle = "";
    private String calenderTitleTxt = "";
    private String searchCalenderTitle = "";
    
    
    private String weekTxt = "";
    private String dates= "";
    private String resCnt = "";
    private String passDate = "";
    private String searchNotProcessGubun = "";
    
    
    private String resDayInfo = "";
    private String resDayEndInfo = "";
    private String resDurationT = "";
    private String meetingNumber = "";
    
    
    private String avayaConfiId = "";
    
    private String avayaUserid = "";
    private String terminalId = "";
    private String endName = "";
    private String terminalNumber = "";
    private String terminalTel = "";
    
    private String userFirstNm = "";
    private String userLastNm = "";
    private String userEmail = "";
    
    private String calenderTitle1 = "";
    private String meetingTel = "";
    private String searchJobpst = "";
    
    private String empname = "";
    private String empno = "";
    private String empmail = "";
    private String emphandphone = "";
    private String empjikw = "";
    private String empjikwcode = "";
    private String deptname = "";
    //회의실 예약 구분 
    private String seatConfirmgubun = "";
    private String seatEqupgubun = "";
    
    private String authorCode = "";
    private String searchEmpno = "";
    private String resEqupcheckTxt = "";
    private String seatAdminid = "";
    //신규
    private String mailSendcheck = "";
    private String smsSendcheck = "";
    
    
    
    private String resMessageMailTxt = "";
    private String resMessageMailContextTxt = "";
    private String resMessageSmsTxt = "";
    private String canMessageMailTxt = "";
    private String canMessageMailContextTxt = "";
    private String canMessageSmsTxt = "";
    
    private String resStartTimeT  = "";
    private String resEndTimeT  = "";
    
    private String resState   = "";
    
    
    
    
    
	public String getResState() {
		return resState;
	}

	public void setResState(String resState) {
		this.resState = resState;
	}

	public String getResStartTimeT() {
		return resStartTimeT;
	}

	public void setResStartTimeT(String resStartTimeT) {
		this.resStartTimeT = resStartTimeT;
	}

	public String getResEndTimeT() {
		return resEndTimeT;
	}

	public void setResEndTimeT(String resEndTimeT) {
		this.resEndTimeT = resEndTimeT;
	}

	public String getResMessageMailTxt() {
		return resMessageMailTxt;
	}

	public void setResMessageMailTxt(String resMessageMailTxt) {
		this.resMessageMailTxt = resMessageMailTxt;
	}

	public String getResMessageMailContextTxt() {
		return resMessageMailContextTxt;
	}

	public void setResMessageMailContextTxt(String resMessageMailContextTxt) {
		this.resMessageMailContextTxt = resMessageMailContextTxt;
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

	public String getCanMessageMailContextTxt() {
		return canMessageMailContextTxt;
	}

	public void setCanMessageMailContextTxt(String canMessageMailContextTxt) {
		this.canMessageMailContextTxt = canMessageMailContextTxt;
	}

	public String getCanMessageSmsTxt() {
		return canMessageSmsTxt;
	}

	public void setCanMessageSmsTxt(String canMessageSmsTxt) {
		this.canMessageSmsTxt = canMessageSmsTxt;
	}

	public String getMailSendcheck() {
		return mailSendcheck;
	}

	public void setMailSendcheck(String mailSendcheck) {
		this.mailSendcheck = mailSendcheck;
	}

	public String getSmsSendcheck() {
		return smsSendcheck;
	}

	public void setSmsSendcheck(String smsSendcheck) {
		this.smsSendcheck = smsSendcheck;
	}

	public String getSeatAdminid() {
		return seatAdminid;
	}

	public void setSeatAdminid(String seatAdminid) {
		this.seatAdminid = seatAdminid;
	}

	public String getResEqupcheckTxt() {
		return resEqupcheckTxt;
	}

	public void setResEqupcheckTxt(String resEqupcheckTxt) {
		this.resEqupcheckTxt = resEqupcheckTxt;
	}

	public String getSearchEmpno() {
		return searchEmpno;
	}

	public void setSearchEmpno(String searchEmpno) {
		this.searchEmpno = searchEmpno;
	}
    

	public String getAuthorCode() {
		return authorCode;
	}

	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

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

	public String getEmpname() {
		return empname;
	}

	public void setEmpname(String empname) {
		this.empname = empname;
	}

	public String getSearchJobpst() {
		return searchJobpst;
	}

	public void setSearchJobpst(String searchJobpst) {
		this.searchJobpst = searchJobpst;
	}

	public String getMeetingTel() {
		return meetingTel;
	}

	public void setMeetingTel(String meetingTel) {
		this.meetingTel = meetingTel;
	}

	public String getCalenderTitle1() {
		return calenderTitle1;
	}

	public void setCalenderTitle1(String calenderTitle1) {
		this.calenderTitle1 = calenderTitle1;
	}

	public String getAvayaConfiId() {
		return avayaConfiId;
	}

	public void setAvayaConfiId(String avayaConfiId) {
		this.avayaConfiId = avayaConfiId;
	}

	public String getAvayaUserid() {
		return avayaUserid;
	}

	public void setAvayaUserid(String avayaUserid) {
		this.avayaUserid = avayaUserid;
	}

	public String getTerminalId() {
		return terminalId;
	}

	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId;
	}

	public String getEndName() {
		return endName;
	}

	public void setEndName(String endName) {
		this.endName = endName;
	}

	public String getTerminalNumber() {
		return terminalNumber;
	}

	public void setTerminalNumber(String terminalNumber) {
		this.terminalNumber = terminalNumber;
	}

	public String getTerminalTel() {
		return terminalTel;
	}

	public void setTerminalTel(String terminalTel) {
		this.terminalTel = terminalTel;
	}

	public String getUserFirstNm() {
		return userFirstNm;
	}

	public void setUserFirstNm(String userFirstNm) {
		this.userFirstNm = userFirstNm;
	}

	public String getUserLastNm() {
		return userLastNm;
	}

	public void setUserLastNm(String userLastNm) {
		this.userLastNm = userLastNm;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getMeetingNumber() {
		return meetingNumber;
	}

	public void setMeetingNumber(String meetingNumber) {
		this.meetingNumber = meetingNumber;
	}

	public String getResDurationT() {
		return resDurationT;
	}

	public void setResDurationT(String resDurationT) {
		this.resDurationT = resDurationT;
	}

	public String getResDayEndInfo() {
		return resDayEndInfo;
	}

	public void setResDayEndInfo(String resDayEndInfo) {
		this.resDayEndInfo = resDayEndInfo;
	}

	public String getResDayInfo() {
		return resDayInfo;
	}

	public void setResDayInfo(String resDayInfo) {
		this.resDayInfo = resDayInfo;
	}

	public String getSearchNotProcessGubun() {
		return searchNotProcessGubun;
	}

	public void setSearchNotProcessGubun(String searchNotProcessGubun) {
		this.searchNotProcessGubun = searchNotProcessGubun;
	}

	public String getPassDate() {
		return passDate;
	}

	public void setPassDate(String passDate) {
		this.passDate = passDate;
	}

	public String getResCnt() {
		return resCnt;
	}

	public void setResCnt(String resCnt) {
		this.resCnt = resCnt;
	}

	public String getWeekTxt() {
		return weekTxt;
	}

	public void setWeekTxt(String weekTxt) {
		this.weekTxt = weekTxt;
	}

	public String getDates() {
		return dates;
	}

	public void setDates(String dates) {
		this.dates = dates;
	}

	public String getSearchCalenderTitle() {
		return searchCalenderTitle;
	}

	public void setSearchCalenderTitle(String searchCalenderTitle) {
		this.searchCalenderTitle = searchCalenderTitle;
	}

	public String getCalenderTitleTxt() {
		return calenderTitleTxt;
	}

	public void setCalenderTitleTxt(String calenderTitleTxt) {
		this.calenderTitleTxt = calenderTitleTxt;
	}

	public String getCalenderTitle() {
		return calenderTitle;
	}

	public void setCalenderTitle(String calenderTitle) {
		this.calenderTitle = calenderTitle;
	}

	public String getResPassTxt() {
		return resPassTxt;
	}

	public void setResPassTxt(String resPassTxt) {
		this.resPassTxt = resPassTxt;
	}

	public String getDelResSeq() {
		return delResSeq;
	}

	public void setDelResSeq(String delResSeq) {
		this.delResSeq = delResSeq;
	}	
	
	public String getCenterNm() {
		return centerNm;
	}

	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}

	public String getSwcTime() {
		return swcTime;
	}

	public void setSwcTime(String swcTime) {
		this.swcTime = swcTime;
	}

	public String getTimeSeq() {
		return timeSeq;
	}

	public void setTimeSeq(String timeSeq) {
		this.timeSeq = timeSeq;
	}

	public String getSwcSeqPop() {
		return swcSeqPop;
	}

	public void setSwcSeqPop(String swcSeqPop) {
		this.swcSeqPop = swcSeqPop;
	}

	

	public String getSearchOrgId() {
		return searchOrgId;
	}

	public void setSearchOrgId(String searchOrgId) {
		this.searchOrgId = searchOrgId;
	}

	public String getSearchSeatSeq() {
		return searchSeatSeq;
	}

	public void setSearchSeatSeq(String searchSeatSeq) {
		this.searchSeatSeq = searchSeatSeq;
	}

	public String getAttendListTxt() {
		return attendListTxt;
	}

	public void setAttendListTxt(String attendListTxt) {
		this.attendListTxt = attendListTxt;
	}

	public int getTotalRecordCount() {
		return totalRecordCount;
	}

	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}

	public String getSearchReservProcessGubun() {
		return searchReservProcessGubun;
	}

	public void setSearchReservProcessGubun(String searchReservProcessGubun) {
		this.searchReservProcessGubun = searchReservProcessGubun;
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

	public String getSearchDayGubun() {
		return searchDayGubun;
	}

	public void setSearchDayGubun(String searchDayGubun) {
		this.searchDayGubun = searchDayGubun;
	}

	public String getSearchProxyYn() {
		return searchProxyYn;
	}

	public void setSearchProxyYn(String searchProxyYn) {
		this.searchProxyYn = searchProxyYn;
	}

	public String getSearchUserId() {
		return searchUserId;
	}

	public void setSearchUserId(String searchUserId) {
		this.searchUserId = searchUserId;
	}

	public String getSearchResSeq() {
		return searchResSeq;
	}

	public void setSearchResSeq(String searchResSeq) {
		this.searchResSeq = searchResSeq;
	}

	public String getProxyYnTxt() {
		return proxyYnTxt;
	}

	public void setProxyYnTxt(String proxyYnTxt) {
		this.proxyYnTxt = proxyYnTxt;
	}	
	

	public String getEmpmail() {
		return empmail;
	}

	public void setEmpmail(String empmail) {
		this.empmail = empmail;
	}

	public String getEmphandphone() {
		return emphandphone;
	}

	public void setEmphandphone(String emphandphone) {
		this.emphandphone = emphandphone;
	}

	public String getEmpjikw() {
		return empjikw;
	}

	public void setEmpjikw(String empjikw) {
		this.empjikw = empjikw;
	}

	public String getEmpjikwcode() {
		return empjikwcode;
	}

	public void setEmpjikwcode(String empjikwcode) {
		this.empjikwcode = empjikwcode;
	}

	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	public String getSeatName() {
		return seatName;
	}

	public void setSeatName(String seatName) {
		this.seatName = seatName;
	}

	public String getResGubunTxt() {
		return resGubunTxt;
	}

	public void setResGubunTxt(String resGubunTxt) {
		this.resGubunTxt = resGubunTxt;
	}

	public String getReservProcessGubunTxt() {
		return reservProcessGubunTxt;
	}

	public void setReservProcessGubunTxt(String reservProcessGubunTxt) {
		this.reservProcessGubunTxt = reservProcessGubunTxt;
	}

	public String getCancelCodeTxt() {
		return cancelCodeTxt;
	}

	public void setCancelCodeTxt(String cancelCodeTxt) {
		this.cancelCodeTxt = cancelCodeTxt;
	}

	public String getAdminCancelcodeTxt() {
		return adminCancelcodeTxt;
	}

	public void setAdminCancelcodeTxt(String adminCancelcodeTxt) {
		this.adminCancelcodeTxt = adminCancelcodeTxt;
	}

	public String getSearchResStartday() {
		return searchResStartday;
	}

	public void setSearchResStartday(String searchResStartday) {
		this.searchResStartday = searchResStartday;
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
