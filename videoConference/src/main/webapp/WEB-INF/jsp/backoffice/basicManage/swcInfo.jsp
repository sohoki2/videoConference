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
    <script type="text/javascript" src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/seatList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>시스템 관리<span>></span><strong>기초 환경 설정</strong>
                    </div>
                </div>
            </div>
            
            <div class="Swrap tableArea viewArea">
                <div class="view_contents">
                <table class="pop_table thStyle">
	                <tbody>
	                    <tr>
	                        <th><span class="redText">*</span>예약 최대일</th>
	                        <td><input type="number" name="swcInterval" id="swcInterval" onkeypress="only_num();" value="${regist.swcInterval }" style="width:100px;"/>
	                            
	                        </td>
	                        <th><span class="redText">*</span>크레딧 회수시간(분단위)</th>
	                        <td style="text-align:left"><input type="number" name="tennRetrieve" id="tennRetrieve" value="${regist.tennRetrieve }" onkeypress="only_num();"  style="width:100px;"/></td>
	                    </tr>	                    
	                    <tr>
	                        <th><span class="redText">*</span>예약 시작 시간</th>
	                        <td style="text-align:left">
	                        	<input type="text" name="startTime" size="10" id="startTime" value="${regist.startTime }" style="width:260px;"/>
	                        </td>
	                        <th><span class="redText">*</span>예약 종료 시간</th>
	                        <td style="text-align:left">
	                            <input type="text" name="endTime" size="10" id="endTime" value="${regist.endTime }" style="width:260px;"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">회사명</th>
	                        <td style="text-align:left">
	                        	<input type="text" name="comTitle" size="10" id="comTitle" value="${regist.comTitle }" style="width:260px;"/>
	                        </td>
	                        <th><span class="redText">회원사 월별 크레딧 배포 수량</th>
	                        <td style="text-align:left">
	                        	<input type="number" name="tennMonthcnt" id="tennMonthcnt" value="${regist.tennMonthcnt }" onkeypress="only_num();"  style="width:100px;"/>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn"><a href="javascript:fn_Checkform();" class="blueBtn" id="btnUpdate">저장</a></div>
        </div>
    </div>

<c:import url="/backoffice/inc/bottom_inc.do" />
</form:form>
	</div>
<script type="text/javascript">
	function fn_Checkform(){
		if (any_empt_line_id("swcInterval", "최대 예약 일수를 입력해주세요.") == false) return;
		if (any_empt_line_id("tennRetrieve", "크레딧 회수 시간를 입력해주세요.") == false) return;
		if (any_empt_line_id("startTime", "예약 시작  시간를 입력주세요.") == false) return;
		if (any_empt_line_id("endTime", "예약 종료  시간를 입력주세요.") == false) return;
		if (any_empt_line_id("comTitle", "회사명을 입력해주세요.") == false) return;
		if (any_empt_line_id("tennMonthcnt", "월별 크레딧 배포 수량을 입력해 주세요.") == false) return;
		
		var url = "/backoffice/orgManage/swcInfoUpdate.do";
    	var params = {   'swcInterval' : $("#swcInterval").val(),
		    		     'tennRetrieve' : $("#tennRetrieve").val(),
		    		     'startTime' : fn_emptyReplace($("#startTime").val(),"08:00"),
		    		     'endTime' : fn_emptyReplace($("#endTime").val(),"19:00"),
		    			 'comTitle' : $("#comTitle").val(),
		    			 'tennMonthcnt' : $("#tennMonthcnt").val(),
    	               }; 
    	uniAjax(url, params, 
      			function(result) {
 				       if (result.status == "LOGIN FAIL"){
 				    	   alert(result.meesage);
   						   location.href="/backoffice/login.do";
   					   }else if (result.status == "SUCCESS"){
   						   //총 게시물 정리 하기'
   						   alert("정상적으로 처리 되었습니다.")
   					   }
 				    },
 				    function(request){
 					    alert("Error:" +request.status );	   
 					    $("#btn_needPopHide").trigger("click");
 				    }    		
        );
	}
</script>  
</body>
</html>