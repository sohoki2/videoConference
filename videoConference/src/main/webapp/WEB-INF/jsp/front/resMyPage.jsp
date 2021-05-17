<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    
    <link rel="stylesheet" href="/css/new/paragraph.css">    
    <link rel="stylesheet" href="/css/new/reset.css"> 
    <link rel="stylesheet" href="/css/new/swiper.css">
    
        
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    <link rel="stylesheet" href="/css/new/jquery-ui.css">
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/new/needpopup.min.css">    
    <script src="/js/popup.js"></script>    
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    <script type="text/javascript" src="/js/common_res.js"></script>
	<script type="text/javascript" src="/js/SE/js/HuskyEZCreator.js"></script>
</head>
<body>
<div id="wrapper">
        <c:import url="/front/inc/fnt_top_inc.do" />
        <div id="container">
            <div class="contents">
                <h2 class="sub_tit">나의예약</h2>                
                <!-- contents -->
                <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/resList.do">	
                <input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
                <input type="hidden" id="resSeq" name="resSeq">
                <input type="hidden" id="reservProcessGubun" name="reservProcessGubun">
                <input type="hidden" id="meetingLog" name="meetingLog">
                
                <jsp:useBean id="nowDate" class="java.util.Date" />
                
				<c:set var="sysday"><fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /></c:set>
				<c:set var="systime"><fmt:formatDate value="${nowDate}" pattern="HH:mm" /></c:set>
                <div class="pe_010">
                    <div class="day_con">                     

                        <!-- list style -->
                        <div class="list_box">
                            <c:forEach items="${resultlist }" var="resInfo" varStatus="status">
                            <div class="list_meeting">
                                <div class="left_box">
                                    <span class="meeting_tit">${resInfo.res_title}
                                        <c:if test="${(resInfo.reserv_process_gubun eq 'PROCESS_GUBUN_4' || resInfo.reserv_process_gubun eq 'PROCESS_GUBUN_2') && sysday > resInfo.resStartday.replaceAll('-','') }">
                                         <a href="#" onclick="fn_meetingLog('${resInfo.res_seq }')" class="list_modifi">회의록작성</a>
                                        </c:if>
                                    </span>
                                    
                                    <p class="meeting_time">${resInfo.resstartday } ${resInfo.resstarttime }~${resInfo.resendtime }</p>
                                    <!-- <div class="meeting_ing meeting_state"></div> -->
                                    <ul class="meeting_info">
                                        <li>주최자 : ${resInfo.empname } [${resInfo.deptname} ]</li>
                                        <li>참여자: ${resInfo.attendlisttxt }</li>
                                        <li>장소: ${resInfo.meeting_name } 
										<c:if test="${resInfo.con_number ne ''}">
										    방번호: ${resInfo.con_number }
										</c:if>
										</li>
                                    </ul>
                                    
                                </div>
                                <div class="right_box">
                                    <!-- <p class="meetine_member"> -->
                                       <c:if test="${resInfo.proxy_yn eq 'R' and sysday < resInfo.resstartday.replaceAll('-','') }">
	                                       <c:choose>  
	                                           <c:when test="${resInfo.reserv_process_gubun eq 'PROCESS_GUBUN_1' }">
	                                               <a class="list_join" href="javascript:res_cancel('${resInfo.res_seq}', 'PROCESS_GUBUN_6')">취소</a>
	                                           </c:when>
	                                           <c:when test="${resInfo.reserv_process_gubun eq 'PROCESS_GUBUN_2' }">
	                                               <a class="list_join" href="javascript:res_cancel('${resInfo.res_seq}', 'PROCESS_GUBUN_6')">취소</a>
	                                           </c:when>
	                                           <c:when test="${resInfo.reserv_process_gubun eq 'PROCESS_GUBUN_4' }">
	                                               <a class="list_join" href="javascript:res_cancel('${resInfo.res_seq}', 'PROCESS_GUBUN_6')">취소</a>
	                                           </c:when>
	                                       </c:choose>
	                                   </c:if>
                                       <c:if test="${resInfo.proxy_yn eq 'S' && sysday <= resInfo.resstartday.replaceAll('-','')  }">
                                            <c:choose>  
	                                           <c:when test="${resInfo.reserv_process_gubun eq 'PROCESS_GUBUN_1' }">
	                                               <a class="list_join" href="javascript:res_cancel('${resInfo.res_seq}', 'PROCESS_GUBUN_2')">예약 승인</a>
	                                               <a class="list_join" href="javascript:res_cancel('${resInfo.res_seq}', 'PROCESS_GUBUN_3')">예약 취소</a>
	                                           </c:when>
	                                           <c:when test="${resInfo.reserv_process_gubun eq 'PROCESS_GUBUN_2' }">
	                                               <a class="list_join" href="javascript:res_cancel('${resInfo.res_seq}', 'PROCESS_GUBUN_6')">취소</a>
	                                           </c:when>
	                                       </c:choose>
                                       </c:if>
                                     <p class="meetine_member"  style="text-align:right;">${resInfo.reservprocessgubuntxt}</p>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            
                            </c:forEach>
                        </div>                       
                        <!-- // list style -->

                        <!-- page number --> 
                        <div class="page_num">
                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
                        </div>
                        <!-- bottom btn -->
                       
                    </div>
                </div>
                <!-- // contents -->
            </div>            
        </div>
    </div>
    
    
    <!-- 취소 사유 생성 -->
    <div id='cancel_info' class="needpopup">
        <div class="box_padding">
            <h2 class="pop_top" id="">취소</h2>  
            <div class="pop_container">
                
                <form:select path="cancelCode" id="cancelCode" title="소속" class="add_sel">
				         <form:option value="" label="취소선택"/>
                         <form:options items="${selectCancel}" itemValue="code" itemLabel="codeNm"/>
				</form:select>  
                <textarea placeholder="내용을 입력하세요." id="cancelReason" rows="8" class="add_text">
                </textarea>
            </div>
            <div class="pop_footer">
                <a href="#" onClick="fn_resUpdate()" class="pop_btn">완료</a>
                <a href="#" class="pop_btn">취소</a>
            </div>
        </div>            
    </div>
    <!-- //취소 사유 생성 끝  -->
    <!-- 회의록 작성 -->
    <div id='meeting_log' class="needpopup">
        <div class="box_padding">
            <h2 class="pop_top">회의록</h2>  
            <span id="sp_resTitle"></span>
            
            <textarea name="ir" id="ir" style="width:860px; height:120px; display:none;"></textarea>
            <div class="pop_footer">
                <a href="#" onClick="fn_meetingUpdate()" class="pop_btn">입력</a>
                <a href="#" class="pop_btn">취소</a>
            </div>
        </div>            
    </div>
    <!-- 회의록 작성  끝  -->
    
    <button id="btn_Cancecl" style="display:none" data-needpopup-show='#cancel_info'>확인1</button>
    <button id="btn_meetingLog" style="display:none" data-needpopup-show='#meeting_log'>확인2</button>
    </form:form>
    <!--popup-->
    <script src="/js/needpopup.min.js"></script> 
    <script>  
        function fn_meetingUpdate(){
        	   var sHTML = oEditors.getById["ir"].getIR();
        	   $("#meetingLog").val(sHTML);
   		       var params = {'resSeq': $("#resSeq").val(), 'meetinglog': $("#meetingLog").val() };
				uniAjax("/front/resInfo/resMeetingUpdate.do", params, 
						function(result) {
						       if (result.status == "LOGIN FAIL"){
						    	        alert(result.message);
										location.href="/backoffice/login.do";
								   }else if (result.status == "SUCCESS"){
									    //테이블 정리 하기
									   alert(result.message);
									   location.reload();
								   }
						    },
						    function(request){
							    alert("Error:" +request.status );	       						
						    }    		
			  );
        }
		function linkPage(pageNo) {
			$(":hidden[name=pageIndex]").val(pageNo);				
			$("form[name=regist]").attr("action", "/front/resInfo/resMypage.do").submit();
		}
        function fn_meetingLog(resSeq, resTitle){
        	$("#sp_resTitle").html(resTitle);
        	$("#resSeq").val(resSeq);
        	var params = {'resSeq': resSeq};
        	uniAjax("/front/resInfo/resMeetingInfo.do", params, 
         			function(result) {
        		     
        			       if (result.status == "LOGIN FAIL"){
        			    	    alert(result.message);
        						location.href="/backoffice/login.do";
        					}else if (result.status == "SUCCESS"){
        						var obj = result.resInfo;
        						$("#ir").text(obj.meetinglog);
        						$("#btn_meetingLog").trigger("click");
        					}else{
        					   	
        					}
				    },
				    function(request){
					    alert("Error:" +request.status );	       						
				    }    		
			);
        	
        }
        
        function res_cancel(resSeq, process){
        	$("#cancelCode").val("");
		    $("#cancelReason").val("");
		    
		    $("#resSeq").val(resSeq);
    		$("#reservProcessGubun").val(process);
        	if (process == "PROCESS_GUBUN_2"){
        		fn_resUpdate();
        	}else {
        		//취소시 팝업 먼저 발생 후 처리 하기 
        		$("#btn_Cancecl").trigger("click");
        		
        	}
        }
        function fn_resUpdate(){
        	if ($("#reservProcessGubun").val() != "PROCESS_GUBUN_2"){
        		if (any_empt_line_id("cancelCode", '취소 유형을 선택해 주세요.') == false) return;
        		if (any_empt_line_id("cancelReason", '취소 사유를 입력해 주세요.') == false) return;
        	}
        	var params = {'resSeq': $("#resSeq").val(), 'reservProcessGubun': $("#reservProcessGubun").val(), 
        			           'cancelCode' : $("#cancelCode").val(), 'cancelReason' : $("#cancelReason").val() };
        	uniAjax("/front/resInfo/resUpdate.do", params, 
         			function(result) {
        			       if (result.status == "LOGIN FAIL"){
        			    	        alert(result.message);
        							location.href="/backoffice/login.do";
        					   }else if (result.status == "SUCCESS"){
        						    //테이블 정리 하기
        						   alert(result.message);
        						   location.reload();
        					   }
        			    },
        			    function(request){
        				    alert("Error:" +request.status );	       						
        			    }    		
             );
        }
        var oEditors = [];
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "ir",                        
            sSkinURI: "/js/SE/SmartEditor2Skin.html",
            htParams: { bUseToolbar: true,
                fOnBeforeUnload: function () { },
                //boolean 
                fOnAppLoad: function () { }
                //예제 코드
            },
            fCreator: "createSEditor2"
        });
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
    <script>
      $( function() {
        $( "#datepicker" ).datepicker();
      } );
    </script>
    
</body>
</html>