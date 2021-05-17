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
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/holyList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="mode" id="mode" value="${regist.mode }">
<form:hidden path="pageSize" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />
<form:hidden path="holySeq" />

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
	                        <th>휴일</th>
	                        <td>${regist.holyDate }	</td>
	                        <th>휴일명</th>
	                        <td style="text-align:left">${regist.holyNm }</td>
	                    </tr>	                    
	                   <%--  <tr>
	                        <th>휴일정보</th>
	                        <td style="text-align:left">${regist.holyInfo }</td>
	                        <th>휴일구분</th>
	                        <td style="text-align:left">${regist.holyGubun }</td>
	                    </tr> --%>
	                    <tr>
	                        
	                        <th>휴일근무직원</th>
	                        <td style="text-align:left">${regist.empNm }&nbsp; ${regist.empNo }	
	                        </td>
	                        <th>부서</th>
	                        <td style="text-align:left">${regist.orgName }&nbsp; ${regist.posGrdNm }
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>근무사유 </th>
	                        <td colspan="3" style="text-align:left">
	                        	${regist.holyRemark}
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn">
	            <a href="javascript:check_form();" class="redBtn" id="btnUpdate">수정</a>
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
	function check_form(){
		   $("form[name=regist]").attr("action", "/backoffice/basicManage/holyDetail.do").submit();
	}
	function del_form(){
		
	    if (confirm("삭제 하시겠습니까?")== true){
	    	apiExecute(
					"POST", 
					"/backoffice/basicManage/holyDelete.do",
					{
						holyId : $("#holyId").val()
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