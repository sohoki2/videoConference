package com.sohoki.backoffice.sts.res.vo;

import java.io.Serializable;

import com.sohoki.backoffice.sts.res.vo.ResInfo;
import lombok.Data;

@Data
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
    
    
    private String searchCenter = "";
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
    private String meetingName   = "";
    private String roomType = "";
   
   
    
}
