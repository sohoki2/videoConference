<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.sohoki.backoffice.cus.org.vo.EmpInfoVO" %>
<%
   EmpInfoVO loginVO = (EmpInfoVO) session.getAttribute("empInfoVO");
   if(loginVO != null ){
%> 

<div class="back" id="mySidenav">
     <div class="sidenav" id="mySidenav1">
         <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
         <div class="userBox" id="userBox">
             <div class="float_left">
                 <img src="/front_res/img/userImg.png">
                 <p class="user_name"><%=loginVO.getEmpname() %> 님</p>
                 <a href="/web/myPage.do" class="join mypage">마이페이지</a>
                 <p class="logout"><a href="/web/Logout.do" class="user_logout" >로그아웃</a></p>
             </div>
             <!--  좌석 일반 사무실 유저만 보여주기 -->
             <div class="float_left userInfo">
                 <p class="seat_name">
                     <p>나의 예약 현황</p>
                     <div>
                         <div>
                             <span>16F <span>23</span></span>
                         </div>
                     </div>
                 </p>
             </div>
             <div class="clear"></div>
             <div class="state">
                 <ul>
                     <li><a href="/front/webFloor.do" id="check_in" class="active">입실</a></li>
                     <li><a href="" data-needpopup-show="#exit_pop" id="check_out" class="">퇴실</a></li>
                 </ul>
                 <div class="clear"></div>
             </div>
             <!--  좌석 일반 사무실 유저만 보여주기 -->
         </div>

        <div class="gnb user_reser_b">
             <div class="reser_box reser_box_txt"><span>바로가기 메뉴</span></div>
             <div onclick="" class="reser_box"><a class="reser_iconGo" href="/web/seatInfo.do">자율좌석예약</a></div>
             <div onclick="" class="reser_box"><a class="reser_iconGo" href="/web/meetingDay.do">회의실예약현황</a></div>
             <div onclick="" class="reser_box"><a class="reser_iconGo" href="/web/coronation.do">시설대관</a></div>
             <div onclick="" class="reser_box"><a class="reser_iconGo" href="/web/mybooking.do">나의예약</a></div>
             <div onclick="" class="reser_box"><a class="reser_iconGo" href="/web/notice.do">공지사항</a></div>
             <div class="clear"></div>
         </div>
     </div>
     <div class="backShadow"></div>
 </div>

 <%
   }
 %> 
 