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
          <a href="#" onClick="fn_hisInfo()" class="grayBtn" style="width:100%">확인</a>
        </div>
        <div class="clear"></div>  
</div>
<input type="hidden" id="page_result" name="page_result" /> 
<!--  애러 발생시 이전 스크립트로 전환 -->
<input type="hidden" id="hid_history" name="hid_history" /> 
<div id="dv_meetingInfo" class="needpopup">
      <h2 class="pop_tit"><span id="sp_meetingTitle">회의 상세정보</span></h2>
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


 <!--//회의자원 팝업-->
 <div id='meet_detail' class="needpopup">
     <h5 class="pop_tit">예약신청</h5>
     <ul class="form">
       <li>
         <!-- Swiper -->
         <div class="swiper-container">
           <div class="swiper-wrapper">
             <div class="swiper-slide"><img id="img_left01" name="img_left01"/></div>
             <div class="swiper-slide"><img id="img_left02" name="img_left02"/></div>
             <div class="swiper-slide"><img id="img_left03" name="img_left03"/></div>
           </div>
           <!-- Add Pagination -->
           <div class="swiper-pagination"></div>
           <!-- Add Arrows -->
           <div class="swiper-button-next swiper-button-white"></div>
           <div class="swiper-button-prev swiper-button-white"></div>
         </div>
         <table class="table_pop">
           <tbody>
             <tr>
               <th>회의실명</th>
               <td><span id="sp_roomTitle"></span></td>
             </tr>
              <tr>
               <th>회의실 자원</th>
               <td><span id="sp_remark"></span></td>
             </tr>
              <tr>
               <th>최대사용인원</th>
               <td><span id="sp_personCnt"></span>명</td>
             </tr>
           </tbody>
         </table>
       </li>
     </ul>
 </div>
 <!--회의자원 팝업//-->
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
        <input type="hidden" name="floorSeq" id="floorSeq" value="${regist.floorSeq}">
		<input type="hidden" name="searchCenterId" id="searchCenterId" value="${regist.searchCenterId}">
		<input type="hidden" id="itemGubun" name="itemGubun" value="${regist.itemGubun}" />
		<input type="hidden" id="searchRoomType" name="searchRoomType" value="${regist.searchRoomType}"/>
		
        <input type="hidden" id="mode" name="mode" />
        <input type="hidden" id="roomType" name="roomType"/>
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
      <button type="button" class="blueBtn" onclick="fn_ResSave();">예약</button>
      <button type="button" onClick="need_close();" class="grayBtn">취소</button>
    </div>
    <div class="clear"></div>
</div>        
 <!--//예약신청 팝업 끝-->
  
  
 <!--//탈퇴 팝업-->
 <div id="secession" class="needpopup">
     <h5 class="pop_tit">회원탈퇴</h5>
     <ul class="form">
       <li>
         <p>
                             회원 탈퇴 즉시 개인정보는 삭제 되며 기존 예약 결과 조회등이 불가능합니다
         </p>
       </li>
     </ul>
     <div class="footerBtn">
       <button type="button" onClick="fn_secession()" class="blueBtn" onClick="fn_secession()">확인</button>
       <button type="button" onClick="need_close()" class="grayBtn">취소</button>
     </div>
     <div class="clear"></div>
 </div>
 <!--//탈퇴 팝업-->

<!--  예약 취소 팝업 -->
 <div id="cancle_popup" class="needpopup main_pop opened">
     <div class="box_padding">
         <h2 class="pop_tit">예약취소</h2>  
         <div class="form">
             <div class="pop_con">
                 <div class="box_2">
                     <textarea id="cancelReason" style="width:95%;"></textarea>
                 </div>                    
             </div>   
         </div>
         <div class="footerBtn">
             <a href="#" onClick="fn_resCancelUpdate()" class="blueBtn" >예약취소</a>
             <a href="#" onClick="need_close()" class="grayBtn">취소</a>
         </div>
         <div class="clear"></div>
     </div>            
     <a href="#" class="needpopup_remover"></a>
</div>
<!--  예약 취소 팝업  끝 부분-->                        
<button type="button" id="btn_result" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
<button type="button" id="btn_resultCk" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
<button type="button" id="btn_meetingInfo" style="display:none" data-needpopup-show='#dv_meetingInfo'>경고창 보여 주기</button>
<button type="button" id="btn_meeting" style="display:none" data-needpopup-show='#app_meeting'>예약 화면 보여주기</button>
<button type="button" id="btn_SeatRes" style="display:none" data-needpopup-show='#seat_fastR_popup'>좌석예약 보여주기</button>
<button type="button" id="btn_meetingShow" style="display:none" data-needpopup-show='#meet_detail'>회의실 상세 보여주기</button>

<script src="/front_res/js/swiper.min.js"></script>
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