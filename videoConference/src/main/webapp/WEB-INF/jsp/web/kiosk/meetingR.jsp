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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    <link rel="stylesheet" href="/css/kiosk/paragraph.css">
    <link rel="stylesheet" href="/css/kiosk/reset.css">
    

    <script src="/front_res/js/jquery-3.5.1.min.js"></script>
	<script src="/front_res/js/bpopup.js" ></script>
	<link rel="stylesheet" href="/front_res/css/popup.css"/>
    
    
    

    <!-- 캘린더 관련 -->
    
      <link rel='stylesheet' href='/front_res/css/smart.css'/>
    <link rel='stylesheet' href='/front_res/css/main.css'/>
    <link rel='stylesheet' href='/front_res/css/day_main.css'/>
    <link rel='stylesheet' href='/front_res/css/time_main.css'/>
    <link rel='stylesheet' href='/front_res/css/list_main.css' />
    
	<script src="/front_res/js/packages/main.js"></script>
    <script type="text/javascript" src="/front_res/js/packages/day_main.js"></script>
    <script type="text/javascript" src="/front_res/js/packages/time_main.js"></script>
    
    <script type="text/javascript" src="/front_res/js/common.js"></script>
    <script type="text/javascript" src="/front_res/js/com_resInfo.js"></script>

    
</head>
<body>
<form:form name="regist" commandName="regist" method="post" >
 <input type="hidden" id="meetingId" name=meetingId value="${regist.meeting_id }">
 <input type="hidden" id="floorSeq" name="floorSeq" value="${regist.floor_seq }">
 <input type="hidden" id="resSeq" name="resSeq"  >
 <input type="hidden" id="userId" name="userId"  >
 <input type="hidden" id="mode" name="mode"  >
 <input type="hidden" id="resStartday" name="resStartday" >
 <input type="hidden" id="searchCenterId" name="searchCenterId"  value="${regist.center_id }">
 <input type="hidden" id="seatConfirmgubun" name="seatConfirmgubun"  value="${regist.meeting_confirmgubun }">
 
 <input type="hidden" id="timeSeq" name="timeSeq"  >
  <input type="hidden" id="swcTime" name="swcTime"  >




 <div class="wrap">
        <!--//header-->
        <header id="header">
            <div class="leftBox">
                <h1 class="logo"><img src="/img/logo.png" alt="Kbank" /></h1>
                <span id="sp_swcName">${regist.meeting_name}</span>
            </div>
            <div class="rightBox">
                <span class="day"><span id="sp_dayInfo"></span> </span>
                <span class="time"><span id="sp_timeInfo"></span>  </span>
            </div>
            <div class="clear"></div>
        </header>
        <!--header//-->
            
        <div class="contents" >
            <!--// 회의실 현황 -->
             
            <div class="mainBox"  id="resMeetingInfoE">
                <div class="main_con blank">
                    <p>예정된 회의가 없습니다.</p>
                </div>
            </div>
            <div class="mainBox"  id="resMeetingInfoR">
                <div class="main_con">
                    <!-- 우측(whiteBox)에서 회의 일정을 선택했을 때 해당 내용과 닫기 버튼 표출 
                    <a href="javascript:;" class="main_close"></a> -->
                    <!--// 제목 -->
                    <!-- 회의 종료
                    <p class="state before">회의 종료</p> -->
                    <!-- 회의 중  
                    <p class="state now">회의 중</p> -->
                    <!-- 회의 예정 -->
                   
                    <p class="state after" id="p_stateInfo">회의 예정</p> 
                    <!-- 제목이 1줄~2줄 일 경우 -->
                    <h1>
                        <span id="sp_title"> </span>  
                    </h1>
                    
                    <!-- 제목이 3줄일 경우 스타일 변경 
                    <h1 class="long_tit"> 현대 글로비스 스마트 오피스 웹사이트 신규 론칭 건 사전 오픈 미팅 및  사내 인테리어 회의</h1>-->
                    <!-- 제목 //-->
                    <!--// 회의 정보 -->
                    <div class="mid_con">
                        <div class="time"  id="dv_time">10:00 - 11:30</div>
                        <div class="info">
                            <span id="sp_userInfo"></span>
                            <a data-popup-open="staffList" href="javascript:fn_viewAttend() ;" class="rightBox">참석자 보기</a>
                        </div>
                    </div>
                    <!-- 회의 정보 //-->
                    <!--// 버튼 -->
                    <div class="bottom_con">
                       <!--// 회의 예정 일 때(입실하기 버튼이 표출 되었을 때) 안내문구와 버튼이 같이 표출 됩니다. -->
                        <p>* 회의 시작 후 10분 내 ‘입실 인증’을 하지 않으면 예약이 자동 취소됩니다.</p>
                        <div class="btnBox">
                            <a  class="rightGBtn"  data-popup-open="login"  onClick="meetingR.fn_mode('C');">예약 취소</a>
                            <a href="javascript:;meetingR.fn_MeetingState('IN')" class="darkGBtn" id="a_stateChange">입실하기</a>
                        </div>
                        <div class="clear"></div>
                        <!--회의 예정 일 때(입실하기 버튼이 표출 되었을 때) 안내문구와 버튼이 같이 표출 됩니다.// -->

                        <!-- //예약취소 버튼--> 
                        <!--<a data-popup-open="cancel" class="rightGBtn bottom">예약 취소</a>-->
                        <!-- 예약취소 버튼//--> 

                        <!-- //퇴실하기 버튼 -->
                        <!--<a data-popup-open="checkOut2" class="darkGBtn bottom">퇴실하기</a>-->
                        <!-- 퇴실하기 버튼// -->
                    </div>
                    <div class="clear"></div>
                    <!-- 버튼 //-->
                </div>
            </div>
            <!-- 회의실 현황 //-->
            <!--// 회의 일정 -->
            <div class="whiteBox">
                <div class="top">
                    <span class="guide_icon"></span>
                    <span>회의실 예약 일정 확인 후 예약하기 버튼을 눌러주세요.</span>
                    <!--빈 영역 선택 시 예약하기 버튼 활성화 creserves명 active 추가 -->
                    <!-- <a data-popup-open="booking" class="darkBtn rightBox active">예약하기</a> -->
                    <a href="#"  onclick="meetingR.fn_mode('R');"  data-popup-open="login"  class="darkBtn rightBox active"   id="a_btn_res">예약하기</a>
                </div>
                <div class="clear"></div>
                <section class="scheduler">
                    <div>
                        <div id="calendar"></div>
                    </div>
                </section>
            </div>
            <!-- 회의 일정 -->
        </div>
        <!-- contents -->
    </div>
    <!-- wrap -->

    <!--// 팝업 -->
    <!-- 로그인 팝업 -->
    <div data-popup="login" class="popup login">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <div class="top">
                <p>로그인</p>
                <span>사원번호를 입력해 주세요.</span>
            </div>
            <ul class="key_header">
                <li id="li_userNumber"></li>
            </ul>
            <ul class="keyboard">
                <li  onClick="meetingR.fn_keyNumber('1')">1</li>
                <li onClick="meetingR.fn_keyNumber('2')">2</li>
                <li onClick="meetingR.fn_keyNumber('3')">3</li>
                <li onClick="meetingR.fn_keyNumber('4')">4</li>
                <li onClick="meetingR.fn_keyNumber('5')">5</li>
                <li onClick="meetingR.fn_keyNumber('6')">6</li>
                <li onClick="meetingR.fn_keyNumber('7')">7</li>
                <li onClick="meetingR.fn_keyNumber('8')">8</li>
                <li onClick="meetingR.fn_keyNumber('9')">9</li>
                <li class="key_back"  onClick="meetingR.fn_keyNumber('B')"></li>
                <li  onClick="meetingR.fn_keyNumber('0')">0</li>
                <li class="key_check"  onClick="meetingR.fn_login()">확인</li>
            </ul>
            <div class="clear"></div>
        </div>
    </div>  
    <!-- 로그인 정보 없음  -->
    <div data-popup="login_none" class="popup notiPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <p>일치하지 않습니다.</p>
        </div>
    </div> 
    <!-- 입실 가능 시간이 아닐 경우 -->
    <div data-popup="alert1" class="popup notiPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <p>입실 가능 시간이 아닙니다.</p>
        </div>
    </div> 
    <!-- 예약 시간을 설정 할 때 예약 된 부분 까지 선택했을 때 -->
    <div data-popup="alert2" class="popup notiPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <p>비어있는 영역만 설정 가능합니다.</p>
        </div>
    </div> 
    <!-- 예약 시간을 설정 할 때 2시간 초과 했을 때 -->
    <div data-popup="alert3" class="popup notiPop notiPop_b">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <p>예약 시간은 2시간을 초과할 수<br>없습니다.</p>
        </div>
    </div> 
    <!-- 예약 시간을 이전 시간으로 설정했을 때 -->
    <div data-popup="aler4" class="popup notiPop notiPop_b">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <p>예약 시간은 현재 시각 이후부터 설정<br>가능합니다.</p>
        </div>
    </div> 
    <!-- 입실 완료 -->
    <div data-popup="checkIn"  id="checkIn" class="popup notiPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <span id="sp_stateTxt"></span>
        </div>
    </div>
    <!-- 회의실 예약 완료 -->
    <div data-popup="reserve" class="popup focusPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <div class="top">
                <p>소회의실</p><span>10:30 ~ 11:00</span>
            </div>
            <div class="con">
                <p class="check_line">회의실 예약이 완료되었습니다.</p>
                <span>예약 시간 기준 N분 안에 입실하지 않으면 자동 취소됩니다.</span>
            </div>
            <a href="javascript:;" class="greenBtn">확인</a>
        </div>
    </div>
    <div data-popup="cancel" class="popup notiPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <p>예약이 취소되었습니다.</p>
        </div>
    </div>
    <!-- 예약하기 -->
    <!-- 예약하기 -->
        <div data-popup="booking" class="popup bookingPop">
            <div class="popup_con">
                <span class="button b-close">&times;</span>
                <div class="top">
                    <p><span id="sp_bookingTitle"></span></p><span>예약 시간을 선택해주세요.</span>
                </div>
                <div class="con">
                    <select id='resStarttime' style="width:120px;"></select>~
                     <select id='resEndtime' style="width:120px;"></select>
                </div>
                <a class="greenBtn" onclick="meetingR.fn_meetReservation()">예약</a>
            </div>
        </div>

        
    <!-- 참석자 정보 -->
    <div data-popup="staffList" class="popup staffList">
        <span class="button b-close">&times;</span>
        <div class="popup_con">
            <p class="tit">참석자 정보</p>
            <span id="sp_resListPop">
            </span>
        </div>
    </div>
    <!-- 팝업 //-->
    <!-- 회의 정보 팝업 -->
    
    
    <div data-popup="meet_info" class="popup meetinfoPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <div class="top">
                <p>${regist.seatName}</p><span id="meeting_timeInfo">10:30 ~ 11:00</span>
            </div>
            <div class="con" id="meeting_conInfo">
                <p class="check_line"   >스마트 오피스 신규 사이트 오픈 미팅 A</p>
                <span>이준석 책임 외 5명<br/>글로벌 기획 서비스팀</span>
            </div>
             <a  class="greenBtn"   data-popup-close="meet_info">확인</a>
        </div>
    </div>
    <!-- 팝업 //-->
    
    <a data-popup-open="checkIn"  style="display:none"  class="rightGBtn" id="btn_checkIn">예약 취소</a>
    <a data-popup-open="booking"  style="display:none"  class="rightGBtn" id="btn_booking"  onclick="meetingR.bookingInfo()">예약</a>
    <a data-popup-open="meet_info"  style="display:none"  class="rightGBtn" id="btn_showRes" >회의 정보 보여주기</a>
    
    <a  style="display:none"  class="rightGBtn" id="btn_hide" data-popup-close="login">화면 사라지게 하기</a>
    <a  style="display:none"  class="rightGBtn" id="btn_hideRes" data-popup-close="booking">화면 사라지게 하기</a>
    
    
    
    <script type="text/javascript">
        $('[data-popup-open]').bind('click', function () {
          var targeted_popup_class = jQuery(this).attr('data-popup-open');
          $('[data-popup="' + targeted_popup_class + '"]').bPopup();
          });
        $('[data-popup-close]').on('click', function(e)  {
        	 var targeted_popup_class = jQuery(this).attr('data-popup-close');
        	$('[data-popup="' + targeted_popup_class + '"]').fadeOut(1000).bPopup().close();
        	$('body').css('overflow', 'auto');
            e.preventDefault(); 
        });
        
        
	$( function() {
		setInterval(function() {
			$("#sp_timeInfo").html(new Date().format('HH:mm:ss'));
		}, 1000);
		meetingR.meetingInfo();
	});
        
        
        var meetingR = {
        		meetingInfo : function(){
        			var url = "/web/resPadInfoAjax.do?meetingId="+$("#meetingId").val();
        			
        			uniAjaxSerial(url, null, 
    		      			function(result) {
    		 				       // 결과 시작 
			        				if (result.status == "SUCCESS"){
										  if (result.resultlist.length > 0 ){
											console.log("result.resultlist.length:" + result.resultlist.length);
										    var resBtn = "";
											for (var i = 0; i < 1; i ++ ){
											     var obj = result.resultlist;
											     
											     if (obj[i].room_type == "SWC_GUBUN_3"){
													resBtn = "hide";
													$("#dv_time").html(obj[i].res_startday +"일"+ obj[i].resstarttimet+"~<br/>"+ obj[i].res_endday +"일"+ obj[i].resendtimet +"까지")
					  							 }else {
			  							    		resBtn = "show";
			  							    		$("#dv_time").html( obj[i].resstarttimet+"~"+ obj[i].resendtimet)
			  							    	 }
												 $("#centerId").val(obj[i].center_id);
										    	 $("#timeSeq").val(obj[i].time_seq);
										    	 $("#swcTime").val(obj[i].swc_time);
										    	 $("#sp_swcName").html(obj[i].meeting_name);
										    	 $("#sp_bookingTitle").html(obj[i].meeting_name);
										    	 
											     if (obj[i].res_seq != "0"){
											    	$("#sp_title").html(obj[i].res_title );
			  							    	 $("#sp_userInfo").html(obj[i].empname);
			  							    	 $("#resSeq").val(obj[i].res_seq);
			  							    	 
			  							    	
			  							    	 //인사 정보 확인
												 console.log("start");
			  							    	 var sHtml = "<ul>";
			  							    	 if (obj[i].empname != ""){
			  							    		var empInfo = obj[i].empname.split('|');
			  							    		sHtml += "<li><p>"+empInfo[0]+"</p><br><span>"+empInfo[1]+"</span><em>예약자</em></li>";
			  							    		if (result.resUserList != undefined){
			  							    			for (var a =0; a < result.resUserList.length; a++ ){
				  							    			var resUser = result.resUserList;
				  							    			sHtml += "  <li><p>"+resUser[a].empname +"</p><br><span>"+resUser[a].deptname +"</span></li>";
				  							    		}	
			  							    		}
			  					                 }
			  							    	 sHtml += "</ul>";
			  							    	 $("#sp_resListPop").html(sHtml);
												 console.log("in_time:" + obj[i].in_time + ":" + obj[i].ot_time);
			  							    	 if ((obj[i].in_time != "" && obj[i].in_time != undefined)  &&  (obj[i].ot_time == ""  || obj[i].ot_time == undefined )){
													 
			  							    		 $("#p_stateInfo").html("회의 중");
			  							    		 $("#a_stateChange").prop('href', 'javascript:;meetingR.fn_MeetingState("OT")').text("퇴실");
			  							    	 }else if  (obj[i].in_time == "" || obj[i].in_time == undefined) {
														$("#a_stateChange").show();
            				  							$("#p_stateInfo").html("회의 예정");
            				  							$("#a_stateChange").prop('href', 'javascript:;meetingR.fn_MeetingState("IN")').text("입실");
			  							    	 }else if (obj[i].ot_time != "" || obj[i].ot_time != undefined ){
			  							    		 $("#a_stateChange").hide();
			  							    		 $("#p_stateInfo").html("회의 종료");
			  							    	 }
				  							  	     $("#resMeetingInfoE").hide();
			  									     $("#resMeetingInfoR").show();
											     }else {
											    	$("#resMeetingInfoE").show();
			  									    $("#resMeetingInfoR").hide();
											    }
											 
										   }
											//
										}else {
											$("#resMeetingInfoE").show();
											$("#resMeetingInfoR").hide();
											
										}
									   $("#sp_dayInfo").html(result.dayInfo);
									   $("#resStartday").val(result.dayInfo);
									   // 신규 추가 
									   if (  parseInt( result.timeInfo.substring(0,5).replaceAll(":","") ) > 2000  ||  parseInt( result.timeInfo.substring(0,5).replaceAll(":","") ) < 800){
										   $("#a_btn_res").hide();
									   }else {
										   $("#a_btn_res").show();
									   }
										(resBtn == "hide") ? $("#a_btn_res").hide():$("#a_btn_res").show();

								       //$("#sp_timeInfo").html(result.timeInfo);//날짜 
								       
								       calView( result.resTime  );
									}else {
										 meetingR.fn_hideMessage("처리 도중 문제가 발생하였습니다.", "checkIn");
									}
    		 				       
    		 				       //결과 끝 
    		 				    },
    		 				    function(request){
    		 				    	meetingR.fn_hideMessage("처리 도중 문제가 발생하였습니다.", "checkIn");
    		 				    }    		
    		            );
        			   //1분 마다 리로드 
                	   window.setTimeout("meetingR.meetingInfo()", 30000);
        		}, fn_MeetingState : function (state){
        			//입실 하기 
        			    var params = {'resSeq' : $("#resSeq").val(), 'resState': state };
        				uniAjax("/web/resPadStateAjax.do", params, 
        			 			function(result) {
        					           if (result.status == "SUCCESS"){
        									    //테이블 정리 하기
			        									 if (state == "IN"){
			      			  								meetingR.fn_hideMessage("입실 처리 되었습니다.", "checkIn");
															
			      			  							 }else {
			      			  								meetingR.fn_hideMessage("퇴실 처리  되었습니다.", "checkIn");
			      			  							 }
        									    		 meetingR.meetingInfo();
			      			  			   }else {
        									    meetingR.fn_hideMessage("처리 도중 문제가 발생하였습니다.", "checkIn");
        								   }
        						    },
        						    function(request){
        						    	  meetingR.fn_hideMessage("처리 도중 문제가 발생하였습니다.", "checkIn");
        						    }    		
        			     );	
        				meetingR.meetingInfo();
        				$("#btn_checkIn").trigger("click");
        			
        		},  fn_login : function(){
        			//사용자 로그인
        			var params = {'userId' : $("#userId").val(), 'mode': $("#mode").val(), 'resSeq' : $("#resSeq").val()  };
    				uniAjax("/web/resLoginCheckAjax.do", params, 
    			 			function(result) {
    					           if (result.status == "SUCCESS"){
    									    //테이블 정리 하기
		        						    if ($("#mode").val() == "R" ){
		        						    	
		        						    	
		        						    	
		        						    	$("#btn_hide").trigger("click");
		        								$("#btn_booking").trigger("click");
		        						    }else {
		        						    	//예약 취소 함수 요청 
		        						    	
		        						    	$("#btn_hide").trigger("click");
		        						    	meetingR.fn_hideMessage("예약이 정상적으로 취소 되었습니다.", "checkIn");
		        						    	meetingR.meetingInfo();
		  														
		      							    }		
    								   }else {
    									   meetingR.fn_hideMessage("해당 사원 정보가 없습니다.", "checkIn");
    								   }
    						    },
    						    function(request){
    						    	 meetingR.fn_hideMessage("처리 도중 문제가 발생하였습니다.", "checkIn");
    						    }    		
    			     );	
        			
        		}, fn_meetReservation : function (){
        			 //예약 화면 닫기 하기 
        		     $("#booking").bPopup().close();
        		     $("#btn_hideRes").trigger("click");
        		     
        			 if (parseInt($("#resStarttime").val() ) > parseInt($("#resEndtime").val())      ){
        				   meetingR.fn_hideMessage("시작 시간이 종료 시간보다 빠를 수 없습니다.", "checkIn");
        			 }else {
        				 var params = {'mode': $("#mode").val(), 'itemId': $("#meetingId").val(), 'itemGubun':'ITEM_GUBUN_1', 
            					       'resTitle' : "현장 예약 입니다",'resPassword' : "Y", 
            					       'resStartday' : $("#resStartday").val().replaceAll("-", "") ,
         							   'resStarttime' : $("#resStarttime").val(), 'resEndtime' : $("#resEndtime").val(),
         							   'proxyUserId' : $("#userId").val(), 'resGubun' : "SWC_GUBUN_1",
         							   'useYn' : "Y", 'centerId': $("#searchCenterId").val(),
         							   'proxyYn' :  "Y",  'meetingSeq' : "", 
         							   'seatConfirmgubun': $("#seatConfirmgubun").val(),
       							       'resAttendlist' :$("#userId").val(),
       							       'conNumber' : "N", 'conPin' : "N",
       							       'conVirtualPin' :"N", 'conAllowstream' : "N",
       							       'conBlackdial' : "N" , 'conSendnoti' :  "N",
       							       'resEqupcheck' : "RES_EQUPCHECK_1", 
       							       'sendMessage' : 'N',
       							       'floorSeq' : $("#floorSeq").val(), 'resRemark' : '', 'resPerson' : "0"
            			              };
            			
            			 //값 수정 
            			 
            			 uniAjax("/web/resReservertionKioskUpdate.do", params, 
            		  			function(result) {
            						       if (result.status == "SUCCESS"){
            						    	    meetingR.meetingInfo();
            						    	    meetingR.fn_hideMessage(result.message, "checkIn");
            						    	    
            							   }else {
            								   meetingR.fn_hideMessage(result.message, "checkIn");
            							   }
            						    },
            						    function(request){
            							    alert("Error:" +request.status );	       						
            						    }    		
            		      );
        			 }
        			 
        		}, fn_keyNumber : function(Num){
        			var userId =  $("#userId").val();
        			if (Num == "C"){
        				$("#userId").val("");
        				$("#li_userNumber").text("");
        			}else if (Num == "B"){
        				if(userId !=""){
							$("#userId").val(userId.substring(0, parseInt(userId.length -1) )); 
							$("#li_userNumber").text(userId.substring(0, parseInt(userId.length -1)) );
        				}
        				return;
        			} else {
        				userId += Num;
        				$("#userId").val(userId);
        				$("#li_userNumber").text(userId );
        			}
        		}, fn_mode : function(mode){
        			$("#mode").val(mode);
        			$("#userId").val("");
    				$("#li_userNumber").text("" );
    				
    			   if (mode == "C"){
    				   
    			   }
        		}, bookingInfo : function (){
        			//부킹 정보 확인 하기 
        			var time_params = {'resStarttime': $("#swcTime").val() , 'resSeq': '0', 'itemId' : $("#meetingId").val()   };
        			uniAjax("/web/resInfoAjax.do", time_params, 
				 			function(result) {
							           if (result.status == "SUCCESS"){
										    //테이블 정리 하기
											var objS = result.resStartTime;
											if (objS.length > 0 ){
												$("#resStarttime option").remove();
												for (var i = 0; i <= objS.length; i ++){
													try{
														$("#resStarttime").append("<option value='"+objS[i].codeNm.replace(":","") +"'>"+objS[i].codeNm+"</option>");
													}catch(err){
														console.log(err);
													}
				  						    }
											}
											var objE = result.resEndTime;
											if (objE.length > 0 ){
												$("#resEndtime option").remove();
				  							for (var i = 0; i <= objE.length; i ++){
				  								try{
				  									$("#resEndtime").append("<option value="+objE[i].codeNm.replace(":","")+">"+objE[i].codeDc+"</option>");
				  								}catch(err){
				  									console.log(err);
				  								}
				  						    }
											}
											//회의실 구분
										
											
											if (resSeq != "0"){
										    	$("#resEndtime").val();
										    }else {
										    	$("#resStarttime option:eq(0)").prop("selected", true);
											    $("#resEndtime option:eq(0)").prop("selected", true);
										    }
										    	
									   }
							    },
							    function(request){
								    alert("Error:" +request.status );	       						
							    }    		
				     );
        			
        		}, showResInfo : function (resSeq){
        			
        	        uniAjax("/web/resMeetingInfoAjax.do?resSeq="+resSeq, null, 
        		  			function(result) {
        	        	               if (result.status == "SUCCESS"){
        						    	     var obj  =  result.resInfo;
        						    	     
        						    	     var attendlisttxt = (obj.attendlisttxt = 'undefined') ? "" : obj.attendlisttxt+"<br/>";
        						    	     $("#meeting_timeInfo").html (obj.resstartday +":" +   obj.resstarttime+"~"+ obj.resendtime)
        						    	     $("#meeting_conInfo").html(" <p class='check_line'>"+obj.res_title+"</p><span>"+attendlisttxt+""+obj.deptname+"</span>");
        						       }else {
        								   $("#sp_stateTxt").html("<p>조회 도중 문제가 발생 하였습니다.</p>");
 											
        							   }
        						    },
        						    function(request){
        							    alert("Error:" +request.status );	       						
        						    }    		
        		      );
        			$("#btn_showRes").trigger("click");
        			//요소가 있는지 확인 후 삭제 하기
        			$('#meet_info').fadeOut(3000).bPopup().close();
    	        	$('body').css('overflow', 'auto');
    	            
        		}, fn_hideMessage : function (resMessage, _panel){
					
        			$("#sp_stateTxt").html("<p>"+resMessage+"</p>");
    				$("#btn_checkIn").trigger("click");
					$('#' +_panel).fadeOut(1000).bPopup().close();
    				//1초후 클릭 
    	        	$('body').css('overflow', 'auto');
					bPopup().close();
    	           
    	            
             }
        }
       
    </script>
    <script>
           function calView(eventList ) {
        	    $("#calendar").empty();
                var calendarEl = document.getElementById('calendar');
                var calendar = new FullCalendar.Calendar(calendarEl, {
                   plugins: ['interaction', 'timeGrid'],
                   defaultView: 'timeGridDay',
                   minTime: $('#swcTime').val().substring(0,2)+":" + $('#swcTime').val().substring(2,4)+":00",
                   maxTime: "19:00:00",
                   header: false,
                   columnHeader: false,
                   defaultDate:   $("#resStartday").val(), 
                   contentHeight: 'auto',
                   allDaySlot: false,
                   slotLabelFormat: {
                       hour: '2-digit',
                       minute: '2-digit',
                       meridiem: false,
                       hour12: false
                   },
                   displayEventTime: false,
                   // 저장된 일정 리사이징 및 이동 안되게 하려면 아래 값 false로 설정
                   editable: true,
                   eventOverlap: false,
                   longPressDelay: 500,
                   unselectAuto: false,
                   selectable:true,
                   selectOverlap:false,
                   // 빈공간 클릭했을때 액션
                   dateClick: function (info) {
                       // 클릭한 시간 값 : info.dateStr
                        //alert("dateClick" + info)

                       // 클릭했을때 셀렉트 하려면 활성화
                        selectTimeGrid(info.dateStr)
                   },
                   select: function (info) {
                	   $('.resrv_tool>div.resrv button').attr('disabled', false)
                       $('.fc-highlight').append("<div class='remove_btn'></div>")
                   },
                   unselect: function (info) {
                	   $('.resrv_tool>div.resrv button').attr('disabled', true)
                   },
                   
                   events:  eventList,
                   // 이벤트에 작성자 넣기
                   eventRender: function (info) {
                	   $(info.el).find('.fc-title').append("<span>" + info.event.extendedProps.author +
                           '</span>');
                   },
                   // 이벤트 크기 조절했을때 액션
                   eventResize: function (info) {
                       var elSize = $('.fc-selected').outerHeight()
                       // 크기 변경했을때 저장 액션 실행
                       // 이벤트 크기가 1칸일때 액션(30분)
                       if (elSize < 30) {
                           console.log('1칸')
                       }
                   },
                   // 이벤트 클릭 액션
                   eventClick: function (info) {
                	   meetingR.showResInfo(info.event.extendedProps.id);
                   }
               });

               // 클릭 했을때 셀렉트 하려면 활성화
                function selectTimeGrid(start) {
            	   
                    var end = new Date(start);
                    end.setMinutes(end.getMinutes() + 30);
                    calendar.select(start, end)
                }

               calendar.render();

               // 회의실 개수 3개 이하일때 리스트 맞추기
               var confLength = $('.conf_list ul').children().length
               if (confLength < 4) {
                   $('.conf_list ul').addClass('fit')
               }

               // 스케쥴러 셀렉트 해제 버튼 액션
               $(document).on('click', '.remove_btn', function(){
            	   calendar.unselect()
               })
           }
    </script>
</form:form>
</body>
</html>