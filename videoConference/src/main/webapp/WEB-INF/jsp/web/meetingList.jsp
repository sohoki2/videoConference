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
<!--//header 추가-->
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
                       <a href="#" onClick="res.fn_floorSearch(${floorList.floor_seq })" name="btn_floor" id="btn_${floorList.floor_seq }" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
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
                <div class="contents meet_list">
                    <div class="float_right">
                    <button type="button" class="resource margintop15" onClick="location.href='/web/meetingResource.do'">회의자원현황</button>
                  </div>
                  <div class="dateBox float_left">
                      <input type="text" class="inputSearch" id="searchResStartday" name="searchResStartday">
                      <div class="dateIcon">
                        <a class="dateBtn">검색</a>
                      </div>
                      <div class="clear"></div>
                   </div>
                  <div class="float_right btnL">
                        <a href="/web/meetingList.do" class="listBtn"></a>  
                        <a href="/web/meetingDay.do" class="active blockBtn"></a>  
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
                            <div class="meet_subtit float_right">주최자 : ${resInfo.empname } 장소: ${resInfo.meeting_name } </div>
                       </div>
                       <div class="clear"></div>
                       <div class="meetD">
                            ${resInfo.resstartday } ${resInfo.resstarttime }~${resInfo.resendtime }
                       </div>
                   </li>
                   </c:forEach>
                   
               </ul>
               <!--//page number-->
               <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
               
               <!--page number//-->
           </div>
        </div>
        <!--contetns//-->

        <!--//팝업-->
        <!--//퇴실 팝업-->
        <div id='cancle_popup' class="needpopup">
            <p>
                예약 취소가 완료되었습니다.
            </p>
        </div>
        <!--퇴실 팝업-//->
        <!--needpopup script-->
        <script src="/front_res/js/needpopup.min.js"></script>
        <script>  
            $( function() {
            	 $( "#searchResStartday" ).datepicker({ dateFormat: 'yymmdd' });
            	 res.fn_floorInfo();
            });
            var res = {
            		  fn_floorInfo : function(){
            			if (yesterDayConfirm($("#searchResStartday").val() , "지난 일자는 검색 하실수 없습니다" ) == false ) return;
                    	
                    	var params = {'searchCenterId' : $("#searchCenterId").val(), 
                    			      'searchFloorseq' :  $("#floorSeq").val(),
                    			      'searchResStartday' : $("#searchResStartday").val(), 
                    			      'searchSeatView': 'Y' 
                        }; 
                    	var url = "/web/meetingDayAjax.do";
                    	uniAjax(url, params, 
            		     			function(result) {
            						       if (result.status == "LOGIN FAIL"){
            						    	   alert(result.meesage);
            		  						   location.href="/web/Login.do";
            		  					   }else if (result.status == "SUCCESS"){
            		  						    $("#searchResStartday").val(result.result.searchResStartday);
            		  						    $("#searchCenterId").val(result.result.searchCenterId);
            		  						    //버튼 정리 
            		  						    
            		  						    var setHtml = "";
            	  								$("#tb_seatTimeInfo > tbody").empty(); 
            	  								for (var i in result.seatInfo){
            	  									//alert(i);
            	  									var seatinfo = result.seatInfo[i];
            	  									setHtml += "<tr id='swcSeq_"+seatinfo.meeting_id +"' style='height:50px;'>";
            	  									setHtml += "<th style='padding-left: 20px;' title='"+seatinfo.meetingroom_remark+"' class='fixed_th'>"+seatinfo.meeting_name+"</th>";
            	  									//alert(seatinfo.timeInfo);
            	  									console.log(seatinfo.meeting_equpgubun);
            	  									
            	  									if (seatinfo.timeinfo.length < 20){
            	  										setHtml += "<td colspan='20' style='text-aling:center;'>예약 불가</td>";
            	  									}else {
            	  										for (var a  in seatinfo.timeinfo){
            		  										var timeInfo = seatinfo.timeinfo[a];
            		  										var classInfo = "";
            		  										//색갈 넣기 및 예약자 클릭 관련 내용 넣기 \
            		  										if (timeInfo.res_seq == "-1" && timeInfo.apprival == "N" ){
            		  											setHtml += "<td id='"+timeInfo.time_seq+"' class='none'></td>";
            		  										}else if (timeInfo.res_seq != "0" && (timeInfo.apprival == "R")){
            		  											setHtml += "<td id='"+timeInfo.time_seq+"' class='waiting' onclick='fn_resView(&#39;"+timeInfo.res_seq +"&#39;)'></td>";
            		  										}else if (timeInfo.res_seq != "0" && (timeInfo.apprival == "Y" )){
            		  											setHtml += "<td id='"+timeInfo.time_seq+"' class='now' onclick='fn_resView(&#39;"+timeInfo.res_seq +"&#39;)'></td>";
            		  										}else if  (timeInfo.res_seq == "0" && timeInfo.apprival == "N"){
            		  											setHtml += "<td id='"+timeInfo.time_seq+"' data-needpopup-show='#app_meeting' class='popup_view' onclick='fn_resInfo(&#39;"+seatinfo.meeting_id +"&#39;,&#39;"+timeInfo.time_seq +"&#39;,&#39;"+timeInfo.swc_time +"&#39;,&#39;"+ seatinfo.meeting_name +"&#39;,&#39;"+timeInfo.res_seq +"&#39;,&#39;"+seatinfo.meeting_confirmgubun +"&#39;,&#39;"+seatinfo.meeting_equpgubun +"&#39;);'></td>";
            		  										}
            		  									}
            	  									}
            	  									
            	  									//centerId 값 넣기 
            	  									setHtml += "</tr>";
            	  									$("#tb_seatTimeInfo >  tbody:last").append(setHtml);
            	  									setHtml = "";
            	  									
            	  									if ($("#searchCenterId").val(seatinfo.center_id));
            		  					      }
            		  					   }
            						    },
            						    function(request){
            							    alert("Error:" +request.status );	       						
            						    }    		
            		    );
            		}, fn_floorSearch : function (floorSeq){
            			$("#dv_floor").find("[name=btn_floor]").attr('class', '');
            			$("#btn_"+floorSeq).attr('class', 'active');
            			$("#floorSeq").val(floorSeq);
            			res.fn_floorInfo();
            		}
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
</form:form>
</body>
</html>