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

    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    <link rel="stylesheet" href="/css/jquery-ui.css">
    
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    
    
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/main/needpopup.min.css">



    
</head>
<body>


<div id="wrapper" class=" main_back">
        <c:import url="/front/inc/fnt_top_inc.do" />
        <div id="container">
            <div class="contents">
                <div class="main_titB">
                    <p>장소 제약 없이 어디서나 가능한 스마트한 회의 예약 시스템</p>
                    <p class="main_tit">케이뱅크 스마트회의 예약시스템</p>
                </div>    
                
                <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/Index.do">
                	  
                <input type="hidden" id="searchResStartday" name="searchResStartday" />  
                <input type="hidden" id="resStartday" name="resStartday" />
                <input type="hidden" id="swcSeq" name="swcSeq">
                <input type="hidden" id="searchCenterId" name="searchCenterId">
                <input type="hidden" id="meetingSeq" name="meetingSeq">
                <input type="hidden" id="userMode" name="userMode">
                <input type="hidden" id="mode" name="mode" />
                <input type="hidden" id="hid_attendList" name="hid_attendList">
                <input type="hidden" name="boardSeq" id="boardSeq" />
                <input type="hidden" id="hid_equipList" name="hid_equipList"> 
                
                <!--slider -->
                <div class="slider_box main_slide">
                    <!-- Add Arrows -->
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <!-- meeting -->
                            <c:forEach items="${resultlist }" var="resInfo" varStatus="status">
                                <c:choose>
                                   <c:when test="${resInfo.res_seq eq '0'}">
                                      <div class="swiper-slide">
                                            <div class="slider_box">
			                                    <p class="slide_tit meeting_loading">${resInfo.seat_name }</p>
			                                    <p class="meeting_noti">지금 바로 회의를 시작 해보세요</p>                                   
			                                </div>
			                                <div class="meeting_btn">
			                                    <div class="padding_box">
			                                        <a href="#" data-needpopup-show='#app_meeting' onclick="fn_indexInfo('${resInfo.meeting_id}','${resInfo.time_seq }','${resInfo.swcTime}','${resInfo.seat_name}','0','${resInfo.center_id}', '${resInfo.meeting_confirmgubun}' , '${resInfo.meeting_equpgubun}');" class="booking_btn">예약하기</a>    
			                                    </div>                                    
			                                </div>
			                            </div>
                                   </c:when>
                                   <c:otherwise>
                                        <div class="swiper-slide">
			                                <div class="slider_box">
			                                    <p class="slide_tit meeting_ing">${resInfo.seat_name }</p>
			                                    <p class="meeting_noti">회의 진행중 입니다</p>
			                                    ${resInfo.attendlisttxt }                                    
			                                </div>
			                                <div class="meeting_btn">
			                                    <div class="padding_box">
			                                        <a href="#" onclick="fn_resView('${resInfo.res_seq}')" class="bookinginfo_btn">자세히보기</a>  
			                                    </div>                                    
			                                </div>
			                            </div>
                                   </c:otherwise>
                                </c:choose>
                              
                            </c:forEach>
                            
                            <!--// meeting -->
                        </div>                 
                    </div>
                </div>                    
                <!-- // slider -->
            </div>
        </div>
        
        <div class="main-noti">
            <div class="main-noti-con contents">
                <h3><a href="javascript:fn_noticeList();">공지사항</a></h3>
                <marquee direction="left"  scrolldelay="50" width="650px;" >
                <c:forEach items="${boardList }" var="boardList" varStatus="status">
                
                <a href="javascript:fn_noticeView('NOT','${boardList.boardSeq }')">
                 
                    <h3>${boardList.boardTitle } </h3>
                    <h3>${boardList.boardRegdate }</h3>
                </a>
                
                </c:forEach>
                </marquee>
				
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
                       <span id="sp_ResDay" style="margin-right: 30px;"></span>
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
                    <div class="box_2 popup_view"  data-needpopup-show="#view_meeting" style="width:50%;">
                        <a href="#" onclick="fn_userPop('P')">참가대상</a>
                    </div>
                </div>
                <div class="pop_con" id="div_meetingRoomInfo" style="display:none;">
                    <div class="box_2">
                        <span id="meegintRoomInfo"></span>
                    </div>
                </div>
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
                <!--  추가 부분 끝 -->
                <div class="pop_con" id="div_attendList">
                   <div class="box_3">
                      <span id="sp_meetingAttendList" style="border-style: none;"></span>
                   </div>
                </div>
                <div class="pop_con">
                    <div class="box_2">
                        <label>비공개 체크 시 비공개 회의로 전환 합니다.</label>
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
                    <div class="box_2">
                        <span id="sp_useYn"></span>
                    </div>
                    <div class="box_2 popup_view" >
                        <span id="sp_resPorcess"></span>
                    </div>
                </div>
                <div class="pop_con">
                   <div class="box_2">
                      <span id="sp_ResMeetingAttendList" style="border-style: none;"></span>
                   </div>
                </div>
                   
            </div>
            <div class="pop_footer">
                <a href="#" onclick="need_close();"  class="pop_btn">닫기</a>
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
                <div>
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
                    <a href="#" onClick="fn_userSearch()" class="btn_search">SEARCH</a>
                </div>
                <div class="clearfix"></div>
                <div class="pop_userList group_pop">
                 <!--<input type="checkbox" id="comferenceAllCheck" name="comferenceAllCheck" onclick="fn_conAllCheck();">전체 선택-->
                </div>
                <div class="pop_userList group_pop">
                    <div class="border_line">
                        <span id="sp_popUsrLst"></span>
                       
                        
                    </div>
                </div>  
                <div class="pop_con">
                   <div class="box_2">
                      <font color='red'>※ 중복 선택 가능 합니다</font>
                   </div>
                </div> 
                <div class="pop_userList group_pop" id="div_attend" style="height:40px;">
                    <div class="border_line">
                        <span id="sp_popAttendLst"></span>
                       
                    </div>
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
  
      
   
  
  
  <!-- 참여하기인증 팝업 //-->
  <!-- Swiper JS -->
  <script src="/js/swiper.js"></script>
  <script type="text/javascript" src="/js/com_resInfo.js"></script>
  <script type="text/javascript" src="/js/common_res.js"></script>
  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper('.swiper-container', {
      slidesPerView: 3,
      spaceBetween: 30,
      slidesPerGroup: 3,
      loop: true,
      loopFillGroupWithBlank: true,
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  </script>
  
    <!--popup-->
    <script src="/js/needpopup.min.js"></script> 
    <script>  
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
    <script>
      $( function() {
        $( "#datepicker" ).datepicker();
		$(".needpopup_remover").attr("display","none");
      });
      
      function fn_noticeView(boardGubun, boardSeq){
    	  $("#boardSeq").val(boardSeq);
		  $("form[name=regist]").attr("action", "/front/resInfo/resNoticeView.do").submit(); 
      }
      function fn_noticeList(){
    	  location.href="/front/resInfo/resNoticeList.do";
      }
    </script> 
</form:form>
</body>
</html>