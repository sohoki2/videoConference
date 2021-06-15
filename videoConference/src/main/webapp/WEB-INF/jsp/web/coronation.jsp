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

        <input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}">
		<input type="hidden" name="searchCenterId" id="searchCenterId" value="${regist.searchCenterId}">
		<input type="hidden" id="itemGubun" name="itemGubun" value="${regist.itemGubun}" />
		<input type="hidden" id="searchRoomType" name="searchRoomType" value="${regist.searchRoomType}"/>
        <input type="hidden" name="hid_attendList" id="hid_attendList">
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
                       <a href="#" onClick="fn_floorSearch(${floorList.floor_seq }, 'fn_floorMeetingInfo()')" name="btn_floor" id="btn_${floorList.floor_seq}" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
                    </c:forEach>
                    
                </div>               
                <div class="clear"></div>
            </div>
        </div>
        <!--floor Btn//-->
        
        <!--//contents-->
        <div class="contents coron">
           <div class="line">
            <!--//date picker-->
                <div class="contents mobileM">
                    <div class="float_right">
                    <a href="/web/meetingDay.do" class="resource">회의실예약</a>
                  </div>
                  <div class="dateBox float_left">
                      <input type="text" id="searchResStartday" name="searchResStartday" class="inputSearch" value="${regist.searchResStartday}" onChange="res.fn_floorInfo()">
                      <div class="dateIcon" onClick="res.fn_floorInfo()">
                        <a class="dateBtn">검색</a>
                      </div>
                      <div class="clear"></div>
                   </div>
                </div>
              <!--date picker//-->
           </div>
           <div class="whiteBack meet">
            <div class="infoContents float_left">
                        <span class="usingSeat">예약완료</span>
                        <span class="posSeatD">예약검토</span>
                        <span class="posSeatU">대관요청</span>
                </div>
                <div class="clear"></div>
               <div class="scroll">
                  <div class="clear"></div>
                    <div>
                       <table class="day_T" id="tb_seatTimeInfo">
                           <thead>
                               <tr>
                                   <th class="fixed_th">시간</th>
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
                               <tr>
                                   <th class="fixed_th">스튜디오</th>
                                   <td class="none meet_popup" onclick="myFunction()">
                                     <span class="popuptext" id="meet_booking_pop">
                                       <p class="m_room">스튜디오</p>
                                       <p class="m_day">2021-05-07 12:00-15:00</p>
                                       <p class="m_title">시스템기획팀업무회의</p>
                                     </span>
                                   </td>
                                   <td class="none"></td>
                                   <td class="none"></td>
                                   <td></td>
                                   <td data-needpopup-show="#cor_reserve_popup"></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td class="now"></td>
                                   <td class="waiting"></td>
                                   <td class="waiting"></td>
                                   <td class="waiting"></td>
                                   <td class="waiting"></td>
                               </tr>
                           </tbody>
                       </table>
                    </div>
                </div>
           </div>
        </div>
        <!--contetns//-->
        
<div id="ok_reserve" class="needpopup opened">
     <span id="sp_message"></span>
     <a href="#" class="needpopup_remover"></a>
</div>        
<!--//대관 신청 팝업-->
<div id="app_meeting" class="needpopup">
      <h5 class="pop_tit">예약신청</h5>
      <ul class="form">
        <li>
          <p class="pop_text">대관</p>
          <span id="res_swcName"></span>
          <!--  영상 회의 관련 내용 -->
          <div style="display:none">
          
          <input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}">
		  <input type="hidden" name="searchCenterId" id="searchCenterId" value="${regist.searchCenterId}">
		  <input type="hidden" id="itemGubun" name="itemGubun" value="${regist.itemGubun}" />
		  <input type="hidden" id="searchRoomType" name="searchRoomType" value="${regist.searchRoomType}"/>
		
		
          <select id="resGubun"></select>
          <input type="radio" id="resPassword" name="resPassword" value="Y">공개
          <input type="radio" id="resPassword" name="resPassword" value="N">비공개
          <input type="hidden" id="conPin" name="conPin"/>
          <input type="hidden" id="conVirtualPin" name="conVirtualPin"/>
          <input type="hidden" id="conAllowstream" name="conAllowstream"/>
          <input type="hidden" id="conBlackdial" name="conBlackdial"/>
          <input type="hidden" id="conSendnoti" name="conSendnoti"/>
          <input type="hidden" id="resEqupcheck" name="resEqupcheck"/>
          <input type="hidden" id="proxyUserId" name="proxyUserId"/>
          <input type="checkbox" id="sendMessage" name="sendMessage"> 
          <input type="checkbox" id="proxyYn" name="proxyYn" value="Y"> <!--  대리 예약 관련 내용 --> 
          <input type="hidden" id="seatConfirmgubun" name="seatConfirmgubun"> 
          
          </div>
          <!--  영상 회의 관련 내용 -->
        </li>
        <li class="w50_cor">
          <p class="pop_text">사용자</p>
         
        </li>
        <li class="w50_cor">
          <p class="pop_text">이메일</p>
        </li>
        <li>
          <p class="pop_text">사용목적</p>
          <input type="text" id="resRemark" name="resRemark">
        </li>
        <li>
          <p class="pop_text">행사규모</p>
          <input type="number" id="resPerson" name="resPerson">
        </li>
        <li>
          <p class="pop_text">사용일시</p>
          <input class="date_cor" type="text" id="resStartday" name="resStartday" class="inputSearch">
          <select id='resStarttime' style="width:120px;"></select>
          ~ 
          <input class="date_cor" type="text" id="resEndday" name="resEndday" class="inputSearch">
          <select id='resEndtime' style="width:120px;"></select>
        </li>
        <li><input type="text" placeholder="제목" name="resTitle" id="resTitle"></li>
        <li>
          <p class="pop_text">주의사항</p>
          <div class="scroll">
            1. 대관신청은 사용 시작일 기준 7일 전까지 완료되어야 합니다. <br/>
            2. 실예약자 외 타인에게 대관을 양도할 수 없습니다.<br/>
            3. 시설 이용 후 집기비품은 반드시 원상복구해야 합니다.<br/>
            4. 시설 내 취식은 불가합니다.<br/>
            5. 예약을 취소하거나 변경할 경우 반드시 담당자에게 연락하셔야 합니다.<br/>
            6. 사용자의 과실/부주의로 파손, 분실 등이 발생할 경우 손해배상책임이 있습니다.<br/>
            7. 개인정보 수집동의(아래)<br/>
            ○ 목적: 시설 운영관리<br/>
            ○ 보유항목: 이름, 소속, 전화번호, 이메일<br/>
            ○ 개인정보 보유 및 이용기간: 신청일 기준 5년<br/>
                                ※ 동의를 거부할 권리가 있으며 동의 거부 시 시설 이용이 제한됩니다.<br/>
          </div>
          <p class="pop_text margintop10"><input type="checkbox" id="agreeCheck" name="agreeCheck">동의합니다</p>
          
        </li>
      </ul>
      <div class="clear"></div>
      <div class="footerBtn">
        <a href="#" onClick="res.fn_ResSave()" class="blueBtn">대관신청</a>
        <a href="#" onClick="need_close()" class="grayBtn">취소</a>
      </div>
      <div class="clear"></div>
  </div>
  
  
  <div id="ok_reserve" class="needpopup opened">
     <span id="sp_message"></span>
     <a href="#" class="needpopup_remover"></a>
  </div>
  <button type="button" id="btn_result" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
  <!--예약 팝업//-->           
        <script src="/front_res/js/needpopup.min.js"></script>
		<script type="text/javascript">
			function need_close(){
				needPopup.hide();
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
        <!--//pinch-zoom-->
        <script>  
            $( function() {
            	 $( "#searchResStartday").datepicker({ dateFormat: 'yymmdd' });
            	 $( "#resStartday").datepicker({ dateFormat: 'yymmdd' });
            	 $( "#resEndday").datepicker({ dateFormat: 'yymmdd' });
            	 fn_floorMeetingInfo();
            	 var state = "${status}";
        		 if (state == "FAILLACK"){
        	   		 alert("적용되는 시설물이 없습니다");
        	   		 location.href= "/web/index.do";
        	   	 }
        		
            });
           
            var res = {
            		fn_floorInfo : function(){
            			if (yesterDayConfirm($("#searchResStartday").val() , "지난 일자는 검색 하실수 없습니다" ) == false ) return;
                    	
                    	var params = {'searchCenterId' : $("#searchCenterId").val(), 
                    			      'searchFloorseq' :  $("#floorSeq").val(),
                    			      'searchResStartday' : $("#searchResStartday").val(), 
                    			      'searchRoomType' : 'SWC_GUBUN_3',
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
            		  											setHtml += "<td id='"+timeInfo.time_seq+"' data-needpopup-show='#app_meeting' class='popup_view' onclick='res.fn_resInfo(&#39;"+seatinfo.meeting_id +"&#39;,&#39;"+timeInfo.time_seq +"&#39;,&#39;"+timeInfo.swc_time +"&#39;,&#39;"+ seatinfo.meeting_name +"&#39;,&#39;"+timeInfo.res_seq +"&#39;,&#39;"+seatinfo.meeting_confirmgubun +"&#39;,&#39;"+seatinfo.meeting_equpgubun +"&#39;,&#39;"+seatinfo.room_type +"&#39;);'></td>";
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
            		}, fn_resInfo : function (itemId, timeSeq, swcTime, swcName, resSeq, seatConfirmgubun, seatEqupgubun){
            			if (resSeq == "0"){
            				$("#mode").val("Ins");
            				$("#res_swcName").text(swcName);
            				$("#resTitle").val();
            				var resDay = ($("#searchResStartday").val() == "") ? today_get() : $("#searchResStartday").val();
            				$("#resStartday").val(resDay);
            				$("#resEndday").val(resDay);
            				$("#itemId").val(itemId);
            				$("#useYn").val("Y");
            		        $("#sp_meetingAttendList").html("");
            		        $("#hid_attendList").val("");
            		        $("#meetingSeq").val("");
            		        $("#meegintRoomInfo").html("");
            		        $("#seatConfirmgubun").val(seatConfirmgubun);
            		        $("#hid_equipList").val("");
            		   	    $("#sp_equipRoomInfo").html("");
            		   	    $("#resEqupcheck").val("");
            		   		$("#div_meeting1").hide();
            			    $("#div_meeting2").hide();
            			    if (seatEqupgubun == "Y"){
            		        	$("#div_equipRoomInfo").show();
            		           // $("#resEqupcheck").html("");
            		        }else {
            		        	$("#div_equipRoomInfo").hide();
            		        }
            			}else {
            				$("#mode").val("Edt");
            			}
            			res.fn_swcTime(swcTime, resSeq, itemId, roomType);
            			//fn_swcTimeUni
            			
            		}, fn_swcTime : function (swcTime, resSeq, itemId ){
            			var params = {'resStarttime': swcTime, 'resSeq': resSeq, 'itemId' : itemId, 'searchRoomType' : $("#searchRoomType").val()};
            			uniAjax("/web/resInfo.do", params, 
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
            										    console.log(objS[i].codeNm);
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
            		  							for (var i in  objE){
            		  								try{
            		  									$("#resEndtime").append("<option value="+objE[i].codeNm.replace(":","")+">"+objE[i].codeDc+"</option>");
            		  								}catch(err){
            		  									console.log(err);
            		  								}
            		  						    }
            									}
            									//회의실 구분
            									fn_ResGubunCombo("resGubun", result.seatInfo.room_type, null);
            									$("#resStarttime").val(swcTime);
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
            		}, fn_ResSave : function(){
            			 var resEqupcheck = "";
            			 
            			 
            			 
            			 // 회의실 일떄 -> ITEM_GUBUN_1 로 정의 추후 변경 예정 
	           			 if (res.fn_Check("agreeCheck", "개인정보 수집 및 이용 동의는 필수입니다.") == false) return;
	           			 if (any_empt_line_span("resTitle", '회의 제목을 입력해 주세요.',"sp_errorMessage") == false) return;
	           			 if (any_empt_line_span("resStarttime", '회의 시작 시간을 선택해 주세요.', "sp_errorMessage") == false) return;
	           			 if (any_empt_line_span("resEndtime", '회의 종료 시간을 선택해 주세요.', "sp_errorMessage") == false) return;
	           			 if ($("#div_equipRoomInfo").is(":visible") == true){
	           		           if (any_empt_line_span("resEqupcheck", '장비사용 여부를 선택해 주세요.', "sp_errorMessage") == false) return;
	           			 }
	           			 if ($("#resGubun").val() == "SWC_GUBUN_2"  && $("#meetingSeq").val() == ""){
	           				 $("#sp_errorMessage").html("영상회의를 진행할 회의실을 선택해 주세요.");	 
	           				 return;
	           			 }
	           			 if ($("#resEqupcheck").val() == "장비 사용여부"){
	           		         resEqupcheck = "RES_EQUPCHECK_1";
	           			 }else {
	           				 //여기 부분에 값 넣기 
	           				 resEqupcheck = $("#resEqupcheck").val();
	           			 }
	           			 if ($("#meetingSeq").val() == "on"){
	           		          $("#meetingSeq").val("");
	           			 }
	           			 var params = {'mode': $("#mode").val(), 'itemId': $("#itemId").val(), 'itemGubun':'ITEM_GUBUN_3', 'resTitle' : $("#resTitle").val(),
	           			               'resPassword' : fn_domNullReplace( $("input:radio[name='resPassword']:checked").val() ,'Y'), 'resStartday' : $("#resStartday").val(),
	           			               'resEndday' : $("#resEndday").val(),
	           					       'resStarttime' : $("#resStarttime").val(), 'resEndtime' : $("#resEndtime").val(),
	           					       'proxyUserId' : $("#proxyUserId").val(), 'resGubun' : $("#resGubun").val(),
	           					       'useYn' : "Y", 'centerId': $("#searchCenterId").val(),
	           					       'proxyYn' :  $("#proxyYn").val(),  'meetingSeq' : $("#meetingSeq").val(), 
	           					       'seatConfirmgubun': $("#seatConfirmgubun").val(),
	           					       'resAttendlist' : $("#hid_attendList").val().substring(1),
	           					       'conNumber' : "", 'conPin' : $("#conPin").val(),
	           					       'conVirtualPin' :$("#conVirtualPin").val(), 'conAllowstream' : fn_domNullReplace($("#conAllowstream").val(), "N") ,
	           					       'conBlackdial' : fn_domNullReplace($("#conBlackdial").val(), "N") , 'conSendnoti' :  fn_domNullReplace($("#conSendnoti").val(), "N"),
	           					       'resEqupcheck' : fn_domNullReplace( $("#resEqupcheck").val(), "RES_EQUPCHECK_1"), 
	           					       'sendMessage' : fn_domNullReplace($("input:checkbox[name='sendMessage']:checked").val() ,'N'),
	           					       'floorSeq' : $("#floorSeq").val(), 'resRemark' : $("#resRemark").val(), 'resPerson' : fn_domNullReplace($("#resPerson").val(), "0")
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
	           								    fn_resCancel();
	           								    res.fn_floorInfo();	
	           							   }
	           							  
	           					},
	           				    function(request){
	           					     alert("Error:" +request.status );	       						
	           				    }    		
	           		     );
           		    }, fn_Check : function(_UniCheckFormNm, _btn_message){
	            		if ($("#"+_UniCheckFormNm).is(":checked") == true){
	            			return true;
	            		}else {
	            		    $("#sp_message").text(_btn_message);
	            		    $("#btn_result").trigger("click");
	            			return false;
	            		}
            		}
            }
         </script>
         <script type="text/javascript">
              var el = document.querySelector('div.pinch-zoom');
              new PinchZoom.default(el, {});
        </script>
        <!--pinch-zoom//-->
</form:form>
</body>
</html>