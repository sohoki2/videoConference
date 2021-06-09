package com.sohoki.backoffice.sts.res.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ResInfo implements Serializable {

	private static final long serialVersionUID = 1L;

    private String resSeq = "";
    private String itemId = "";
    private String centerId = ""; 
    private String resGubun = ""; 
    private String userId = ""; 
    private String deptId = ""; 
    private String rankId = ""; 
    private String resStartday = ""; 
    private String resEndday = ""; 
    private String resStarttime = ""; 
    private String resEndtime = ""; 
    private String regDate = ""; 
    private String reservProcessGubun = ""; 
    private String reservationGubun = ""; 
    private String cancelCode = ""; 
    private String cancelReason = "";
    private String resRemark = ""; 
    private String proxyYn = ""; 
    private String proxyUserId = ""; 
    private String updateDate = ""; 
    private String updateId = ""; 
    private String resReplyDate = ""; 
    private String adminReplayDate = ""; 
    private String adminProcessGubun = ""; 
    private String adminCancelcode = ""; 
    private String useYn = "";
    private String resTitle = "";
    private String resPassword = "";
    private String mode = "";
    private String reservationReason = "";
    private String meetingSeq = "";
    private String resAttendlist = "";
    private String meetinglog = "";
    private String resFile1 = "";
    private String resFile2 = "";
    
    
    private String conferenceId = "";
    private String conNumber = "";
    private String conPin = "";
    private String conVirtualPin = "";
    private String conAllowstream = "";
    private String conBlackdial = "";
    private String conSendnoti = "";
    private String resSendResult = "";
    private String resSendResultTxt = "";
    private String resEqupinfo = "";
    private String resEqupcheck = "";
    private String seatMainview = "";
    //신규 수정
    private String servicePrefix = "";
    private String inTime = "";
    private String otTime = "";
    
    private String itemGubun = "";
    private String userType = "";
    private String tennCnt = "";
    private String floorSeq = "";
    private String sendMessage = "";
    private String resPerson = "";
    
	
}
