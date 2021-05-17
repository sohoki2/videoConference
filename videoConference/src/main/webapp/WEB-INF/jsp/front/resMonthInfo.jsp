<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    
    <link rel="stylesheet" href="/css/new/paragraph.css">    
    <link rel="stylesheet" href="/css/new/reset.css"> 
    <link rel="stylesheet" href="/css/new/swiper.css">
    
        
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    
    <link rel="stylesheet" href="/css/new/jquery-ui.css">
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    
    <link rel="stylesheet" href="/css/new/demo.css" />
    
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    <script type="text/javascript" src="/js/common_res.js"></script>
	<style type="text/css">
    	.floatL{float: left;}
    	.floatR{float: right;}
    	.clear{clear: both;}
    	.marginB25{margin-bottom: 25px;}
    	.margin0{margin: 0 !important;}
    </style>
</head>
<body>
 <div id="wrapper">
        <c:import url="/front/inc/fnt_top_inc.do" />
         <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/resMonthList.do">	
        
                
         <input type="hidden" id="searchResStartday" name="searchResStartday" />
        <div id="container">
            <div class="contents pe_005_2">
                <h2 class="sub_tit">예약 현황</h2>

				<!-- top button -->
                <div class="sub02">
                	<div class="floatR marginB25">
	                   <a href="#" class="cal_btn select">달력</a>
					  <a href="/front/resInfo/resList.do" class="text_btn">목록보기</a>
					  <a href="/front/resInfo/resListInfo.do" class="text_btn">테이블</a>
	                </div>
	                <div class="floatL">  
	                    <form:select path="searchCenterId" id="searchCenterId" title="소속" style="width:180px;height:40px;">
					         <form:option value="" label="선택"/>
	                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
						</form:select>	
						<form:select path="searchRoomType" id="searchRoomType" title="소속"  style="width:180px;height:40px;">
								 <form:option value="" label="회의실타입선택"/>
								 <form:options items="${selectSeat}" itemValue="code" itemLabel="codeNm"/>
						</form:select>	
                     </div>
                </div>  
                <div class="clearfix"></div>
                <!-- // top button -->  


                <!-- top button
                <div class="center_box sub02">
                  <a href="#" class="cal_btn select">달력</a>
                  <a href="/front/resInfo/resList.do" class="text_btn">목록보기</a>
                  <a href="/front/resInfo/resListInfo.do" class="text_btn">테이블</a>
                  
                    <form:select path="searchCenterId" id="searchCenterId" title="소속" style="width:180px;height:40px;">
					         <form:option value="" label="선택"/>
	                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
					</form:select>	
					<form:select path="searchRoomType" id="searchRoomType" title="소속"  style="width:180px;height:40px;">
							 <form:option value="" label="회의실타입선택"/>
							 <form:options items="${selectSeat}" itemValue="code" itemLabel="codeNm"/>
					</form:select>	
                </div>         
                <div class="clearfix"></div>
                <!-- // top button -->        
                <!-- calendar -->                
                <div class="calendar-container">
                  <div class="calendar-header">
                    <h1>
                      <form:select path="searchCalenderTitle" id="searchCalenderTitle" title="소속"  style="width:180px;height:40px;">
							 <form:option value="" label="예약할 월 선택"/>
							 <form:options items="${selectMonthList}" itemValue="calenderTitle" itemLabel="calenderTitleTxt"/>
					  </form:select>	
					   <a href="#" onclick="fn_search();" class="text_btn">검색</a>
                    </h1>
                  </div>
                  
                  <table class="calendar">
                        <thead>
                            <tr>
                                <td class="day-name">Mon</td>
                                <td class="day-name">Tue</td>
                                <td class="day-name">Wed</td>
                                <td class="day-name">Thu</td>
                                <td class="day-name">Fri</td>
                                <td class="day-name">Sat</td>
                                <td class="day-name sun">Sun</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                              <c:set var="sum"  value="0" />
                              <c:set var="tr_sum"  value="0" />
                              
                              <c:forEach var="empty" begin="1" end="${frDay }">
		                         <td class="day day--disabled">&nbsp;</td>
		                         <c:set var="sum"  value="${sum + 1}" />
		                         <c:set var="tr_sum"  value="${tr_sum + 1}" />		                         
							  </c:forEach>
							  					  
							  <c:forEach items="${calenderInfo }" var="calenInfo" varStatus="status">
                                
                                
                                  <c:set var="tr_sum"  value="${tr_sum + 1}" />		
                                  <c:set var="sum"  value="${sum + 1}" />    
		                          <c:choose>
		                            <c:when test="${calenInfo.passDate eq '0'}">
		                             <td class="day">
		                              <!-- <div class="day" style="z-index:99;"> -->
				                            <a href="javascript:fn_resList('${calenInfo.dates}')" >
				                            <c:choose>
				                               <c:when test="${calenInfo.weekTxt eq '1'}">
				                               <font color="red">${fn:substring(calenInfo.dates, 6, 8) }</font>
				                               </c:when>
				                               <c:when test="${calenInfo.weekTxt eq '7'}">
				                               <font color="blue">${fn:substring(calenInfo.dates, 6, 8) }</font>
				                               </c:when>
				                               <c:otherwise>
				                               ${fn:substring(calenInfo.dates, 6, 8) }
				                               </c:otherwise>
				                            </c:choose>
				                            </a>
				                            <c:if test="${calenInfo.resCnt ne '0'}" >
				                             <section class="task task--primary">
				                               <a href="javascript:fn_resInfo('${calenInfo.dates}')">회의실예약:${calenInfo.resCnt}</a>
				                              </section>
				                            </c:if>
				                        <!-- </div> -->
				                        </td>
		                            </c:when>
		                            <c:otherwise>
		                                <!-- <div class="day day--disabled"  style="z-index:99;"> -->
		                                <td class="day day--disabled">
		                                    
		                                    <c:choose>
				                               <c:when test="${calenInfo.weekTxt eq '1'}">
				                               <font color="red">${fn:substring(calenInfo.dates, 6, 8) }</font>
				                               </c:when>
				                               <c:when test="${calenInfo.weekTxt eq '7'}">
				                               <font color="blue">${fn:substring(calenInfo.dates, 6, 8) }</font>
				                               </c:when>
				                               <c:otherwise>
				                               ${fn:substring(calenInfo.dates, 6, 8) }
				                               </c:otherwise>
				                            </c:choose>
		                                    
				                            <c:if test="${calenInfo.resCnt ne '0'}" >
				                             <section class="task task--primary">
				                               <a href="javascript:fn_resInfo('${calenInfo.dates}')">회의실예약:${calenInfo.resCnt}</a>
				                              </section>
				                            </c:if>
				                        <!-- </div> -->
				                        </td>
		                            </c:otherwise>
		                         </c:choose>
		                         <c:if test="${ tr_sum > 6 }">
		                          </tr><tr>
		                          <c:set var="tr_sum"  value="0" />
		                       </c:if>
		                    </c:forEach>
		                    <c:forEach var="empty_dr" begin="${tr_sum}" end="6">
		                         <td class="day day--disabled">&nbsp;</td>
		                    </c:forEach>	                        
	                       </tr>     
                        </tbody>
                    </table>
                        
                  
                  
                 <%--  <div class="calendar" >
                    <span class="day-name sun">Sun</span>
                    <span class="day-name">Mon</span>
                    <span class="day-name">Tue</span>
                    <span class="day-name">Wed</span>
                    <span class="day-name">Thu</span>
                    <span class="day-name">Fri</span>
                    <span class="day-name">Sat</span>
                    
                    
                    <c:forEach begin="1" end="${frDay }">
                         <div class="day day--disabled">&nbsp;</div>
					</c:forEach>
                    <c:forEach items="${calenderInfo }" var="calenInfo" varStatus="status">
                         
                         <c:choose>
                            <c:when test="${calenInfo.passDate eq '0'}">
                               <div class="day" style="z-index:99;">
		                            <a href="javascript:fn_resList('${calenInfo.dates}')" >
		                            
		                            <c:choose>
		                               <c:when test="${calenInfo.weekTxt eq '1'}">
		                               <font color="red">${fn:substring(calenInfo.dates, 6, 8) }</font>
		                               </c:when>
		                               <c:when test="${calenInfo.weekTxt eq '7'}">
		                               <font color="blue">${fn:substring(calenInfo.dates, 6, 8) }</font>
		                               </c:when>
		                               <c:otherwise>
		                               ${fn:substring(calenInfo.dates, 6, 8) }
		                               </c:otherwise>
		                            </c:choose>
		                            
		                            </a>
		                            <c:if test="${calenInfo.resCnt ne '0'}" >
		                             <section class="task task--primary">
		                               <a href="javascript:fn_resInfo('${calenInfo.dates}')">회의실예약:${calenInfo.resCnt}</a>
		                              </section>
		                            </c:if>
		                        </div>
                            </c:when>
                            <c:otherwise>
                                <div class="day day--disabled"  style="z-index:99;">
                                    
                                    <c:choose>
		                               <c:when test="${calenInfo.weekTxt eq '1'}">
		                               <font color="red">${fn:substring(calenInfo.dates, 6, 8) }</font>
		                               </c:when>
		                               <c:when test="${calenInfo.weekTxt eq '7'}">
		                               <font color="blue">${fn:substring(calenInfo.dates, 6, 8) }</font>
		                               </c:when>
		                               <c:otherwise>
		                               ${fn:substring(calenInfo.dates, 6, 8) }
		                               </c:otherwise>
		                            </c:choose>
                                    
		                            <c:if test="${calenInfo.resCnt ne '0'}" >
		                             <section class="task task--primary">
		                               <a href="javascript:fn_resInfo('${calenInfo.dates}')">회의실예약:${calenInfo.resCnt}</a>
		                              </section>
		                            </c:if>
		                        </div>
                            </c:otherwise>
                         </c:choose>
                    </c:forEach>
                    
                    <!--// booking_info--> 
                </div> --%>
                <!-- // calendar -->
				<br/>
				<br/>
				<br/>
                <div class="clearfix"></div>
            </div>            
        </div>
         </form:form>   
    </div>
   
   <div id='view_meetingRoom' class="needpopup">
        <div class="box_padding ">
            <h2 class="pop_top" id="popTopTxt">예약정보</h2>  
            <div class="pop_container">
               <table class="pop_list" id="tb_resInfoTable">
                     <thead>
                     <tr class="pop_list-tr">
                         <th>회의실구분</th>
                         <th>회의실명</th>
                         <th>회의실 구분</th>
                         <th>회의제목</th>
                         <th>예약시간</th>
                         <th>주체자</th>
                         <th>참여자</th>
                         <th>공개여부</th>
                     </tr>
                     </thead>
                     <tbody>
                     </tbody>
                 </table>  
            </div>
            <div class="pop_footer">
                <a href="#" onclick="fn_resCancel();" class="pop_btn">닫기</a>
            </div>
        </div>            
    </div>
     <!--popup-->
    <button id="btn_meeting" style="display:none" data-needpopup-show='#view_meetingRoom'>확인1</button>
    <script src="/js/needpopup.min.js"></script> 
    <script>  
        function fn_resList(resDay){
        	$("#searchResStartday").val(resDay);
        	$("form[name=regist]").attr("action", "/front/resInfo/resListInfo.do").submit();
        }
        function fn_resInfo(resInfo){
        	$("#btn_meeting").trigger("click");
        	var params = {'searchNotProcessGubun': 'cancel', 'searchDayGubun' : 'resDay', 'searchStartDay' : resInfo, 'searchEndDay' : resInfo, 'searchRoomType' : $("#searchRoomType").val() , 'pageUnit': '100' };
        	uniAjax("/front/resInfo/resDayInfo.do", params, 
         			function(result) {
    				       if (result.status == "LOGIN FAIL"){
    				    	    alert(result.message);
      							location.href="/backoffice/login.do";
      					   }else if (result.status == "SUCCESS"){
      						    //테이블 정리 하기
      						 if (result.totalCnt > 0){
      							    var shtml = "";
    								$("#tb_resInfoTable >tbody").empty();
    								for (var i =0; i < result.resultList.length; i ++){
    									var obj = result.resultList[i];
    									
    									
    									shtml += "<tr><td>"+obj.centerNm +"</td>";
    									shtml += "<td>"+obj.seatName +"</td>";
    									shtml += "<td>"+obj.resGubunTxt +"</td><td>"+obj.resTitle +"</td>";
    									shtml += "<td>"+obj.resStarttime +"~"+obj.resEndtime +"</td><td>"+obj.empname +"</td>";
    									shtml += "<td>"+obj.attendListTxt +"</td><td>"+obj.resPassTxt +"</td>";
    									shtml += "</tr>";
    								}
    								$("#tb_resInfoTable >  tbody:last").append(shtml);
    								shtml = "";
    								
    							  //$("#sp_popMeetingLst").html(shtml);
      						 }
      					   }
    				    },
    				    function(request){
    					    alert("Error:" +request.status );	       						
    				    }    		
             );
        }
        function fn_search(){
      	    $("form[name=regist]").attr("action", "/front/resInfo/resMonthList.do").submit();
        }
        needPopup.config.custom = {
            'removerPlace': 'outside',
            'closeOnOutside': false,
            onShow: function() {
                console.log('needPopup is shown');
            },
            onHide: function() {
                console.log('needPopup is hidden');
            }
        };
        needPopup.init();
    </script>
</body>
</html>