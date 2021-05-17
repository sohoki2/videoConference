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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>국민건강보험</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/calendar.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/new_calendar.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/holyList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="mode" id="mode" value="${regist.mode }">
<form:hidden path="pageSize" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />
<form:hidden path="holySeq" />
<input type="hidden" name="holyRemark" id="holyRemark" value="${regist.holyRemark }">

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                                          기초관리
                        <span>></span>
                        <strong>휴일근무관리</strong>
                    </div>
                </div>
            </div>

            
            <div class="Swrap tableArea viewArea">
                <div class="view_contents">
                <table class="pop_table thStyle">
	                <tbody>
	                    <tr>
	                        <th><span class="redText">*</span>휴일</th>
	                        <td>
	                            <form:input  path="holyDate" size="30" maxlength="20" id="holyDate" class="date-picker-input-type-text" value="${regist.holyDate }" />	
	                        </td>
	                        <th><span class="redText">*</span>휴일명</th>
	                        <td style="text-align:left">
	                        <form:input  path="holyNm" size="30" maxlength="20" id="holyNm"   value="${regist.holyNm }" />
	                        </td>
	                    </tr>	                    
	                    <tr>
	                     <%--    <th>휴일정보</th>
	                        <td style="text-align:left">
	                            <form:input  path="holyInfo" size="30" maxlength="20" id="holyInfo"   value="${regist.holyInfo }" />	
	                        </td> 
	                        <th>휴일구분</th>
	                        <td style="text-align:left">
	                           <form:input  path="holyGubun" size="30" maxlength="20" id="holyGubun"   value="${regist.holyGubun }" />	
	                        </td>--%>
	                    </tr>
	                    <tr>
	                    	<th><span class="redText">*</span>특정직원휴일근무지정</th>
	                        <td style="text-align:left">
	                        	<input type="hidden" name="empNo" size="10" id="empNo"   value="${regist.empNo }" />                        
		                        <input type="text"  id="empNm" size="10" style="width:300px;" value="${regist.empNm } ${regist.empNo }" readonly="true" disabled="disabled"/>
	                           <%-- <form:input  path="empNm" size="30" maxlength="20" id="empNm"   value="${regist.empNm }" />	 --%>
	                           <a href="javascript:user_search();" class="deepBtn">직원조회</a>
	                        </td>
	                        <th><span class="redText">*</span>부서/직급</th>
	                        <td style="text-align:left">
	                          <input type="hidden" name="orgId" size="10" id="orgId"   value="${regist.orgId }" />
	                          <form:input  path="orgName" size="30" maxlength="20" id="orgName"   value="${regist.orgName }  ${regist.posGrdNm }" disabled="disabled" readonly="true"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>근무사유 </th>
	                        <td colspan="3" style="text-align:left">
	                            <textarea name="ir1" id="ir1" style="width:1000px; height:100px; display:none;">${regist.holyRemark }</textarea>
	                        </td>
	                    </tr>	                    
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn">
	            <a href="javascript:check_form();" class="redBtn" id="btnUpdate">등록</a>
	            <c:if test="${regist.mode != 'Ins' }">
	           <!--  <a href="javascript:del_form();" class="redBtn">삭제</a> -->
	            </c:if>
	            <a href="javascript:linkPage('1')" class="deepBtn">목록</a>
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
	var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
         oAppRef: oEditors,
         elPlaceHolder: "ir1",                        
         sSkinURI: "/js/SE/SmartEditor2Skin.html",
         htParams: { bUseToolbar: true,
             fOnBeforeUnload: function () { },
             //boolean 
             fOnAppLoad: function () { }
             //예제 코드
         },
         fCreator: "createSEditor2"
    });
	$(document).ready(function() {     		
		if ("${status}" != ""){
			if ("${status}" == "SUCCESS") {
				alert("정상 처리 되었습니다");  
				document.location.href = document.location.href;
			}else{
				alert("작업 도중 문제가 발생 하였습니다.");
			}						
		}		
	    if ($("#mode").val() == "Ins"){
	 		$("#btnUpdate").text("등록");
	    }	else {
	    	$("#btnUpdate").text("저장");	   	    
	    }
	});	
	$(function () {
        var clareCalendar = {
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            weekHeader: 'Wk',
            dateFormat: 'yymmdd', //형식(20120303)
            autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
            changeMonth: true, //월변경가능
            changeYear: true, //년변경가능
            showMonthAfterYear: true, //년 뒤에 월 표시
            buttonImageOnly: true, //이미지표시
            buttonText: '달력선택', //버튼 텍스트 표시
		    //buttonImage: '/images/calendar.gif', //이미지주소
            buttonImage: '/images/invisible_image.png', //이미지주소
            showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)
            yearRange: '1970:2030' //1990년부터 2020년까지
        };	      
        $("#holyDate").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});	
	function check_form(){
		if (any_empt_line_id("holyDate", "휴일를 선택 하지 않았습니다.") == false) return;
		if (any_empt_line_id("holyNm", "휴일명를 입력 하지 않았습니다.") == false) return;
		if (any_empt_line_id("empNo", "특정직원을 선택 하지 않았습니다.") == false) return;
		if (any_empt_line_id("orgId", "근무자의 부서를 선택 하지 않았습니다.") == false) return;
		
		var sHTML = oEditors.getById["ir1"].getIR();
		$("#holyRemark").val(sHTML);
		if($("#holyRemark").val() == "<p><br></p>"){
			   alert("근무사유를 입력 하지 않았습니다.");
			   return;
		   }	   
	   	var commentTxt = "";
	   	
	    if ($("#mode").val() == "Ins"){
	    	commentTxt = "등록 하시겠습니까?";
	    }else {
	    	commentTxt = "저장 하시겠습니까?";   
	    }
	   
	   if (confirm(commentTxt)== true){
		   $("form[name=regist]").attr("action", "/backoffice/basicManage/holyUpdate.do").submit();
	   }
	   
	   
	   return;
	}
	function user_search(){
		var url ="/backoffice/popup/empSearchList.do?code=hly&admin=Y";
		NewWindow(url, 'name', '1024', '768', 'yes');
	}
	function del_form(){
		
	    if (confirm("삭제 하시겠습니까?")== true){
	    	apiExecute(
					"POST", 
					"/backoffice/basicManage/holyDelete.do",
					{
						adminId : $("#adminId").val()
					},
					null,				
					function(result) {				
						if (result != null) {
							if (result == "O"){
								alert("정상적으로 삭제되었습니다.");
							}else {
								alert("삭제시 문제가 생겼습니다");
							}					
						}else {
						    alert("삭제시 문제가 생겼습니다");
						  
						}
						$("form[name=regist]").attr("action", "/backoffice/basicManage/holyList.do").submit();					
					},
					null,
					null
				);	
	    }else {
	    	return;
	    } 	   
	}	
</script>  
</body>
</html>