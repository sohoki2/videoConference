<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title><spring:message code="URL.TITLE" /></title>
    <!--css-->
    <link href="/front_res/css/kiosk_pc/reset.css" rel="stylesheet" />
    <link href="/front_res/css/kiosk_pc/paragraph.css" rel="stylesheet" />
	<link href="/front_res/css/needpopup.min.css" rel="stylesheet" type="text/css" >
	<!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/jquery-ui.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
    <script src="/front_res/js/panzoom.js" ></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/com_resInfo.js"></script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post">

<input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}" />
<input type="hidden" name="searchCenterId" id="searchCenterId" value="${regist.centerId}" />
<input type="hidden" name="searchResStartday" id="searchResStartday" value="${regist.searchResStartday}" />
<input type="hidden" name="partSeq" id="partSeq" />
<input type="hidden" name="itemGubun" id="itemGubun" value="ITEM_GUBUN_2"/>
<input type="hidden" name="floorInfo" id="floorInfo" />
<input type="hidden" name="authorCode" id="authorCode" />
<input type="hidden" name="loginOK" id="loginOK" />
<input type="hidden" name="hid_history" id="hid_history" />
<input type="hidden" name="resStarttimeKiosk" id="resStarttimeKiosk" value="${regist.nowDate}" />
<input type="hidden" name="resEndtimeKiosk" id="resEndtimeKiosk" value="${regist.endDate}"/>
<input type="hidden" name="seatConfirmgubun" id="seat_confirmgubun" />
<input type="hidden" name="resReqday" id="res_reqday" />	
<input type="hidden" name="itemId" id="itemId" />		
<input type="hidden" name="kioskGubun" id="kioskGubun" value="SEAT"/>
						
 <div class="wrap">
    <div class="contents">
      <header>
        <div class="floatL">
          <h1><img src="/images/logo.png" align="서울관광플라자"></h1>
          <div class="tit">
            <span id="sp_FloorTitle"></span>
            <span>
              서울관광플라자 스마트워크센터 예약 시스템<br/>
              SEOUL TOURISM PLAZA Reservation System
            </span>
          </div>
        </div>
        <div class="floatR">
          <div class="day"><span id="sp_dayInfo"></span></div>
          <div class="time"><strong><span id="sp_timeInfo"></span></strong></div>
        </div>
        <div class="clear"></div>
      </header>
    </div>
    <div class="contents shadow">
      <ul class="floorSel floatL" id="floor_list">
        <c:forEach items="${floorinfo }" var="floorList" varStatus="status">
        <li id="li_${floorList.floor_seq }" name="btn_floor"  class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>"  onclick="res.floorCheck('${floorList.floor_seq}')">
          <em>${floorList.floor_name }</em>
        </li>
        </c:forEach>
      </ul>
      <!--  좌석 도명  -->
      <div class="centerBox floatL" id="seat_floor">
	        <div class="clear"></div>
	        <!--// map -->
	        <div class="mapArea_wrap">
	          <!-- 도면 확대 or 축소 시 버튼(reset_icon) 표출 + 클릭 후 버튼 사라짐 -->
	          <a id="btnResetZoom" class="reset_icon" style="display: none;"></a>
	          <div class="seat_map">
	            <div class="map_back_box" tabindex="0">
	              <div id="lipsum" class="mapArea zoomable">
	              <div class="seat">
	                <ul id="seat_list">
	                </ul>
	              </div>
	            </div> 
	          </div>
	        </div>
	      </div>
	  </div>
      <!-- 좌석 도명 끝 부분 -->
      <!-- 미팅 상태 시작 -->
      <div class="centerBox floatL" id="meet_floor">
        <div class="meet_table">
          <div class="meet_contents">
            <table id="tb_meetingState">
              <thead>
                <tr>
                  <th>회의실</th>
                  <th>09:00</th>
                  <th>09:30</th>
                  <th>10:00</th>
                  <th>10:30</th>
                  <th>11:00</th>
                  <th>11:30</th>
                  <th>12:00</th>
                  <th>12:30</th>
                  <th>13:00</th>
                  <th>13:30</th>
                  <th>14:00</th>
                  <th>14:30</th>
                  <th>15:00</th>
                  <th>15:30</th>
                  <th>16:00</th>
                  <th>16:30</th>
                  <th>17:00</th>
                  <th>17:30</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <!-- 미팅 상태 끝 부분 -->
    <div class="sideBox floatR">
      <div class="count">
        <strong><span id="sp_total"></span>석</strong> 사용가능</span> / <span class="use">사용좌석 <span id="sp_useSeat"/>석
      </div>
	    
	    
	    <!-- //인증 전-->
	    <div id="dv_preInfo">
		    <div class="info">
		          휴대폰 인증 후 예약 가능합니다.
		    </div>
		    <p class="info_sub" >좌석 예약 이용 시 인증을 먼저해주세요.</p>
        </div> 
         <!-- //인증 전-->
        <div id="dv_LoginInfo">
	        <div class="info" id="dv_info">
	        </div>
	        <p class="info_sub">좌석을 선택해주세요.</p>
        </div>
        <!-- //인증 후-->
        <div class="button">
          <button type="button" class="userBtn" id="btn_login" onClick="res.fn_empInput()"><p>휴대폰 인증</p><span>User-check</span></button>
          <button type="button" class="meetBtn" onClick="res.fn_meetingInfo()" id="btn_meetingBtn"><p>회의실 현황</p><span>Meeting room Status</span></button>
        </div>
        <div class="useinfo">
          <h5>이용안내</h5>
          <ul>
            <li>010을 제외한 8자리 숫자로 휴대폰 인증을 수행합니다</li>
            <li>예약을 원하는 좌석을 선택합니다 </li>
            <li>좌석 선택 후 팝업에서 시작시간 - 종료시간을 선택합니다</li>
            <li>선택 좌석 및 시간 정보 확인 후 예약하기 버튼을 터치하여 예약을 완료합니다  </li>
          </ul>
        </div>
      </div>
      <div class="clear"></div>
    </div>

    <!--//번호인증 팝업-->
    <div id="mem_num" class="needpopup"  style="display: none;">
     <div class="top">
       <input type="text" name="userId" id="userId" placeholder="휴대폰 번호를 입력해주세요">
       <p>좌석 예약을 위해 010을 제외한 휴대폰 번호 뒤 8자리를 입력해주세요</p>
     </div>
     <div class="key_num">
       <ul>
         <li onClick="res.fn_keyNumber('1')">1</li>
         <li onClick="res.fn_keyNumber('2')">2</li>
         <li onClick="res.fn_keyNumber('3')">3</li>
         <li onClick="res.fn_keyNumber('4')">4</li>
         <li onClick="res.fn_keyNumber('5')">5</li>
         <li onClick="res.fn_keyNumber('6')">6</li>
         <li onClick="res.fn_keyNumber('7')">7</li>
         <li onClick="res.fn_keyNumber('8')">8</li>
         <li onClick="res.fn_keyNumber('9')">9</li>
         <li class="delete" onClick="res.fn_keyNumber('B')">delete</li>
         <li onClick="res.fn_keyNumber('0')">0</li>
         <li class="ok" onClick="res.fn_login()">확인</li>
       </ul>
     </div>
   </div>
   <!--번호인증 팝업//-->    



   <!--//시간선택 팝업-->
   <div id="openTime" class="needpopup"  style="display: none;">
	     <div class="time">
	       <div class="seat_info">
	         좌석 명<span class="blueFont" id="sp_seatName">4F 01</span> 번 좌석
	      </div>
	      <div class="select_time">
	        <p>* 예약을 원하는 시작 시간과 종료 시간을 선택해주세요 *</p>
	        <div class="sel_box">
	          <div class="sel_inner_box" id="reserve_list">        
		      </div>         
		  </div>
		  <div class="pop_meeting_btn">
		    <a href="javascript:res.reserve_meeting()" class="blueBtn meeting_btn">좌석 예약</a>
		  </div>
	    </div>
  </div>
  <!--시간선택 팝업//-->    
  


 <!--//예약정보 팝업-->
 
   <div id="check_in_popup" class="needpopup"  style="display: none;">
    <div class="pop_top">
     <h5 class="pop_h5">예약정보 확인</h5>
     <p>예약좌석과 예약시간을 확인해주세요.</p>
    </div>
    <table>
      <tbody>
        <tr>
          <th>예약자</th>
          <td><span id="sp_resName"></span></td>
        </tr>
        <tr>
          <th>예약 좌석</th>
          <td><span id="sp_roomNm"></span></td>
        </tr>
        <tr>
          <th>예약 시간</th>
          <td><span id="sp_resDay">2021년05월10일</span>
            <span id="sp_resStartTime">08:00</span> ~ <span id="sp_resEndTime">18:00</span>
          </td>
        </tr>
      </tbody>
    </table>
    
    <div class="footer_btn">
      <button type="button" class="graybtn floatL" onClick="need_close();res.fn_reset()">닫기</button>
      <button type="button" class="oranbtn floatL" onClick="res.fn_ResSave()">예약</button>
      <div class="clear"></div>
    </div>
   </div>
   <!--예약정보 팝업//-->   

 <!--//예약완료 팝업-->
   <div id="reserve_pop" class="needpopup"  style="display: none;">
     <div class="popup_con">
            <span id="sp_stateTxt"></span>
     </div>
   </div>
   <!--예약완료 팝업//-->   



 <!--//임직원 정보 팝업-->
   <div id="mem_info" class="needpopup"  style="display: none;">
     <p>홍길동 | 서울관광플라자</p>
     <p>9F 1번좌석</p>
   </div>
   <!--임직원 정보 팝업//-->   



  <a data-needpopup-show="#reserve_pop"  style="display:none"  class="rightGBtn" id="btn_checkIn">예약 취소</a>
  <a data-needpopup-show="#mem_num"  style="display:none"  class="rightGBtn" id="btn_empInput">사번 입력창</a>
  <a data-needpopup-show="#openTime"  style="display:none"  class="rightGBtn" id="btn_SeatRes">예약 창 설정</a>
  <a data-needpopup-show="#check_in_popup"  style="display:none"  class="rightGBtn" id="btn_SeatResInfo">예약 창 설정</a>
  
<!--needpopup script-->
<script>
	$( function() {
		$("#kioskGubun").val("SEAT");
		res.fn_rightBtn($("#kioskGubun").val());
		res.fn_loginForm("LOGOUT");
		
	});
	function fn_nowTime(){
		let today = new Date();   
		let hours =  stringLength( today.getHours(), "2", "0"); // 시
		let minutes = stringLength( today.getMinutes(), "2", "0");  // 분
		return hours +""+minutes;
		
	}
	function fn_seatTime(){
		var url = "/web/kioskSeatInfoTime.do";
		params = {'floorSeq' : $("#floorSeq").val()};
		uniAjaxSerial(url, params, 
				function(result) {
					if (result.status == "SUCCESS"){
						   //총 게시물 정리 하기
						   if (result.regist.timeInfo!= null){
							   var obj = result.regist.timeInfo;
							   $("#sp_dayInfo").html(obj.dayinfo +"<br>"+obj.weekinfo);
							   $("#sp_timeInfo").html("<strong>"+obj.timeinfo+"<strong>");
						   }
						   if (result.regist.floorInfo!= null)
							   $("#sp_FloorTitle").html("<p>"+result.regist.floorInfo.floor_name+"</p>");
						   res.fn_floorInfo();
					   }
					},
					function(request){
						alert("Error:" +request.status );	   
						$("#btn_needPopHide").trigger("click");
					}    		
		);
		// 60초 후 정리 하기 
		window.setTimeout("res.fn_floorInfo()", 60000);
	}
	
    var res = {
		   fn_floorInfo : function(){
			    var url = "/backoffice/resManage/seatStateInfo.do";
				var params = {"swcResday" : $("#searchResStartday").val().replaceAll("-",""), 
	  					      "floorSeq" : $("#floorSeq").val(), 
	  					       "seatUseyn" : "Y", 
	  					      "resStarttime" : $("#resStarttimeKiosk").val(), 
	  					      "resEndtime" : $("#resEndtimeKiosk").val()
	  					      };
				uniAjax(url, params, 
		      			function(result) {
					          if (result.status == "SUCCESS"){
		   						   //총 게시물 정리 하기
		   						   if(result.seatMapInfo != null){
	 									var img=   $("#partSeq").val() != "" ? result.seatMapInfo.part_map1 : result.seatMapInfo.floor_map;
	 									$('.mapArea').css({"background":"#fff url(/upload/"+img+")", 'background-repeat' : 'no-repeat', 'background-position':' center'});
	 								 }else{
	 									$('.mapArea').css({"background":"#fff url()", 'background-repeat' : 'no-repeat', 'background-position':' center'});
	 							   }
		   						   var totalSeat = 0;
		   						   var useSeat = 0;
		   						   var resSeat = 0;
		 				    	   if(result.resultlist.length > 0){
		 				    		   var shtml = "";
		 				    		   var obj = result.resultlist;
		 				    		   for (var i in result.resultlist) {
		 				    			   if (obj[i].state_info === 'Y'){
		 				    				  resSeat = parseInt(resSeat) + 1;   
		 				    			   }else {
		 				    				  useSeat = parseInt(useSeat) + 1;  
		 				    			   }
		 				    			   totalSeat = parseInt(totalSeat) + 1;
		 				    			   var classinfo = (obj[i].state_info === 'Y' ) ? "seatUse" : "none";  
		 				    			   var script =  "res.fn_openTimeKiosk('"+ obj[i].seat_id +"', '"+classinfo+"', '"+obj[i].seat_gubun+"','"+ obj[i].seat_name+"','"+ obj[i].seat_confirmgubun+"','"+ obj[i].res_reqday+"');"; 
		 				    			   shtml += '<li id="s'+NVL(obj[i].seat_name) +'" onClick="'+script+ '" class="'+classinfo+'" seat-id="'+ obj[i].seat_id +'" name="'+obj[i].seat_id +'" >'+ NVL(obj[i].seat_name) +'</li>';
										   }
										   $('#seat_list').html(shtml);
		 				    		   for (var i in result.resultlist) {
											 $('.mapArea ul li#s' + NVL(obj[i].seat_name) ).css({"top" : NVL(obj[i].seat_top)+"px", "left" : NVL(obj[i].seat_left)+"px"});
										   }
		 				    		   $("#sp_total").text(resSeat);
		 				    		   $("#sp_useSeat").text(useSeat);
		 				    		   //상태 표시 넣기 
		 				    	   } 
		 				    	   
		 				    	   
		   					   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }    		
		        );
			}, fn_openTimeKiosk : function(seat_id, classinfo, seatGubun, seat_name,seat_confirmgubun, res_reqday){
				if ($("#loginOK").val() == "OK" && $("#userId").val() != ""){
					//좌석 예약 
					res.fn_reset();
					$("#itemId").val(seat_id);
					$("#hid_history").val("");
					$("#sp_seatName").text(seat_name);
					
					$("#seat_confirmgubun").text(seat_confirmgubun);
					$("#res_reqday").text(res_reqday);
					
					var url = "/web/selectTimeInfoKiosk.do";
					var params = {"itemId" :seat_id, "userId" :  $("#userId").val(), "searchResStartday" : $("#searchResStartday").val().replaceAll("-","")};
					uniAjax(url, params, 
			      			function(result) {
						          
			 				      if (result.status == "SUCCESS"){
			   						   //총 게시물 정리 하기
			 				    	   if(result.resultlist.length > 0){
			 				    		  var shtml = "";
			 				    		  var obj = result.resultlist;
			 				    		  $("#reserve_list").empty();
			 				    		  for (var i in result.resultlist){
			 				    			  if ( parseInt(obj[i].res_seq) >  -1){
			 				    				  shtml= "<div class=\"menu_box\">"
		     		                                  + " <ul class=\"sel_list etrans\">"
		     		                                  + "   <li class=\"sel_list_time\">"+ obj[i].swc_times+"~"+obj[i].swc_timee+"</li>"
		     		                                  + "   <li class=\"sel_list_txt\">";
		     		                                  if (obj[i].res_seq == "0"){
		     		                                	 shtml +=   " <label for=\"ex_chk04\">선택이 가능합니다</label>"	  
		     		                                	       + "    <input type=\"checkbox\" id=\"show_time\" name=\"show_time\"  value="+obj[i].swc_time+">";
		     		                                  }else {
		     		                                	 shtml +=   " <label for=\"ex_chk04\"><a href=''>예약된 좌석 입니다.</a></label>"	  
		     		                                	       + "    "; 
		     		                                  }
		     		                                
		     		                             shtml += "   </li>"
		     		                                   + " </ul>"
		     		                                   + "</div>";
		     		                             $("#reserve_list").append(shtml);
			 				    			   }
			 				    		  }
			 				    		  $("#btn_SeatRes").trigger("click");  
			 				    		  
			 				    	   }
			   					   }else {
			   						 $("#sp_stateTxt").html("<p>"+result.message+"</p>");
			   						 $("#btn_checkIn").trigger("click");
			   					   }
			 				    },
			 				    function(request){
			 					    alert("Error:" +request.status );	   
			 					    $("#btn_needPopHide").trigger("click");
			 				    }    		
			         );
					
				}else {
					 //로그인 하기 
					$("#sp_stateTxt").html("<p>로그인 후 사용 가능 합니다.</p>");
					$("#btn_checkIn").trigger("click");
				}
			}, fn_reset : function(){
				 $("#itemId").val("");
				 $("#seatConfirmgubun").val("");
				 $("#resReqday").val("");
			}, reserve_meeting : function (){
				//우축 메뉴 클릭으로 해서 예약 하기 
				
				$("#p_seatNm").text($("#sp_seatName").text());
				$("#sp_roomNm").text($("#sp_seatName").text());
				
				$("#sp_resDay").text($("#searchResStartday").val());
				var checkItem = checkbox_val("체크된 값이 없습니다", "show_time");
				if (checkItem != false){
					const tempToArray = checkItem.split(',')
					var minVal = Math.min.apply(null, tempToArray);
					var maxVal = Math.max.apply(null, tempToArray);
					$("#resStarttimeKiosk").val(stringLength(String(minVal), "4", "0"));
					$("#resEndtimeKiosk").val(stringLength(String(maxVal), "4", "0"));
					$("#sp_resStartTime").text(timeComma(stringLength(String(minVal), "4", "0"),"S"));
					$("#sp_resEndTime").text(timeComma(stringLength(String(maxVal), "4", "0"),"E"));
					$("#hid_history").val("res.reserve_meeting");
					$("#btn_SeatResInfo").trigger("click");
				}else{
					
				}
				
			},fn_keyNumber : function(Num){
    			var userId =  $("#userId").val();
    			if (Num == "C"){
    				$("#userId").val("");
    				
    			}else if (Num == "B" && userId !=""){
    					$("#userId").val(userId.substring(0, parseInt(userId.length -1) )); 
    			}else {
    				userId += Num;
    				$("#userId").val(userId);
    			}
    		}, fn_login : function(){
    			//사용자 로그인
    			var params = {'userId' : $("#userId").val(), 'mode': 'S', 'resSeq' : $("#resSeq").val() , 'floorSeq' : $("#floorSeq").val()};
				uniAjax("/web/resLoginCheckAjax.do", params, 
			 			function(result) {
					           if (result.status == "SUCCESS"){
								   //테이블 정리 하기
								   $("#dv_info").html(result.resultVO.empname+"|"+ result.resultVO.deptname);
								   $("#sp_resName").text(result.resultVO.empname);
								   $("#loginOK").val("OK");
								   res.fn_loginForm("LOGIN");
							   }else {
								   $("#userId").val("");
								   res.fn_hideMessage("해당 사원 정보가 없습니다.", "checkIn");
								   res.fn_loginForm("LOGOUT");
							   }
						    },
						    function(request){
								 $("#userId").val("");
						    	res.fn_hideMessage("처리 도중 문제가 발생하였습니다.", "checkIn");
						    	res.fn_loginForm("LOGOUT");
						    }    		
			     );	
    			
    		}, fn_hideMessage : function (resMessage, _panel){
    			$("#sp_stateTxt").html("<p>"+resMessage+"</p>");
				$("#btn_checkIn").trigger("click");
		    }, fn_loginForm : function(_check){
		    	if (_check == "LOGIN"){
		    		$("#dv_preInfo").hide();
		    		$("#dv_LoginInfo").show();
		    		$("#btn_login").html("<p>로그 아웃</p><span>User-Logout</span>");
		    		needPopup.hide();
		    		
		    	}else {
		    		$("#dv_preInfo").show();
		    		$("#dv_LoginInfo").hide();
		    		$("#btn_login").html("<p>휴대폰 인증</p><span>User-check</span>");
		        	
		    	}
		    }, fn_empInput : function(){
		    	if ($("#userId").val() == ""){
		    		$("#btn_empInput").trigger("click");
		    	}else {
		    		$("#sp_stateTxt").html("<p>로그 아웃 하셨습니다.</p>");
					$("#btn_checkIn").trigger("click");
					$("#userId").val("")
					$("#loginOK").val("");
                    //좌석 예약으로 넘기기
					res.fn_loginForm("LOGOUT");
					$("#kioskGubun").val("SEAT");
					res.fn_rightBtn($("#kioskGubun").val());
		    	}
		    }, fn_ResSave : function(){
		   	 
			   	 var resEqupcheck = "";
			   	 //장기 예약 할떄도 처리 준비 하기 
			   	 if ( $("#itemGubun").val() == "ITEM_GUBUN_2"){
			   	     $("#hid_history").val("res_show");
			   	    
			   	 }else {
			   	     if (any_empt_line_span("resTitle", '회의 제목을 입력해 주세요.') == false) return;
			   		 if (any_empt_line_span("resStarttime", '회의 시작 시간을 선택해 주세요.') == false) return;
			   		 if (any_empt_line_span("resEndtime", '회의 종료 시간을 선택해 주세요.') == false) return;
			   		 if (fn_TimeCheck ( "resStarttime",  "resEndtime", "시작 시간이 종료 시간보다 빠릅니다" ) == false) return;
			   		 if (any_empt_line_span("resGubun", '회의 구분을 선택해 주세요.') == false) return;
			   		 if ($("#div_equipRoomInfo").is(":visible") == true){
			   	           if (any_empt_line_span("resEqupcheck", '장비사용 여부를 선택해 주세요.') == false) return;
			   		 }
			   		 if ($("#resGubun").val() == "SWC_GUBUN_2"  && $("#meetingSeq").val() == ""){
			   			 $("#sp_errorMessage").html("영상회의를 진행할 회의실을 선택해 주세요.");	 
			   			 return;
			   		 }
			   		 if ($("#resEqupcheck").val() == "장비 사용여부"){
			   	         resEqupcheck = "RES_EQUPCHECK_1";
			   		 }else {
			   			 resEqupcheck = $("#resEqupcheck").val();
			   		 }
			   		 if ($("#meetingSeq").val() == "on")
			   	         $("#meetingSeq").val("");
			   	 }
			   	 var resTitle =  $("#sp_seatName").text();
			   	 var params = {'mode': "Ins", 'itemId': $("#itemId").val(), 'itemGubun':$("#itemGubun").val(), 
			   	               'resTitle' : resTitle, 'resPassword' : 'Y', 
			   	               'resStartday' : $("#searchResStartday").val().replaceAll("-","") , 'resEndday' : "",
			   			       'resStarttime' : $("#resStarttimeKiosk").val(), 'resEndtime' : $("#resEndtimeKiosk").val(),
			   			       'proxyUserId' :  $("#userId").val(), 'resGubun' : "SWC_GUBUN_4",
			   			       'useYn' : "Y", 'centerId': $("#searchCenterId").val(),
			   			       'proxyYn' :  $("#proxyYn").val(),  'meetingSeq' : "", 
			   			       'seatConfirmgubun': $("#seatConfirmgubun").val(),
			   			       'resAttendlist' : "",
			   			       'conNumber' : "", 'conPin' : $("#conPin").val(),
			   			       'conVirtualPin' :"", 'conAllowstream' : "N" ,
			   			       'conBlackdial' : "N" , 'conSendnoti' : "N",
			   			       'resEqupcheck' : "RES_EQUPCHECK_1", 
			   			       'sendMessage' : 'N',
			   			       'floorSeq' : $("#floorSeq").val(), 'resRemark' : "", 'resPerson' : "0"
			   	              };
			   	 
			   	 uniAjax("/web/resReservertionKioskUpdate.do", params, 
			  			function(result) {
							       if (result.status == "SUCCESS"){

							   		
							    	    $("#resStarttimeKiosk").val(fn_nowTime());
							    	    $("#resEndtimeKiosk").val("1730");
							    	    res.fn_empInput();
							    	    res.fn_floorInfo();
							    	    res.fn_hideMessage(result.message, "checkIn");
							    	    
								   }else {
									    res.fn_hideMessage(result.message, "checkIn");
								   }
							    },
							    function(request){
								    alert("Error:" +request.status );	       						
							    }    		
			      );
		            
		   }, floorCheck : function (floorSeq){
			   //체크값 넣기 
			   $("#floor_list").find("[name=btn_floor]").attr('class', '');
			   $("#li_"+floorSeq).attr('class', 'active');
			   $("#floorSeq").val(floorSeq);
			   if ($("#kioskGubun").val() == "SEAT"){
				   //좌석 정보 보여 주기 
				   fn_seatTime();
			   }else{
				   //회의실 정보 보여주기 
				   res.fn_meetingState();
			   }
		   }, fn_meetingInfo : function(){
			   if ($("#loginOK").val() == "OK" && $("#userId").val() != ""){
				   var kioskGubun = $("#kioskGubun").val();
				   kioskGubun =  (kioskGubun == "SEAT") ? "MEETING" :  "SEAT";
				   $("#kioskGubun").val(kioskGubun);
				   res.fn_rightBtn(kioskGubun); 
			   }else {
					 //로그인 하기 
					$("#sp_stateTxt").html("<p>로그인 후 사용 가능 합니다.</p>");
					$("#btn_checkIn").trigger("click");
				}
		   }, fn_rightBtn : function(msgGubun){
			   var btn_message = (msgGubun == "SEAT") ?"<p>회의실 현황</p><span>Meeting room Status</span>":"<p>좌석 예약</p><span>Seat Reserve</span>";
			   $("#btn_meetingBtn").html(btn_message);
			   if (msgGubun == "SEAT"){
				   //좌석 정보 보여 주기 
				   $("#seat_floor").show();
				   $("#meet_floor").hide();
				   fn_seatTime();
			   }else{
				   //회의실 정보 보여주기
				   $("#seat_floor").hide();
				   $("#meet_floor").show();
	               res.fn_meetingState();
			   }
		   }, fn_meetingState : function(){
			   var params = {'userId' : $("#userId").val()};
			   uniAjax("/web/meetingFloorInfo.do", params, 
			 			function(result) {
				           if (result.status == "SUCCESS"){
							   $("#floor_list").empty();
							   $("#floorSeq").val(result.floorSeq);
							   var obj = result.floorinfo;
							   var shtml = "";
							   for (var i in result.floorinfo){
								   var varCheck = (obj[i].floor_seq == $("#floorSeq").val()) ? "active" : "";
								   shtml = " <li class='"+varCheck+"' id='li_"+obj[i].floor_seq+"' name='btn_floor' onclick='res.floorCheck($#39;"+obj[i].floor_seq+"$#39;)'><em>"+obj[i].floor_name+"</em></li>";
								   $("#floor_list").append(shtml);
							   }
							   //회의실 정보 보여 주기 
							   res.fn_meetingState();
						   }else {
							   res.fn_hideMessage(result.message , "checkIn");
						   }
						},
						function(request){
					  	   res.fn_hideMessage(result.message, "checkIn");
						}    		
			   );	
		   }, fn_meetingState : function(){
			   //회의실 상태 정보 보여  주기 
			     var params = {'userId' : $("#userId").val(), 
					           'searchCenterId' : $("#searchCenterId").val(), 
						       'searchFloorseq' :  $("#floorSeq").val(),
						       'searchResStartday' : $("#searchResStartday").val().replaceAll("-",""), 
						       'searchRoomType' : $("#searchRoomType").val(),
						       'searchSeatView': 'Y' 
			     }; 
			     var url = "/web/meetingDayAjaxKiosk.do";
				 uniAjax(url, params, 
			     			function(result) {
							       if (result.status == "LOGIN FAIL"){
							    	   alert(result.meesage);
			  						   location.href="/web/Login.do";
			  					   }else if (result.status == "SUCCESS"){
			  						    $("#searchResStartday").val(day_convert(result.result.searchResStartday));
			  						    $("#searchCenterId").val(result.result.searchCenterId);
			  						    var setHtml = "";
										$("#tb_meetingState > tbody").empty(); 
										
										for (var i in result.seatInfo){
											var seatinfo = result.seatInfo[i];
											setHtml += "<tr>";
											setHtml += "<th>"+seatinfo.meeting_name+"</th>";
											if (seatinfo.timeinfo.length < 18){
												setHtml += "<td colspan='18' style='text-aling:center;'>예약 불가</td>";
											}else {
												//console.log("seatinfo.res_reqday:" + seatinfo.res_reqday)
												var rowCol = 0;
												var rowResseq = "";
												var rowInfo = "";
												var resTitle = "";
												var resStart = "";
												console.log("<resStart>" + resStart);

												for (var a  in seatinfo.timeinfo){
			  										var timeInfo = seatinfo.timeinfo[a];
			  										var classInfo = "";
			  										//색갈 넣기 및 예약자 클릭 관련 내용 넣기 \
			  										if (timeInfo.res_seq == "-1" && timeInfo.apprival == "N" ){
														setHtml += "<td id='"+timeInfo.time_seq+"' class='none'></td>";
			  										}else if ((timeInfo.res_seq == "0" || timeInfo.res_seq == "-1")  &&  rowResseq != "0"){
														var resInfo = resTitle.split("|");
														setHtml += "<td colspan='"+rowCol+"'><div class='"+resInfo[1]+"'>"+resInfo[0]+"</div></td>";
														rowResseq = timeInfo.res_seq;
														rowCol = 1;
														resTitle= "";
													}else if (timeInfo.res_seq != "0" ){
														if (timeInfo.res_seq != parseInt(rowResseq) && resStart != ""){
															var resInfo = resTitle.split("|");
															setHtml += "<td colspan='"+rowCol+"'><div class='"+resInfo[1]+"'>"+resInfo[0]+"</div></td>";
															rowResseq = timeInfo.res_seq;
															rowCol = 1;
														    resTitle= "";
														}else if (timeInfo.res_seq != parseInt(rowResseq) && resStart == ""){
															rowResseq = timeInfo.res_seq;
															resTitle = timeInfo.res_info;
                                                            rowCol = parseInt(rowCol)+1;
															resStart = "S";
														}else{
															resTitle = timeInfo.res_info;
                                                            rowCol = parseInt(rowCol)+1;
														}
			  										}else if  (timeInfo.res_seq == "0" && timeInfo.apprival == "N"){
														setHtml += "<td></td>";
			  										}
			  									}
											}
											//centerId 값 넣기 
											setHtml += "</tr>";
											$("#tb_meetingState >  tbody:last").append(setHtml);
											setHtml = "";
											
			  					      }
			  					   }
							},
						    function(request){
							    alert("Error:" +request.status );	       						
						    }    		
			    );   
		   }
		
    } 
</script>
<script src="/front_res/js/needpopup.min.js"></script>
<script>  
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
<script type="text/javascript">
  var area = document.querySelector('.zoomable')
  var instance = "";

  instance  = panzoom(area, { 
    bounds: true,
    beforeWheel: false,
    boundsPadding: 0.9,
    maxZoom: 3,
    minZoom: 0.9,
    rangeStep: 0.05,
    zoomDoubleClickSpeed: 1,
  });

  instance.zoomAbs(
    600, // initial x position
     0, // initial y position 
     0.5 // initial zoom 
  );


  $("#btnResetZoom").on("click",function(){
    resetBuilding();
    $('#btnResetZoom').hide();
  });
</script>

</form:form>
</body>
</html>