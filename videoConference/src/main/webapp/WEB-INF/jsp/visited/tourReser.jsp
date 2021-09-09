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
</head>
<body>
<div class="wrapper sub_back">
        <!--//header 추가-->
        <c:import url="/visited/inc/top_inc.do" />
        <!--//contents-->
        <div class="contents">
            <h2 class="sub_tit">서울관광플라자 투어 신청서</h2>
            <div class="tourInfo">
                <p class="font-bold">○ 서울관광플라자 투어 소개</p>
                                     서울관광플라자 투어는 서울관광플라자 내 공간 소개(*지상 1층, 4~11층) 및 서울관광을 체험하는 프로그램으로 진행됩니다.<br>
                                     서울관광플라자 투어를 희망하는 분들은 아래 신청서 작성 후 제출해주시면,
                                     담당자가 확인 후 유선으로 안내드립니다. <br>
                 * 지상 1층은 별도 신청 없이 자유롭게 방문하실 수 있습니다.<br><br> 

                <p class="font-bold">○ 8월 투어 신청 가능일자 및 인원</p>
                <c:forEach items="${tourInfo }" var="tourInfo" varStatus="status">
                - ${tourInfo.tourday } ${tourInfo.code_nm } / ${tourInfo.cnt }명<br>
                </c:forEach>
                                           ※ 사회적 거리두기 4단계 지속 시 운영 중단될 수 있음<br><br>

                <p class="font-bold">○ 유의사항</p>
                - 8월 정기투어는 기존과 동일하게 진행되나, 코로나19 수도권 사회적 거리두기 4단계 지속 연장 시 운영이 중단될 수 있습니다.<br>
                - 원활한 투어 진행을 위해 회차별 최대 10명을 모집하여 진행하므로, 투어 시 여러팀이 함께 동행하는 점 양해 바랍니다.<br>
                - 동일한 일자 및 시간대에 투어가 접수될 경우, 접수시간을 기준으로 가장 먼저 접수된 건부터 투어가 진행됩니다.<br>
                                           ※위 상황의 경우, 일정 조정을 위해 담당자가 유선으로 개별 연락드립니다. <br>
                - 많은 분들이 투어를 받으실 수 있도록 가급적이면 일정 변경을 지양해주시고, 부득이한 사정으로 신청 취소 및 일정 변경을 희망하시면 유선으로 연락 바랍니다. (☎02-3788-8172)<br>
                - 투어는 정각에 진행되며, 정각 이후에는 중도 합류만 가능합니다. 많은 인원이 함께 동행하는 만큼 반드시 시간을 준수하여 주시기 바랍니다.<br>
                - 실시간으로 투어 예약 취소가 반영되므로, 투어 신청 가능일자 및 인원이 변동되는 점 양해 바랍니다.<br>
                - 코로나19 등 감염병으로 인해 투어 일정 변경 또는 취소될 수 있는 점 많은 양해 바랍니다.<br>
            </div>
            <h2 class="sub_tit">투어 신청 절차</h2>
            <div class="tourInfo">
                <div class="tourStep">
                    <ul>
                        <li>
                            <p>01</p>
                            <span>투어 신청서 작성</span>
                        </li>
                        <li>
                            <p>02</p>
                            <span>담당자 신청서 확인</span>
                        </li>
                        <li>
                            <p>03</p>
                            <span>투어 일정 확정</span>
                        </li>
                        <li>
                            <p>04</p>
                            <span>투어 안내</span>
                        </li>
                    </ul>                    
                </div>    
                <table class="tour_table">
                    <tbody>
                        <tr>
                            <th>진행방식</th>
                            <td>정기투어</td>
                        </tr>
                        <tr>
                            <th>진행일자</th>
                            <td>매월 2,4번째 금용일(공휴일 제외) <br>※ 상황에 따라 투어 진행 일정은 변경될 수 있습니다.</td>
                        </tr>
                        <tr>
                            <th>투어시간</th>
                            <td>오후 2시, 4시</td>
                        </tr>
                        <tr>
                            <th>신청인원</th>
                            <td>10명 이내</td>
                        </tr>
                        <tr>
                            <th>소요시간</th>
                            <td>약 30분~1시간 이내</td>
                        </tr>
                        <tr>
                            <th>유선 및 메일 문의</th>
                            <td>관광플라자팀 02-3788-8172 / plaza@sto.or.kr</td>
                        </tr>
                    </tbody>
                </table>
                <span>※ 매월 2,4 번째 금요일 투어 진행</span>            
            </div>
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
                                        <input type="text" id="visitedReqName" name="visitedReqName" placeholder="성명을 입력하세요. *">
                                    </li>
                                    <li>
                                        <input type="text" id="visitedReqCelphone" name="visitedReqCelphone" placeholder="휴대폰 번호를 입력하세요. *">
                                    </li>
                                    <li>
                                        <input type="text" id="visitedReqOrg" name="visitedReqOrg" placeholder="소속 업체명을 입력하세요.">
                                    </li>
                                    <li>
                                        <div class="checks">
                                            <input type="checkbox" id="visitedGroupCheck" name="visitedGroupCheck" value="Y"> 
                                            <label for="visitedGroupCheck">단체예약</label> 
                                        </div>
                                        <input type="text" id="visitedGroupName" name="visitedGroupName" placeholder="단체명을 입력하세요.">
                                    </li>
                                    <li>
                                        <div class="userApply">
                                            1. 개인정보 수집 이용 목적: 서울관광플라자 투어 예약<br>2. 수집하려는 개인정보 항목: 회사명, 성명, 전화번호, 휴대폰번호, 이메일<br>3. 개인정보 보유 기간: 1년 <br>4. 정보주체는 본인의 개인정보 수집･이용의 동의를 거부할 권리가 있습니다. 단, 개인정보 수집･이용에 동의하지 않을 경우에는 예약이 불가할 수 있습니다.
                                        </div>
                                        <div class="checks">
                                            <input type="checkbox" id="apply"> 
                                            <label for="apply">(필수) 개인정보보호방침</label> 
                                        </div>
                                    </li>
                                </ul>
                                <div class="step_bottom">
                                    <!-- Here goes your actions buttons -->
                                    <button type="button" class="waves-effect waves-dark btn" onClick="visited.fn_nextStep('1')" > 다음</button>
                                    <button class="waves-effect waves-dark btn next-step" id="btn_step01" style="display:none">다음</button>
                                </div>
                            </div>                         
                        </div>
                   </div>
                </li>
                <!-- 방문자 정보 입력  -->
                <li class="step">
                    <div class="step-title waves-effect">신청서 작성</div>
                    <div class="step-content">
                       <!-- Your step content goes here (like inputs or so) -->
                        <div class="step-actions">
                            <div>
                                <p class="step_con_tit">투어 신청서를 입력하세요.</p>
                                <ul class="step_reser_list">
                                    <li>
                                        <p class="apply_hint">투어 날짜 선택</p>
                                           <select id="visitedResday" name="visitedResday" title="투어 날짜" onChange="visited.fn_tourCheck()">
                                              <option value="">투어 일자</option>
						                      <c:forEach items="${tourCombo}" var="tourCombo">
						                            <option value="${tourCombo.tourday}">${tourCombo.tourday}</option>
						                      </c:forEach>
                                           </select>
                                         
                                        <p class="apply_hint">
                                                                                                                   ※ 투어는 매월 두 번째, 네 번째 금요일 오후 2시 및 4시에 진행되며(공휴일 제외), 상황에 따라 일정은 변경될 수 있습니다.
                                        </p>
                                    </li>
                                    <li>
                                        <p class="apply_hint">투어 시간/참여인원</p>
                                        <div class="row">
                                            <div class="sm-6">
                                                <select id="visitedRestime" name="visitedRestime" title="투어 날짜" onChange="visited.fn_tourCheck()">
		                                              <option value="">종료 층수</option>
								                      <c:forEach items="${selectTourGubun}" var="selectTourGubun">
								                            <option value="${selectTourGubun.codeDc}">${selectTourGubun.codeNm}</option>
								                      </c:forEach>
	                                            </select>
                                            </div>
                                            <div class="sm-6">
                                                <select id="visitedPerson" name="visitedPerson" title="참여 인원" onChange="visited.fn_tourCheck()">
		                                              <option value="">없음</option>
								                      <option value="1">1명</option>
								                      <option value="2">2명</option>
								                      <option value="3">3명</option>
								                      <option value="4">4명</option>
								                      <option value="5">5명</option>
								                      <option value="6">6명</option>
								                      <option value="7">7명</option>
								                      <option value="8">8명</option>
								                      <option value="9">9명</option>
								                      <option value="10">10명</option>
	                                            </select>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </li> 
                                    <li>
                                        <input type="text" id="visitedPurpose" name="visitedPurpose" placeholder="어떤 경로를 통해 서울관광플라자 정기투어를 접하게 되셨나요?">
                                    </li>
                                    <li>
                                        <input type="text" id="visitedRemark" name="visitedRemark" placeholder="기타 및 문의사항">
                                    </li>
                                </ul>
                                <div class="step_bottom">
                                    <!-- Here goes your actions buttons -->
                                    <button id="btn_submit" class="waves-effect waves-dark btn apply-btn" data-needpopup-show="#visit_reser" disabled onClick="visited.fn_submit();">완료</button>
                                    <button class="waves-effect waves-dark btn-flat previous-step">이전</button>
                                </div>
                            </div>                 
                        </div>
                    </div>
                 </li>
             </ul>   
             <div class="clear"></div>               
        </div>
    </div>
    <!-- 팝업 -->    
    <!--// 예약 완료 //예약 완료 및 실패 등 간략한 noti알림 팝업-->
    <div id='visit_reser' class="needpopup reser_noti">
        <div class="reser_noti_pop">            
        <span id="sp_message"></span>
        </div>
    </div> 

    
    <!-- stepper 추가 -->
    <script>
        var stepper = document.querySelector('.stepper');
        var stepperInstace = new MStepper(stepper, {
            // options
            firstActive: 0 // this is the default
        })
        var visited = {
    		fn_nextStep  : function(_step){
    			if (_step == "1"){
    				if (any_empt_line_span("visitedReqName", "성명을 입력하세요.") == false) return;	
        			if (any_empt_line_span("visitedReqCelphone", "휴대폰 번호를 입력하세요.") == false) return;	
        			if (any_empt_line_span("visitedReqOrg", "소속 업체명을 입력하세요.") == false) return;	
        			if($('visitedGroupCheck').is(":checked") == true){
        		    	if (any_empt_line_span("visitedGroupName", "단체명을 입력해 주세요.") == false) return;
        		    }
        			if (fn_Check("apply", "개인정보 수집 및 이용 동의는 필수입니다.") == false) return;
        		}
    			$("#btn_step0"+_step).click();
    			
    		}, fn_preStep : function (_step){
    			$("#btn_pre_step0"+_step).click();
    		}, fn_submit : function (){
    			
    		   var url = "/visited/visitReserProcess.do";
    		   var parms = {"visitedReqName" : $("#visitedReqName").val(),
    				        "visitedReqCelphone" : $("#visitedReqCelphone").val(),
    				        "visitedReqOrg" : $("#visitedReqOrg").val(),
	    				    "visitedResday" : $("#visitedResday").val(),
	    				    "visitedRestime" : $("#visitedRestime").val(),
	    				    "visitedGroupName" : $("#visitedGroupName").val(),
	    				    "visitedGroupCheck" : visited.fn_checkVal("visitedGroupCheck"),
	    				    "visitedPurpose" : $("#visitedPurpose").val(),
	    				    "visitedRemark" :  $("#visitedRemark").val(),
	    				    "visitedPerson" :  $("#visitedPerson").val(),
	    				    "visitedGubun" : "VISITED_GUBUN_2",
	    				    "visitedStatus" : "VISITED_STATE_1"
    		   }
    		   
    		   uniAjax(url, parms, 
  		     			function(result) {
  						       if (result.status == "SUCCESS"){
  						    	 $("#sp_message").text("정상적으로 등록 되었습니다.");
  							     $("#btn_result").trigger("click");
	   		  					 location.href="/visited/index.do";  
  		  					   }else {
  		  						 $("#sp_message").text(result.message);
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
    			if($('visitedGroupCheck').is(":checked") == true){
    		    	if (any_empt_line_span("visitedGroupName", "단체명을 입력해 주세요.") == false) return;
    		    }
    			if (any_empt_line_span("visitedResday", "방문 일자를 선택하세요.") == false) return  true;	
				if (any_empt_line_span("visitedRestime", "방문시간을 선택하세요.") == false) return  true;	
				
				return false;
				
    		}, fn_empSearch : function (){
    			//사용자 검색 
    			
    		}, fn_tourCheck : function(){
    			$("#btn_submit").attr('disabled', visited.fn_submitCheck());
    		}, fn_checkVal : function(_checkNm){
    			return ($("#"+_checkNm).is(":checked") == true) ? "Y" : "N";
    		}
       } 
    </script>
    <!--popup-->
    <script src="../js/needpopup.min.js"></script> 
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
</body>
</html>