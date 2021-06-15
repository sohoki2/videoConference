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
                                <button type="button" class="darkBtn joinBtn" id="btn_passch" onClick="fn_passChange()">비밀번호 변경</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table id="tb_modify">
                    <tbody>
                        <tr>
                            <th>이름</th>
                            <td><input type="text" name="userName" id="userName" value="${userinfo.empname }">
                            <input type="hidden" name="userId" id="userId" value="${userinfo.empid}"/>
                            <input type="hidden" name="userNo" id="userNo" value="${userinfo.empno}"/>
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
                                <button type="button" class="darkBtn joinBtn" id="btn_passch" onClick="fn_formPass()">비밀번호 변경</button>
                                <button type="button" class="darkBtn joinBtn" data-needpopup-show="#secession">회원탈퇴</button>
                                <button type="button" class="modiBtn" onClick="fn_modify()">수정하기</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
               
            </div>
        </div>
       

        
        <!--//needpopup script-->
        <c:import url="/web/inc/unimessage.do" />
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
	      				     "userNo" : $("#userNo").val(),
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
            	$("#tb_modify").hide();
            	$("#tb_passwd").show();
            }
            function fn_passChange(){
            	if (any_empt_line_span("nowPassword", "기존 비밀번호를 입력해주세요.") == false) return;
            	if (any_empt_line_span("newPassword1", "신규 비밀번호를 입력해주세요.") == false) return;
            	if (any_empt_line_span("newPassword2", "신규 비밀번호를 입력해주세요.") == false) return;
            	if ( $.trim($('#newPassword1').val()) !=   $.trim($('#newPassword2').val())  ){
      			   $("#sp_message").text("비밀 번호가 일치 하지 않습니다.");
         		       $("#btn_message").trigger("click");
      			   return;
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