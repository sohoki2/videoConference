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
    <link href="/front_res/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/jquery-ui.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post" >



        <!--//header 추가-->
        <c:import url="/web/inc/top_inc.do" />
        <!--header 추가//-->
        <!--// left menu -->
        <c:import url="/web/inc/right_menu.do" />
        <!--left menu //-->

        <div class="contents joinCon">
            <div class="joinArea">
                <table id="tb_modify">
                    <tbody>
                        <tr>
                            <th>이름</th>
                            <td><input type="text" name="userName" id="userName" value="${userinfo.empname }">
                            <input type="hidden" name="userId" id="userId" value="${userinfo.empid}"/>
                            </td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td><input type="text" name="userEmail" id="userEmail" value=${userinfo.empmail }></td>
                        </tr>
                        <tr>
                            <th>휴대전화</th>
                            <td>
                                
                                <section>
                                    <input type="text" name="userCellphone" id="userCellphone" placeholder="전화번호 입력" value="${userinfo.emphandphone }">
                                    <button>인증번호 받기</button>
                                </section>
                                <input type="text" name="" placeholder="인증번호를 입력하세요.">
                                <button type="button" class="darkBtn joinBtn" id="btn_passch" onClick="fn_passChange()">비밀번호 변경</button>
                                <button type="button" class="darkBtn joinBtn" data-needpopup-show="#secession">회원탈퇴</button>
                                <button type="button" class="modiBtn" onClick="fn_modify()">수정하기</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table  id="tb_passwd" style="width:100%">
                    <tbody>
                        <tr>
                            <th>기존 비밀번호</th>
                            <td><input type="password" name="nowPassword" id="nowPassword"></td>
                        </tr>
                        <tr>
                            <th>신규 비밀번호 </th>
                            <td><input type="password" name="newPassword1" d="newPassword1"></td>
                        </tr>
                        <tr>
                            <th>신규 비밀번호 재확인</th>
                            <td><input type="password" name="newPassword2" d="newPassword2"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <a href="fn_passChange()"  class="darkBtn joinBtn" >비밀번호 변경</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
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
              <button class="blueBtn" onClick="fn_secession()" data-needpopup-show="#secession_ok">확인</button>
              <button class="grayBtn">취소</button>
            </div>
            <div class="clear"></div>
        </div>
        <!--//탈퇴 팝업-->

        <!--//탈퇴완료 팝업-->
        <div id="secession_ok" class="needpopup">
            <p>
                회원 탈퇴가 완료 되었습니다<br/>
                개인정보는 즉시 삭제됩니다
            </p>
        </div>
        <!--//탈퇴완료 팝업-->

        <!--//수정 팝업-->
        <div id="agreeN_popup" class="needpopup">
            <p><span id="sp_message"></span></p>
        </div>
        <!--//수정 팝업-->
        <button type="button" id="btn_message" style="display:none" data-needpopup-show='#agreeN_popup'>확인1</button>
        <!--//needpopup script-->
        <script src="/front_res/js/needpopup.min.js"></script>
        <script>  
	        $( function() {
	        	$("#tb_modify").show();
            	$("#tb_passwd").hide();
		    }); 
            function fn_modify(){
            	//회원 정보 수정 
            	if (any_empt_line_span("userName", "사용자명을 입력해주세요.") == false) return;
      		    if (any_empt_line_span("userCellphone", "연락처를 기입해 주세요.") == false) return;
      		    if (any_empt_line_span("userEmail", "이메일를 기입해  주세요.") == false) return;
	      		var param = {"userId" : $("#userId").val(),
		     		     	 "userName" : $("#userName").val(),
		     		     	 "userCellphone" : $("#userCellphone").val(),
		     		     	 "userEmail" : $("#userEmail").val(),
		     		     	 "mode" :  "Edt"
			                }
				
			    if (confirm("변경 하시겠습니까?")== true){
				   uniAjax("/web/JoinProcess.do", param, 
			     			function(result) {
							       if (result.status == "SUCCESS"){
		                               //관련자 보여 주기 
							    	   $("#sp_message").text(result.message);
					   		           $("#btn_message").trigger("click");
		                           }else {
			  						  $("#sp_message").text(result.message);
			  	    		          $("#btn_message").trigger("click");
			  					   }
							},
							function(request){
								    alert("Error:" +request.status );	       						
							}    		
			        );
			    }
            }
            function fn_secession(){
            	
            }
            function fn_formPass(){
            	
            }
            function fn_passChange(){
            	//비밀 번호 변경 
            	$("#tb_modify").hide();
            	$("#tb_passwd").show();
            }
            function any_empt_line_span(frm_nm, alert_message){
	       	     if ($('#'+frm_nm).val() == "" || $('#'+frm_nm).val() == null ){
	       	    	  $("#sp_message").html(alert_message);
	       	    	  $("#btn_message").trigger("click");
	        		      $('#'+frm_nm).focus();
	       			  return false;
	       		 }else{
	       	         return true;
	       		 }
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
</form:form>
</body>
</html>