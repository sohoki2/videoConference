package com.sohoki.backoffice.sts.res.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VisitedInfo {

	
	   private String visitedCode = "";
	   private String visitedStatus  = "";
	   private String visitedResday  = "";
	   private String visitedRestime  = "";
	   private String visitedPerson  = "";
	   private String visitedPurpose = "";
	   private String visitedGubun  = "";
	   private String visitedQrcode  = "";
	   private String centerId  = "";
	   private String floorSeq  = "";
	   private String visitedEmpno  = "";
	   private String visitedRegdate  = "";
	   private String visitedRegid  = "";
	   private String visitedUpdatedate  = "";
	   private String visitedUpdateid  = "";
	   private String visitedRemark  = "";
	   //신규 
	   private String visitedReqName = "";
	   private String visitedReqCelphone = "";
	   private String visitedReqOrg = "";

	   private String mode = "";
       // 리스트 되는즈 확인
	   
	   private String visitedGroupName = "";
	   private String visitedGroupCheck = "";
	   
	   private String visitedTitle  = "";
	   private String cancelReason = "";
	   
	   private List<VisitedDetailInfo> detailList ;
}
