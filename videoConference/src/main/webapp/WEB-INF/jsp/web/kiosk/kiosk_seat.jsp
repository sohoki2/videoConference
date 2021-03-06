<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<html>
<head>
    <meta charset="utf-8">
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
	<style>
	input[type=text]::-ms-clear{
	  display: none;
	  }
	input[type=password]::-ms-reveal{
	  display: none;
	  }
	</style>
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
          <h1><img src="/images/logo.png" align="?????????????????????"></h1>
          <div class="tit">
            <span id="sp_FloorTitle"></span>
            <div class="tit_con">
              <p>????????????????????? ????????????????????? ?????? ?????????</p>
			  <p>SEOUL TOURISM PLAZA Reservation System</p>
            </div>
          </div>
        </div>
        <div class="floatR">
          <div class="day"><span id="sp_dayInfo"></span></div>
          <div class="time"><span id="sp_timeInfo"></span></div>
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
      <!--  ?????? ??????  -->
      <div class="centerBox floatL" id="seat_floor">
	        <div class="clear"></div>
	        <!--// map -->
	        <div class="mapArea_wrap">
	          <!-- ?????? ?????? or ?????? ??? ??????(reset_icon) ?????? + ?????? ??? ?????? ????????? -->
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
      <!-- ?????? ?????? ??? ?????? -->
      <!-- ?????? ?????? ?????? -->
      <div class="centerBox floatL" id="meet_floor">
        <div class="meet_table">
          <div class="meet_contents">
            <table id="tb_meetingState">
              <thead>
                <tr>
                  <th>?????????</th>
                  <th id="th_0900">09:00</th>
                  <th id="th_0930">09:30</th>
                  <th id="th_1000">10:00</th>
                  <th id="th_1030">10:30</th>
                  <th id="th_1100">11:00</th>
                  <th id="th_1130">11:30</th>
                  <th id="th_1200">12:00</th>
                  <th id="th_1230">12:30</th>
                  <th id="th_1300">13:00</th>
                  <th id="th_1330">13:30</th>
                  <th id="th_1400">14:00</th>
                  <th id="th_1430">14:30</th>
                  <th id="th_1500">15:00</th>
                  <th id="th_1530">15:30</th>
                  <th id="th_1600">16:00</th>
                  <th id="th_1630">16:30</th>
                  <th id="th_1700">17:00</th>
                  <th id="th_1730">17:30</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <!-- ?????? ?????? ??? ?????? -->
    <div class="sideBox floatR">
      <div class="count">
        <strong><span id="sp_total"></span>???</strong> ????????????</span> / <span class="use">???????????? <span id="sp_useSeat"/>???
      </div>
	    
	    
	    <!-- //?????? ???-->
	    <div id="dv_preInfo">
		    <div class="info">
		          ????????? ?????? ??? ?????? ???????????????.
		    </div>
		    <p class="info_sub" >?????? ?????? ?????? ??? ????????? ??????????????????.</p>
        </div> 
         <!-- //?????? ???-->
        <div id="dv_LoginInfo">
	        <div class="info" id="dv_info">
	        </div>
	        <p class="info_sub">????????? ??????????????????.</p>
        </div>
        <!-- //?????? ???-->
        <div class="button">
          <button type="button" class="userBtn" id="btn_login" onClick="res.fn_empInput()"><p>????????? ??????</p><span>User-check</span></button>
          <button type="button" class="meetBtn" onClick="res.fn_meetingInfo()" id="btn_meetingBtn"><p>????????? ??????</p><span>Meeting room Status</span></button>
        </div>
        <div class="useinfo">
          <h5>????????????</h5>
          <ul>
            <li>010??? ????????? 8?????? ????????? ????????? ????????? ???????????????</li>
            <li>????????? ????????? ????????? ??????????????? </li>
            <li>?????? ?????? ??? ???????????? ???????????? - ??????????????? ???????????????</li>
            <li>?????? ?????? ??? ?????? ?????? ?????? ??? ???????????? ????????? ???????????? ????????? ???????????????  </li>
          </ul>
        </div>
      </div>
      <div class="clear"></div>
    </div>

    <!--//???????????? ??????-->
    <div id="mem_num" class="needpopup"  style="display: none;">
     <div class="top">
       <input type="text" name="userId" id="userId" placeholder="????????? ????????? ??????????????????">
       <p>?????? ????????? ?????? 010??? ????????? ????????? ?????? ??? 8????????? ??????????????????</p>
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
         <li class="delete" onClick="res.fn_keyNumber('B')"  style="height:54px"><font color="white" style="display:none">delete</font></li>
         <li onClick="res.fn_keyNumber('0')">0</li>
         <li class="ok" onClick="res.fn_login()">??????</li>
       </ul>
     </div>
   </div>
   <!--???????????? ??????//-->    



   <!--//???????????? ??????-->
   <div id="openTime" class="needpopup"  style="display: none;">
	     <div class="time">
	       <div class="seat_info">
	         ?????? ???<span class="blueFont" id="sp_seatName">4F 01</span> ??? ??????
	      </div>
	      <div class="select_time">
	        <p>* ????????? ????????? ?????? ????????? ?????? ????????? ?????????????????? *</p>
	        <div class="sel_box">
	          <div class="sel_inner_box" id="reserve_list">        
		      </div>         
		  </div>
		  <div class="pop_meeting_btn">
		    <a href="javascript:res.reserve_meeting()" class="blueBtn meeting_btn">?????? ??????</a>
		  </div>
	    </div>
  </div>
  <!--???????????? ??????//-->    
  


 <!--//???????????? ??????-->
 
   <div id="check_in_popup" class="needpopup"  style="display: none;">
    <div class="pop_top">
     <h5 class="pop_h5">???????????? ??????</h5>
     <p>??????????????? ??????????????? ??????????????????.</p>
    </div>
    <table>
      <tbody>
        <tr>
          <th>?????????</th>
          <td><span id="sp_resName"></span></td>
        </tr>
        <tr>
          <th>?????? ??????</th>
          <td><span id="sp_roomNm"></span></td>
        </tr>
        <tr>
          <th>?????? ??????</th>
          <td><span id="sp_resDay">2021???05???10???</span>
            <span id="sp_resStartTime">08:00</span> ~ <span id="sp_resEndTime">18:00</span>
          </td>
        </tr>
      </tbody>
    </table>
    
    <div class="footer_btn">
      <button type="button" class="graybtn floatL" onClick="need_close();res.fn_reset()">??????</button>
      <button type="button" class="oranbtn floatL" onClick="res.fn_ResSave()" style="Background:#FBA10A">??????</button>
      <div class="clear"></div>
    </div>
   </div>
   <!--???????????? ??????//-->   

 <!--//???????????? ??????-->
   <div id="reserve_pop" class="needpopup"  style="display: none;">
     <div class="popup_con">
            <span id="sp_stateTxt"></span>
     </div>
   </div>
   <!--???????????? ??????//-->   



 <!--//????????? ?????? ??????-->
   <div id="mem_info" class="needpopup"  style="display: none;">
     <p>????????? | ?????????????????????</p>
     <p>9F 1?????????</p>
   </div>
   <!--????????? ?????? ??????//-->   



  <a data-needpopup-show="#reserve_pop"  style="display:none"  class="rightGBtn" id="btn_checkIn">?????? ??????</a>
  <a data-needpopup-show="#mem_num"  style="display:none"  class="rightGBtn" id="btn_empInput">?????? ?????????</a>
  <a data-needpopup-show="#openTime"  style="display:none"  class="rightGBtn" id="btn_SeatRes">?????? ??? ??????</a>
  <a data-needpopup-show="#check_in_popup"  style="display:none"  class="rightGBtn" id="btn_SeatResInfo">?????? ??? ??????</a>
  
<!--needpopup script-->
<script>
	$( function() {
		$("#kioskGubun").val("SEAT");
		res.fn_rightBtn($("#kioskGubun").val());
		res.fn_loginForm("LOGOUT");
		
		
		setInterval(function() {
			$("#sp_timeInfo").html(new Date().format('HH:mm'));
		}, 60000);
	});
	function fn_nowTime(){
		let today = new Date();   
		let hours =  stringLength( today.getHours(), "2", "0"); // ???
		let minutes = stringLength( today.getMinutes(), "2", "0");  // ???
		return hours +""+minutes;
		
	}
	function fn_seatTime(){
		var url = "/web/kioskSeatInfoTime.do";
		params = {'floorSeq' : $("#floorSeq").val()};
		uniAjaxSerial(url, params, 
				function(result) {
					if (result.status == "SUCCESS"){
						   //??? ????????? ?????? ??????
						   if (result.regist.timeInfo!= null){
							   var obj = result.regist.timeInfo;
							   $("#sp_dayInfo").html("<p>"+obj.dayinfo +"</p><p>"+obj.weekinfo+"</p>");
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
		// 60??? ??? ?????? ?????? 
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
		   						   //??? ????????? ?????? ??????
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
		 				    		   //?????? ?????? ?????? 
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
					//?????? ?????? 
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
			   						   //??? ????????? ?????? ??????
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
		     		                                	 shtml +=   " <label for=\"ex_chk04\">????????? ???????????????</label>"	  
		     		                                	       + "    <input type=\"checkbox\" id=\"show_time\" name=\"show_time\"  value="+obj[i].swc_time+">";
		     		                                  }else {
		     		                                	 shtml +=   " <label for=\"ex_chk04\"><a href=''>????????? ?????? ?????????.</a></label>"	  
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
					 //????????? ?????? 
					$("#sp_stateTxt").html("<p>????????? ??? ?????? ?????? ?????????.</p>");
					$("#btn_checkIn").trigger("click");
				}
			}, fn_reset : function(){
				 $("#itemId").val("");
				 $("#seatConfirmgubun").val("");
				 $("#resReqday").val("");
			}, reserve_meeting : function (){
				//?????? ?????? ???????????? ?????? ?????? ?????? 
				
				$("#p_seatNm").text($("#sp_seatName").text());
				$("#sp_roomNm").text($("#sp_seatName").text());
				
				$("#sp_resDay").text($("#searchResStartday").val());
				var checkItem = checkbox_val("????????? ?????? ????????????", "show_time");
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
    			//????????? ?????????
    			var params = {'userId' : $("#userId").val(), 'mode': 'S', 'resSeq' : $("#resSeq").val() , 'floorSeq' : $("#floorSeq").val()};
				uniAjax("/web/resLoginCheckAjax.do", params, 
			 			function(result) {
					           if (result.status == "SUCCESS"){
								   //????????? ?????? ??????
								   $("#dv_info").html(result.resultVO.empname+"|"+ result.resultVO.deptname);
								   $("#sp_resName").text(result.resultVO.empname);
								   $("#loginOK").val("OK");
								   res.fn_loginForm("LOGIN");
							   }else {
								   $("#userId").val("");
								   res.fn_hideMessage("?????? ?????? ????????? ????????????.", "checkIn");
								   res.fn_loginForm("LOGOUT");
							   }
						    },
						    function(request){
								 $("#userId").val("");
						    	res.fn_hideMessage("?????? ?????? ????????? ?????????????????????.", "checkIn");
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
		    		$("#btn_login").html("<p>?????? ??????</p><span>User-Logout</span>");
		    		needPopup.hide();
		    		
		    	}else {
		    		$("#dv_preInfo").show();
		    		$("#dv_LoginInfo").hide();
		    		$("#btn_login").html("<p>????????? ??????</p><span>User-check</span>");
		        	
		    	}
		    }, fn_empInput : function(){
		    	if ($("#userId").val() == ""){
		    		$("#btn_empInput").trigger("click");
		    	}else {
		    		$("#sp_stateTxt").html("<p>?????? ?????? ???????????????.</p>");
					$("#btn_checkIn").trigger("click");
					$("#userId").val("")
					$("#loginOK").val("");
                    //?????? ???????????? ?????????
					res.fn_loginForm("LOGOUT");
					$("#kioskGubun").val("SEAT");
					res.fn_rightBtn($("#kioskGubun").val());
		    	}
		    }, fn_ResSave : function(){
		   	 
			   	 var resEqupcheck = "";
			   	 //?????? ?????? ????????? ?????? ?????? ?????? 
			   	 if ( $("#itemGubun").val() == "ITEM_GUBUN_2"){
			   	     $("#hid_history").val("res_show");
			   	    
			   	 }else {
			   	     if (any_empt_line_span("resTitle", '?????? ????????? ????????? ?????????.') == false) return;
			   		 if (any_empt_line_span("resStarttime", '?????? ?????? ????????? ????????? ?????????.') == false) return;
			   		 if (any_empt_line_span("resEndtime", '?????? ?????? ????????? ????????? ?????????.') == false) return;
			   		 if (fn_TimeCheck ( "resStarttime",  "resEndtime", "?????? ????????? ?????? ???????????? ????????????" ) == false) return;
			   		 if (any_empt_line_span("resGubun", '?????? ????????? ????????? ?????????.') == false) return;
			   		 if ($("#div_equipRoomInfo").is(":visible") == true){
			   	           if (any_empt_line_span("resEqupcheck", '???????????? ????????? ????????? ?????????.') == false) return;
			   		 }
			   		 if ($("#resGubun").val() == "SWC_GUBUN_2"  && $("#meetingSeq").val() == ""){
			   			 $("#sp_errorMessage").html("??????????????? ????????? ???????????? ????????? ?????????.");	 
			   			 return;
			   		 }
			   		 if ($("#resEqupcheck").val() == "?????? ????????????"){
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
			   //????????? ?????? 
			   $("#floor_list").find("[name=btn_floor]").attr('class', '');
			   $("#li_"+floorSeq).attr('class', 'active');
			   $("#floorSeq").val(floorSeq);
			   if ($("#kioskGubun").val() == "SEAT"){
				   //?????? ?????? ?????? ?????? 
				   fn_seatTime();
			   }else{
				   //????????? ?????? ???????????? 
				   res.fn_meetingState();
			   }
		   }, fn_meetingInfo : function(){
			   if ($("#loginOK").val() == "OK" && $("#userId").val() != ""){
				   var kioskGubun = $("#kioskGubun").val();
				   kioskGubun =  (kioskGubun == "SEAT") ? "MEETING" :  "SEAT";
				   $("#kioskGubun").val(kioskGubun);
				   res.fn_rightBtn(kioskGubun); 
			   }else {
					 //????????? ?????? 
					$("#sp_stateTxt").html("<p>????????? ??? ?????? ?????? ?????????.</p>");
					$("#btn_checkIn").trigger("click");
				}
		   }, fn_rightBtn : function(msgGubun){
			   var btn_message = (msgGubun == "SEAT") ?"<p>????????? ??????</p><span>Meeting room Status</span>":"<p>?????? ??????</p><span>Seat Reserve</span>";
			   $("#btn_meetingBtn").html(btn_message);
			   if (msgGubun == "SEAT"){
				   //?????? ?????? ?????? ?????? 
				   $("#seat_floor").show();
				   $("#meet_floor").hide();
				   fn_seatTime();
			   }else{
				   //????????? ?????? ????????????
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
							   //????????? ?????? ?????? ?????? 
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
			   //????????? ?????? ?????? ??????  ?????? 
			     var params = {'userId' : $("#userId").val(), 
					           'searchCenterId' : $("#searchCenterId").val(), 
						       'searchFloorseq' :  $("#floorSeq").val(),
						       'searchResStartday' : $("#searchResStartday").val().replaceAll("-",""), 
						       'searchRoomType' : $("#searchRoomType").val()
			     }; 
			     
			     var url = "/web/meetingDayAjaxKiosk.do";
				 uniAjax(url, params, 
			     			function(result) {
							       if (result.status == "LOGIN FAIL"){
							    	   location.href="/web/Login.do";
			  					   }else if (result.status == "SUCCESS"){
			  						    $("#searchResStartday").val(day_convert(result.result.searchResStartday));
			  						    $("#searchCenterId").val(result.result.searchCenterId);
			  						    var setHtml = "";
			  						    var headHtml = "";
										$("#tb_meetingState > tbody").empty(); 
										$("#tb_meetingState > thead").empty(); 
										
										for (var i in result.seatInfo){
											
											if (i == 0){
												headHtml += "<tr><th>?????????</th>";
												
											}
											
											var seatinfo = result.seatInfo[i];
											
											setHtml += "<tr>";
											setHtml += "<th>"+seatinfo.meeting_name+"</th>";
											/*
											if (seatinfo.timeinfo.length < 18){
												setHtml += "<td colspan='18' style='text-aling:center;'>?????? ??????</td>";
											}else {
											*/
												//console.log("seatinfo.res_reqday:" + seatinfo.res_reqday)
												var rowCol = 0;
												var rowResseq = "";
												var rowInfo = "";
												var resTitle = "";
												var resStart = "";
												
												for (var a  in seatinfo.timeinfo){
													var timeInfo = seatinfo.timeinfo[a];
													if ( i == 0){
														headHtml += "<th>"+timeInfo.swc_times+"</th>";
													}
													
													
			  										var classInfo = "";
			  										//?????? ?????? ??? ????????? ?????? ?????? ?????? ?????? \
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
												if ( i == 0){
													console.log(headHtml);
													headHtml += "</tr>";
													$("#tb_meetingState >  thead").append(headHtml);
												}
											}
											//centerId ??? ?????? 
											setHtml += "</tr>";
											
											
											$("#tb_meetingState >  tbody:last").append(setHtml);
											setHtml = "";
									  /*		
			  					      }
									  */
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