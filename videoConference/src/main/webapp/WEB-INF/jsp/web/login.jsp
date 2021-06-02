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
    <form name="regist" method="post" action="/web/LoginProcess.do" autocomplete="off">
    
    <div class="login">
            <div class="log_b">
                <h1><img src="/front_res/img/logo.png"></h1>
                <p>LOGIN</p>
                <span>SIGN IN TO CONTINUE</span>
                <!--//input 박스-->
                <div class="login_reser_b">
                    <div class="login_reser_box">
                        <p class="reser_b_tit">아이디</p>                
                        <input type="text" name="user_id" id="user_id" placeholder="아이디를 입력하세요." value="002786">
                    </div>
                    <div class="login_reser_box">
                        <p class="reser_b_tit">비밀번호</p>                
                        <input type="password" name="user_password" id="user_password" placeholder="비밀번호를 입력하세요."  value="qwe123!@#">
                    </div>
                </div>
                <!--input 박스//-->
                <div class="log_footer">
                    <a href="javascript:login()" class="log_f_btn" >로그인</a>
                    <hr/>
                    <a href="/web/Join.do" class="join">회원가입</a>
                    <span>* 회원가입을 한 회원만 사용이 가능합니다</span>
                </div>
            </div>
        </div>

        <!--//아이디/패스워드 틀릴 때 팝업-->
        <div id='error_popup' class="needpopup">
            <p>
              <span id="sp_error"></span>
            </p>
        </div>
        <!--아이디/패스워드 틀릴 때 팝업//-->
  </form>
<!--needpopup script-->
<button id="btn_message" style="display:none" data-needpopup-show='#error_popup'>확인1</button>
<script src="/front_res/js/jquery-1.11.0.min.js"></script>
<script src="/front_res/js/needpopup.min.js"></script>
<script>  
    function login(){
    	if (any_empt_line_id("user_id", "아이디를 입력해주세요.") == false) return;	
    	if (any_empt_line_id("user_password", "패스워드를 입력해주세요.") == false) return;	
    	var params = {"userId": $("#user_id").val(), "userPassword": $("#user_password").val()};
    	var url = "/web/LoginProcess.do";
    	uniAjax(url, params, 
	     			function(result) {
					       if (result.status == "SUCCESS"){
					    	    location.href="/web/index.do";
	  					   }else {
	  						  $("#sp_error").html(result.message);
	  						  $("#btn_message").trigger("click");
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
</body>
</html>