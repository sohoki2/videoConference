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
<form:form name="regist" commandName="regist" method="post" >
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }" />
<input type="hidden" name="pageSize" id="pageSize"  value="${regist.pageSize }" />
<input type="hidden" name="pageUnit" id="pageUnit"  value="${regist.pageUnit }"/>
<input type="hidden" name="resSeq" id="resSeq" />
<input type="hidden" name="cancelCode" id="cancelCode" value="CANCEL_CODE_3"/>
<input type="hidden" name="reservProcessGubun" id="reservProcessGubun" />

        <!--//header 추가-->
        <c:import url="/web/inc/top_inc.do" />
        <!--header 추가//-->
        <!--// left menu -->
        <c:import url="/web/inc/right_menu.do" />
        <!--left menu //-->
        <!--//contents-->
        <div class="contents">
            <div class="whiteBack mybooking">
                <h5>최근 나의 예약 현황 리스트입니다</h5>      
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
                            <th></th>
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
                            <td>
                                <!--예약취소 활성화 active-->
                                <a href="" class="cancleBtn active" data-needpopup-show="#cancle_popup">예약취소</a>
                                <!--예약 취소 후-->
                                <!--<a href="" class="cancleBtn">취소완료</a>-->
                            </td>
                        </tr>
                       
                    </tbody>
                </table>
               
                </section>
             </div>
              <div id="dv_page"></div>
        </div>
        <!--contetns//-->
        <div id="cancle_popup" class="needpopup main_pop opened">
	        <div class="box_padding">
	            <h2 class="pop_tit">예약취소</h2>  
	            <div class="form">
	                <div class="pop_con">
	                    <div class="box_2">
	                        <textarea id="cancelReason"></textarea>
	                    </div>                    
	                </div>   
	            </div>
	            <div class="footerBtn">
	                <a href="" onClick="fn_resUpdate()" class="blueBtn">완료</a>
	                <a href="" class="grayBtn">취소</a>
	            </div>
	            <div class="clear"></div>
	        </div>            
	        <a href="#" class="needpopup_remover"></a>
	    </div>
	    <div id='recancle_popup' class="needpopup">
            <p> <span id="sp_message"></span></p>
        </div>
        <!--//needpopup script-->
        
        <button type="button" id="btn_result" style="display:none" data-needpopup-show='#recancle_popup'>경고창 보여 주기</button>
        <script src="/front_res/js/needpopup.min.js"></script>
        <script type="text/javascript">
		    $( function() {
		    	fn_bookingList();
		    });
	        function fn_bookingList(){
	        	var url = "/web/mybookingAjax.do";
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
		   						   $("#tb_booking > tbody").empty();
		   						   if (result.resultlist.length > 0){
		   							   var sHtml = "";
		   							   var obj = result.resultlist;
		   							   var costInfo  = "";
		   							   var a = "1";
		   							   for (var i in result.resultlist ){
		   								
		   								costInfo = (obj[i].reserv_process_gubun == "PROCESS_GUBUN_1" || obj[i].reserv_process_gubun == "PROCESS_GUBUN_2") ?
		   										   "<a href='' onClick='fn_resCancel(&#39;"+ obj[i].res_seq+"&#39;,&#39;PROCESS_GUBUN_6&#39;)' class='cancleBtn active' data-needpopup-show='#cancle_popup'>예약취소</a>" :
		   										   "취소완료";
		   								  
		   								  sHtml	+="<tr>"
					                            +"    <td>"+a+"</td>"
					                            +"    <td>"+obj[i].item_gubun+"</td>"
					                            +"    <td>"+obj[i].res_title+"</td>"
					                            +"    <td>"+obj[i].resstartday+"</td>"
					                            +"    <td>"+obj[i].resstarttime+"~"+obj[i].resendtime+"</td>"
					                            +"    <td>"+obj[i].tenn_cnt+"</td>"
					                            +"    <td>"+costInfo+"</td>"
					                            +"</tr>";
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
	       	   $(":hidden[name=pageIndex]").val(pageNo);
	           fn_bookingList();
	   	    }
	        function fn_resCancel(resSeq, reservProcessGubun){
	        	
	        	$("#resSeq").val(resSeq);
	        	$("#reservProcessGubun").val(reservProcessGubun);
	        	
	        }
	        function fn_resUpdate(){
	        	if (any_empt_line_id("cancelCode", '취소 유형을 선택해 주세요.') == false) return;
	        	if (any_empt_line_id("cancelReason", '취소 사유를 입력해 주세요.') == false) return;
	        	var params = {'resSeq': $("#resSeq").val(), 'reservProcessGubun': $("#reservProcessGubun").val(), 
	        			           'cancelCode' : $("#cancelCode").val(), 'cancelReason' : $("#cancelReason").val() };
	        	uniAjax("/web/resUpdate.do", params, 
	         			function(result) {
	        			       if (result.status == "LOGIN FAIL"){
	        			    	        alert(result.message);
	        							location.href="/web/Login.do";
	        					   }else if (result.status == "SUCCESS"){
	        						    //테이블 정리 하기
	        						    need_close();
	        							$("#sp_message").text(result.message);
	        							$("#btn_result").trigger("click");
	        						    fn_bookingList();
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
</form:form>
</body>
</html>
 