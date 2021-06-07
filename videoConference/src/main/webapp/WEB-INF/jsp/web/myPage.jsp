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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>서울관광플라자</title>

    <!--css-->
    <link href="/front_res/css/reset.css" rel="stylesheet" />
    <link href="/front_res/css/jquery-ui.css" rel="stylesheet" />
    <link href="/front_res/css/needpopup.min.css" rel="stylesheet" type="text/css" >
    <link href="/front_res/css/style.css" rel="stylesheet" />
    <link href="/front_res/css/paragraph.css" rel="stylesheet" />
    <link href="/front_res/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="../css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/jquery-ui.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
</head>
<body>
        <c:import url="/web/inc/top_inc.do" />
        <!--header 추가//-->
        <!--// left menu -->
        <c:import url="/web/inc/right_menu.do" />
        <!--left menu //-->
        <!--//contents-->
        <div class="contents">
            <div class="whiteBack w_half float_left">
                <h5>프로필</h5>    
                <div class="profile">
                    <div class="float_left"><img src="/front_res/img/userImg.png"></div>
                    <div class="float_left">
                        <ul>
                            <li>
                                <span class="tit">이름</span>
                                <span>홍길동</span>
                            </li>
                            <li>
                                <span class="tit">이메일</span>
                                <span>abv@atensys.co.kr</span>
                            </li>
                            <li>
                                <span class="tit">휴대전화</span>
                                <span>010-0000-0000</span>
                            </li>
                        </ul>
                    </div>
                    <div class="clear"></div>
                    <a href="myModify.do" class="darkBtn">수정</a>
                </div>
            </div>
            <div class="whiteBack w_half float_right">
                <div class="credit">
               <div class="float_left"><img src="/front_res/img/credits.png"></div>
                    <div class="float_left">
                        <h5>잔여 크레딧</h5>    
                        <div class="res">
                        <span class="blueFont">50</span>
                        / 100
                    </div>
                    </div>
                    <div class="clear"></div>
                    <p>크레딧은 월 초 자동 충전되며, 잔여 크레딧은 자동 소멸됩니다</p>
                    </div>
            </div>
            <div class="clear"></div>
            <div class="whiteBack mybooking">
                <h5>크레딧 사용 내역</h5>      
                <section>
                <table class="my_T" id="tb_tenn">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>구분</th>
                            <th>예약내용</th>
                            <th>이용날짜</th>
                            <th>이용시간</th>
                            <th>이용크레딧</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>좌석예약</td>
                            <td>16F_23번 좌석</td>
                            <td>2021-04-21</td>
                            <td>12:00~13:00</td>
                            <td>-3</td>
                        </tr>
                    </tbody>
                </table>
                </section>
                <!--//page number-->
               <ul class="page_num">
                   <li class="active">1</li>
                   <li>2</li>
                   <li>3</li>
                   <li>4</li>
                   <li>5</li>
               </ul>
               <!--page number//-->
             </div>
        </div>
        <!--contetns//-->


        <!--needpopup script-->
        
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