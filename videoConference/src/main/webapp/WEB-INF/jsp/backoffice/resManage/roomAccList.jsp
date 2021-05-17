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
    <title>국민건강보험</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/calendar.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/new_calendar.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/jscript" src="/SE/js/HuskyEZCreator.js" ></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
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
        
        $("#searchStartDay").datepicker(clareCalendar);
        $("#searchEndDay").datepicker(clareCalendar);
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});
    </script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/resManage/roomAccList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="delResSeq" id="delResSeq">

<div class="Aconbox">


        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                        <strong>입/퇴실관리</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">총 <span>${totalCnt}</span>건의 입퇴실정보가 있습니다.</div>
                
                <section class="Bclear">
                	<table class="pop_table searchThStyle magin-bottom20">
		                <tr class="tableM">
		                	<th style="width:90px">
			                	기간
			                </th>
                   			<td colspan="3">
			                	<c:choose>
				                	<c:when test="${regist.searchDayGubun eq '1'}">
				                		<input type="radio" id="searchDayGubun" name="searchDayGubun" value="1" checked>
				                		<label>신청일</label>
			                            <input type="radio" id="searchDayGubun" name="searchDayGubun" value="2"/>
			                            <label>예약일 </label> 
				                	</c:when>
				                	<c:otherwise>
				                		<input type="radio" id="searchDayGubun" name="searchDayGubun" value="1" >
				                		<label>신청일</label>
			                            <input type="radio" id="searchDayGubun" name="searchDayGubun" value="2"checked/>
			                            <label>예약일</label> 
				                	</c:otherwise>
			                	</c:choose>
			                	&nbsp;&nbsp;&nbsp;&nbsp;
			                	<form:input  path="searchStartDay" size="10" maxlength="20" id="searchStartDay" style="cursor:default;" class="date-picker-input-type-text" readonly="true" value="${regist.searchStartDay }" />
			                     ~
			                    <form:input  path="searchEndDay" size="10" maxlength="20" id="searchEndDay" style="cursor:default;"  class="date-picker-input-type-text" readonly="true" value="${regist.searchEndDay }" />
	                		</td>
                			<th style="width:90px">
		                		검색어
		                	</th>
		                	<td colspan="3">
		                		<select name="searchCondition"  id="searchCondition">
									<option value="0">전체</option>
									<option value="1" <c:if test="${regist.searchCondition == '1' }"> selected="selected" </c:if>>사번</option>
									<option value="2" <c:if test="${regist.searchCondition == '2' }"> selected="selected" </c:if>>이름</option>
								</select>
								<input class="nameB"  size="20" type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}">            
		                	</td>
		                	<td rowspan="2" class="border-left" style="width:70px">
			                    <a href="javascript:search_form();"><span class="searchTableB">조회</span></a>
		                	</td>
		                </tr>
		                <tr>
		                	<th>
		                		사무소별
		                	</th>
		                	<td>
		                		<form:select path="searchCenterId" id="searchCenterId" title="사무소">
						         	<form:option value="" label="사무소구분"/>
			                        <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
						    	</form:select>	
		                	</td>
		                	<th>
		                		내/외부인구분
		                	</th>
		                	<td>
		                		<select id="searchcoworkerYn" name="searchcoworkerYn">
			                        <option value="" >내/외부인구분</option>
			                        <option value="1" <c:if test="${regist.searchcoworkerYn == '1' }"> selected="selected" </c:if> >내부</option>
			                        <option value="0" <c:if test="${regist.searchcoworkerYn == '0' }"> selected="selected" </c:if>>외부</option>
			                    </select>
		                	</td>	
		                	<th>
		                		부서별
		                	</th>
		                	<td>
		                		<form:select path="searchorgId" id="searchorgId" title="소속">
							         <form:option value="" label="부서구분"/>
			                         <form:options items="${selectOrg}" itemValue="orgId" itemLabel="orgName"/>
							    </form:select>
		                	</td>	
		                	<th>
		                		정렬순서
		                	</th>
							<td>	                	
			                    <select name="searchOdr"  id="searchOdr">
									<option value="0"<c:if test="${regist.searchOdr == '0' }"> selected="selected" </c:if>>예약일 내림차순</option>
									<option value="1"<c:if test="${regist.searchOdr == '1' }"> selected="selected" </c:if>>예약일 오름차순</option>
									<option value="2" <c:if test="${regist.searchOdr == '2' }"> selected="selected" </c:if>>신청일 내림차순</option>
									<option value="3"<c:if test="${regist.searchOdr == '3' }"> selected="selected" </c:if>>신청일 오름차순</option>
									<option value="4"<c:if test="${regist.searchOdr == '4' }"> selected="selected" </c:if>>회의실번호 내림차순</option>
									<option value="5"<c:if test="${regist.searchOdr == '5' }"> selected="selected" </c:if>>회의실번호 오름차순</option>
								</select>
		                	</td>
						</tr>
                    </table>
                
                <div class="rightB ">
                        <a href="javascript:excel_down();"><span class="deepBtn">엑셀다운</span></a>                        
                    </div>
                    </section>
            </div>

            <div class="Swrap tableArea">
                <table class=" backTable">
                    <thead>
                        <tr>
                        	<th>번호</th>
                        	<th>예약사무소</th>
                            <th>회의실번호</th>
                            
                            <th>부서</th>
                            <th>직급</th>
                            <th>이름</th>
                            <th>사번</th>
                            <th>외부인구분</th>
                            <th>실근무자</th>
                            <!-- <th>연락처</th> -->
                            <th>신청일</th>
                            <th>예약일</th>
                            <th>예약시간</th>
                            <th>입실시간</th>
                            <th>퇴실시간</th>    
                            <th>상태</th>                        
                            <th>로그인</th>
                            <th>로그아웃</th>
                            <th>비밀번호</th>
                        </tr>
                    </thead>
                    <tbody>
                       <c:forEach items="${resultList }" var="resInfo" varStatus="status">
                        <tr>
                        	<td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
                        	<td>${resInfo.centerNm }</td>     
                            <td>${resInfo.seatName }</td>
                            <td>${resInfo.orgName }</td>
                            <td>${resInfo.posGrdNm }</td>
                            <td>${resInfo.empNm }</td>
                            <td>${resInfo.userId }</td>
                            <%-- <td>${resInfo.mobTelNo }</td> --%>
                            
                            <td>
                            	<c:choose>
								   <c:when test="${resInfo.coworkerYn ne '1' }">외부인</c:when>
								   <c:otherwise></c:otherwise>
								</c:choose>	
							</td>
							<td>
								   <c:if test="${resInfo.coworkerYn ne '0' && resInfo.proxyYn ne 'P'}">본인</c:if>
								   <c:if test="${resInfo.coworkerYn ne '0' && resInfo.proxyYn eq 'P'}">${resInfo.proxyUserNm}</c:if>
								   <c:if test="${resInfo.coworkerYn ne '1'}">${resInfo.outUserNm}</c:if>
							</td>
                            <td>${fn:substring(resInfo.regDate,0,10) }</td>
                              
                            <td>${resInfo.resDay }</td>
                            <td>${resInfo.resStarttime}~${resInfo.resEndtime}</td>
                            <td>${resInfo.roomIntime }</td>
                            <td>${resInfo.roomOttime }</td>
                            <td>
                            <c:choose>
									   <c:when test="${resInfo.roomIntime ne null }">
									      <c:choose>
	                                          <c:when test="${resInfo.roomOttime ne null }">
												확인	                                                                                                                         
	                                          </c:when>
	                                          <c:otherwise>미확인</c:otherwise>
	                                     </c:choose>									            
									   </c:when>
									   <c:otherwise>미확인</c:otherwise>
									</c:choose>
                            </td>                     							
							<td>${resInfo.login }</td>
							<td>${resInfo.logout }</td>	
							<c:choose>		
								<c:when test="${resInfo.roomOttime eq null }">				
	                            	<td><a href="javascript:send_Password('${resInfo.attSeq }', '${resInfo.resSeq }')" >재전송</a></td>
	                            </c:when>
                            </c:choose>
                        </tr>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="pagenum">
                <div class="pager">
                	<ol>
                		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
                   </ol>
                </div>
            </div>
        </div>
    </div>
<c:import url="/backoffice/inc/bottom_inc.do" /> 
</form:form>
</div>
 <script type="text/javascript">
    $(document).ready(function() {
		if ("${status}" != "" ){
			if ("${status}" == "SUCCESS" ){
				alert("정상처리 되었습니다");					
			}else  {
				alert("처리 도중 문제가 발생 하였습니다.");				
			}	
		}						   
	});	  
    function send_Password(code, code1){
    	apiExecute(
				"POST",
				"/backoffice/resManage/changePassword.do",
				{
					attCode : code					
					,resCode : code1
				}, null, function(result) {
					if (result != null) {
						if (result == "T") {							
							alert("정상적으로 처리 되었습니다");
						} else {
							alert("처리 도중 문제가 발생 하였습니다.");							
						}
					}
				}, null, null);	
    }
    
    function search_form(){    	
    	if ($("#searchStartDay").val() > $("#searchEndDay").val()) {
    		alert("시작일이 종료일 보다 빠를수 없습니다.");
    		return;
    	}    	
    	$(":hidden[name=pageIndex]").val("1");				
    	$("form[name=regist]").attr("action", "/backoffice/resManage/roomAccList.do").submit();
    }   
    function excel_down(){    	
    	$("form[name=regist]").attr("action", "/backoffice/resManage/iotListExcel.do").submit();
    }    
    function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);				
		$("form[name=regist]").attr("action", "/backoffice/resManage/roomAccList.do").submit();
	}	 
	</script>
</body>
</html>