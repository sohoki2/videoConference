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
    <title><spring:message code="URL.TITLE" /></title>
    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css">
    
    
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/jscript" src="/SE/js/HuskyEZCreator.js" ></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post" action="/backoffice/popup/reasonPop.do">
<div id="wrapper">	   	  


<input type="hidden" name="resSeq" id="resSeq" value="${resSeq }">
     <div class="pop_container">
		<!--//팝업 타이틀-->
		<div class="pop_header">
			<div class="pop_contents">
	        	<h2>예약 정보</h2>
			</div>			
		</div>
		<!--팝업타이틀//-->
		<!--//팝업 내용-->
		<div class="pop_contents">
			<table class="pop_table thStyle">
				<tbody class="search">
				 <tr>
				  <th>회의 제목</th>
				  <td colspan="3">${resInfo.resTitle}</td>
				 </tr>
				 <tr>
				   <th>회의장소</th>
				   <td>${resInfo.seatName }</td>
				   <th>회의일자</th>
				   <td>${resInfo.resStartday } ${resInfo.resStarttime }~${resInfo.resEndtime }</td>
				 </tr>
				 <tr>
				   <th>회의구분</th>
				   <td>${resInfo.resGubunTxt }</td>
				   <th>진행상태</th>
				   <td>${resInfo.reservProcessGubunTxt }</td>
				 </tr>
				 <c:if test="${resInfo.resGubun eq 'SWC_GUBUN_2' }">
				  <tr>
				   <th>참여 회의실</th>
				   <td colspan="3">
				     <c:forEach items="${resRoomInfo}" var="meetingInfo" varStatus="status">
				        ${meetingInfo.seatName }
				     </c:forEach>
				   </td>
				 </tr>
				 
				 </c:if>
				 <tr>
				   <th>신청자</th>
				   <td>${resInfo.empname }</td>
				   <th>연락처</th>
				   <td>${resInfo.empmail }</td>
				 </tr>
				 <tr>
				   <th>승인구분</th>
				   <td>${resInfo.proxyYnTxt }</td>
				   <th>승인자</th>
				   <td>${resInfo.proxyUserId }</td>
				 </tr>
				 <tr>
				   <th>결제상태</th>
				   <td>${resInfo.reservProcessGubunTxt }</td>
				   <th>참석자</th>
				   <td>${resInfo.attendListTxt }</td>
				 </tr>
				 <tr>
				   <th>참석자 상세</th>
				   <td colspan="3">
				   <c:forEach items="${resUserList}" var="attendInfo" varStatus="status">
				        ${attendInfo.empname }
				     </c:forEach>
				   </td>
				 </tr>
				 <c:if test="${ (resInfo.reservProcessGubun == 'PROCESS_GUBUN_3' || resInfo.reservProcessGubun == 'PROCESS_GUBUN_5'
							     || resInfo.reservProcessGubun == 'PROCESS_GUBUN_6' || resInfo.reservProcessGubun == 'PROCESS_GUBUN_7' )}">
				 <tr>
				   <th>취소유형</th>
				   <td>${resInfo.cancelCodeTxt }</td>
				   <th>취소 사유</th>
				   <td>${resInfo.cancelReason }</td>
				 </tr>
				 </c:if>
				</tbody>
			</table>
		</div>
		<!--팝업 내용//-->
        <!--//팝업 버튼-->
        <div class="footerBtn">
	        	<a href="javascript:self.close();" class="deepBtn">닫기</a>
        </div>
        <!--팝업 버튼//-->
	</div>

</div>
</form:form>
</body>
</html>