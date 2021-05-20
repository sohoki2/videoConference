<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>서울관광플라자</title>

    <!--css-->
    <link href="/front_res/css/reset.css" rel="stylesheet" />
    <link href="/front_res/css/jquery-ui.css" rel="stylesheet" />
    <link href="/front_res/css/style.css" rel="stylesheet" />
    <link href="/front_res/css/paragraph.css" rel="stylesheet" />
    <link href="/front_res/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/front_res/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
    
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/jquery-ui.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/needpopup.min.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
    </head>
    
    <body>
        <div class="login">
            <div class="log_b">
                <h1><img src="img/logo.png"></h1>
                <p>LOGIN</p>
                <span>SIGN IN TO CONTINUE</span>
                <!--//input 박스-->
                <div class="login_reser_b">
                    <div class="login_reser_box">
                        <p class="reser_b_tit">사원번호</p>                
                        <input type="text" name="user_id" id="user_id" placeholder="사원번호를 입력하세요.">
                    </div>
                    <div class="login_reser_box">
                        <p class="reser_b_tit">비밀번호</p>                
                        <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요.">
                    </div>
                </div>
                <!--input 박스//-->
                <div class="log_footer">
                    <a href="javascript:login()" class="log_f_btn">로그인</a>
                </div>
            </div>
        </div>
    </body>
 </html>