<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    
    <link rel="stylesheet" href="/css/new/paragraph.css">    
    <link rel="stylesheet" href="/css/new/reset.css"> 
    <link rel="stylesheet" href="/css/new/swiper.css">
    
        
    <script type="text/javascript" src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="/js/front/common.js"></script>
    <script type="text/javascript" src="/js/front/uni_common.js"></script>
    
    <link rel="stylesheet" href="/css/new/jquery-ui.css">
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/main/needpopup.min.css">
    
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/front/com_resInfo.js"></script>
    <script type="text/javascript" src="/js/front/common_res.js"></script>
</head>
<body>

 <div id="wrapper">
        <c:import url="/front/inc/fnt_top_inc.do" />
       
        <div id="container">
            <div class="contents">
                <h2 class="sub_tit">예약</h2>                
                <!-- contents -->
                 <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/resListInfo.do">	
                 <input type="hidden" id="mode" name="mode" />
                 <input type="hidden" id="resStartday" name="resStartday" />
                 <input type="hidden" id="itemId" name="itemId" />
                 <input type="hidden" id="meetingSeq" name="meetingSeq">
                 <input type="hidden" id="userMode" name="userMode">
                 <input type="hidden" id="hid_attendList" name="hid_attendList">
                 <input type="hidden" id="hid_equipList" name="hid_equipList"> 
				 <input type="hidden" id="searchRoomType" name="searchRoomType" value="${regist.searchRoomType}"> 

				 
                <div class="pe_005">
                    <div class="pe_left">
                        <a href="#" onClick="fn_arrow('F');"><img src="/images/pe_icon01.png"></a>
                    </div>
                    <div class="pe_con">
                        <!-- top button -->
                        <div class="left_box">
                            <form:select path="searchCenterId" id="searchCenterId" title="소속" style="width:180px;height:40px;">
							         <form:option value="" label="선택"/>
			                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
							</form:select>	
							<input type="text" class="date_box" id="searchResStartday" name="searchResStartday" />  
                        </div>
                        <div class="right_box">
                           <a href="#" onclick="fn_search();" class="text_btn">검색</a>
                           <a href="/front/resInfo/resMonthList.do" class="text_btn">달력</a>
                           <a href="/front/resInfo/resList.do" class="text_btn">목록보기</a>
                        </div>
                        <div class="clearfix"></div>
                        <!-- // top button -->

                        <!--week table -->
                        <table class="pe_005T" id="tb_seatTimeInfo">
                            <thead>
                                <tr>
                                    <th style="width:200px;">시간</th>
                                    <th colspan="2">8시</th>
                                    <th colspan="2">9시</th>
                                    <th colspan="2">10시</th>
                                    <th colspan="2">11시</th>
                                    <th colspan="2">12시</th>
                                    <th colspan="2">13시</th>
                                    <th colspan="2">14시</th>
                                    <th colspan="2">15시</th>
                                    <th colspan="2">16시</th>
                                    <th colspan="2">17시</th>
                                    <th colspan="2">18시</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                    <div class="pe_right">
                        <a href="#" onClick="fn_arrow('N');"><img src="/images/pe_icon02.png"></a>
                    </div>
                </div>
                <!-- // contents -->
                </form:form>   
            </div>            
        </div>
    </div>
     
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
                        <input type="radio" name="resPassword" value="Y" id="resPassword_1"><span id="sp_01">공개</span>
                        <input type="radio" name="resPassword" value="N" id="resPassword_2"><span id="sp_02">비공개</span>
                    </div>
                    <div class="box_2 popup_view"  data-needpopup-show="#view_meeting" >
                        <a href="#" onclick="fn_userPop('P')">참가대상</a>
                    </div>
                </div>
                <div class="pop_con" id="div_meetingRoomInfo" style="display:none;">
                    <div class="box_2">
                        <span id="meegintRoomInfo"></span>
                    </div>
                </div>
                <!-- <div class="pop_con" id="div_equipRoomInfo" style="display:none;">
                   <div class="box_2 popup_view"  data-needpopup-show="#view_equpInfo">
                        <a href="#" onclick="fn_equipList()">대여장비선택</a>
                    </div>
                    <div class="box_2">
                        <span id="sp_equipRoomInfo"></span>
                    </div>
                </div> -->
                <div class="pop_con" id="div_equipRoomInfo" style="display:none;">
                   <div class="box_2 popup_view"  >
                        <select id='resEqupcheck' name="resEqupcheck"  onChange="fn_EquipCheck()">
                            <option value="">장비 사용여부</option>
                            <option value="RES_EQUPCHECK_1">신청 없음</option>
                            <option value="RES_EQUPCHECK_2">대여 신청 </option>
                        </select>
                    </div>
                    <div class="box_2">
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
                            <option value="Y">녹화 허용</option>
                            <option value="N" selected>녹화 허용안함</option>
                        </select>                    
                    </div>
                </div>
                
                <div class="pop_con" id="div_meeting2" style="display:none;">
                    <div class="box_2 popup_view">
                        <input type="text" name="conVirtualPin" id="conVirtualPin"  placeholder="진행자PIN번호" autocomplete="false"/>
						<font color="red">*진행자가 있는 회의인 경우만 입력</font>
                    </div>
					  <div class="box_2 popup_view">
                        <select id='conBlackdial' name="conBlackdial" >
                            <option value="Y">참여 허용</option>
                            <option value="N" selected>참여허용안함</option>
                        </select>    
                    </div>
                </div>
                <div class="pop_con" id="div_meeting3" style="display:none;">
                    <div class="box_2 popup_view" >
                        <select id='conSendnoti' name="conSendnoti" >
                            <option value="Y">회의 공지</option>
                            <option value="N" selected>공지 안함</option>
                        </select> 
                    </div>
                </div>
                <!--  추가 부분 끝 -->
                <!-- <div class="pop_con">
                    <div class="box_2">
                        <select id='useYn' name="useYn">
                            <option>회의실 사용여부</option>
                            <option value="Y">사용</option>
                            <option value="N">비사용</option>
                        </select>
                    </div>
                    
                </div> -->
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
                <!-- <div class="pop_con">
                    <div class="box_2">
                        <label>비밀번호 입력시 비공개 회의로 전환 합니다.</label>
                    </div>
                </div>    --> 
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
                   <div class="box_2">
                      <span id="sp_ResMeetingAttendList" style="border-style: none;"></span>
                   </div>
                </div>
				<div class="pop_con">
                   <div class="box_2">
                      <span id="sp_EquipList" style="border-style: none;"></span>
                   </div>
                </div>
            </div>
			<div class="pop_footer">
                <a href="#" onclick="fn_resCancel()" class="pop_btn">닫기</a>
            </div>
            
        </div>            
    </div>
    <!-- 예약 정보 확인  -->
    <!-- 예약신청하기 팝업 //-->
    <!-- 영상 회의 관련 팝업 -->
    <div id='view_meetingRoom' class="needpopup">
        <div class="box_padding">
            <h2 class="pop_top" id="popTopTxtMeeting">호출 대상 회의실 선택</h2>  
            <div class="pop_container">
                
                <div class="clearfix"></div>
               <!--  <div class="userList_btn">
                    <input type="checkbox" name="" class="group_check">전체선택
                    <a href="#" class="group_del">삭제</a>
                </div> -->
                <div class="clearfix"></div>
                <div class="pop_userList group_pop">
                 <!--<input type="checkbox" id="comferenceAllCheck" name="comferenceAllCheck" onclick="fn_conAllCheck();">전체 선택-->
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
			                      <option value="deptname">부서명</option>
			                     <option value="empname" selected>사용자명</option>
			        </select>
		        </div>
                <div class="search_form">
                   <fieldset>
                       <input type="text" id="searchKeyword" placeholder="임직원을 입력하세요">
                   </fieldset>
                </div>
                 <div class="group_btn">
                    <a href="#" onClick="fn_userSearch()" class="btn_search">검색</a>
                </div>
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
    <!--popup-->
    <script src="/js/needpopup.min.js"></script> 
    <script> 
        function fn_search(){
        	if (yesterDayConfirm($("#searchResStartday").val() , "지난 일자는 검색 하실수 없습니다" ) == false ) return;
        	/*
        	if ($("#searchCenterId").val() == ""){
        		$("#searchCenterId option:eq(1)").prop("selected", true);
        	}
        	*/
        	var params = {'searchCenterId' : $("#searchCenterId").val(), 
        			      'searchRoomType' :  $("#searchRoomType").val(), 
        			      'searchResStartday' : $("#searchResStartday").val(), 
        			      'searchSeatView': 'Y' 
            }; 
        	var url = "/front/resInfo/selectTimeInfo.do";
        	uniAjax(url, params, 
		     			function(result) {
						       if (result.status == "LOGIN FAIL"){
						    	   alert(result.meesage);
		  						   location.href="/backoffice/login.do";
		  					   }else if (result.status == "SUCCESS"){
		  						    var setHtml = "";
	  								$("#tb_seatTimeInfo > tbody").empty(); 
	  								for (var i in result.seatInfo){
	  									//alert(i);
	  									var seatinfo = result.seatInfo[i];
	  									setHtml += "<tr id='swcSeq_"+seatinfo.meeting_id +"' style='height:50px;'>";
	  									setHtml += "<td style='padding-left: 20px;' title='"+seatinfo.meetingroom_remark+"'  >"+seatinfo.meeting_name+"</td>";
	  									//alert(seatinfo.timeInfo);
	  									console.log(seatinfo.meeting_equpgubun);
	  									
	  									if (seatinfo.timeinfo.length < 21){
	  										setHtml += "<td colspan='22' style='text-aling:center;'>예약 불가</td>";
	  									}else {
	  										for (var a  in seatinfo.timeinfo){
		  										var timeInfo = seatinfo.timeinfo[a];
		  										var classInfo = "";
		  										//색갈 넣기 및 예약자 클릭 관련 내용 넣기 \
		  										if (timeInfo.res_seq == "-1" && timeInfo.apprival == "N" ){
		  											setHtml += "<td id='"+timeInfo.time_seq+"' class='none'></td>";
		  										}else if (timeInfo.res_seq != "0" && (timeInfo.apprival == "R")){
		  											setHtml += "<td id='"+timeInfo.time_seq+"' class='reative' onclick='fn_resView(&#39;"+timeInfo.res_seq +"&#39;)'></td>";
		  										}else if (timeInfo.res_seq != "0" && (timeInfo.apprival == "Y" )){
		  											setHtml += "<td id='"+timeInfo.time_seq+"' class='active' onclick='fn_resView(&#39;"+timeInfo.res_seq +"&#39;)'></td>";
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
        $( "#searchResStartday" ).datepicker({ dateFormat: 'yymmdd' });
        fn_search();
        
      } );
	  $( function() {
        $(".needpopup_remover").hide();
      });
    </script>

</body>
</html>