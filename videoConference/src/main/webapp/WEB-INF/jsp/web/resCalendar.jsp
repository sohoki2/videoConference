<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ page import ="com.sohoki.smartoffice.homepage.web.HomepageUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title><spring:message code="URL.TITLE" /></title>
    <!--css-->
    <link href="/front_res/css/reset.css" rel="stylesheet" />
    <link href="/front_res/css/swiper.css" rel="stylesheet">
    <link href="/front_res/css/jquery-ui.css" rel="stylesheet" />
    <link href="/front_res/css/needpopup.min.css" rel="stylesheet" type="text/css" >
    <link href="/front_res/css/style.css" rel="stylesheet" />
    <link href="/front_res/css/paragraph.css" rel="stylesheet" />
    <link href="/front_res/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/front_res/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
    <link href="/front_res/css/calendar.css" rel="stylesheet" type="text/css" />
     
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/jquery-ui.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/com_resInfo.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
    
</head>
<body>
<form:form name="regist" commandName="regist" method="post" >	
<input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}">
            <!--//header ??????-->
            <c:import url="/web/inc/top_inc.do" />
            <!--header ??????//-->
            <!--// left menu -->
             <c:import url="/web/inc/right_menu.do" />
            <!--left menu //-->
        <!--//floor Btn-->
        <div id="allFloors">
            <div class="contents">
                <div class="flooreArea float_left" id="dv_floor">
                    <c:forEach items="${floorinfo }" var="floorList" varStatus="status">
                       <a href="#" onClick="fn_floorSearch(${floorList.floor_seq }, 'fn_floorSubmit')" name="btn_floor" id="btn_${floorList.floor_seq}" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
                    </c:forEach>
                    
                </div>               
                <div class="clear"></div>
            </div>
        </div>
        <!--floor Btn//-->
        <!--//contents-->
        <div class="contents calendar_con">
           <div class="line">
            <div class="contents search_con">
                <div class="float_right">
                  <button type="button" class="resource margintop15" onClick="location.href='/web/meetingResource.do'">??????????????????</button>
                </div>
                <div class="float_right list_T">
                     <a href="/web/meetingDay.do" class="dayBtn">day</a>  
                     <a href="/web/resCalendar.do" class="active calBtn">calendar</a>  
                </div>
                <div class="float_right btnL">
                     <a href="/web/meetingList.do" class="listBtn"></a>  
                     <a href="/web/meetingDay.do" class="active blockBtn"></a>  
                </div>
                <div class="clear"></div>
           </div>
         </div>
           <div class="whiteBack">
            <div class="infoContents float_left">
                        <span class="usingSeat">????????????</span>
                        <span class="posSeatD">3?????? ?????? ????????????</span>
                        <span class="posSeatU">3?????? ?????? ????????????</span>
                    </div>
                    <div class="clear"></div>
               <div class="calendar-container">
                  <div class="calendar-header">
                      <select id="searchCalenderTitle" name="searchCalenderTitle" onChange="fn_monthChange()">
                           <option value="">????????? ??? ??????</option>
	                        <c:forEach items="${selectMonthList}" var="floorList">
	                            <option value="${floorList.calenderTitle}" <c:if test="${floorList.calenderTitle eq regist.searchCalenderTitle }"> selected </c:if> >${floorList.calenderTitleTxt}</option>
	                         </c:forEach>
                      </select>
                    </h1>
                    <p>${fn:substring(regist.searchCalenderTitle,0,4)}</p>
                  </div>
                  <table class="calendar">
                        <thead>
                            <tr>
                                <td class="day-name sun">Sun</td>
                                <td class="day-name">Mon</td>
                                <td class="day-name">Tue</td>
                                <td class="day-name">Wed</td>
                                <td class="day-name">Thu</td>
                                <td class="day-name">Fri</td>
                                <td class="day-name">Sat</td>
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
                                  <c:set var="content" value="${calenInfo.resState}" /> 
	                                  <% 
	                                     String content = (String) pageContext.getAttribute("content"); 
	                                     content = HomepageUtil.conferenceState(content); 
	                                     pageContext.setAttribute("content", content); 
	                                  %> 
                                     <c:choose>
				                               <c:when test="${calenInfo.passDate eq '0'}">
				                                 <c:set var="tr_class" value="day" />
				                               </c:when>
				                               <c:otherwise>
				                                  <c:set var="tr_class" value="day day--disabled" />
				                               </c:otherwise>
				                     </c:choose>
				                              
		                             <td class="${tr_class}">
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
				                            <br />
				                            ${content}
				                            
				                        </td>
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
                  
                </div>
           </div>
        </div>
        <!--contetns//-->
  </form:form>  
  <script type="text/javascript">
     function fn_floorSubmit(){
    	$("form[name=regist]").attr("action", "/web/resCalendar.do").submit();
     }
     function fn_monthChange(){
    	$("form[name=regist]").attr("action", "/web/resCalendar.do").submit();
     }
  </script>
 </div>
</body>
</html>