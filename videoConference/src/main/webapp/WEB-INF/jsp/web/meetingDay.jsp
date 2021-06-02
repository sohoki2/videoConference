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
<input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}">
<input type="hidden" name="searchCenterId" id="searchCenterId" value="${regist.searchCenterId}">
<input type="hidden" id="mode" name="mode" />
<input type="hidden" id="resStartday" name="resStartday" />
<input type="hidden" id="itemId" name="itemId" />
<input type="hidden" id="hid_attendList" name="hid_attendList">
<input type="hidden" id="hid_equipList" name="hid_equipList">

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
                      <button type="button" onClick="res.fn_floorSearch(${floorList.floor_seq })" name="btn_floor" id="btn_${floorList.floor_seq }" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</button>
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
                    <button class="resource" onClick="location.href='meeting_resource.html'">회의자원현황</button>
                  </div>
                  <div class="dateBox float_left">
                      <input type="text" class="inputSearch" id="searchResStartday" name="searchResStartday">
                      <div class="dateIcon">
                        <a class="dateBtn">검색</a>
                      </div>
                      <div class="clear"></div>
                   </div>
                   <div class="float_right list_T">
                     <button type="button" onClick="location.href='/web/meetingDay.do'" class="active dayBtn">day</button>  
                     <button type="button" onClick="location.href='/web/resCalendar.do'" class="calBtn">calendar</button>  
                   </div>
                   <div class="float_right btnL">
                        <button type="button" onClick="location.href='meetingList.do'" class="listBtn"></button>  
                        <button type="button" onClick="location.href='meetingDay.do'" class="active blockBtn"></button>  
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
                                   <th class="fixed_th" >시간</th>
                                   <td colspan="2">8시</td>
                                   <td colspan="2">9시</td>
                                   <td colspan="2">10시</td>
                                   <td colspan="2">11시</td>
                                   <td colspan="2">12시</td>
                                   <td colspan="2">13시</td>
                                   <td colspan="2">14시</td>
                                   <td colspan="2">15시</td>
                                   <td colspan="2">16시</td>
                                   <td colspan="2">17시</td>
                                   <td colspan="2">18시</td>
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
        

           <!--//예약신청 팝업-->
        <div id="app_meeting" class="needpopup">
            <h5 class="pop_tit">예약신청</h5>
            <ul class="form">
              <li>
                <p class="pop_text">회의실: <span id="res_swcName"></span></p>
                
              </li>
              <li style="display:none">
                <select id='resGubun' name="resGubun" onChange="fn_MeetingCheck()">
                      <option>회의실 사용여부</option>
                      <option value="SWC_GUBUN_1">일반 회의실</option>
                      <option value="SWC_GUBUN_2">영상 회의실</option>
                </select>
                
                <input type="radio" name="resPassword" value="Y" id="resPassword_1"><span id="sp_01">공개</span>
                <input type="radio" name="resPassword" value="N" id="resPassword_2"><span id="sp_02">비공개</span>
                
                 <a href="#" onclick="fn_userPop('P')">참가대상</a>
                 <span id="meegintRoomInfo"></span>
              </li>
              <li>
                <p class="pop_text">회의 시간 선택</p>
                <!--  기본값 -->
                <input type="hidden" name="proxyYn" id="proxyYn">
                <input type="hidden" name="seatConfirmgubun" id="seatConfirmgubun">
                
                <span id="sp_ResDay" style="margin-right: 20px;"></span>
                <select id='resStarttime' style="width:120px;"></select>
                ~
                <select id='resEndtime' style="width:120px;"></select>
              </li>
              <li><input type="text" placeholder="제목" name="resTitle" id="resTitle"></li>
              <li><input type="checkbox" id="sendMessage" name="sendMessage" value="Y"> 카카오톡 알림 발송</li>
            </ul>
            <div class="clear"></div>
            <div class="footerBtn">
              <button class="blueBtn" onclick="fn_ResSave();">예약</button>
              <button class="grayBtn">취소</button>
            </div>
            <div class="clear"></div>
        </div>
        
        <!--//예약 완료 팝업-->
        <div id='app_reserve' class="needpopup">
            <p><span id="sp_message"></span></p>
        </div>
        <!--예약 완료 팝업//-->
        
        <button id="btn_meeting" style="display:none" data-needpopup-show='#app_meeting'>확인1</button>
        <button type="button" id="btn_result" style="display:none" data-needpopup-show='#app_reserve'>경고창 보여 주기</button>
        <!--예약 팝업//-->    

        
        <script>
          function myFunction() {
            var popup = document.getElementById("meet_booking_pop");
            popup.classList.toggle("show");
          }
        </script>
        <!--//needpopup script-->
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
            			$("#dv_floor").find("button[name=btn_floor]").attr('class', '');
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

</body>
</html>