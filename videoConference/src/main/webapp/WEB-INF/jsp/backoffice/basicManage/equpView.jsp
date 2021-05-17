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
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/equpList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="mode" id="mode" value="${regist.mode }">
<input type="hidden" name="equpCode" id="equpCode" value="${regist.equpCode }"> 

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                                          기초관리
                        <span>></span>
                        <strong>비품 관리</strong>
                    </div>
                </div>
            </div>

            
            <div class="Swrap tableArea viewArea">
                <div class="view_contents">
                <table class="pop_table thStyle">
	                <tbody>
	                    <tr>
	                        <th>비품명</th>
	                        <td style="text-align:left">${regist.equipmentName }
	                        </td>
	                        <th>등록일</th>
	                        <td style="text-align:left">${regist.equpIndate }	                        
	                        </td>	                        
	                    </tr>	                    
	                    <tr>
		                    <th>비치사무소</th>
		                    <td>${regist.centerNm }
		                    </td>
	                        <th>장소구분</th>
	                        <td style="text-align:left">${regist.roomType }</td>
	                    </tr>
	                    <tr>
	                    	<th>구역구분</th>
	                        <td style="text-align:left">${regist.roomId }</td>
	                    	<th>회의실(회의실)명</th>
		                    <td>${regist.seatNm }</td>
		                </tr>
	                    <tr>    
	                        <th>수량</th>
	                        <td style="text-align:left">${regist.cnt }</td>
	                        <th>제조회사</th>
	                        <td style="text-align:left">${regist.company }</td>
	                    </tr>	                    
	                    <tr>
	                        <th>사용유무</th>
	                        <td style="text-align:left" colspan="3">${regist.useYn}	                            
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>비고 </th>
	                        <td colspan="3" style="text-align:left">${regist.remark }
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn">
	            <a href="javascript:check_form();" class="redBtn" id="btnUpdate">등록</a>
	            <!-- <a href="javascript:del_form();" class="redBtn">삭제</a> -->
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
	    	$("#btnUpdate").text("수정");	   	    
	    }
	});	
	$(function () {
        var clareCalendar = {
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            weekHeader: 'Wk',
            dateFormat: 'yy-mm-dd', //형식(20120303)
            autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
            changeMonth: true, //월변경가능
            changeYear: true, //년변경가능
            showMonthAfterYear: true, //년 뒤에 월 표시
            buttonImageOnly: true, //이미지표시
            buttonText: '달력선택', //버튼 텍스트 표시
			buttonImage: '/images/calendar.gif', //이미지주소
            // showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)
            yearRange: '1970:2030' //1990년부터 2020년까지
        };	      
        $("#exceptStartDate").datepicker(clareCalendar);
        $("#exceptEndDate").datepicker(clareCalendar);
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});	
	function check_form(){
		   $("#mode").val("Edt");
		   $("form[name=regist]").attr("action", "/backoffice/basicManage/equpDetail.do").submit();
	}
	function del_form(){
		
	    if (confirm("삭제 하시겠습니까?")== true){
	    	apiExecute(
					"POST", 
					"/backoffice/basicManage/equpDelete.do",
					{
						equpCode : $("#equpCode").val()
					},
					null,				
					function(result) {				
						if (result != null) {
							if (result == "T"){
								alert("정상적으로 삭제되었습니다.");
							}else {
								alert("삭제시 문제가 생겼습니다");
							}					
						}else {
						    alert("삭제시 문제가 생겼습니다");						  
						}
						$("form[name=regist]").attr("action", "/backoffice/basicManage/equpList.do").submit();					
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