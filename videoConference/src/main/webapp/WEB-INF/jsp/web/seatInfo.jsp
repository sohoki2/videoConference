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
    <link href="/front_res/css/reset.css" rel="stylesheet" />
    <link href="/front_res/css/jquery-ui.css" rel="stylesheet" />
    <link href="/front_res/css/needpopup.min.css" rel="stylesheet" type="text/css" >
    <link href="/front_res/css/style.css" rel="stylesheet" />
    <link href="/front_res/css/paragraph.css" rel="stylesheet" />
    <link href="/front_res/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/front_res/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
     
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/jquery-ui.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
    <script src="/front_res/js/common.js"></script>
	<script src="/front_res/js/com_resInfo.js"></script>
    
</head>
<body>
<form:form name="regist" commandName="regist" method="post">
<input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}" />
<input type="hidden" name="searchCenterId" id="searchCenterId" value="${regist.centerId}" />
<input type="hidden" name="partSeq" id="partSeq" />

<input type="hidden" name="itemGubun" id="itemGubun" value="ITEM_GUBUN_2"/>

         <!--//header 추가-->
        <c:import url="/web/inc/top_inc.do" />
        <!--header 추가//-->
        <!--// left menu -->
        <c:import url="/web/inc/right_menu.do" />
        <!--left menu //-->
        <!--//floor Btn-->
        <div id="allFloors">
            <div class="contents">
                <div class="flooreArea" id="dv_floor">
                    <c:forEach items="${floorinfo }" var="floorList" varStatus="status">
                      <a href="#" onClick="fn_floorSearch(${floorList.floor_seq }, 'res.fn_seatTimeCombo()')" name="btn_floor" id="btn_${floorList.floor_seq }" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
                    </c:forEach>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        
       
        <!--floor Btn//-->
        <!--//search box-->
        <div class="contents">
            <div class="searchBox float_right" style="display:none">
                <input type="text" placeholder="임직원 검색" id="search_user" name="search_user" class="inputSearch ui-autocomplete-input">
                <div class="searchIcon">
                    <a href="#" onClick="res.fn_userSearch()" class="searchBtn">검색</a>
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
        <!--search box//-->
        <!--//contents-->
        <div class="contents">
            <div class="line">
                <div class="contents search_con">
                    <div class="dateBox float_left">
                      <input type="text" class="inputSearch" id="searchResStartday" name="searchResStartday" value="${regist.searchResStartday}" onChange="res.fn_seatTimeCombo()">
                      <div class="dateIcon">
                        <a href="" class="dateBtn">검색</a>
                      </div>
                      <div class="clear"></div>
                   </div>
                   <div class="float_left timeBox" style="margin-left: 15px;margin-top: -20px;">
                        <select id='resStarttime' style="width:100px;height:30px;"></select>
                         ~
                        <select id='resEndtime' style="width:100px;height:30px;"></select>
                        <a href="#" onClick="res.fn_floorInfo()" class="seat_fast" style="height: 32px;">검색</a>
                   </div>
                        
                    <div class="infoContents float_left">
                        <span class="posSeatU">예약가능</span>
                        <span class="usingSeat">사용좌석</span>
                    </div>
                    
                    <div class="infoSeat float_right">
                        <span class="unuse"><strong><span id="sp_total"></span>석</strong> 사용가능</span> / <span class="use">사용좌석 <span id="sp_useSeat"/>석</span>
                    </div>                    
                    <div class="clear"></div>
                </div>
            </div>
            <div class="contents mapbottom">
                <div class="whiteBack">
                    <div class="mapArea">
                        <div class="mapBox pinch-zoom-parent">
                                <div class="map pinch-zoom"  style="background-repeat: no-repeat; background-position: center center">
                                    <div class="seat">
                                        <ul id="area_Map">
                                        </ul>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--contetns//-->
       
        <!--에약완료팝업-->
        
        <div id='seat_fastR_popup' class="needpopup opened">
            <h2 class="pop_tit">예약 정보</h2>
            <ul class="form">
              <li>
                                   좌석 명 <span class="blueFont" id="p_seatNm">4F 01</span> 번 좌석
              </li>
              <li>예약 정보: 
                <span id="sp_resDay">2021년05월10일</span> 
                <span id="sp_resTimeS">08:00</span> ~ <span id="sp_resTimeE">18:00</span>
              </li>
            </ul>
            <div class="clear"></div>
            <div class="footerBtn">
              <a href="#" onClick="fn_ResSave('seatInfo')" class="blueBtn" style="width:150px;padding: 15px 20px;">예약</a>
              <a href="#" onClick="need_close();res.fn_rightView()" class="blueBtn" style="width:150px;padding: 15px 20px;" id="btn_other">다른 시간 예약</a>
              <a href="#" onClick="need_close();res.fn_reset()" class="grayBtn" style="width:150px;padding: 15px 20px;">닫기</a>
            </div>
            <div class="clear"></div>
            <!--  영상 회의 관련 내용 -->
            
        </div>
        
        <!--//팝업-->
        

    <!--// 시간선택 슬라이드 -->
    <div class="back" id="mySidetime">
         <div class="sidenav" id="mySidenav1">
                  <a href="javascript:void(0)" class="closebtn" onclick="res.fn_reset();closeTime();">&times;</a>
                  <div class="seat_info">
                                          좌석 명 <span class="blueFont" id="sp_seatNm"> </span> 번 좌석
                  </div>
                  <div class="select_time">
                      <p>* 예약을 원하는 시작 시간과 종료 시간을 선택해주세요 *</p>
                      <div class="sel_box">
                      <div class="sel_inner_box">
                           <div class="menu_box">
                              <!-- <ul class="sel_list etrans">
                                  <li class="sel_list_time">
                                      <input type="checkbox" disabled="disabled" id="ex_chk01" name="check_reserve_time" class="checkBox" value="0800|1800">
                                      <label for="ex_chk01">종일 </label>
                                      <input type="hidden" id="show_time" name="show_time" value="08:00~18:00">
                                  </li>
                                  <li class="sel_list_time">
                                      <input type="checkbox" disabled="disabled" id="ex_chk01" name="check_reserve_time" class="checkBox" value="0800|1800">
                                      <label for="ex_chk01">오전</label>
                                      <input type="hidden" id="show_time" name="show_time" value="08:00~18:00">
                                  </li>
                                  <li class="sel_list_time">
                                      <input type="checkbox" disabled="disabled" id="ex_chk01" name="check_reserve_time" class="checkBox" value="0800|1800">
                                      <label for="ex_chk01">오후</label>
                                      <input type="hidden" id="show_time" name="show_time" value="08:00~18:00">
                                  </li>
                                  <li class="sel_list_txt">
                                  </li>
                              </ul> -->
                          </div> 
                   </div>  
                   <div class="sel_inner_box" id="reserve_list">
                   </div>       
              </div>
	          <div class="pop_meeting_btn">
	              <a href="#" onClick="res.reserve_meeting()" class="blueBtn meeting_btn">좌석예약</a>
	          </div>
          </div>
        <div class="backShadow"></div>
     </div>
     <!--시간선택 슬라이드 //-->
     <c:import url="/web/inc/unimessage.do" />
     <script>  
         $( function() {
        	 $("#searchResStartday").datepicker({ dateFormat: 'yy-mm-dd' });
	       	 res.fn_seatTimeCombo();
	     });
         var res = {
        		fn_userSearch : function (){
        			//사용자 검색 
        		}, fn_floorInfo : function(){
        			var url = "/backoffice/resManage/seatStateInfo.do";
        			var params = {"swcResday" : $("#searchResStartday").val().replaceAll("-",""), 
		  					      "floorSeq" : $("#floorSeq").val(), 
		  					      "resStarttime" : $("#resStarttime").val(), 
		  					      "resEndtime" : $("#resEndtime").val()
		  					      };
        			uniAjax(url, params, 
    		      			function(result) {
    		 				      if (result.status == "SUCCESS"){
    		   						   //총 게시물 정리 하기
    		 				    	   if(result.seatMapInfo != null){
    	 									var img=   $("#partSeq").val() != "" ? result.seatMapInfo.part_map1 : result.seatMapInfo.floor_map;
    	 									$('.map').css({"background":"#fff url(/upload/"+img+")", 'background-repeat' : 'no-repeat', 'background-position':' center'});
    	 								 }else{
    	 									$('.map').css({"background":"#fff url()", 'background-repeat' : 'no-repeat', 'background-position':' center'});
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
    		 				    			   var script =  "res.fn_openTime('"+ obj[i].seat_id +"', '"+classinfo+"', '"+obj[i].seat_gubun+"','"+ obj[i].seat_name+"','"+ obj[i].seat_confirmgubun+"','"+ obj[i].res_reqday+"');"; 
    		 				    			   shtml += '<li id="s'+NVL(obj[i].seat_name) +'" onClick="'+script+ '" class="'+classinfo+'" seat-id="'+ obj[i].seat_id +'" name="'+obj[i].seat_id +'" >'+ NVL(obj[i].seat_name) +'</li>';
  	 									   }
  	 									   $('#area_Map').html(shtml);
    		 				    		   for (var i in result.resultlist) {
   	 										 $('.map ul li#s' + NVL(obj[i].seat_name) ).css({"top" : NVL(obj[i].seat_top)+"px", "left" : NVL(obj[i].seat_left)+"px"});
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
        		}, fn_seatTimeCombo : function(){
        			if (yesterDayConfirm($("#searchResStartday").val().replaceAll("-","") , "지난 일자는 검색 하실수 없습니다" ) == false ) return;
        			var params =  {'resStartday' : $("#searchResStartday").val().replaceAll("-",""), 'floorSeq':$("#floorSeq").val(), 'resSeq': '0'};
       	       	    fn_swcTimeUni(params, "SWC_GUBUN_4", 0, "res.fn_floorInfo");
       	       	    
        		}, fn_openTime : function(seat_id, classinfo, seatGubun, seat_name,seat_confirmgubun, res_reqday){
        			res.fn_reset();
        			$("#itemId").val(seat_id);
    				$("#p_seatNm").text(seat_name);
    				$("#seatConfirmgubun").val(seat_confirmgubun);
    				$("#resReqday").val(res_reqday);
    				$("#sp_seatNm").text(seat_name);
    				$("#resStartday").val($("#searchResStartday").val().replaceAll("-",""));
    				if (seatGubun == "SEAT_GUBUN_2" && classinfo == "seatUse") {
        				//스마트워크 좌석 예약
        				$("#btn_other").show();
        				$("#sp_resDay").text($("#searchResStartday").val());
        				$("#sp_resTimeS").text( $("#resStarttime option:selected").text());
        				$("#sp_resTimeE").text( $("#resEndtime option:selected").text())
        				//history 내용 없음
        				$("#hid_history").val("");
        				$("#btn_SeatRes").trigger("click");
        			} else if (seatGubun == "SEAT_GUBUN_2" && classinfo == "none") {	
        				res.fn_rightView();
        				//오른쪽 화면 보여주기 
        			}else {
        				//당일 좌석제 
        			}
        		}, fn_reset : function(){
        			 $("#itemId").val("");
        			 $("#seatConfirmgubun").val("");
        			 $("#resReqday").val("");
        		}, fn_rightView : function(){
        			 var url = "/web/selectTimeInfo.do";
    				 var params = {"itemId" : $("#itemId").val(), "searchResStartday" : $("#searchResStartday").val().replaceAll("-","")};
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
             		                                	 shtml +=   " <label for=\"ex_chk04\"><a href=''>좌석 예약 완료.</a></label>"	  
             		                                	       + "    "; 
             		                                  }
             		                                
             		                             shtml += "   </li>"
             		                                   + " </ul>"
             		                                   + "</div>";
             		                             $("#reserve_list").append(shtml);
    		 				    			  }
    		 				    		  }
    		 				    	   }
    		   					   }
    		 				    },
    		 				    function(request){
    		 					    alert("Error:" +request.status );	   
    		 					    $("#btn_needPopHide").trigger("click");
    		 				    }    		
    		         );
    				 openTime();
        		}, reserve_meeting : function (){
        			//우축 메뉴 클릭으로 해서 예약 하기 
        			$("#p_seatNm").text($("#sp_seatNm").text());
    				$("#sp_resDay").text($("#resStartday").val());
    				var checkItem = checkbox_val("체크된 값이 없습니다", "show_time");
    				if (checkItem != false){
    					const tempToArray = checkItem.split(',')
        				var minVal = Math.min.apply(null, tempToArray);
        				var maxVal = Math.max.apply(null, tempToArray);
        				$("#resStarttime").val(stringLength(String(minVal), "4", "0"));
        				$("#resEndtime").val(stringLength(String(maxVal), "4", "0"));
        				$("#sp_resTimeS").text( $("#resStarttime option:selected").text());
        				$("#sp_resTimeE").text( $("#resEndtime option:selected").text());
        				//다른 시간 버특 hide
        				$("#hid_history").val("res.fn_rightView");
        				$("#btn_other").hide();
        				$("#btn_SeatRes").trigger("click");
        				
    				}
    				
        		}
        		
            } 
        </script>

         <script type="text/javascript">
              var el = document.querySelector('div.pinch-zoom');
              new PinchZoom.default(el, {});
        </script>
</form:form>
</body>
</html>