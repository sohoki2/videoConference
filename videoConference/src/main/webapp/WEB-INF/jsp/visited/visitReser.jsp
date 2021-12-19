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
       var VisitedArrays = new Array();
       var visited = {
    		fn_nextStep  : function(_step){
    			if (_step == "1"){
    				if (any_empt_line_span("visitedReqName", "성명을 입력하세요.") == false) return;	
        			if (any_empt_line_span("visitedReqCelphone", "휴대폰 번호를 입력하세요.") == false) return;	
        			if (any_empt_line_span("visitedReqOrg", "소속 업체명을 입력하세요.") == false) return;	
        			if (fn_Check("apply", "개인정보 수집 및 이용 동의는 필수입니다.") == false) return;
        			
    			}else if (_step == "2"){
    				if (any_empt_line_span("centerId", "방문 지점을 선택하세요.") == false) return;	
    				if (any_empt_line_span("floorSeq", "방문층수를 선택하세요.") == false) return;	
    				if (any_empt_line_span("visitedEmpno", "접견 대상자 명을 선택하세요.") == false) return;	
    				if (any_empt_line_span("visitedResday", "방문 일자를 선택하세요.") == false) return;	
    				if (any_empt_line_span("visitedRestime1", "방문시간을 선택하세요.") == false) return;	
    				if (any_empt_line_span("visitedRestime2", "방문시간을 선택하세요.") == false) return;	
    				if (any_empt_line_span("visitedPurpose", "방문 목적을 입력하세요.") == false) return;
					visited.fn_equal();


    			}
    			$("#btn_step0"+_step).click();
    			
    		}, 
    		fn_floorCombo : function(){
    			 if ($("#centerId").val() != ""){
    				 var _url = "/backoffice/basicManage/floorComboInfo.do?centerId="+$("#centerId").val();
        	    	 var _params = {"centerId" : $("#centerId").val()};
        	    	 
        	    	 var returnVal = uniAjaxReturn(_url, _params);
        	    	 if (returnVal.resultlist.length > 0){
    			        var obj  = returnVal.resultlist;
    				    $("#floorSeq").empty();
    				    $("#floorSeq").append("<option value=''>선택</option>");
    				    for (var i in obj) {
    				        var array = Object.values(obj[i])
    				        $("#floorSeq").append("<option value='"+ array[0]+"'>"+array[1]+"</option>");
    				    }
    				}else {
    			      //값이 없을때 처리 
    			      $("#floorSeq").remove();
    			    }
    			 }
    			 
    		}, fn_preStep : function (_step){
    			$("#btn_pre_step0"+_step).click();
    		}, fn_equalCheck : function (){
    			var detailInfo =  new Object(); 
    			detailInfo.visitedName = "'" +$("#visitedReqName").val()+ "'";
    			detailInfo.visitedCelphone = $("#visitedReqCelphone").val().replaceAll("-", "");
    			detailInfo.visitedOrg = "'" +$("#visitedReqOrg").val()+ "'";
    			$("#visitedEqual").val("Y");
    			VisitedArrays.push(detailInfo);
    			visited.fn_visitedList();
    			needPopup.hide();
    			
    		},fn_equal : function (){
    			var detailInfo =  new Object(); 
    			detailInfo.visitedName = "'" +$("#visitedReqName").val()+ "'";
    			detailInfo.visitedCelphone = $("#visitedReqCelphone").val().replaceAll("-", "");
    			detailInfo.visitedOrg = "'" +$("#visitedReqOrg").val()+ "'";
    			$("#visitedEqual").val("Y");
    			VisitedArrays.push(detailInfo);
    			visited.fn_visitedList();
    			
    		}, fn_visitedList : function(){
    			//리스트 보여주기 
    			$("#btn_submit").attr('disabled', visited.fn_submitCheck());
    			$("#tb_visitedPersonDetail > tbody").empty();
    			for (var i = 0; i < VisitedArrays.length; i ++){
    				var obj = VisitedArrays;
    				html  = "<tr id='"+obj[i].visitedCelphone +"'>"
    				      + "   <td><input type='checkbox' name='visitedInfo' value='"+obj[i].visitedCelphone +"'></td>"
    				      + "   <td>" + obj[i].visitedName.replaceAll("'", "") + "</td>"
					      + "   <td>" + obj[i].visitedCelphone.replaceAll("-", "") + "</td>"
					      + "   <td>" + obj[i].visitedOrg.replaceAll("'", "") + "</td>"
					      + " </tr>";		   						          
			        $("#tb_visitedPersonDetail > tbody").append(html);
    			}  
    		}, fn_userAdd : function(){
    			
    			if (any_empt_line_span("visitedName", "성명을 입력하세요.") == false) return;	
    			if (any_empt_line_span("visitedCelphone", "휴대폰 번호를 입력하세요.") == false) return;	
    			if (any_empt_line_span("visitedOrg", "업체명을 입력하세요.") == false) return;	
    			
    			//기존 전화 번호 있는지 체크 하기 
    			if (visited.fn_cellphoneCheck($("#visitedCelphone").val()) != false){
    				var detailInfo =  new Object(); 
        			detailInfo.visitedName = "'" + $("#visitedName").val() + "'";
        			detailInfo.visitedCelphone = $("#visitedCelphone").val() ;
        			detailInfo.visitedOrg = "'" + $("#visitedOrg").val() + "'";
        			VisitedArrays.push(detailInfo);
        			visited.fn_visitedList();
        			
    			}else {
    				$("#sp_message").text("중복된 핸드폰 번호가 있습니다.");
					$("#btn_result").trigger("click");
    			}
    			$("#visitedName").val("");
    			$("#visitedCelphone").val("");
    			$("#visitedOrg").val("");
    			//값 확인 후 정리 하기
    			
    			
    			
    			
    		}, fn_allCheck : function(){
    			var size = $("input[name='visitedInfo']").length;
                for(i=0;i<size;i++){
                	if ($("#allCheck").prop("checked")){	
                		$("input[name='visitedInfo']").prop("checked", true);
                	}else{
                		$("input[name='visitedInfo']").prop("checked", false);
                	}
                }
    		}, fn_userDel : function (){
    			//tr id 삭제 
    			//체크된 값 가지고 오기 
    			var delChecks = ckeckboxValue("체크된 값이 없습니다", "visitedInfo");
				console.log("delChecks:" + delChecks);

    			var jbSplit  = delChecks.split(',');
    			for (var a in jbSplit){
    				for (let [i, VisitedArray] of VisitedArrays.entries()) {
    					if (VisitedArray.visitedCelphone == jbSplit[a]) {
    				    	VisitedArrays.splice(i, 1);
    				    }
    				}
    			}
    			visited.fn_visitedList();
    		}, fn_submit : function (){
    			
    			
    			
    		    	
    		   if (VisitedArrays.length < 1 ){
    			   $("#sp_message").text("방문자를 등록해주세요.");
				   $("#btn_result").trigger("click");
				   
    		   }
    		   
    		   var url = "/visit/VisitReserProcess.do";
    		   var parms = {"visitedReqName" : $("#visitedReqName").val(),
    				        "visitedReqCelphone" : $("#visitedReqCelphone").val(),
    				        "visitedReqOrg" : $("#visitedReqOrg").val(),
	    				    "centerId" : $("#centerId").val(),
	    				    "floorSeq" : $("#floorSeq").val(),
	    				    "visitedEmpno" : $("#visitedEmpno").val(),
	    				    "visitedResday" : $("#datePick").val().replaceAll("-",""),
	    				    "visitedRestime" : $("#visitedRestime1").val() + $("#visitedRestime2").val(),
	    				    "visitedPurpose" : $("#visitedPurpose").val(),
	    				    "visitedPerson" : VisitedArrays.length,
	    				    "visitedGubun" : "VISITED_GUBUN_1",
	    				    "visitedStatus" : "VISITED_STATE_1",
	    				    "visitedDetail" : VisitedArrays
    		   }
    		   
    		   uniAjax(url, parms, 
  		     			function(result) {
    			               //alert(result.status);
    			               
				               if (result.status == "SUCCESS"){
  						    	 $("#sp_message").text("정상적으로 등록 되었습니다.");
  							     $("#btn_result").trigger("click");
	   		  					 //location.href="/visit/Index.do";  
  		  					   }else {
  		  						 //$("#sp_message").text("등록중 애러가 발생 하였습니다.");
								 $("#sp_message").text("정상적으로 등록 되었습니다.");
 							     $("#btn_result").trigger("click");
								 
  		  					   }
  						},
  						function(request){
  							    alert("Error:" +request.status );	       						
  						}    		
   		      );
    			
    		}, fn_cellphoneCheck : function (_CellPhone){
    			//전화 번호 체크 하기 
    			var cellCheck = true;
    			for (var i = 0; i < VisitedArrays.length; i ++){
    				if (VisitedArrays[i].visitedCelphone == _CellPhone){
    					cellCheck =  false;
    					break;
    				}
    			}  
    			return cellCheck;
    		}, fn_userPop : function (){
    			//신청자 view 확인 
    			$("#visitedEqual").val() == "Y" ? $("#dv_checks").hide() : $("#dv_checks").show();
    		}, fn_submitCheck : function(){
    			//값 체크 이후 정리 하기 
    			if (any_empt_line_span("visitedReqName", "성명을 입력하세요.") == false) return true;	
    			if (any_empt_line_span("visitedReqCelphone", "휴대폰 번호를 입력하세요.") == false) return  true;	
    			if (any_empt_line_span("visitedReqOrg", "소속 업체명을 입력하세요.") == false) return  true;	
    			if (fn_Check("apply", "개인정보 수집 및 이용 동의는 필수입니다.") == false) return  true;
    			if (any_empt_line_span("centerId", "방문 지점을 선택하세요.") == false) return  true; 	
				if (any_empt_line_span("floorSeq", "방문층수를 선택하세요.") == false) return  true;	
				if (any_empt_line_span("visitedEmpno", "접견 대상자 명을 선택하세요.") == false) return  true;	
				if (any_empt_line_span("datePick", "방문 일자를 선택하세요.") == false) return  true;	
				if (any_empt_line_span("visitedRestime1", "방문시간을 선택하세요.") == false) return  true;	
				if (any_empt_line_span("visitedRestime2", "방문시간을 선택하세요.") == false) return  true;	
				if (any_empt_line_span("visitedPurpose", "방문 목적을 입력하세요.") == false) return  true;
				if (VisitedArrays.length < 1 ){
    			   $("#sp_message").text("방문자를 등록해주세요.");
				   $("#btn_result").trigger("click");
                   return  true;
			    }
				return false;
				
    		}, fn_empSearch : function (){
    			//사용자 검색 
    			if (any_empt_line_span("searchTxt", "검색할 내용을 입력 하지 않았습니다.") == false) return true;	
    			var url = "/visit/VisitEmpsearch.do";
    			var param = {"searchCondition" : $("#searchGubun").val()  , "searchKeyword" : $("#searchTxt").val()}
    			var returnVal = uniAjaxReturn(url, param);
    			if (returnVal.resultlist.length > 0){
			        var obj  = returnVal.resultlist;
				    $("#visitedEmpno").empty();
				    $("#visitedEmpno").append("<option value=''>선택</option>");
				    for (var i in obj) {
				        var array = Object.values(obj[i])
				        $("#visitedEmpno").append("<option value='"+ array[1]+"'>"+array[2]+"</option>");
				    }
				}else {
			      //값이 없을때 처리 
			       $("#sp_message").text("검색된 내역이 없습니다. 확인 후 다시 검색 부탁 드립니다.");
 				   $("#btn_result").trigger("click"); 
			       $("#visitedEmpno").empty();
			    }
    	    	 
    			
    		}  
       } 
       
    </script>
<body>
<form:form name="regist" commandName="regist" method="post">
<input type="hidden" id="uniCheck" />
<input type="hidden" id="visitedPerson" />
<input type="hidden" id="visitedEqual" />

<div class="wrapper sub_back">
        <!--//header 추가-->
        <c:import url="/visit/inc/top_inc.do" />
        <!--header 추가//-->
        <!--//contents-->
        <div class="contents">
            <h2 class="sub_tit">방문 신청하기</h2>
            <ul class="stepper linear">
                <!-- 신청자 정보입력 -->
                <li class="step active">
                    <!-- stepper 타이틀 -->
                   <div class="step-title waves-effect">신청자 정보입력</div>
                   <!-- stepper 내용 -->
                   <div class="step-content">
                        <div class="step-actions">
                            <div>
                                <p class="step_con_tit">신청자 정보를 입력하세요.</p>
                                <ul class="step_reser_list">
                                    <li>
                                        <input type="text" id="visitedReqName" name="visitedReqName" placeholder="성명을 입력하세요.">
                                    </li>
                                    <li>
                                        <input type="text" id="visitedReqCelphone" name="visitedReqCelphone" placeholder="휴대폰 번호를 입력하세요." onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                                    </li>
                                    <li>
                                        <input type="text" id="visitedReqOrg" name="visitedReqOrg" placeholder="소속 업체명을 입력하세요.">
                                    </li>
                                    <li>
                                        <div class="userApply">
                                            1. 수집·이용목적 : 서울관광플라자 출입 및 시설과 장비에 대한 예약을 위한 사용자 정보 수집 및 이용<br>
                                            2. 개인정보 수집 항목 : 이름, 소속, 휴대폰 번호(예약결과 안내 및 예약 조회시 시용)<br>
                                            3. 개인정보 보유 및 이용기간 : 시설 이용 후 1년간 정보 보관<br>
                                            4. 동의 거부 시 불이익에 관한 사항 : 수집·이용에 관한 사항의 동의를 거부할 때에는 예약 서비스의 이용이 제한됩니다.
                                        </div>
                                        <div class="checks">
                                            <input type="checkbox" id="apply"> 
                                            <label for="apply">(필수)개인정보보호 방침 동의</label> 
                                        </div>
                                    </li>
                                </ul>
                                <div class="step_bottom">
                                    <!-- Here goes your actions buttons -->
                                    <button type="button" class="waves-effect waves-dark btn" onClick="visited.fn_nextStep('1')" style="font-size: 1.6rem;background: #2196f3;color: #fff;border: none;padding: 7px 20px;"> 다음</button>
                                    <button class="waves-effect waves-dark btn next-step" id="btn_step01" style="display:none">다음</button>
                                </div>
                            </div>                         
                        </div>
                   </div>
                </li>
                <!-- 방문자 정보 입력  -->
                <li class="step">
                    <div class="step-title waves-effect">방문지 정보입력</div>
                    <div class="step-content">
                       <!-- Your step content goes here (like inputs or so) -->
                        <div class="step-actions">
                            <div>
                                <p class="step_con_tit">방문 정보를 입력하세요.</p>
                                <ul class="step_reser_list">
                                    <li>
                                        <select id="centerId" onChange="visited.fn_floorCombo()">
					                        <option value="">방문 회사</option>
					                         <c:forEach items="${centerInfo}" var="centerInfo">
					                            <option value="${centerInfo.centerId}">${centerInfo.centerNm}</option>
					                         </c:forEach>
					                    </select>
					                    
                                       
                                    </li>
                                    <li>
                                        <select id="floorSeq" name="floorSeq">
					                    </select>
                                    </li>
                                    <li>
										<div class="visitSearchForm">
											<select id="searchGubun" style="width:110px">
											   <option value="">선택</option>
											   <option value="emphandphone">전화번호</option>
											   <option value="empname">이름</option>
											</select>
											<input type="text" id="searchTxt" placeholder="검색할 내용을 입력하세요." style="width:calc(100% - 193px);">
											<a href="javascript:visited.fn_empSearch()" class="search_btn">검색</a>
										</div>
										<div class="visitSearchSel">
											<select id="visitedEmpno">
											   
											</select>
										</div>
										<span class="visitSearch_noti">※ 접견 대상자의 정보를 입력하여 선택하세요.</span>
                                    </li>
                                    <li>
                                       <input type="text" id="datePick" readonly="readonly" name="mainDate" value="today" class="datePicker">
                                    </li>  
                                    <li>
                                        <p class="apply_hint">방문 시간 선택</p>
                                        <div class="row">
                                            <div class="sm-6">
                                                <select id="visitedRestime1">
                                                    <option>09</option>   
                                                    <option>10</option>
                                                    <option>11</option>   
                                                    <option>12</option>   
                                                    <option>13</option>
                                                    <option>14</option>  
                                                    <option>15</option>   
                                                    <option>16</option>
                                                    <option>17</option>   
                                                    <option>18</option>                     
                                                </select>
                                            </div>
                                            <div class="sm-6">
                                                <select id="visitedRestime2">
                                                    <option>00</option>   
                                                    <option>10</option> 
                                                    <option>20</option>      
                                                    <option>30</option>                                
                                                    <option>40</option>      
                                                    <option>50</option>  
                                                </select>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </li> 
                                     <li>
                                        <input type="text" id="visitedPurpose" id="visitedPurpose" placeholder="방문 목적을 입력하세요">
                                    </li>
                                </ul>
                                <div class="step_bottom">
                                    <!-- Here goes your actions buttons -->
                                    <button type="button" onClick="visited.fn_nextStep('2')" style="font-size: 1.6rem;background: #2196f3;color: #fff;border: none;padding: 7px 20px;">다음</button>
                                    <button type="button" onClick="visited.fn_preStep('1')" style="font-size: 1.6rem; background: #808080;color: #fff;border: none;padding: 7px 20px;">이전</button>
                                    
                                    <button class="waves-effect waves-dark btn next-step" id="btn_step02" style="display:none">다음</button>
                                    <button class="waves-effect waves-dark btn-flat previous-step" id="btn_pre_step02"  style="display:none">이전</button>
                                </div>
                            </div>                 
                        </div>
                    </div>
                 </li>
                 <!-- 신청서 작성 -->
                <li class="step">
                    <div class="step-title waves-effect">신청서 작성</div>
                    <div class="step-content">
                        <!-- Your step content goes here (like inputs or so) -->
                        <div class="step-actions">
                            <div>
                                <p class="step_con_tit">방문자를 등록해주세요.</p>
                                <div class="apply_top">
                                    <button class="add_btn" type="button" data-needpopup-show="#apply_mem" onClick="visited.fn_userPop();">등록</button>
                                    <button class="del_btn" type="button" onClick="visited.fn_userDel()">제거</button>
                                </div>
                                <div class="table-block">
                                    <table class="apply_table table-block" id="tb_visitedPersonDetail">
                                        <thead>
                                            <tr>
                                                <th><input type="checkbox" id="allCheck" name="allCheck" value="all" onClick="visited.fn_allCheck()"></th>
                                                <th>방문자</th>
                                                <th>휴대폰</th>
                                                <th>업체</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           
                                        </tbody>
                                    </table>
                                </div>
                                <div class="step_bottom">
                                    <!-- Here goes your actions buttons --> 
                                    <!-- 입력 정보 미 입력 시 완료 버튼 disabled-->
                                    <button id="btn_submit" class="waves-effect waves-dark btn apply-btn" disabled onClick="visited.fn_submit();">완료</button>
                                    <button class="waves-effect waves-dark btn-flat previous-step">이전</button>
                                </div>
                            </div>                 
                        </div>
                    </div>
                 </li>
             </ul>
                
        </div>
    </div>
    <!-- 팝업 -->
    <!--// 방문자 추가 -->
    <div id='apply_mem' class="needpopup">
        <div class="reser_noti_pop">            
            <div class="pop_header">
                <p>방문자 등록</p>
            </div>
            <div class="pop_con">
                <div class="checks" id="dv_checks">
                    <input type="checkbox" id="user" onChange="visited.fn_equalCheck()"> 
                    <label for="user">신청자와 동일</label> 
                </div>
                <div>
                    <ul class="step_reser_list">
                        <li>
                            <input type="text" id="visitedName" id="visitedName" placeholder="성명을 입력하세요.">
                        </li>
                        <li>
                            <input type="text" id="visitedCelphone" id="visitedCelphone" placeholder="휴대폰 번호를 입력하세요.">
                        </li>
                        <li>
                            <input type="text" id="visitedOrg" id="visitedOrg" placeholder="업체명을 입력하세요.">
                        </li>  
                        <li>
                            <p class="apply_hint">* 유료 발렛 주차 가능 (1시간 8천원)</p>
                        </li>                      
                    </ul>
                </div>
                <div class="pop_footer">
                    <button type="button" onClick="visited.fn_userAdd()">등록하기</button:>
                </div>
            </div>
        </div>
    </div> 
    
    <!--// 예약 완료 //예약 완료 및 실패 등 간략한 noti알림 팝업-->
    
    <div id='ok_reserve' class="needpopup reser_noti">
        <div class="reser_noti_pop">            
           <span id="sp_message"></span>
        </div>
    </div> 
    <button type="button" id="btn_result" style="display:none" data-needpopup-show='#ok_reserve'>경고창 보여 주기</button>
    
    <!-- stepper 추가 -->
    <script>
        var stepper = document.querySelector('.stepper');
        var stepperInstace = new MStepper(stepper, {
            // options
            firstActive: 0 // this is the default
        })

    </script>
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
 </form:form>
</body>
</html>