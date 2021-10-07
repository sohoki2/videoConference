<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
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
     
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/jquery-ui.js"></script>
    
    <script src="/front_res/js/com_resInfo.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
    
</head>
<body>
<form:form name="regist" commandName="regist" method="post">
        <c:import url="/web/inc/top_inc.do" />
        <!--header 추가//-->
        <!--// left menu -->
        <c:import url="/web/inc/right_menu.do" />
        <!--left menu //-->
        <!--//floor Btn-->
        <div id="allFloors">
            <div class="contents">
                <div class="flooreArea float_left" id="dv_floor">
                    <c:forEach items="${floorinfo }" var="floorList" varStatus="status">
                       <a href="#" onClick="fn_floorSearch(${floorList.floor_seq }, 'fn_floorMeetingInfo()')" name="btn_floor" id="btn_${floorList.floor_seq}" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
                    </c:forEach>
                    
                </div>               
                <div class="clear"></div>
            </div>
        </div>
        <!--floor Btn//-->
        
        <!--//contents-->
        <div class="contents">
           <div class="line">
            <!--//date picker-->
                <div class="contents mobileM">
                    <div class="float_right">
                    <button type="button" class="resource" onClick="location.href='/web/meetingResource.do'">회의자원현황</button>
                  </div>
                  <div class="dateBox float_left">
                      <input type="text" class="inputSearch" id="searchResStartday" name="searchResStartday"  value="${regist.searchResStartday}" onChange="fn_floorMeetingInfo()">
                      <div class="dateIcon" onClick="fn_floorMeetingInfo()">
                        <a href="#" class="dateBtn">검색</a>
                      </div>
                      <div class="clear"></div>
                   </div>
                   <div class="float_right list_T">
                     <a href="/web/meetingDay.do" class="active dayBtn">day</a>  
                     <a href="/web/resCalendar.do" class="calBtn">calendar</a>  
                   </div>
                   <div class="float_right btnL">
                        <a href="javascript:fn_ViewChange('List')" class="listBtn"></a>  
                        <a href="javascript:fn_ViewChange('Day')" class="active blockBtn"></a>  
                   </div>
                <div class="clear"></div>
                </div>
              <!--date picker//-->
           </div>
           <div class="whiteBack meet">
               <h5>빈 일정 영역을 선택하시면 해당 일에 회의실 예약이 가능합니다</h5>
               <div class="scroll">
                  <div class="clear"></div>
                    <div>
                       <table class="day_T" id="tb_seatTimeInfo">
                           <thead>
                               <tr>
                                   <th class="fixed_th" >회의실</th>
                                   <!--<td colspan="2">8시</td>-->
                                   <td colspan="2">9시</td>
                                   <td colspan="2">10시</td>
                                   <td colspan="2">11시</td>
                                   <td colspan="2">12시</td>
                                   <td colspan="2">13시</td>
                                   <td colspan="2">14시</td>
                                   <td colspan="2">15시</td>
                                   <td colspan="2">16시</td>
                                   <td colspan="2">17시</td>
                                   <!--<td colspan="2">18시</td>-->
                               </tr>
                           </thead>
                           <tbody>
                           </tbody>
                       </table>
                    </div>
                </div>
           </div>
        </div>
        <!--contetns//-->
</form:form>
        

        <!--예약 팝업//-->    
        <!--//needpopup script-->
        <c:import url="/web/inc/unimessage.do" />
        
        <script>  
            $( function() {
            	 $("#searchResStartday").datepicker({ dateFormat: 'yy-mm-dd' });
				 //alert($("#searchResStartday").val());

            	 fn_floorMeetingInfo();
            }); 
        </script>

</body>
</html>