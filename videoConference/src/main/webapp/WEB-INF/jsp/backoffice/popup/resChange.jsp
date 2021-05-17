<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <title>국민건강보험</title>
    <link rel="stylesheet" href="/css/frn/reset.css">
    <link rel="stylesheet" href="/css/frn/popup.css">
    <link href="/css/calendar.css" rel="stylesheet" />
    <script src="<c:url value='/'/>js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
    <script src="/js/common.js"></script>
    <script>
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
            buttonImage: '/images/invisible_image.png', //이미지주소
            //showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)
            yearRange: '1970:2030' //1990년부터 2020년까지
        };	       
        $("#resEndday").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});	
    </script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post" action="/front/res/popRes.do">
<div id="wrapper">	   	  

<input type="hidden" name="resSeq" id="resSeq" value="${registInfo.resSeq }">

	
<div class="pop_container">
        <!--//팝업 타이틀-->
        <div class="pop_header">
            <div class="pop_contents">
            <h2>
                   장기예약_근무일변경
             </h2>
            </div>
        </div>
        <!--팝업타이틀//-->
        <!--//팝업 내용-->
        <div class="pop_contents">
            <table class="pop_table thStyle newPopTable">
                <tbody>
                    <tr>
                  		<th>실근무자 성명</th>
                  		<td>
                  		<c:choose>
                  			<c:when test="${registInfo.coworkerYn eq '1' }">
                  				${registInfo.userName }
                  			</c:when>
                  			<c:otherwise>
                  				외부인
                  			</c:otherwise>
                  		</c:choose>
                  		</td>
                        <th>신청자 성명(사번)</th>
                  		<td>${registInfo.userName }(${registInfo.userId })</td>
                    </tr>
                    <tr>
                  		
                  		<th>좌석번호</th>
                        <td>${registInfo.seatName}</td>
                        <th>연락처</th>
                        <td>${registInfo.mobTelNo}</td>
                    </tr>
                    <tr>
						<th>기존 신청 근무일</th>
                        <td>
							<%-- <input type="text" name="resStartday" id="resStartday" value="${registInfo.resStartday }"  readOnly> --%>
                            ${registInfo.resStartday}&nbsp;~&nbsp; ${registInfo.resEndday}
						</td>
						<th>변경 신청 근무일</th>
                      		<td>
                      		<input type="hidden" name="pre_resStartday" id="pre_resStartday" value="${registInfo.resStartday }" >
                      		<input type="hidden" name="pre_resEndday" id="pre_resEndday" value="${registInfo.resEndday }" >
                      	    <input type="text" name="resStartday" id="resStartday" value="${registInfo.resStartday }"  readOnly class="date-picker-input-type-text" style="width:100px;" title="근무 시작일, 변경불가">
                      			&nbsp;~&nbsp;
                      	    <input type="text" name="resEndday" id="resEndday" value="${registInfo.resEndday }"  readOnly class="date-picker-input-type-text" style="width:100px; cursor:pointer;" title="근무종료일 선택">
                      		</td>
	               	</tr>
						
                </tbody>
            </table>
        </div>
        <!--팝업 내용//-->
        <!--//팝업 버튼-->
        <div class="footerBtn">
            <a href="javascript:self.close();" class="deepBtn">취소</a>&emsp;
            <a href="javascript:checkform();" class="redBtn">예약변경</a>
        </div>
        <!--팝업 버튼//-->
    </div>
</div>
</form:form>

	  
    <script type="text/javascript">
      var day = new Date();
	    var dateNow = fnLPAD(String(day.getDate()), "0", 2); //일자를 구함
	    var monthNow = fnLPAD(String((day.getMonth() + 1)), "0", 2); // 월(month)을 구함
	    var yearNow = String(day.getFullYear()); //년(year)을 구함
	    var today = yearNow + monthNow + dateNow;
	    
	    
    	var getTomorrow = tomorrow_get();
    	
    	$(document).ready(function(){
    		$("#resEndday").val(today);
    	});
    	
        function checkform(){
        	
       		var resStartday = $("#resStartday").val(); // 선택 시작일 - Fix Data
       		var resEndday = $("#resEndday").val(); // 선택 종료일 - 변경 됨
       		var pre_resStartday = $("#pre_resStartday").val(); // 기존 시작일 - Fix Data 
       		var pre_resEndday = $("#pre_resEndday").val(); // 기존 종료일 - Fix Data
        	
       		// 다섯가지 조건
       		if (resEndday < resStartday){
        		// 1 : 예약일 보다 앞설 수 없음
        		alert("변경종료일을 근무시작일보다 뒤로 선택바랍니다.");
        		return;
        	}
        	if (pre_resEndday <= resEndday){
        		// 2 : 예약종료일 부터 뒤로 갈 수 없음
        		alert("변경종료일을 기존 근무종료일보다 앞으로 선택바랍니다");
        		return;
        	}
        	if(today > resEndday){
        		// 3 : 오늘보다 앞설 수 없음
        		alert("변경종료일은 오늘보다 뒤로 선택바랍니다.");
        		return;
        	}
        	
        	if (confirm( "근무종료일을 "+resEndday+"일로 변경 하시겠습니까?")== true){
        		apiExecute(
					   "POST", 
					   "/backoffice/popup/resdayChangeUpdate.do",
						{
						 resSeq : $("#resSeq").val(), 
						 resStartday : $("#resStartday").val(),
						 resEndday : $("#resEndday").val(),
						
						},
						null,				
						function(result) {							
								if (result != null) {			
									if (result == "O"){
										alert("근무일자 변경이 정상적으로 적용되었습니다.");
										opener.parent.location.reload();
										window.close();
									}else{
										alert("근무일자 변경도중 문제가 발생 하였습니다.");
									}
								}else {
									alert("데이터 검색 도중 문제가 발생하였습니다.");
									$("#proxyUserId").val();
								}
							},
						null,
						null
					);
        	
        	}
        }
        
		 
    </script>
    <script  type="text/javascript">
        function popup_hide(id) {
            $('#' + id).hide();
        }
    </script>
</body>
</html>