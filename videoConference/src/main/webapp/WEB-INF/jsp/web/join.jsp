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
<form name="regist" method="post" action="/web/joinProcess.do" autocomplete="off">
    <input type="hidden" id="uniCheck" />
	<input type="hidden" name="DI" id="DI" />
	<input type="hidden" name="CI" id="CI" />
	<input type="hidden" name="TID" id="TID" />
	<input type="hidden" id="cert" name="cert" />
        <div class="contents joinCon">
            <div class="joinArea">
                <h1><img src="/front_res/img/logo.png"/></h1>
                <div class="joinform">
                    <div>
                        <input type="checkbox" id="agreeCheck" name="agreeCheck">
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
                            <td>
                                <section>
	                                <input type="text" id="userId" name="userId">
	                                <a href="#" onClick="join.fn_idCheck()">중복체크</a>
                                </section>
                            </td>
                        </tr>
                        <tr>
                            <th>* 비밀번호</th>
                            <td><input type="password" name="userPassword1" id="userPassword1"></td>
                        </tr>
                        <tr>
                            <th>* 비밀번호 재확인</th>
                            <td><input type="password" name="userPassword2" id="userPassword2"></td>
                        </tr>
                        <tr>
                            <th>* 이름</th>
                            <td><input type="text" name="userName" id="userName"></td>
                        </tr>
                        <tr>
                            <th>* 휴대전화</th>
                            <td>
						        <section>
                                     <input type="text" name="userCellphone" id="userCellphone" placeholder="예약결과 안내등을 위한 정확한 번호를 입력해 주세요."  id="userCellphone">
                                     <a href="javascript:fn_uas()">인증번호 받기</a>
                                </section>
						    </td>
                        </tr>
                        <tr>
                            <th>* 이메일</th>
                            <td>
                            <input type="text" name="userEmail" id="userEmail">
                            <a href="#" class="darkBtn joinBtn" onClick="join.fn_join()">가입하기</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!--//회원가입 완료 팝업-->
        <div id='join_popup' class="needpopup">
            <p>
                서울관광플라자에 오신걸 환영합니다<br/>
                회원가입을 완료 하였습니다
            </p>
        </div>
</form>

<!--needpopup script-->

<c:import url="/web/inc/unimessage.do" />

<script>  
    function fn_uas(){
    	
    	 var options = 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
    	 window.open("/web/Ready.do", "실명인증", options);
    }
    var join = {
    	fn_idCheck : function(){
    		
    		if (any_empt_line_span("userId", "아이디을 입력해 주세요.") == false) return;	
    		var params = {"userId" : $("#userId").val()};
    		fn_uniCheck("/web/userUniCheck.do", params, "uniCheck");
    	},fn_join : function(){
			

    		if (fn_Check("agreeCheck", "개인정보 수집 및 이용 동의는 필수입니다.") == false) return;
    		if (any_empt_line_span("userId", "아이디을 입력해 주세요.") == false) return;	
			if (join.fn_UniCheckAlert("uniCheck", "중복 검사를 하지 않았습니다") == false) return;
			if (any_empt_line_span("userPassword1", "패스워드을 입력해주세요.") == false) return;	
			if (any_empt_line_span("userPassword2", "패스워드을 입력해주세요.") == false) return;

			


			if(!chkPwd( $.trim($('#userPassword1').val())) == false  )return;
			if ($.trim($('#userPassword1').val()) !=   $.trim($('#userPassword2').val())  ){
				$("#sp_message").text("비밀 번호가 일치 하지 않습니다.");
			    $("#btn_result").trigger("click");
			    return;
			}
		    if (any_empt_line_span("userName", "사용자명을 입력해주세요.") == false) return;
			if (any_empt_line_span("CI", "실명인증을 하지 않았습니다.") == false) return;
  		    if (any_empt_line_span("userCellphone", "연락처를 기입해 주세요.") == false) return;
  		    if (any_empt_line_span("userEmail", "이메일를 기입해  주세요.") == false) return;
  		    if (verifyEmail("userEmail") == false) return;
  		    
  		    var param = {"userId" : $("#userId").val(),
	     		     	 "userName" : $("#userName").val(),
	     		     	 "userPassword" : $("#userPassword1").val(),
	     		     	 "userCellphone" : $("#userCellphone").val(),
	     		     	 "ci" : $("#CI").val(),
	     		     	 "tid" : $("#TID").val(),
						 "di" : $("#DI").val(),
						 "userEmail" : $("#userEmail").val(),
	     		     	 "mode" :  "Ins"
  		                }
  			
  		    if (confirm("가입하시겠습니까?")== true){
  			   uniAjax("/web/JoinProcess.do", param, 
  		     			function(result) {
  						       if (result.status == "SUCCESS"){
  	                               //관련자 보여 주기 
  	                               $("#hid_history").val("fn_index");
  						    	   $("#sp_message").text(result.message);
  				   		           $("#btn_result").trigger("click");
  	                               
  		  					   }else {
  		  						  $("#sp_message").text(result.message);
  		  	    		          $("#btn_result").trigger("click");
  		  					   }
  						},
						function(request){
							    alert("Error:" +request.status );	       						
						}    		
  		        );
  		   }
    	} , fn_UniCheckAlert : function (_UniCheckFormNm, _btn_message){
			if ($("#"+_UniCheckFormNm).val() == "Y"){
    			return true;
    		}else {
    		    $("#sp_message").html(_btn_message);
    			$("#btn_result").trigger("click");
    			return false;
    			
    		}
    	}
    }
</script>
</body>
</html>