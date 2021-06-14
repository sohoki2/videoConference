<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="ok_reserve" class="needpopup opened">
        <ul class="form">
          <li>
            <span id="sp_message"></span>
          </li>
        </ul>
        <div class="clear"></div>
        <div class="footerBtn">
          <a href="#" onClick="fn_hisInfo()" class="grayBtn">확인</a>
        </div>
        <div class="clear"></div>  
</div>
<input type="hidden" id="page_result" name="page_result" /> 
<!--  애러 발생시 이전 스크립트로 전환 -->
<input type="hidden" id="hid_history" name="hid_history" /> 
<div id="dv_meetingInfo" class="needpopup">
      <h2 class="pop_tit">회의 상세정보</h2>
        <ul class="form">
          <li>
            <p class="pop_text"><span id="sp_roomNm"></span>회의실A-01</p>
          </li>
          <li>
            <span id="sp_resDay">2021년05월10일</span>
            <span id="sp_resStartTime">08:00</span> ~ <span id="sp_resEndTime">18:00</span>
          </li>
          <li><span id="sp_roomTitle">회의제목입니다</span></li>
        </ul>
        <div class="clear"></div>
        <div class="footerBtn">
          <a href="#" onClick="need_close();" class="blueBtn">확인</a>
          <a href="#" onClick="need_close();" class="grayBtn">닫기</a>
        </div>
        <div class="clear"></div>
</div>

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
        <input type="hidden" id="mode" name="mode" />
        <input type="hidden" id="itemId" name="itemId" />
        <input type="radio" name="resPassword" value="Y" id="resPassword_1"><span id="sp_01">공개</span>
        <input type="radio" name="resPassword" value="N" id="resPassword_2"><span id="sp_02">비공개</span>
        <input type="hidden" id="conPin" name="conPin"/>
        <input type="hidden" id="conVirtualPin" name="conVirtualPin"/>
        <input type="hidden" id="conAllowstream" name="conAllowstream"/>
        <input type="hidden" id="conBlackdial" name="conBlackdial"/>
        <input type="hidden" id="conSendnoti" name="conSendnoti"/>
        <input type="hidden" id="resEqupcheck" name="resEqupcheck"/>
        <input type="hidden" id="proxyUserId" name="proxyUserId"/>
        <input type="hidden" name="proxyYn" id="proxyYn">
        <input type="hidden" name="seatConfirmgubun" id="seatConfirmgubun">
        <input type="hidden" name="hid_attendList" id="hid_attendList">
        <input type="hidden" id="hid_equipList" name="hid_equipList">
        <input type="hidden" id="resStartday" name="resStartday" />
        <a href="#" onclick="fn_userPop('P')">참가대상</a>
        <input type="hidden" name="resReqday" id="resReqday" />
        
        
        <span id="meegintRoomInfo"></span>
         
      </li>
      <li>
        <p class="pop_text">회의 시간 선택</p>
        <!--  기본값 -->
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
      <button type="button" onClick="need_close();" class="grayBtn">취소</button>
    </div>
    <div class="clear"></div>
</div>        
 <!--//예약신청 팝업 끝-->
  
  
     
<button type="button" id="btn_result" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
<button type="button" id="btn_resultCk" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
<button type="button" id="btn_meetingInfo" style="display:none" data-needpopup-show='#dv_meetingInfo'>경고창 보여 주기</button>
<button type="button" id="btn_meeting" style="display:none" data-needpopup-show='#app_meeting'>예약 화면 보여주기</button>
<button type="button" id="btn_SeatRes" style="display:none" data-needpopup-show='#seat_fastR_popup'>좌석예약 보여주기</button>



<script src="/front_res/js/com_resInfo.js"></script>
<script src="/front_res/js/needpopup.min.js"></script>
<script type="text/javascript">
	$( function() {
		 var state = "${status}";
	   	 if (state == "FAILLACK"){
	   		 alert("적용되는 시설물이 없습니다");
	   		 location.href= "/web/index.do";
	   	 }
		
		
	});
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