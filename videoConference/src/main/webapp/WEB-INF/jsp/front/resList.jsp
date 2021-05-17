<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    
    <link rel="stylesheet" href="/css/new/paragraph.css">    
    <link rel="stylesheet" href="/css/new/reset.css"> 
    <link rel="stylesheet" href="/css/new/swiper.css">
    
        
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    
    <link rel="stylesheet" href="/css/new/jquery-ui.css">
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    
    <script src="/js/popup.js"></script>
    
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    <script type="text/javascript" src="/js/common_res.js"></script>
</head>
<body>
<div id="wrapper" >
        <c:import url="/front/inc/fnt_top_inc.do" />
        <div id="container">
            <div class="contents">
                <h2 class="sub_tit">예약현황</h2>                
                <!-- contents -->
                <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/resList.do">	
                <input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
                <input type="hidden" id="mode" name="mode" />
                <input type="hidden" id="meetingSeq" name="meetingSeq">
                <input type="hidden" id="userMode" name="userMode">
                <input type="hidden" id="hid_attendList" name="hid_attendList">
                <input type="hidden" id="hid_equipList" name="hid_equipList"> 
                
                
                <jsp:useBean id="nowDate" class="java.util.Date" />
                <c:set var="sysday"><fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /></c:set>
				<c:set var="systime"><fmt:formatDate value="${nowDate}" pattern="HH:mm" /></c:set>
				
                <div class="pe_005">
                    <div class="day_con">
                        <!-- top button -->
                        <div class="left_box">
                            <form:select path="searchCenterId" id="searchCenterId" title="소속" style="width:180px;height:40px;" onChange="fn_SeatChange()">
							         <form:option value="" label="사무소선택"/>
			                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
							</form:select>	
							<form:select path="searchSeatSeq" id="searchSeatSeq" title="소속" style="width:180px;height:40px;" onChange="fn_SeatChange()">
							         <form:option value="" label="회의실선택"/>
							         <c:forEach items="${selectSeat}" var="meeting">
			                            <option value="${meeting.meeting_id}">${meeting.meeting_name}</option>
			                         </c:forEach>
							</form:select>	
                        </div>
                        <div class="right_box">
                             <a href="/front/resInfo/resMonthList.do" class="text_btn">달력</a>
                             <a href="/front/resInfo/resListInfo.do" class="text_btn">테이블</a>
                           <!--   <a href="#"  data-needpopup-show='#app_meeting' onclick='fn_resPop()'; class="list-btn">예약하기</a> -->
                        </div>
                        <div class="clearfix"></div>
                        <!-- // top button -->

                        <!-- list style -->
                        <div class="list_box">
                            <c:forEach items="${resultlist }" var="resInfo" varStatus="status">
                            <div class="list_meeting">
                                
                                <div class="left_box">
                                    <p class="meeting_time active">${resInfo.resstartday } ${resInfo.resstarttime }~${resInfo.resendtime }</p>
                                    <span class="meeting_tit"><a href='#' onclick="fn_resView('${resInfo.res_seq }')">${resInfo.res_title }</a></span>
                                     <c:choose>  
	                                           <c:when test="${(resInfo.reservProcessGubun eq 'PROCESS_GUBUN_2' or resInfo.reservProcessGubun eq 'PROCESS_GUBUN_4') 
			                                                and sysday eq resInfo.resStartday.replaceAll('-','') 
			                                                and (
			                                                    systime >= resInfo.resstarttime.replaceAll(':','') and systime <= resInfo.resendtime.replaceAll(':','')
			                                                    )}">
	                                               <div class="meeting_ing meeting_state"></div>
	                                           </c:when>
	                                           <c:when test="${(resInfo.reservProcessGubun eq 'PROCESS_GUBUN_2' or resInfo.reservProcessGubun eq 'PROCESS_GUBUN_4') 
		                                                and sysday eq resInfo.resStartday.replaceAll('-','') 
		                                                and systime < resInfo.resEndtime.replaceAll(':','')}">
	                                               <div class="meeting_loading meeting_state"></div>
	                                           </c:when>
	                                </c:choose>
                                    <ul class="meeting_info">
                                        <li>주최자 : ${resInfo.empname } [${resInfo.deptname} ]</li>
                                        <li>참여자: ${resInfo.attendlisttxt }</li>
                                        <li>장소: ${resInfo.meeting_name } 
										<c:if test="${resInfo.con_number ne ''}">
										    방번호: ${resInfo.con_number }
										</c:if>
										</li>
                                    </ul>
                                </div>
                                <div class="right_box">
                                  <p class="meetine_member">회의 구분 : ${resInfo.resgubuntxt }</p>
                                  <p>결제 상태 : ${resInfo.reservprocessgubuntxt }</p>
                                </div>
                                <div class="clearfix"></div>
                            </div>   
                            </c:forEach>
                                               
                        </div>                       
                        <!-- // list style -->
                        <!-- page number --> 
                        <div class="page_num">
                           <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
                        </div>
                        <!-- bottom btn -->
                        <div class="pop_footer">
                           
                        </div>
                    </div>
                </div>
                <!-- // contents -->
                
            </div>            
        </div>
    </div>
    <!--  예약 팝업 시작 -->
    
    <!-- 예약신청하기 팝업 -->
    <div id='app_meeting' class="needpopup">
        <div class="box_padding">
            <h2 class="pop_top">예약 신청</h2>  
            <div class="pop_container">
                <div class="pop_con">
                    <div class="box_2">
                        <span id="res_swcName"></span>
                    </div>
                    <div class="box_2">
                        <input type="text" name="resTitle" id="resTitle"  placeholder="제목" autocomplete="false"/>
                    </div>
                </div>
                <div class="pop_con">
                    
                    <div class="box_2 popup_view">
                        <select id='resGubun' name="resGubun" onChange="fn_MeetingCheck()">
                            <option>회의실 사용여부</option>
                            <option value="SWC_GUBUN_1">일반 회의실</option>
                            <option value="SWC_GUBUN_2">영상 회의실</option>
                        </select>
                    </div>
                    <div class="box_2">
                       <span id="sp_ResDay" style="margin-right: 20px;"></span>
                       <select id='resStarttime' style="width:120px;"></select>~
                       <select id='resEndtime' style="width:120px;"></select>
                    </div>
                </div>
                <div class="pop_con">
                    <div class="box_2 popup_view">
                        <input type="hidden" name="proxyYn" id="proxyYn">
                        <input type="radio" id="resPassword" name="resPassword" value="Y">공개
                        <input type="radio" id="resPassword" name="resPassword" value="N">비공개
                        
                    </div>
                    <div class="box_2 popup_view"  data-needpopup-show="#view_meeting">
                        <a href="#" onclick="fn_userPop('P')">참가대상</a>
                    </div>
                </div>
                <div class="pop_con" id="div_meetingRoomInfo" style="display:none;">
                    <div class="box_2">
                        <span id="meegintRoomInfo"></span>
                    </div>
                </div>
                <div class="pop_con" id="div_equipRoomInfo" style="display:none;">
                   <div class="box_2 popup_view"  data-needpopup-show="#view_equpInfo" style="width:50%">
                        <a href="#" onclick="fn_equipList()" style="width:50%">대여장비선택</a>
                    </div>
                    <div class="box_3">
                        <span id="sp_equipRoomInfo"></span>
                    </div>
                </div>
                <!--  추가 부분 -->
                <div class="pop_con" id="div_meeting1" style="display:none;">
                    <!-- <div class="box_2 popup_view">
                        <input type="text" name="conNumber" id="conNumber"  placeholder="전화번호" autocomplete="false"/>
                    </div> -->
                    <div class="box_2 popup_view" >
                        <input type="text" name="conPin" id="conPin"  placeholder="PIN번호" autocomplete="false"/>
                    </div>
                    <div class="box_2 popup_view"  >
                         <select id='conAllowstream' name="conAllowstream" >
                            <option value="Y">스트리밍 허용</option>
                            <option value="N" selected>스트리밍 허용안함</option>
                        </select>                    
                    </div>
                    
                </div>
                
                <div class="pop_con" id="div_meeting2" style="display:none;">
                    <!-- <div class="box_2 popup_view">
                        <input type="text" name="conVirtualPin" id="conVirtualPin"  placeholder="가상PIN번호" autocomplete="false"/>
                    </div> -->
                </div>
                <div class="pop_con" id="div_meeting3" style="display:none;">
                    <div class="box_2 popup_view">
                    
                        <select id='conBlackdial' name="conBlackdial" >
                            <option value="Y">참여 허용</option>
                            <option value="N" selected>참여허용안함</option>
                        </select>    
                        
                    </div>
                    <div class="box_2 popup_view" >
                        <select id='conSendnoti' name="conSendnoti" >
                            <option value="Y">회의 공지</option>
                            <option value="N" selected>공지 안함</option>
                        </select> 
                    </div>
                </div>
                <!--  추가 부분 끝 -->
                <div class="pop_con" id="div_attendList">
                   <div class="box_3">
                      <span id="sp_meetingAttendList" style="border-style: none;"></span>
                   </div>
                </div>
                
                <div class="pop_con">
                   <div class="box_3">
                      <span id="sp_errorMessage" style="font-color:red;"></span>
                      
                   </div>
                </div>
            </div>
            <div class="pop_footer">
                <a href="#" onclick="fn_ResSave()" class="pop_btn">최종예약</a>
                <a href="#" onclick="fn_resCancel()" class="pop_btn">취소</a>
            </div>
        </div>            
    </div>
    <!-- 예약 정보 확인  -->
    <div id='app_ResInfo' class="needpopup">
        <div class="box_padding">
            <h2 class="pop_top">예약  정보</h2>  
            <div class="pop_container">
                <div class="pop_con">
                    <div class="box_2">
                        <span id="sp_res_swcName"></span>
                    </div>
                    <div class="box_2">
                        <span id="sp_resTitle"></span>
                    </div>
                </div>
                <div class="pop_con">
                    <div class="box_2">
                        <span id="sp_resPassword"></span>
                    </div>
                    <div class="box_2">
                       <span id="sp_ResStartDay" style="margin-right: 20px;"></span>
                       <span id="sp_ResStartTime" style="margin-right: 50px;"></span>
                     
                    </div>
                </div>
                <div class="pop_con">
                    <div class="box_2">
                         <span id="sp_proxyYn"></span>
                        
                    </div>
                    <div class="box_2 popup_view">
                        <span id="sp_regGubun"></span>
                        
                    </div>
                </div>
                <div class="pop_con" id="div_meetingResRoomInfo" style="display:none;">
                    <div class="box_2">
                        <span id="sp_meegintRoomInfo"></span>
                        
                    </div>
                </div>
                <div class="pop_con">
                    <div class="box_2" >
                        <span id="sp_resPorcess"></span>
                    </div>
                </div>
                <div class="pop_con">
                   <div class="box_2">
                      <span id="sp_ResMeetingAttendList" style="border-style: none;"></span>
                   </div>
                </div>
                   
            </div>
            
        </div>            
    </div>
    <!-- 예약 정보 확인  -->
    <!-- 예약신청하기 팝업 //-->
    <!-- 영상 회의 관련 팝업 -->
    <div id='view_meetingRoom' class="needpopup">
        <div class="box_padding">
            <h2 class="pop_top" id="popTopTxtMeeting">영상 회의실 선택</h2>  
            <div class="pop_container">
                
                <div class="clearfix"></div>
               <!--  <div class="userList_btn">
                    <input type="checkbox" name="" class="group_check">전체선택
                    <a href="#" class="group_del">삭제</a>
                </div> -->
                <div class="clearfix"></div>
                <div class="pop_userList group_pop">
                 <input type="checkbox" id="comferenceAllCheck" name="comferenceAllCheck" onclick="fn_conAllCheck();">전체 선택
                </div>
                <div class="pop_userList group_pop">
                    <div class="border_line">
                        <span id="sp_popMeetingLst"></span>                       
                    </div>
                </div>   
                <div class="pop_con">
                   <div class="box_2">
                      <font color='red'>※ 중복 선택 가능 합니다</font>
                   </div>
                </div>
            </div>
            <div class="pop_footer">
                <a href="#" onClick="fn_meetingRoom()" class="pop_btn">완료</a>
                <a href="#" onClick="fn_resMeetingReset()" class="pop_btn">취소</a>
            </div>
        </div>            
    </div>
    <!-- 영상 회의 관련 팝업 -->
    <div id='view_equpInfo' class="needpopup">
          <div class="box_padding">
            <h2 class="pop_top" id="popTopTxtMeeting">대여 장비 선택</h2>  
            <div class="pop_container">
                <div class="clearfix"></div>
                <div class="pop_userList group_pop">
                    <div class="border_line">
                        <span id="sp_equipLst"></span>                       
                    </div>
                </div>
            </div>
            <div class="pop_userList group_pop" id="div_equip" style="height:40px;">
                    <div class="border_line">
                        <span id="sp_popEquipLst"></span>
                    </div>
            </div> 
            <div class="pop_footer">
                <a href="#" onClick="fn_equipInfo()" class="pop_btn">완료</a>
                <a href="#" onClick="fn_resEquipReset()" class="pop_btn">취소</a>
            </div>
        </div>   
     </div>
    <!-- 참가대상 팝업-->
    <div id='view_meeting' class="needpopup">
        <div class="box_padding">
            <h2 class="pop_top" id="popTopTxt"><span id="popTopTxt">참여자 선택</span></h2>  
            <div class="pop_container">
                <div >
                    <select id="searchJobpst" style="width:100px;height:46px;float: left;">
					</select>	
	                <select id=searchCondition style="width:180px;height:46px;float: left;">
			                     <option value="NM_DEPT">부서명</option>
			                     <option value="NM_KORNAME" selected>사용자명</option>
			        </select>
		        </div>
                <div class="search_form">
                   <fieldset>
                       <input type="text" id="searchKeyword" placeholder="임직원을 입력하세요">
                   </fieldset>
                </div>
                 <div class="group_btn">
                    <a href="#" onClick="fn_userSearch()" class="btn_search">SEARCH</a>
                </div>
                <div class="clearfix"></div>
                <div class="clearfix"></div>
                <div class="pop_userList group_pop">
                 <input type="checkbox" id="userAllCheck" name="userAllCheck" onclick="fn_userAllCheck();">전체 선택
                </div>
                <div class="pop_userList group_pop">
                    <div class="border_line">
                        <span id="sp_popUsrLst"></span>
                    </div>
                </div>  
                
                <div class="pop_userList group_pop" id="div_attend" style="height:40px;">
                    <div class="border_line">
                        <span id="sp_popAttendLst"></span>
                       
                    </div>
                </div> 
            </div>
            <div class="pop_con">
                   <div class="box_2">
                      <font color='red'>※ 중복 선택 가능 합니다</font>
                   </div>
                </div> 
            <div class="pop_footer">
                <a href="#" onclick="fn_attendList();" class="pop_btn">완료</a>
                <a href="#" onclick="fn_resReset()" class="pop_btn">취소</a>
            </div>
        </div>            
    </div>
    <!-- 참가대상 팝업 //-->
    <button id="btn_meeting" style="display:none" data-needpopup-show='#app_meeting'>확인1</button>
    <button id="btn_view" style="display:none" data-needpopup-show='#view_meeting'>확인2</button>
    <button id="btn_meetingRoom" style="display:none" data-needpopup-show='#view_meetingRoom'>확인3</button>
    <button id="btn_res" style="display:none" data-needpopup-show='#app_ResInfo'>확인4</button>
    <button id="btn_hide" style="display:none">확인5</button>
      <button id="btn_equip" style="display:none" data-needpopup-show='#app_ResInfo'>확인6</button>
    </form:form>
    <!-- 예약 팝업 끝 -->
    <!--popup-->
    <script src="/js/needpopup.min.js"></script> 
    <script>  
	    function fn_resReset(){
	    	$("#btn_meeting").trigger("click");
	    }
        function fn_SeatChange(){
        	 $("form[name=regist]").attr("action", "/front/resInfo/resList.do").submit();
        }
        
        function fn_resPop(){
        	$("#mode").val("Ins");
        	var resDay = ($("#resStartday").val() == "") ? today_get() : $("#resStartday").val();
        	$("#useYn").val("Y");
            $("#sp_meetingAttendList").html("");
            $("#hid_attendList").val("");
        }
        function fn_swcSeqChange(){
        	var params = {'resStarttime': "0800", 'resSeq': "0", 'swcSeq' : $("#swcSeq").val()};
        	uniAjax("/front/resInfo/resInfo.do", params, 
         			function(result) {
        			       if (result.status == "LOGIN FAIL"){
        			    	    alert(result.message);
        							location.href="/backoffice/login.do";
        					   }else if (result.status == "SUCCESS"){
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
        							
        							fn_ResGubunCombo("resGubun", result.seatInfo.roomType, null);
        							
        							if (result.seatInfo.roomType != "SWC_GUBUN_2"){
        								$("#resGubun").val("SWC_GUBUN_1");
        							}
        							
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
        }
        function fn_resList(){
        	
        }
        function linkPage(pageNo) {
    		$(":hidden[name=pageIndex]").val(pageNo);
    		$("form[name=regist]").attr("action", "/front/resInfo/resList.do").submit();	
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
        <script>
      $( function() {
        $( "#resStartday" ).datepicker({ dateFormat: 'yymmdd' });
        
      } );
    </script>
</body>
</html>