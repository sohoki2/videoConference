<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/calendar.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css"> 
    
    
    <script type="text/javascript" src="/js/new_calendar.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <!-- <script type="text/jscript" src="/SE/js/HuskyEZCreator.js" ></script> -->
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/seatList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="mode"  id="mode" value="${regist.mode }"/>
<form:hidden path="pageSize" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />
<form:hidden path="searchCenterId" />
<form:hidden path="swcSeq" />

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                                                                 기초관리
                        <span>></span>
                        <strong>회의실 관리</strong>
                    </div>
                </div>
            </div>
            
            <div class="Swrap tableArea viewArea">
                <div class="view_contents">
                <table class="pop_table thStyle">
	                <tbody>
	                    <tr>
	                        <th><span class="redText">*</span>회의실 분류</th>
	                        <td>
	                            <form:select path="centerId" id="centerId" title="소속" style="width:260px;">
							         <form:option value="" label="회의실 분류선택"/>
			                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
							    </form:select>	
	                        </td>
	                        <th><span class="redText">*</span>회의실타입</th>
	                        <td style="text-align:left">
	                            <form:select path="roomType" id="roomType" title="소속"  style="width:260px;" onChange="fn_SeatAvayView();">
									         <form:option value="" label="회의실타입선택"/>
									 <form:options items="${selectSwcGubun}" itemValue="code" itemLabel="codeNm"/>
							    </form:select>	
	                        </td>
	                    </tr>	                    
	                    <tr>
	                        <th><span class="redText">*</span>회의실 명</th>
	                        <td style="text-align:left">
	                        	<form:input  path="seatName" size="40" maxlength="80" id="seatName"   value="${registinfo.seatName }" style="width:260px;"/>
	                        </td>
	                        <th><span class="redText">*</span>최대수용인원</th>
	                        <td style="text-align:left">
	                           <form:input  path="maxCnt" size="40" maxlength="80" id="maxCnt"   value="${registinfo.maxCnt }" style="width:30px;"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>메인 페이지 노출 여부</th>
	                        <td style="text-align:left">
	                        	<c:if test="${registinfo.mode == 'Ins' }">
						            <input type="radio" name="seatMainview" value="Y" checked="checked"/><label>사용</label>
					            </c:if>
		                        <c:if test="${registinfo.mode != 'Ins' }">
						            <input type="radio" name="seatMainview" value="Y" <c:if test="${registinfo.seatMainview == 'Y' }"> checked </c:if> /><label>사용</label>
					            </c:if>
								<input type="radio" name="seatMainview" value="N" <c:if test="${registinfo.seatMainview == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                        <th><span class="redText">*</span>페이지 노출 여부</th>
	                        <td style="text-align:left">
	                        	<c:if test="${registinfo.mode == 'Ins' }">
						            <input type="radio" name="seatView" value="Y" checked="checked"/><label>사용</label>
					            </c:if>
		                        <c:if test="${registinfo.mode != 'Ins' }">
						            <input type="radio" name="seatView" value="Y" <c:if test="${registinfo.seatView == 'Y' }"> checked </c:if> /><label>사용</label>
					            </c:if>
								<input type="radio" name="seatView" value="N" <c:if test="${registinfo.seatView == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>회의실  이미지1</th>
	                        <td style="text-align:left">
	                         <input name="seatImg1" id="seatImg1" type="file"  size="20"/>  
	                        </td>
	                        <th><span class="redText">*</span>회의실  이미지2</th>
	                        <td style="text-align:left">
	                        <input name="seatImg2" id="seatImg2" type="file"  size="20"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>장비 사용여부</th>
	                        <td style="text-align:left">
	                              <input type="radio" name="seatEqupgubun" value="Y" <c:if test="${registinfo.seatEqupgubun == 'Y' }"> checked </c:if> /><label>사용</label>
								  <input type="radio" name="seatEqupgubun" value="N" <c:if test="${registinfo.seatEqupgubun == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                        <th><span class="redText">*</span>관리자 승인여부</th>
	                        <td style="text-align:left">
	                              <input type="radio" name="seatConfirmgubun" value="R" <c:if test="${registinfo.seatConfirmgubun == 'R' }"> checked </c:if> /><label>사용</label>
								  <input type="radio" name="seatConfirmgubun" value="S" <c:if test="${registinfo.seatConfirmgubun == 'S' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                    </tr>
						<tr>
	                        <th><span class="redText">*</span>회의실 설명</th>
	                        <td style="text-align:left">
	                            <form:input  path="equipmentState" size="120" maxlength="1000" id="equipmentState"   value="${registinfo.equipmentState }" />
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>메일 전송 여부</th>
	                        <td style="text-align:left">
	                              <input type="radio" name="mailSendcheck" value="Y"  onClick="fn_msgView('M','Y')" <c:if test="${registinfo.mailSendcheck == 'Y' }"> checked </c:if> /><label>사용</label>
								  <input type="radio" name="mailSendcheck" value="N"  onClick="fn_msgView('M','N')" <c:if test="${registinfo.mailSendcheck == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                        <th><span class="redText">*</span>sms 전송 여부</th>
	                        <td style="text-align:left">
	                             
	                              <input type="radio" name="smsSendcheck" value="Y"   onClick="fn_msgView('S','Y')" <c:if test="${registinfo.smsSendcheck == 'Y' }"> checked </c:if> /><label>사용</label>
								  <input type="radio" name="smsSendcheck" value="N"   onClick="fn_msgView('S','N')" <c:if test="${registinfo.smsSendcheck == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                    </tr>
	                    <tr id="tr_resMial">
	                        <th><span class="redText">*</span>예약 메세지</th>
	                        <td style="text-align:left">
	                              <form:select path="resMessageMail" id="resMessageMail" title="소속" style="width:260px;">
							         <form:option value="" label="예약  메세지 선택"/>
			                         <form:options items="${selectMail}"  itemValue="msgSeq" itemLabel="msgTitle"/>
							      </form:select>	
	                        </td>
	                        <th><span class="redText">*</span>취소 메세지</th>
	                        <td style="text-align:left">
	                               <form:select path="canMessageMail" id="canMessageMail" title="소속" style="width:260px;">
							         <form:option value="" label="취소 메세지 선택"/>
			                         <form:options items="${selectMail}"  itemValue="msgSeq" itemLabel="msgTitle"/>
							      </form:select>	
	                        </td>
	                    </tr>
	                    <tr id="tr_resSms">
	                        <th><span class="redText">*</span>예약 SMS</th>
	                        <td style="text-align:left">
	                                <form:select path="resMessageSms" id="resMessageSms" title="소속" style="width:260px;">
							         <form:option value="" label="예약  SMS 선택"/>
			                         <form:options items="${selectSms}"  itemValue="msgSeq" itemLabel="msgTitle"/>
							    </form:select>	
	                        </td>
	                        <th><span class="redText">*</span>취소 SMS</th>
	                        <td style="text-align:left">
	                               <form:select path="canMessageSms" id="canMessageSms" title="소속" style="width:260px;">
							         <form:option value="" label="취소 SMS 선택"/>
			                         <form:options items="${selectSms}"  itemValue="msgSeq" itemLabel="msgTitle"/>
							    </form:select>	
	                        </td>
	                    </tr>
	                    
	                    <tr>
	                        <th><span class="redText">*</span>사용유무</th>
	                        <td style="text-align:left">
		                        <c:if test="${registinfo.mode == 'Ins' }">
						            <input type="radio" name="swcUseyn" value="Y" checked="checked"/><label>사용</label>
					            </c:if>
		                        <c:if test="${registinfo.mode != 'Ins' }">
						            <input type="radio" name="swcUseyn" value="Y" <c:if test="${registinfo.swcUseyn == 'Y' }"> checked </c:if> /><label>사용</label>
					            </c:if>
								<input type="radio" name="swcUseyn" value="N" <c:if test="${registinfo.swcUseyn == 'N' }"> checked </c:if> /><label>사용안함</label>	                            
	                        </td>
	                        <th><span class="redText">정렬 순서</span></th>
		                    <td style="text-align:left">
		                        <form:input  path="seatOrder" size="30" maxlength="80" id="seatOrder" onkeypress="only_num();"  value="${registinfo.seatOrder }" style="width:30px;"/>
		                     </td>
	                    </tr>
	                    <tr class="avayaView">
	                      <th>AVAYA CODE</th>
	                        <td style="text-align:left">
	                           <form:input  path="avayaConfiId" size="40" maxlength="80" id="avayaConfiId" value="${registinfo.avayaConfiId }" style="width:260px;"/>
	                       </td>
	                       <th>어바이어 장비명</th>
	                        <td style="text-align:left">
	                         <form:input  path="avayaUserid" size="40" maxlength="80" id="avayaUserid"   value="${registinfo.avayaUserid }" style="width:250px;"/> 
	                        </td>
	                    </tr>
	                    <tr class="avayaView">
	                        <th><span class="redText">*</span>어바이어 터미널아이디</th>
	                        <td style="text-align:left">
	                        <form:input  path="terminalId" size="40" maxlength="80" id="terminalId"   value="${registinfo.terminalId }" style="width:250px;"/>
	                        </td>
	                        <th>어바이어 터미널 넘버</th>
	                        <td style="text-align:left">
	                        <form:input  path="terminalNumber" size="40" maxlength="80" id="terminalNumber"  onkeypress="only_num();"  value="${registinfo.terminalNumber }" style="width:250px;"/>  
	                        </td>
	                    </tr>
	                    <tr class="avayaView">
	                        <th>어바이어 터미널 전화번호</th>
	                        <td style="text-align:left">
	                        <form:input  path="terminalTel" size="40" maxlength="80" id="terminalTel" onkeypress="only_num();"   value="${registinfo.terminalTel }" style="width:250px;"/>
	                        </td>
	                        <th><span class="redText"></span>어바이어 사용자명</th>
	                        <td style="text-align:left">
	                        first: <form:input  path="userFirstNm" size="20" maxlength="80" id="userFirstNm"   value="${registinfo.userFirstNm }" style="width:120px;"/>
	                        last: <form:input  path="userLastNm" size="20" maxlength="80" id="userLastNm"   value="${registinfo.userLastNm }" style="width:120px;"/>  
	                        </td>
	                    </tr>
	                    <tr class="avayaView">
	                        
	                        <th><span class="redText"></span>이메일</th>
	                        <td style="text-align:left" colspan="3">
	                        <form:input  path="userEmail" size="20" maxlength="80" id="userEmail"   value="${registinfo.userEmail }" style="width:250px;"/>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn">
	            <a href="javascript:check_form();" class="blueBtn" id="btnUpdate">저장</a>
	            <c:if test="${regist.mode != 'Ins' }">
	              <a href="javascript:del_form();" class="grayBtn">삭제</a>
	            </c:if>
	            <a href="javascript:linkPage('1')" class="reviseBtn">목록</a>
	        </div>
        </div>
    </div>

<c:import url="/backoffice/inc/bottom_inc.do" />
</form:form>
	</div>
<script type="text/javascript">
	function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);		
		$("form[name=regist]").submit();
	}	
    function fn_seatAdminView(gubun){
    	if (gubun == "A"){
    		$("#sp_seatInfo").html("<a href='#'  class='redBtn' id='btn_Choice'' onclick='fn_searchView()'>담당자 선택</a>");
    		$("#seatAdminid").val("");
    	}else {
    		$("#sp_seatInfo").html("");
    		$("#seatAdminid").val("");
    	}
    }
    function fn_searchView(){
    	var url ="/backoffice/popup/empSearchList.do?code=except&admin=Y";
		NewWindow(url, 'name', '1024', '768', 'yes');
    }
	function check_form(){
		if (any_empt_line_id("centerId", "회의실 분류를 선택 하지 않았습니다.") == false) return;
		if (any_empt_line_id("seatName", "회의실 명을 입력 하지 않았습니다.") == false) return;
		if (any_empt_line_id("roomType", "회의실 타입을 선택 하지 않았습니다.") == false) return;
		if (any_empt_line_id("maxCnt", "최대 수용 인원을 입력 하지 않았습니다.") == false) return;
	   
	    var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
		if (confirm(commentTxt)== true){
				  document.regist.encoding = "multipart/form-data";
				  $("form[name=regist]").attr("action", "/backoffice/basicManage/seatUpdate.do").submit();
		}
	    
		return;
	}
	function fn_SeatAvayView(){
		 
		if ($("#roomType").val() == "SWC_GUBUN_1"){
			$("input:radio[name='mailSendcheck']:radio[value='Y']").prop('checked', true); 
			$("input:radio[name='smsSendcheck']:radio[value='N']").prop('checked', true); 
			$(".avayaView").hide();
		}else {
			$("input:radio[name='mailSendcheck']:radio[value='Y']").prop('checked', true); 
			$("input:radio[name='smsSendcheck']:radio[value='Y']").prop('checked', true); 
			$(".avayaView").show();
		}
	}
	function del_form(){
		fn_uniDel("/backoffice/basicManage/seatDelete.do"
				  , "swcSeq="+ $("#swcSeq").val()
		          , "/backoffice/basicManage/seatList.do");			
	}		
	$("#centerId").change(function(){
		if($("#centerId option:selected").val().length > 0){
			$("#roomType").attr("disabled", false);
		}
		console.log("mode:" +$("#mode").val() );
		
		if ($("#mode").val() == "Edt"){
			fn_SeatAvayView();
		}
	});
	function fn_msgView(msgType, mesSned){
		if (msgType == "M" && mesSned == "Y"){
			$("#tr_resMial").show();
		}else if (msgType == "M" && mesSned == "N") {
			$("#tr_resMial").hide();			
		}else if (msgType == "S" && mesSned == "Y") {
			$("#tr_resSms").show();			
		}else if (msgType == "S" && mesSned == "N") {
			$("#tr_resSms").hide();			
		}
	}
	function fn_msgView(){
		
	}
	$(document).ready(function() { 
		   var btnTxt = ($("#mode").val() == "Ins") ? "등록" : "수정";
		    $("#btnUpdate").text(btnTxt);
		   if ($("#mode").val() == "Ins"){
			   $("#roomType").val("SWC_GUBUN_1");
			   fn_SeatAvayView();
		   }else {
			   if ($("#roomType").val() == "SWC_GUBUN_1"){
					$(".avayaView").hide();
				}else {
					$(".avayaView").show();
				}	   
		   }
		  
		});
	
</script>  
</body>
</html>