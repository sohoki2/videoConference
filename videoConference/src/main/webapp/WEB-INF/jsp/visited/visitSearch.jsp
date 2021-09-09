<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title><spring:message code="URL.TITLE" /></title>

    <!--css-->
    <link href="/visited/css/reset.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/visited/css/needpopup.min.css">
    <link href="/visited/css/jquery-ui.css" rel="stylesheet" />
    
    <link href="/visited/css/style.css" rel="stylesheet" />
    <link href="/visited/css/paragraph.css" rel="stylesheet" />
    <link href="/visited/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/visited/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
     
    <!--js-->
    <script src="/visited/js/jquery-3.5.1.min.js"></script>
    <script src="/visited/js/jquery-ui.js"></script>
    <script src="/visited/js/common.js"></script>
    <script src="/front_res/js/common.js"></script>
    <link href="/visited/css/needpopup.min.css" rel="stylesheet" />
    <link href="/visited/css/mstepper.min.css" rel="stylesheet" />
    <script src="/visited/js/mstepper.min.js"></script>
    <script type="text/javascript">
       var visitSearch = {
    		   fn_search: function(){
    			   if (any_empt_line_span("seachName", "성명을 입력하세요.") == false) return;	
    			   if (any_empt_line_span("seachCelphone", "휴대폰 번호를 입력하세요.") == false) return;	
    			   
    			   
    			   var parms = {'seachName' : $("#seachName").val(), 'seachCelphone' : $("#seachCelphone").val()};
    			   
    			   uniAjax("/visited/visitSearchResult.do", parms, 
     		     			function(result) {
     						       if (result.status == "SUCCESS"){
     						    	 
     						    	  $("#tv_sarchResult > tbody").empty();
     						    	  if (result.resultlist.length > 0){
     						    		  $("#dv_sarchResult").show();
     						    		 
     						    		  var shtml = "";
     						    		  var css_style = "";
     						    		  
     						    		  //VISITED_STATE_1, VISITED_STATE_2, VISITED_STATE_3
     						    		 
     						    		  for (var i in result.resultlist){
     						    			 var obj = result.resultlist[i]; 
     						    			 if (obj.code == "VISITED_STATE_3"){
     						    				css_style = "status_gray";
     						    			 }else if (obj.code == "VISITED_STATE_1"){
     						    				css_style =  "status_red";
     						    			 }else if (obj.code == "VISITED_STATE_2"){
     						    				css_style = "status_blue";
     						    			 }else {
     						    				css_style =  "status_red"; 
     						    			 }
     						    			 var button_style = obj.code == "VISITED_STATE_1" ? "block" : "none";
     						    			 shtml = "<tr class='view' id='"+obj.visited_code +"'>"
     						    			       + "  <td>"+obj.visited_req_name +"</td>"
     						    			       + "  <td>"+obj.visited_req_org +"</td>"
     						    			       + "  <td>"+obj.center_nm +"</td>"
     						    			       + "  <td>"+obj.floor_name +"</td>"
     						    			       + "  <td>"+obj.empname +"</td>"
     						    			       + "  <td>"+obj.visitedregdate +"</td>"
     						    			       + "  <td>"+obj.visited_resday +":"+obj.visited_restime +"</td>"
     						    			       + "  <td><span class='"+css_style+"'>"+obj.code_nm +"</span></td>"
     						    			       + "  <td><button type='button' class='table_btn' style='display:"+button_style+"' onClick='visitSearch.visitedCancel(&#39;"+obj.visited_code+"&#39;)'>신청취소</button></td>"
     						    			       + "</tr>"
     						    			       + "<tr class='fold'> "
     						    			       + "  <td colspan='9'>"
     						    			       + "     <span class='main_wsubtit'>방문자 리스트</span>"
     						    			       + "      <table class='apply_table' id='tb_"+obj.visited_code+"'>"
     						    			       + "        <thead>"
     						    			       + "         <tr>"
     						    			       + "           <th>방문자</th>"
     						    			       + "           <th>휴대폰</th>"
     						    			       + "           <th>업체</th>"
     						    			       + "         </tr>"
     	                                           + "       </thead>"
     	                                           + "       <tbody>"
     	                                           + "       </tbody>"
     						    			       + "     </td>"
     						    			       + "</tr>";
     						    			 $("#tv_sarchResult >  tbody:last").append(shtml);	
     						    		  }
     						    		  $(".fold-table tr.view").on("click", function(){
     						    			
     									    $(this).toggleClass("open").next(".fold").toggleClass("open");
     									    visitSearch.fn_detailView($(this).attr('id'));
     									    
     									  });
     						    	  }else {
     						    		 $("#sp_message").text("방문자 예약을 신청한 내역이 없습니다.");
        							     $("#btn_result").trigger("click"); 
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
    		   }, fn_detailView : function (visitedCode){
    			   //
    			   //VISITED_SEQ, VISITED_CODE, VISITED_ORG, VISITED_NAME, VISITED_CELPHONE, VISITED_REGDATE
    			   uniAjaxSerial("/visited/visitSearchDetailResult.do", {'visitedCode' : visitedCode}, 
    						  function(result) {
    							       if (result.status == "SUCCESS"){
    							    	   if (result.resultlist.length > 0){
    	     						    		  
    	     						    		  $("#tb_"+visitedCode+" > tbody").empty();
    	     						    		  var shtml = "";
    	     						    		  for (var i in result.resultlist){
    	     						    			 var obj = result.resultlist[i];
    	     						    			 shtml = "<tr>"
		       						    			       + "  <td>"+obj.visited_name +"</td>"
		       						    			       + "  <td>"+obj.visited_celphone +"</td>"
		       						    			       + "  <td>"+obj.visited_org +"</td>"
		       						    			       + "</tr>"
		       						    			  $("#tb_"+visitedCode+" >  tbody:last").append(shtml);	 
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
    		   }, visitedCancel : function(visitedCode){
    			   alert(visitedCode);
    			   
    			   parms = {'visitedCode': visitedCode , 'visitedStatus':'VISITED_STATE_4'};
    			   uniAjax("/visited/visitCancel.do", parms, 
    		     			function(result) {
    						       if (result.status == "SUCCESS"){
    						    	   
    						    	   $("#sp_message").text("정상적으로 취소 되었습니다.");
     							       $("#btn_result").trigger("click");  
     							       visitSearch.fn_search();
    		  					   }else {
    		  						 $("#sp_message").text("처리 도중 애러가 발생 하였습니다.");
   							         $("#btn_result").trigger("click");  
    		  					   }
    						},
    						function(request){
    							    alert("Error:" +request.status );	       						
    						}    		
     		      );
    		   }
       }
    </script>
    
    
    
</head>
<body>
<div class="wrapper sub_back">
        <!--//header 추가-->
        <c:import url="/visited/inc/top_inc.do" />
        <!--header 추가//-->
        <!--//contents-->
        <div class="contents">
            <h2 class="sub_tit">방문신청 조회</h2>
            <div class="sub_con_box">
                
                <ul class="step_reser_list">
                    <li>
                        <input type="text" id="seachName" name="seachName" placeholder="이름을 입력하세요. *">
                    </li>
                    <li>
                        <input type="text" id="seachCelphone" name="seachCelphone" placeholder="휴대폰 번호를 입력하세요. *">
                    </li>
                </ul>
                <div class="step_bottom">
                    <!-- Here goes your actions buttons -->
                    <button type="button" class="apply-btn" type="button" onclick="visitSearch.fn_search()">조회하기</button>
                </div>
                
                <div class="table-block" id="dv_sarchResult">
                    <table class="apply_table fold-table" id="tv_sarchResult">
                        <thead>
                            <tr>
                                <th>신청자</th>
                                <th>신청업체</th>
                                <th>방문업체</th>
                                <th>방문층</th>
                                <th>접견자</th>
                                <th>신청날짜</th>
                                <th>방문일자</th>
                                <th>신청상태</th>
                                <th>비고</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    
                </div> 
                
            </div>                
        </div>
    </div>
    <!-- 팝업 -->    
    
    <div id='ok_reserve' class="needpopup reser_noti">
        <div class="reser_noti_pop">            
           <span id="sp_message"></span>
        </div>
    </div> 
    <button type="button" id="btn_result" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
    
    <!--popup-->
    <script src="/visited/js/needpopup.min.js"></script> 
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
        <script>
			$(function(){
			  $("#dv_sarchResult").hide();
			  
			});
    </script>
</body>
</html>