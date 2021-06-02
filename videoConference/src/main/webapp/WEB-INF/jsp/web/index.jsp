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
    <script src="/front_res/js/jquery-ui.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
</head>
<body>
 <div class="main_back">
            <!--//header 추가-->
            <c:import url="/web/inc/top_inc.do" />
            <!--header 추가//-->
            <!--// left menu -->
            <c:import url="/web/inc/right_menu.do" />
            <!--left menu //-->
            <!--//contents-->
            <div class="contents">
                <div class="main_titB">
                    <p>사람을 잇는 관광</p>
                    <p class="main_tit">서울관광플라자 스마트회의 예약 시스템</p>
                </div> 
                 <!--slider -->
                <div class="slider_box">
                    <!-- Add Arrows -->
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <!-- meeting -->
                            <!-- //진행중인 회의가 3개 미만일 경우-->
                            <div class="swiper-slide">
                                <div class="slider_box">
                                    <p class="slide_tit">LOUNGE A</p>
                                    <p class="meeting_noti">지금 바로 회의를 시작 해보세요</p>                                    
                                </div>
                                <div class="meeting_btn">
                                    <div class="padding_box">
                                        <a href="" class="booking_btn" data-needpopup-show="#reserve_popup">예약하기</a>    
                                    </div>                                    
                                </div>
                            </div>
                            <!-- //진행중인 회의가 3개 미만일 경우-->
                            <!--// meeting -->
                            <!-- meeting -->
                            <div class="swiper-slide">
                                <div class="slider_box">
                                    <p class="slide_tit meeting_ing">LOUNGE B</p>
                                    <a href="" class="view_pop">
                                      <span>회의제목입니다</span>
                                      <br/>
                                      서울관광플라자 소속
                                      <br/>
                                      홍길동
                                    </a>                                    
                                </div>
                                <div class="meeting_btn">
                                    <div class="padding_box">
                                        <a class="start_btn popup_view" data-needpopup-show="#start">참여하기</a>
                                        <a href="" class="booking_btn" data-needpopup-show="#reserve">세부확인</a>    
                                    </div>                                    
                                </div>
                            </div>
                            <!--// meeting -->
                            <!-- meeting -->
                            <div class="swiper-slide">
                                <div class="slider_box">
                                    <p class="slide_tit meeting_ing">LOUNGE C</p>
                                    <a href="" class="view_pop">
                                      <span>회의제목입니다</span>
                                      <br/>
                                      서울관광플라자 소속
                                      <br/>
                                      홍길동
                                    </a>                                          
                                </div>
                                <div class="meeting_btn">
                                    <div class="padding_box">
                                        <a class="start_btn popup_view" data-needpopup-show="#start">참여하기</a>
                                        <a href="" class="booking_btn" data-needpopup-show="#reserve">세부확인</a>    
                                    </div>                                    
                                </div>
                            </div>
                            <!--// meeting -->                            
                            <!-- meeting -->
                            <div class="swiper-slide">
                                <div class="slider_box">
                                    <p class="slide_tit meeting_ing">LOUNGE D</p>
                                    <p class="meeting_noti">화상회의 진행중 입니다</p>
                                    <a href="" class="view_pop">참여정보(8/10) 자세히보기</a>                                    
                                </div>
                                <div class="meeting_btn">
                                    <div class="padding_box">
                                        <a href="" class="start_btn">참여하기</a>
                                        <a href="" class="booking_btn">예약하기</a>    
                                    </div>                                    
                                </div>
                            </div>
                            <!--// meeting -->
                        </div>                 
                    </div>
                </div>                    
                <!-- // slider -->
            </div>
            <!--contents//-->
            <!--  공지 사항 시작 -->
            <div class="main-noti">
                    <div class="main-noti-con contents">
                        <h3 class="font18"><a href="javascript:">공지사항</a></h3>
                        <a href="javascript:">
                            <span class="noti_tit">스마트회의 예약 시스템 사용방법 안내 </span>
                            <span>2019.11.25</span>
                        </a>
                    </div>
                </div>
           
           </div>
            <!--  공지 사항 끝 -->
        <!-- 참여하기인증 팝업 -->
    <div id='start' class="needpopup main_pop">
        <div class="box_padding">
            <h2 class="pop_tit">시스템기획팀회의</h2>  
            <div class="form">
                <div class="pop_con">
                    <div class="box_2">
                        <input type="text" name="" placeholder="비밀번호를 입력하세요.">
                    </div>                    
                </div>   
            </div>
            <div class="footerBtn">
                <button class="blueBtn">참여하기</button>
                <button class="grayBtn">취소</button>
            </div>
            <div class="clear"></div>
        </div>            
    </div>

<!--//예약신청 팝업-->
        <div id="reserve_popup" class="needpopup">
            <h5 class="pop_tit">예약신청</h5>
            <ul class="form">
              <li>
                <p class="pop_text">회의실 선택</p>
                <select>
                  <option>회의실A-01 [3크레딧]</option>
                  <option>회의실A-02 [5크레딧]</option>
                  <option>회의실A-03 [8크레딧]</option>
                  <option>회의실A-04 [7크레딧]</option>
                  <option>회의실A-05 [10크레딧]</option>
                </select>
              </li>
              <li>
                <p class="pop_text">회의 시간 선택</p>
                <span>2021년05월10일</span>
                <select class="startTime">
                  <option>08:00</option>
                  <option>08:30</option>
                  <option>09:00</option>
                  <option>09:30</option>
                  <option>10:00</option>
                  <option>10:30</option>
                  <option>11:00</option>
                  <option>11:30</option>
                  <option>12:00</option>
                  <option>12:30</option>
                  <option>13:00</option>
                  <option>13:30</option>
                  <option>14:00</option>
                  <option>14:30</option>
                  <option>15:00</option>
                  <option>15:30</option>
                  <option>16:00</option>
                  <option>16:30</option>
                  <option>17:00</option>
                  <option>17:30</option>
                  <option>18:00</option>
                </select>
                ~
                <select class="endTime">
                  <option>08:00</option>
                  <option>08:30</option>
                  <option>09:00</option>
                  <option>09:30</option>
                  <option>10:00</option>
                  <option>10:30</option>
                  <option>11:00</option>
                  <option>11:30</option>
                  <option>12:00</option>
                  <option>12:30</option>
                  <option>13:00</option>
                  <option>13:30</option>
                  <option>14:00</option>
                  <option>14:30</option>
                  <option>15:00</option>
                  <option>15:30</option>
                  <option>16:00</option>
                  <option>16:30</option>
                  <option>17:00</option>
                  <option>17:30</option>
                  <option>18:00</option>
                </select>
              </li>
              <li><input type="text" placeholder="제목" name=""></li>
              <li><input type="checkbox"> 카카오톡 알림 발송</li>
            </ul>
            <div class="clear"></div>
            <div class="footerBtn">
              <button class="blueBtn" data-needpopup-show="#ok_reserve">최종예약</button>
              <button class="grayBtn">취소</button>
            </div>
            <div class="clear"></div>
        </div>
        <!--예약 팝업-//->    

        <!--//세부확인 팝업-->
        <div id="reserve" class="needpopup">
          <h2 class="pop_tit">회의 상세정보</h2>
            <ul class="form">
              <li>
                <p class="pop_text">회의실A-01</p>
              </li>
              <li>
                <span>2021년05월10일</span>
                <span>08:00</span> ~ <span>18:00</span>
              </li>
              <li>회의제목입니다</li>
            </ul>
            <div class="clear"></div>
            <div class="footerBtn">
              <button class="blueBtn">확인</button>
              <button class="grayBtn">닫기</button>
            </div>
            <div class="clear"></div>
        </div>
        <!--세부확인 팝업//-->    

        <!--//예약하기 최종예약-->
        <div id="ok_reserve" class="needpopup opened" style="display: block;">
            <p>
                예약이 완료 되었습니다
            </p>
         </div>
      <!--//예약하기 최종예약-->

        <!--//로그아웃 팝업-->
        <div id="logout_pop" class="needpopup">
          <p>
              로그아웃이 완료 되었습니다
           </p>
        </div>
        <!--로그아웃 팝업-//->   

        <!--//퇴실 팝업-->
        <div id="exit_pop" class="needpopup">
          <p>
              퇴실이 완료 되었습니다
           </p>
        </div>
        <!--퇴실 팝업-//->   


         <!-- Swiper JS -->
         <script src="/front_res/js/swiper.js"></script>
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
              breakpoints : { // 반응형 설정이 가능 width값으로 조정
                  1034 : {
                    slidesPerView : 1,
                    slidesPerGroup: 1,
                  },
                },
            });
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
</body>
</html>