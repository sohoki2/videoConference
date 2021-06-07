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
    
</head>
<body>
<form:form name="regist" commandName="regist" method="post">
<input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}" />
<input type="hidden" name="centerId" id="centerId" value="${regist.centerId}" />
<input type="hidden" name="partSeq" id="partSeq" />
<input type="hidden" name="seatId" id="seatId" />
<input type="hidden" name="seatConfirmgubun" id="seatConfirmgubun" />

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
                      <a href="#" onClick="res.fn_floorSearch(${floorList.floor_seq })" name="btn_floor" id="btn_${floorList.floor_seq }" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
                    </c:forEach>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        
       
        <!--floor Btn//-->
        <!--//search box-->
        <div class="contents">
            <div class="searchBox float_right">
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
                   <div class="float_left" style="margin-left: 15px;margin-top: -15px;">
                        <select id='resStarttime' style="width:100px;height:30px;"></select>
                         ~
                        <select id='resEndtime' style="width:100px;height:30px;"></select>
                   </div>
                   <div class="float_left">
                        <a href="#" onClick="res.fn_seatState()" class="seat_fast" style="height: 32px;">검색</a>
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
        <div id="ok_reserve" class="needpopup opened">
            <span id="sp_message"></span>
            <a href="#" class="needpopup_remover"></a>
        </div>
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
              <a href="#" onClick="res.fn_resSave()" class="blueBtn">예약</a>
              <a href="" onClick="res.fn_reset()" class="grayBtn">닫기</a>
            </div>
            <div class="clear"></div>
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
		                                <ul class="sel_list etrans">
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
		                                </ul>
		                            </div> 
		                     </div>  
		                     <div class="sel_inner_box" id="reserve_list">
		                     </div>       
		            </div>
		            <div class="pop_meeting_btn">
		                <a href="#" onClick="res.reserve_meeting()" class="blueBtn meeting_btn" data-needpopup-show="#seat_fastR_popup">좌석예약</a>
		            </div>
                    </div>
                <div class="backShadow"></div>
            </div>
            <!--시간선택 슬라이드 //-->

        <!--예약 완료 팝업//-->
        <!--//needpopup script-->
        <button type="button" id="btn_result" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
        <button id="btn_Res" type="button" style="display:none" data-needpopup-show='#seat_fastR_popup'>예약 팝업</button>
        
        <script src="/front_res/js/needpopup.min.js"></script>
        <script>  
         $( function() {
	       	 $( "#searchResStartday" ).datepicker({ dateFormat: 'yymmdd' });
	       	 res.fn_seatTimeCombo();
         });
         var res = {
        		fn_floorSearch : function (floorSeq){
        			$("#dv_floor").find("[name=btn_floor]").attr('class', '');
        			$("#btn_"+floorSeq).attr('class', 'active');
        			$("#floorSeq").val(floorSeq);
        			res.fn_seatTimeCombo();
        		}, fn_userSearch : function (){
        			//사용자 검색 
        		}, fn_seatState : function(){
        			var url = "/backoffice/resManage/seatStateInfo.do";
        			var params = {"swcResday" : $("#searchResStartday").val(), 
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
    		 				    			   var script =  "res.fn_openTime('"+ obj[i].seat_id +"', '"+classinfo+"', '"+obj[i].seat_gubun+"','"+ obj[i].seat_name+"','"+ obj[i].seat_confirmgubun+"'  );"; 
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
         		   //빠른검색
         		   var params = {"searchResStartday" : $("#searchResStartday").val(), "floorSeq" : $("#floorSeq").val()};
         		   var url = "/web/resSeatTime.do";
         		   uniAjax(url, params, 
         		 			function(result) {
         					       if (result.status == "LOGIN FAIL"){
         					    	    alert(result.message);
         									location.href="/web/Login.do";
         							   }else if (result.status == "SUCCESS"){
         								    //테이블 정리 하기
         									var objS = result.resStartTime;
         									if (objS.length > 0 ){
         										$("#resStarttime option").remove();
         										for (var i in objS){
         										    try{
         												$("#resStarttime").append("<option value='"+objS[i].codeNm.replace(":","") +"'>"+objS[i].codeNm+"</option>");
         											}catch(err){
         												console.log(err);
         											}
         		  						        }
         										$("#resStarttime option:eq(0)").prop("selected", true);
         									}
         									var objE = result.resEndTime;
         									if (objE.length > 0 ){
         										$("#resEndtime option").remove();
 	        		  							for (var i in  objE){
 	        		  								try{
 	        		  									$("#resEndtime").append("<option value="+objE[i].codeNm.replace(":","")+">"+objE[i].codeDc+"</option>");
 	        		  								}catch(err){
 	        		  									console.log(err);
 	        		  								}
 	        		  						    }
 	        		  							$("#resEndtime option:eq(0)").prop("selected", true);
         									}
         									res.fn_seatState();
         							   }
         					    },
         					    function(request){
         						    alert("Error:" +request.status );	       						
         					    }    		
         		     );
         		}, fn_openTime : function(seat_id, classinfo, seatGubun, seat_name,seat_confirmgubun){
        			if (seatGubun == "SEAT_GUBUN_2" && classinfo == "seatUse") {
        				//스마트워크 좌석 예약
        				$("#seatId").val(seat_id);
        				$("#p_seatNm").text(seat_name);
        				$("#sp_resDay").text($("#searchResStartday").val());
        				$("#sp_resTimeS").text( $("#resStarttime option:selected").text());
        				$("#sp_resTimeE").text( $("#resEndtime option:selected").text())
        				$("#seatConfirmgubun").val(seat_confirmgubun);
        				
        				$("#btn_Res").trigger("click");
        			} else if (seatGubun == "SEAT_GUBUN_2" && classinfo == "none") {	
        				res.fn_rightView(seat_id, seat_name,seat_confirmgubun);
        				//오른쪽 화면 보여주기 
        			}else {
        				//당일 좌석제 
        			}
        		},fn_resSave : function(){
	        		 var params = {'mode': "Ins", 'itemId': $("#seatId").val(), 'itemGubun':'ITEM_GUBUN_2', 'resTitle' : "좌석예약: " + $("#p_seatNm").text(),
		        		               'resPassword' : "Y", 
		        		               'resStartday' : $("#searchResStartday").val(),
		        				       'resStarttime' : $("#resStarttime").val(), 'resEndtime' : $("#resEndtime").val(),
		        				       'proxyUserId' : "", 'resGubun' : "",
		        				       'useYn' : "Y", 'centerId': $("#centerId").val(),
		        				       'proxyYn' : "Y",  'meetingSeq' : "", 
		        				       'seatConfirmgubun': $("#seatConfirmgubun").val(),
		        				       'resAttendlist' : "",
		        				       'conNumber' : "", 'conPin' : "",
		        				       'conVirtualPin' : "", 'conAllowstream' : "N" ,
		        				       'conBlackdial' :  "N" , 'conSendnoti' :  "N",
		        				       'resEqupcheck' : "RES_EQUPCHECK_1", 
		        				       'sendMessage' : "N",
		        				       'floorSeq' : $("#floorSeq").val()
		        		              };
	        		
	        		 //값 수정 
	        		 uniAjax("/web/resReservertionUpdate.do", params, 
	        	  			function(result) {
	        					       if (result.status == "LOGIN FAIL"){
	        							    alert(result.message);
	        								location.href="/web/Login.do";
	        						   }else{
	        						        need_close();
	        							    $("#sp_message").text(result.message);
	        							    $("#btn_result").trigger("click");
	        							    res.fn_reset();
	        							    res.fn_seatState();		
	        							    closeTime();
	        						   }
	        						  
	        				},
	        			    function(request){
	        				     alert("Error:" +request.status );	       						
	        			    }    		
	        	      );
        		}, fn_reset : function(){
        			 $("#seatId").val("");
        			 $("#seatConfirmgubun").val("");
        		}, fn_rightView : function(seat_id, seat_name, seat_confirmgubun){
        			 $("#seatId").val(seat_id);
        			 $("#sp_seatNm").text(seat_name);
        			 $("#seatConfirmgubun").val(seat_confirmgubun);
    				 //ajax로 시간바 가지고 오기
    				 var url = "/web/selectTimeInfo.do";
    				 var params = {"itemId" : seat_id, "searchResStartday" : $("#searchResStartday").val()};
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
             		                                	 shtml +=   " <label for=\"ex_chk04\">예약된 좌석 입니다.</label>"	  
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
    				$("#sp_resDay").text($("#searchResStartday").val());
    				var checkItem = checkbox_val("체크된 값이 없습니다", "show_time");
    				const tempToArray = checkItem.split(',')
    				var minVal = Math.min.apply(null, tempToArray);
    				var maxVal = Math.max.apply(null, tempToArray);
    				
    				
    				$("#resStarttime").val(stringLength(String(minVal), "4", "0"));
    				$("#resEndtime").val(stringLength(String(maxVal), "4", "0"));
    				$("#sp_resTimeS").text( $("#resStarttime option:selected").text());
    				$("#sp_resTimeE").text( $("#resEndtime option:selected").text())
    				$("#btn_Res").trigger("click");
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

         <script type="text/javascript">
              var el = document.querySelector('div.pinch-zoom');
              console.log(el);
              //console.log(e0);
              new PinchZoom.default(el, {});
        </script>
</form:form>
</body>
</html>