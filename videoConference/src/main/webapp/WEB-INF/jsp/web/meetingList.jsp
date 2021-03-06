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
    <script src="/front_res/js/jquery-ui.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/com_resInfo.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post">
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }" />
<input type="hidden" name="pageSize" id="pageSize"  value="${regist.pageSize }" />
<input type="hidden" name="pageUnit" id="pageUnit"  value="${regist.pageUnit }"/>
<input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq }"/>
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
                       <a href="#" onClick="fn_floorSearch(${floorList.floor_seq }, 'fn_meeingList')" name="btn_floor" id="btn_${floorList.floor_seq }" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
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
                <div class="contents mobileM meetL">
                    <div class="float_right">
                    <button type="button" class="resource" onClick="location.href='/web/meetingResource.do'">??????????????????</button>
                  </div>
                  <div class="dateBox float_left">
                      <input type="text" class="inputSearch" id="searchResStartday" name="searchResStartday" value="${regist.searchResStartday}"  onChange="fn_meeingList()">
                      <div class="dateIcon"  onClick="fn_meeingList()">
                        <a class="dateBtn">??????</a>
                      </div>
                      <div class="clear"></div>
                   </div>
                  <div class="float_right btnL">
                        <a href="javascript:fn_ViewChange('List')" class="active listBtn"></a>  
                        <a href="javascript:fn_ViewChange('Day')" class="blockBtn"></a> 
                    </div>
                <div class="clear"></div>
                </div>
              <!--date picker//-->
           </div>
           <div class="whiteBack meet_list">
               <ul class="list">
                   <c:forEach items="${resultlist }" var="resInfo" varStatus="status">
                   <li>
                       <div class="meetT">
                            <div class="meet_tit float_left">${resInfo.res_title }</div>
                            <div class="meet_subtit float_right">????????? : ${resInfo.empname } ??????: ${resInfo.item_name } </div>
                       </div>
                       <div class="clear"></div>
                       <div class="meetD">
                            ${resInfo.resstartday } ${resInfo.resstarttime }~${resInfo.resendtime }
                       </div>
                   </li>
                   </c:forEach>
                   
               </ul>
               <!--//page number-->
               <div id="dv_page">
                <ul class="page_num">
                  <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
                </ul>
                </div>
               
               <!--page number//-->
           </div>
        </div>
        <!--contetns//-->

        <!--//??????-->
        <!--//?????? ??????-->
        <div id='cancle_popup' class="needpopup">
            <p>
                ?????? ????????? ?????????????????????.
            </p>
        </div>
        <!--?????? ??????-//->
        <!--needpopup script-->
        <script>  
            $( function() {
            	 $( "#searchResStartday" ).datepicker({ dateFormat: 'yy-mm-dd' });
            });
            function fn_meeingList(){
            	 $("form[name=regist]").attr("action", "/web/meetingList.do").submit();
            }
        </script>
</form:form>
</body>
</html>