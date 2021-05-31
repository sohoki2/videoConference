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
    <title><spring:message code="URL.TITLE" /></title>
    <!--css-->
    <link href="/front_res/css/reset.css" rel="stylesheet" />
    <link href="/front_res/css/swiper.css" rel="stylesheet">
    <link href="/front_res/css/jquery-ui.css" rel="stylesheet" />
    <link href="/front_res/css/needpopup.min.css" rel="stylesheet" type="text/css" >
    <link href="/front_rescss/style.css" rel="stylesheet" />
    <link href="/front_rescss/paragraph.css" rel="stylesheet" />
    <link href="/front_rescss/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/front_rescss/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
     
    <!--js-->
    <script src="/front_res/js/jquery-ui.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
</head>
<body>
    <div class="contents joinCon">
            <div class="joinArea">
                <h1><img src="/front_res/img/logo.png"/></h1>
                <div class="joinform">
                    <div>
                        <input type="checkbox" name="">
                        <p>개인정보 수집 및 이용동의 <span class="blueFont">(필수)</span></p>
                    </div>
                    <div class="scroll">
                        1. 수집·이용목적 : 서울관광플라자 출입 및 시설과 장비에 대한 예약을 위한 사용자 정보 수집 및 이용<br/>
                        2. 개인정보 수집 항목 : 이름, 소속, 휴대폰 번호(예약결과 안내 및 예약 조회시 시용)<br/>
                        3. 개인정보 보유 및 이용기간 : 시설 이용 후 1년간 정보 보관<br/>
                        4. 동의 거부 시 불이익에 관한 사항 : 수집·이용에 관한 사항의 동의를 거부할 때에는 예약 서비스의 이용이 제한됩니다.
                </div>
                <table>
                    <tbody>
                        <tr>
                            <th>* 아이디</th>
                            <td><input type="text" name=""></td>
                        </tr>
                        <tr>
                            <th>* 비밀번호</th>
                            <td><input type="text" name=""></td>
                        </tr>
                        <tr>
                            <th>* 비밀번호 재확인</th>
                            <td><input type="text" name=""></td>
                        </tr>
                        <tr>
                            <th>* 이름</th>
                            <td><input type="text" name=""></td>
                        </tr>
                        <tr>
                            <th>* 이메일</th>
                            <td><input type="text" name=""></td>
                        </tr>
                        <tr>
                            <th>* 휴대전화</th>
                            <td>
                                <select>
                                    <option>대한민국 +82</option>
                                    <option>대한민국 +82</option>
                                    <option>대한민국 +82</option>
                                    <option>대한민국 +82</option>
                                    <option>대한민국 +82</option>
                                </select>
                                <section>
                                    <input type="text" name="" placeholder="전화번호 입력">
                                    <button>인증번호 받기</button>
                                </section>
                                <input type="text" name="" placeholder="인증번호를 입력하세요.">
                                <!--인증번호 받기 버튼 클릭 시 추가 되는 텍스트-->
                                <p class="noti">인증번호가 발송되었습니다</p>
                                <button class="darkBtn joinBtn" data-needpopup-show="#agreeN_popup">가입하기</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!--//개인정보 수집 체크 안했을 때 팝업-->
        <div id='agreeN_popup' class="needpopup">
            <p>
                개인정보 수집 및 이용 동의는 필수입니다
            </p>
        </div>
        <!--개인정보 수집 체크 안했을 때 팝업//-->

        <!--// 필수 입력 정보를 입력 안했을 때 팝업-->
        <div id='checkN_popup' class="needpopup">
            <p>
                필수 입력 정보를 입력하세요
            </p>
        </div>
        <!-- 필수 입력 정보를 입력 안했을 때 팝업//-->

        <!--//회원가입 완료 팝업-->
        <div id='join_popup' class="needpopup">
            <p>
                서울관광플라자에 오신걸 환영합니다<br/>
                회원가입을 완료 하였습니다
            </p>
        </div>
        <!--회원가입 완료 팝업//-->

<!--needpopup script-->
<script src="/front_res/js/jquery-1.11.0.min.js"></script>
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