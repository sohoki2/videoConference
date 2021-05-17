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
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/calendar.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post" action="/backoffice/resManage/report02.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="reportGubun" id="reportGubun">


<div class="Aconbox">
            <div class="rightT">
                <div class="Smain">
                    <div class="Swrap Stitle">
                        <div class="infomenuA">
                            <img src="/images/home.png" alt="homeicon" />
                            <span>></span>
                            <span>통계</span>
                            <span>></span>
                            <strong>회의실통계</strong>
                        </div>
                    </div>
                </div>

                <div class="Swrap Asearch">
                	<section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>
		                		날짜 검색
		                	</th>
		                	<td>
		                		<input type="text" id="searchStartDay" name="searchStartDay" class="date-picker-input-type-text" value="${regist.searchStartDay}"/>
	                    ~ &nbsp;&nbsp;&nbsp;
	                    <input type="text" id="searchEndDay" name="searchEndDay" class="date-picker-input-type-text" value="${regist.searchEndDay}"/>
								<a href="javascript:searchform()"><span class="searchTableB">조회</span></a>
								
								          
		                	</td>
		                	<td class="text-right">
		                		 <a href="javascript:void(0);" onclick="excel_down()"><span class="deepBtn">엑셀다운</span></a>
		                	</td>		                	
						</tr>
                    </table>
                    <br/>                
                </section>
                    
                </div>
                <div class="box">
                    <div class="Swrap tableArea">
                        <table class="margin-top30 backTable">
                            <thead>
                                <tr>
                                    <th>구분(기간)</th>
                                    <th>기간총계</th>
                                    <th>미팅룸1</th>
                                    <th>미팅룸2</th>
                                    <th>미팅룸3</th>
                                    <th>소회의실</th>
                                    <th>중회의실</th>
                                    <th>대회의실</th>
                                    <th>영상회의실</th>
                                </tr>
                            </thead>
                            <tbody>
                             <%-- <c:forEach items="${resultList }" var="reportinfo" varStatus="status"> --%>
                                <tr>
                                    <td class="bold"></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                              <%-- </c:forEach>   --%>                            
                            </tbody>
                        </table>
                    </div>
                </div>
               
            </div>
        </div>

<c:import url="/backoffice/inc/bottom_inc.do" /> 
</form:form>
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
    function change_process(code){
    	apiExecute(
				"POST",
				"/backoffice/res/reservationProcessChange.do",
				{
					resCode : code,
					resProcess : $("#"+code+"").val() 
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
    
    function searchform(){
    	
    	if ($("#searchStartDay").val() > $("#searchEndDay").val()) {
    		alert("시작일이 종료일 보다 빠를수 없습니다.");
    		return;
    	}
    	
    	$(":hidden[name=pageIndex]").val("1");				
		$("form[name=regist]").submit();
    }   
    function excel_down(){    	
    	$("form[name=regist]").attr("action", "/backoffice/res/resReportListExcel.do").submit();
    }    
    function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);				
		$("form[name=regist]").submit();
	}	 
	</script>
</body>
</html>