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
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }" />
<input type="hidden" name="pageSize" id="pageSize"  value="${regist.pageSize }" />
<input type="hidden" name="pageUnit" id="pageUnit"  value="${regist.pageUnit }"/>
<input type="hidden" name="resSeq" id="resSeq" />
<input type="hidden" name="boardGubun" id="boardGubun" />
<input type="hidden" name="cancelCode" id="cancelCode" value="CANCEL_CODE_3"/>
<input type="hidden" name="reservProcessGubun" id="reservProcessGubun" />
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
                                <span>${userinfo.empname }</span>
                            </li>
                            <li>
                                <span class="tit">이메일</span>
                                <span>${userinfo.empmail }</span>
                            </li>
                            <li>
                                <span class="tit">휴대전화</span>
                                <span>${userinfo.emphandphone }</span>
                            </li>
                        </ul>
                    </div>
                    <div class="clear"></div>
                    <c:if test="${userinfo.authorCode eq 'ROLE_USER' }">
                    <a href="/web/myModify.do" class="darkBtn">수정</a>
                    </c:if>
                </div>
            </div>
            <div class="whiteBack w_half float_right">
                <div class="credit">
               <div class="float_left"><img src="/front_res/img/credits.png"></div>
                    <div class="float_left">
                        <h5>잔여 크레딧</h5>    
                        <div class="res">
                        <span class="blueFont" id="sp_nowtenn">${cominfo.tenn_info }</span>
                        /<span id="sp_totaltenn">${cominfo.tenn_total_info }</span>
                    </div>
                    </div>
                    <div class="clear"></div>
                    <p>크레딧은 월 초 자동 충전되며, 잔여 크레딧은 자동 소멸됩니다</p>
                    </div>
            </div>
            <div class="clear"></div>
            <div class="whiteBack mybooking">
                <div id="allFloors">
		            <div class="contents">
		                <div class="flooreArea float_left" >
		                     <a href="#" onClick="fn_boardList('res')" id="a_res" class="active">예약 내역</a>  
		                     <a href="#" onClick="fn_boardList('ten')" id="a_tenn">크레딧내역</a>  
		                     <a href="#" onClick="fn_boardList('vis')" id="a_vis">방문자예약</a>  
		                </div>               
		                <div class="clear"></div>
		            </div>
		        </div>
                <section>
                <table class="my_T" id="tb_booking">
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
                <div id="dv_page"></div>
                
               <!--page number//-->
             </div>
        </div>
        <!--contetns//-->


        <!--needpopup script-->
        
        <c:import url="/web/inc/unimessage.do" />
        
        
        <div id="canclePopup" class="needpopup main_pop opened">
		     <div class="box_padding">
		         <h2 class="pop_tit">방문 예약 취소</h2>  
		         <div class="form">
		             <div class="pop_con">
		                 <div class="box_2">
		                     <textarea id="cancelReasonVisited" style="width:95%;"></textarea>
		                 </div>                    
		             </div>   
		         </div>
		         <div class="footerBtn">
		             <a href="#" onClick="fn_cancelVisited()" class="blueBtn" >방문 예약 취소</a>
		             <a href="#" onClick="need_close()" class="grayBtn">취소</a>
		         </div>
		         <div class="clear"></div>
		     </div>            
		     <a href="#" class="needpopup_remover"></a>
		</div>
		<div id="visitedDetailPopup" class="needpopup main_pop opened">
		     <div class="box_padding">
		         <h2 class="pop_tit">방문 예약 현황</h2>  
		         <div class="form">
		             <div class="pop_con">
		                 <div class="box_2">
		                      <h5 class='main_wsubtit'>방문자 리스트</h5>
     						  <table class='pop_table_visit' id="tb_visitedDetail">
     						    <thead>
     						      <tr>
     						    	<th>방문자</th>
     						    	<th>휴대폰</th>
     						    	<th>업체</th>
     						      </tr>
     	                        </thead>
     	                        <tbody>
     	                        </tbody>
     	                      </table>
		                 </div>                    
		             </div>   
		         </div>
		         <!--  // 팝업 내 상단 x버튼이 있으므로 닫기 버튼은 삭제하겠습니다.
		         <div class="footerBtn">
		             <a href="#" onClick="need_close()" class="grayBtn">닫기</a>
		         </div>
		         <div class="clear"></div>
				 -->
		     </div>            
		     <a href="#" class="needpopup_remover"></a>
		</div>
		
		
		<input type="hidden" id='visitedCode'>
        <script type="text/javascript">
		    $( function() {
		    	$("#boardGubun").val("res");
		    	fn_bookingList();
		    });
		    function fn_boardList(gubun){
		    	$("#boardGubun").val(gubun);
		    	if (gubun == "res"){
		    		$("#a_res").addClass("active");
		    		$("#a_tenn").removeClass("active");
		    		$("#a_vis").removeClass("active");
		    		
		    		
		    	}else if (gubun == "vis"){
		    		$("#a_res").removeClass("active");
		    		$("#a_tenn").removeClass("active");
		    		$("#a_vis").addClass("active");
		    	}else {
		    		$("#a_res").removeClass("active");
		    		$("#a_tenn").addClass("active");
		    		$("#a_vis").removeClass("active");
		    	}
		    	fn_bookingList();
		    }
	        function fn_bookingList(){
	        	var gubun = $("#boardGubun").val();
	        	var url = "";
	        	if (gubun == "res"){
	        		url = "/web/mybookingAjax.do";
	        	}else if (gubun == "vis"){
	        		url = "/web/visitedAjax.do";
	        	}else {
	        		url = "/web/myTennAjax.do";
	        	}
	        	
	        	var params = { 
			    	    		"pageIndex": $("#pageIndex").val(),
			    	    		"searchKeyword" : $("#searchKeyword").val(),
			    	    		"pageUnit": $("#pageUnit").val()
	     		              }; 
	            
		    	uniAjax(url, params, 
		      			function(result) {
		 				       if (result.status == "LOGIN FAIL"){
		 				    	   alert(result.meesage);
		   						   location.href="/web/Login";
		   					   }else if (result.status == "SUCCESS"){
		   						   //총 게시물 정리 하기
		   						   $("#tb_booking > thead").empty();
		   						   var tHtml  = "";
		   						   if (gubun == "res"){
		   							  tHtml = "<tr><th>NO</th><th>구분</th><th>예약내용</th><th>이용날짜</th><th>이용시간</th><th>이용크레딧</th><th></th></tr>";
		   						   }else if (gubun == "vis") {
		   							  tHtml = "<tr><th>NO</th><th>신청자명</th><th>휴대폰번호</th><th>소속업체</th><th>방문장소</th><th>방문예약일</th><th>상태</th></tr>";
		   						   }else {
		   							  tHtml = "<tr><th>NO</th><th>구분</th><th>예약내용</th><th>이용날짜</th><th>이용시간</th><th>이용크레딧</th></tr>";  
		   						   }
		   						   $("#tb_booking > thead").append(tHtml);
		   						    
		   						   $("#tb_booking > tbody").empty();
		   						   if (result.resultlist.length > 0){
		   							   var sHtml = "";
		   							   var obj = result.resultlist;
		   							   var costInfo  = "";
		   							   var a = "1";
		   							   for (var i in result.resultlist ){
		   								
		   								  costInfo = (obj[i].reserv_process_gubun == "PROCESS_GUBUN_1" || obj[i].reserv_process_gubun == "PROCESS_GUBUN_2" || obj[i].reserv_process_gubun == "PROCESS_GUBUN_4" || obj[i].reserv_process_gubun == "PROCESS_GUBUN_8") ?
		   										   "<a href='' onClick='fn_resCancel(&#39;"+ obj[i].res_seq+"&#39;,&#39;PROCESS_GUBUN_6&#39;)' class='cancleBtn active' data-needpopup-show='#cancle_popup'>예약취소</a>" :
		   										   "취소완료";
		   								  
	   									  if (gubun == "res"){
	   										 var resDay = obj[i].res_gubun == "SWC_GUBUN_3" ? obj[i].resstartday +" " +obj[i].resstarttime +" 부터" : obj[i].resstartday;
											 var resTime = obj[i].res_gubun == "SWC_GUBUN_3" ? obj[i].resendday +" " +obj[i].resendtime +" 까지" : obj[i].resendtime;
	   										 sHtml	+="<tr>"
						                            +"    <td>"+a+"</td>"
						                            +"    <td>"+obj[i].item_gubun_t+"</td>"
						                            +"    <td>"+obj[i].res_title+"</td>"
						                            +"    <td>"+resDay+"</td>"
						                            +"    <td>"+resTime+"</td>"
						                            +"    <td>"+obj[i].tenn_cnt+"</td>"
						                            +"    <td>"+costInfo+"</td>"
						                            + "</tr>";
				                          }else if (gubun == "vis"){
				                        	  
				                        	  consInfo = (obj[i].visited_status == "VISITED_STATE_1") ?
				                        			   "<a href='#' onClick='fn_VisitedChange(&#39;"+ obj[i].visited_code+"&#39;,&#39;VISITED_STATE_2&#39;)' class='apply_btn'>승인</a><a href='#' onClick='fn_VisitedCancel(&#39;"+ obj[i].visited_code+"&#39;)' class='apply_btn_none' data-needpopup-show='#canclePopup'>취소</a> " :
				                        				   obj[i].code_nm  
				                        	  
				                        	  sHtml	+="<tr>"
						                            +"    <td>"+a+"</td>"
						                            +"    <td onClick='fn_visitedDetail(&#39;"+obj[i].visited_code+"&#39;)' data-needpopup-show='#visitedDetailPopup' >"+obj[i].visited_req_name+"</td>"
						                            +"    <td>"+obj[i].visited_req_celphone+"</td>"
						                            +"    <td>"+obj[i].visited_req_org+"</td>"
						                            +"    <td>"+obj[i].floor_name+"</td>"
						                            +"    <td>"+obj[i].visited_resday+":"+ obj[i].visited_restime + "</td>"
						                            +"    <td>"+consInfo+"</td>"
						                            + "</tr>";
				                          } else {
				                        	  sHtml	+="<tr>"
						                            +"    <td>"+a+"</td>"
						                            +"    <td>"+obj[i].code_nm+"</td>"
						                            +"    <td>"+obj[i].res_title+"</td>"
						                            +"    <td>"+obj[i].res_startday+"</td>"
						                            +"    <td>"+obj[i].resstarttime+"~"+obj[i].resendtime+"</td>"
						                            +"    <td>"+obj[i].tenn_cnt+"</td>";
						                          
						                            sHtml += "</tr>";
				                          }	
		   										
		   								 
		   								  a = parseInt(a)+1;
		   							   }
		   							   $("#tb_booking > tbody").append(sHtml);
		   							   
		   							   //페이지 설정 
		   							   var pageObj = result.paginationInfo
		  						       var pageHtml = ajaxPaging(pageObj.currentPageNo, pageObj.firstPageNo, pageObj.recordCountPerPage, 
								                                 pageObj.firstPageNoOnPageList, pageObj.lastPageNoOnPageList, 
								                                 pageObj.totalRecordCount, pageObj.pageSize, "ajaxPageChange");
								        $("#dv_page").html(pageHtml);
		   						   }
	
		   					   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }   
		 				    
		 				    
		        );
	        }
	        function fn_search(){
	        	if (any_empt_line_id("searchKeyword", "검색어를 입력해 주세요.") == false) return;	
	        	$("#pageIndex").val("1");
	        	fn_bookingList();
	        }
	        function ajaxPageChange(pageNo) {
	           $("#pageIndex").val(pageNo);
	           fn_bookingList();
	   	    }
	        function fn_visitedDetail(visitedCode){
	        	
	        	//상세 보기 
	        	uniAjaxSerial("/visit/VisitSearchDetailResult.do", {'visitedCode' : visitedCode}, 
						  function(result) {
							       if (result.status == "SUCCESS"){
							    	   if (result.resultlist.length > 0){
	     						    		  
	     						    		  $("#tb_visitedDetail > tbody").empty();
	     						    		  var shtml = "";
	     						    		  for (var i in result.resultlist){
	     						    			 var obj = result.resultlist[i];
	     						    			 shtml = "<tr>"
	       						    			       + "  <td>"+obj.visited_name +"</td>"
	       						    			       + "  <td>"+obj.visited_celphone +"</td>"
	       						    			       + "  <td>"+obj.visited_org +"</td>"
	       						    			       + "</tr>"
	       						    			  $("#tb_visitedDetail >  tbody:last").append(shtml);	 
	     						    		  }
							    	   }
								   }else {
									   $("#sp_message").text("조회중 애러가 발생 하였습니다.");
	    							   $("#btn_result").trigger("click"); 
								   }
						  },
						  function(request){
							    alert("Error:" +request.status );	       						
						  }    		
			   );
	        }
	        function fn_VisitedCancel(visitedCode){
			    $("#visitedCode").val(visitedCode);
			    	
			}
	        function fn_cancelVisited(){
	        	fn_VisitedChange($("#visitedCode").val(), 'VISITED_STATE_4');
	        	need_close();
	        }
	        function fn_VisitedChange(visitedCode, status){
	        	var params = {'visitedCode': visitedCode, 'mode' : 'Edt', 'visitedStatus' : status, 'visitedGubun' : 'VISITED_GUBUN_1', 'cancelReason': $("#cancelReasonVisited").val()};
	       	    uniAjax("/visit/VisitUpdaterProcess.do", params, 
	   	  			 function(result) {
	   					       if (result.status == "SUCCESS"){
	   					    	   alert("정상적으로 처리 되었습니다.");
	   					    	   fn_bookingList();
	   						   }else {
	   							   alert(result.message);
	   						   }
	   					  },function(request){
	   						    alert("Error:" +request.status );	       						
	   					  }    		
	   	       );
			}
        </script>
</form:form>
</body>
</html>