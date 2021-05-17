<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css"> 
    
    
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    
    <link rel="stylesheet" href="/css/new/jquery-ui.css">
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    <script type="text/javascript" src="/js/common_res.js"></script>
    
    <script>
    $(function () {
        var clareCalendar = {
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            weekHeader: 'Wk',
            dateFormat: 'yymmdd', //형식(20120303)
            autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
            changeMonth: true, //월변경가능
            changeYear: true, //년변경가능
            showMonthAfterYear: true, //년 뒤에 월 표시
            buttonImageOnly: true, //이미지표시
            buttonText: '달력선택', //버튼 텍스트 표시
            buttonImage: '/images/invisible_image.png', //이미지주소
            yearRange: '1970:2030' //1990년부터 2020년까지
        };	       
        $("#searchStartDay").datepicker(clareCalendar);
        $("#searchEndDay").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});	
    </script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/resManage/resList.do">
<jsp:useBean id="nowDate" class="java.util.Date" />
<c:set var="sysday"><fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /></c:set>
<c:set var="systime"><fmt:formatDate value="${nowDate}" pattern="HH:mm" /></c:set>



<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">

<input type="hidden" name="delResSeq" id="delResSeq">
<input type="hidden" name="hid_equpState" id="hid_equpState">

<input type="hidden" name="mode" id="mode">
<input type="hidden" name="searchRoomType" id="searchRoomType" value="${regist.searchRoomType}">

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span><spring:message code="menu.menu03" /> 
                        <span>></span><strong><spring:message code="menu.menu03_1" /></strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">
                
                
                <spring:message code="page.common.pageCusCnt"  arguments="${totalCnt}, 예약정보가"/>
                </div>
                <section class="Bclear">
	                <table class="pop_table searchThStyle">
		                <tr class="tableM">
			                <th style="width:90px;">
			                	기간
			                </th>
	                   			<td colspan="3" style="text-align:left;padding-left: 20px;">
	                   			   
	                   			    
	                   			    <input type="radio" id="searchDayGubun" name="searchDayGubun" value="REG_DATE" <c:if test="${regist.searchDayGubun == 'REG_DATE' }"> checked </c:if>  />
					                <label>신청일</label>
				                    <input type="radio" id="searchDayGubun" name="searchDayGubun" value="RES_STARTDAY" <c:if test="${regist.searchDayGubun == 'RES_STARTDAY' }"> checked </c:if> />
				                    <label>예약일 </label> 
				                	&nbsp;&nbsp;&nbsp;&nbsp;
				                	<form:input  path="searchStartDay" size="10" maxlength="20" id="searchStartDay" style="cursor:default;" class="date-picker-input-type-text" readonly="true" value="${regist.searchStartDay }" />
				                     ~
				                    <form:input  path="searchEndDay" size="10" maxlength="20" id="searchEndDay" style="cursor:default;"  class="date-picker-input-type-text" readonly="true" value="${regist.searchEndDay }" />
		                		</td>
		                	<th style="width:90px;">검색어</th>
		                	<td colspan="5"  style="text-align:left;padding-left: 20px;">
		                		<select name="searchCondition"  id="searchCondition">
									<option value="c.SEAT_NAME" <c:if test="${regist.searchCondition == 'c.SEAT_NAME' }"> selected="selected" </c:if>>회의실</option>
									<option value="b.EMP_NO" <c:if test="${regist.searchCondition == 'b.EMP_NO' }"> selected="selected" </c:if>>사번</option>
									<option value="b.EMP_NM" <c:if test="${regist.searchCondition == 'b.EMP_NM' }"> selected="selected" </c:if>>이름</option>
								</select>
								<input class="nameB " type="text" name="searchKeyword" id="searchKeyword"   size="20"  maxlength="30" value="${regist.searchKeyword}"   onkeydown="if(event.keyCode==13){search_form();}">
		                	</td>
		                	
		                	<td rowspan="2" class="border-left" style="width:70px">
			                    <a href="javascript:search_form();"><span class="searchTableB">조회</span></a>
		                	</td>
						</tr>
						<tr>  
		                	<th>회의실별</th>
		                	<td style="text-align:left;padding-left: 20px;">
		                		<form:select path="searchCenterId" id="searchCenterId" title="회의실구분">
								         <form:option value="" label="회의실구분"/>
				                         <form:options items="${searchCenterId}" itemValue="centerId" itemLabel="centerNm"/>
						    	</form:select>	
		                	</td>
		                	<th>승인구분</th>
				            <td style="text-align:left;padding-left: 20px;">
			                    <select name="searchProxyYn"  id="searchProxyYn">
									<option value="">승인/구분</option>
									<option value="S" <c:if test="${regist.searchProxyYn == 'S' }"> selected="selected" </c:if>>본인</option>
									<option value="P" <c:if test="${regist.searchProxyYn == 'P' }"> selected="selected" </c:if>>승인자 지정</option>
								</select>
							</td>
		                	<th>부서별</th>
		                	<td style="text-align:left;padding-left: 20px;">
		                		<form:select path="searchOrgId" id="searchOrgId" title="부서구분" style="width:120px;">
								         <form:option value="" label="부서구분"/>
				                         <form:options items="${selectOrg}" itemValue="deptcode" itemLabel="deptname"/>
						    	</form:select>
		                	</td>
		                	<th>결재상태별</th>
		                	<td colspan="3">
		                		<form:select path="searchReservProcessGubun" id="searchReservProcessGubun" title="결재상태">
							    	<form:option value="" label="결재상태"/>
				                    <form:options items="${selectProcessType}" itemValue="code" itemLabel="codeNm"/>
							    </form:select>
		                	</td>
		                	
		                </tr>   
                    </table>
                </section>
                <div class="rightB magin-bottom20">
                	  <!-- <a href="javascript:fn_ResCheck('C');"><span class="grayBtn">예약취소</span></a> -->
                      <a href="javascript:fn_ExcelDown();"><span class="deepBtn">엑셀다운</span></a>
                </div>
                <div class="clear"></div>
            </div>

            <div class="Swrap tableArea"> 
                <table class="backTable font14">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>부서</th>
                            <th>이름</th>
                            <th>사번</th>
                            <th>연락처</th>
                            <th>예약사무소</th>
                            <th>회의실명</th>
                            <th>회의구분</th>
                            <th>회의제목</th>
                            <th>비공개여부</th>
                            <th>참여인원</th>
                            <th>신청일</th>
                            <th>예약일자</th>
                            <th>결제상태</th>
                            <th>관리자승인</th>
                            <th>비품승인</th>
                        </tr>
                    </thead>
                    <tbody>
                       <c:forEach items="${resultList}" var="resInfo" varStatus="status">
                        <tr>
                            <td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
                            <td>${resInfo.deptname }</td>
                            <td>${resInfo.empname }</td>
                            <td>${resInfo.userId }</td>
							<td>${resInfo.empmail }</td>
							<td>${resInfo.centerNm }</td>
							<td>${resInfo.seatName }</td>
					   		<td>${resInfo.resGubunTxt }</td>
					   		<td><a href="#"   onclick="fn_resinfo('${resInfo.resSeq }')"   data-needpopup-show="#resInfoPop">${resInfo.resTitle }</a></td>
					   		<td>${resInfo.resPassTxt }</td>
							<td>${resInfo.attendListTxt }</td>
							<td>${fn:substring(resInfo.regDate,0,10) }</td>
							<td>${resInfo.resStartday } 
							    ${resInfo.resStarttime }~${resInfo.resEndtime }
							</td>
							<td>${resInfo.reservProcessGubunTxt }</td>
							<td>
							    <c:choose>
							       <c:when test="${(resInfo.reservProcessGubun == 'PROCESS_GUBUN_1' || resInfo.reservProcessGubun == 'PROCESS_GUBUN_2'
							                        || resInfo.reservProcessGubun == 'PROCESS_GUBUN_4' )}">
							               <select name="reservProcessGubun_${resInfo.resSeq}"  id="reservProcessGubun_${resInfo.resSeq}" onchange="javascript:change_process('reservProcessGubun_${resInfo.resSeq}', '${resInfo.resSeq}');">
							                    <option value="">관리자 승인여부</option>
												<c:forEach var="code" items="${selectProcessTypeAdmin}" varStatus="status2">
													<option value="<c:out value="${code.code }" />" 
													<c:if test="${resInfo.reservProcessGubun == 'resProcess05' }">disabled="disabled"</c:if>
													<c:if test="${resInfo.reservProcessGubun == code.code }">selected="selected"</c:if>>
														<c:out value="${code.codeNm }" />
													</option>
												</c:forEach>
											</select>
							       </c:when>
							       <c:otherwise>
							           ${resInfo.reservProcessGubunTxt }
							       </c:otherwise>
							    </c:choose>
							</td>
							<td>
							<c:choose>
							    <c:when test="${resInfo.equipType01 eq 'Y'  }">
							     마이크 사용<Br/>
							     </a>
							    </c:when>
							</c:choose>
							<c:choose>
							    <c:when test="${resInfo.equipType02 eq 'Y'  }">
							     스크린 사용
							     </a>
							    </c:when>
							</c:choose>  
							
							</td>
                        </tr>
                        
                       </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="pagenum">
                <div class="pager">
                	<ol>
                		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
                   </ol>
                </div>
            </div>
        </div>
    </div>
<c:import url="/backoffice/inc/bottom_inc.do" /> 
<!--  장비 요청 팝업 -->

<div id='equipPop' class="needpopup">
        <div class="popHead">
            <h2>대여 현황</h2>
        </div>
        
        <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">장비를 선택 후 상태 변경 버튼을 클릭 하세요.</span>
             <a href="javascript:fn_equpChange('EQUIP_STATE_2');" class="redBtn" id="btnRental">장비 대여</a> 
             <a href="javascript:fn_equpChange('EQUIP_STATE_1');" class="redBtn" id="btnReturn">대여 반납</a>    
             <a href="javascript:fn_equpChange('EQUIP_STATE_5');" class="redBtn" id="btnCancel">장비 취소</a>    
            <div class="clear"></div>
        </div>
        
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box100">
                <div class="padding15" style="background-color:white">
                    <table class="pop_table thStyle" id="tb_equip">
                       <thead>
                          <tr>
                               <td><input type="checkbox" id="allCheck" />전체선택</td>
                               <td>장비명</td>
                               <td>시리얼번호</td>
                               <td>상태</td>
                          </tr>
                       </thead>
                       <tbody>
                       </tbody>
                     </table>
                </div>                
            </div>
            <div class="clear"></div>   
        </div>           
    </div> 
<!--  장비 요청 팝업 끝 부분-->

<!--  예약 정보 상세 팝업 -->


        <div id='resInfoPop' class="needpopup">
        <div class="popHead">
            <h2>예약 현황</h2>
        </div>
        
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box100">
                <div class="padding15" style="background-color:white">
                    <table class="pop_table thStyle">
				<tbody class="search">
				 <tr>
				  <th>회의 제목</th>
				  <td colspan="3"><span id="sp_resTitle"></span></td>
				 </tr>
				 <tr>
				   <th>회의장소</th>
				   <td><span id="sp_seatName"></span></td>
				   <th>회의일자</th>
				   <td><span id="sp_resStartday"></span>  </td>
				 </tr>
				 <tr>
				   <th>회의구분</th>
				   <td><span id="sp_resGubunTxt"></span></td>
				   <th>진행상태</th>
				   <td><span id="sp_reservProcessGubunTxt"></span>   </td>
				 </tr>
				  <tr  id="tr_swcGubun">
				   <th>참여 회의실</th>
				   <td colspan="3">
				      <span id="sp_meegintRoomInfo"></span>
				   </td>
				 </tr>
				 <tr>
				   <th>신청자</th>
				   <td><span id="sp_empname"></span>  </td>
				   <th>연락처</th>
				   <td> <span id="sp_empmail"></span> </td>
				 </tr>
				 <tr>
				   <th>승인구분</th>
				   <td><span id="sp_proxyYnTxt"></span></td>
				   <th>승인자</th>
				   <td><span id="sp_proxyUserId"></span>  </td>
				 </tr>
				 <tr>
				   <th>결제상태</th>
				   <td> <span id="sp_reservProcessGubunTxt"></span></td>
				   <th>참석자</th>
				   <td><span id="sp_attendListTxt"></span>   </td>
				 </tr>
				 <tr>
				   <th>참석자 상세</th>
				   <td colspan="3">
				    <span id="sp_resAttendInfo"></span>
				   
				   </td>
				 </tr>
			
				 <tr id="tr_cancel">
				   <th>취소유형</th>
				   <td><span id="sp_cancelCodeTxt"></span>
				   </td>
				   <th>취소 사유</th>
				   <td><span id="sp_cancelReason"></span>
				   </td>
				 </tr>
			
				</tbody>
			</table>
                </div>                
            </div>
            <div class="clear"></div>   
        </div>           
    </div> 

<!--  예약 정보 상세 팝업 끝-->
</form:form>
<script src="/js/needpopup.js"></script> 
<script src="/js/jquery-ui.js"></script>
</div>
 <script type="text/javascript">
    $(document).ready(function() {					   
	});	  
    
    function fn_resinfo(resSeq){
       var params =  {"resSeq" : resSeq};
       uniAjaxSerial("/backoffice/resManage/resInfoAjax.do?resSeq="+resSeq, params, 
 	  			function(result) {
 					       if (result.status == "LOGIN FAIL"){
 					    	    alert(result.message);
 								location.href="/backoffice/login.do";
 						   }else if (result.status == "SUCCESS"){
	 							var obj = result.resInfo;
	 							$("#sp_resTitle").html(obj.resTitle);
	 							$("#sp_seatName").html(obj.seatName);
	 							$("#sp_resStartday").html(obj.sp_resStartday + "  " + obj.resStarttime +"~"+ obj.resEndtime);
	 							
	 							
	 							$("#sp_resGubunTxt").html(obj.resGubunTxt);
	 							$("#sp_reservProcessGubunTxt").html(obj.reservProcessGubunTxt);
	 							$("#sp_empname").html(obj.empname);
	 							$("#sp_empmail").html(obj.empmail);
	 							$("#sp_proxyYnTxt").html(obj.proxyYnTxt);
	 							$("#sp_proxyUserId").html(obj.proxyUserId);
	 							$("#sp_reservProcessGubunTxt").html(obj.reservProcessGubunTxt);
	 							$("#sp_attendListTxt").html(obj.attendListTxt);
	 							
	 							$("#sp_attendListTxt").html(obj.attendListTxt);
	 							$("#sp_attendListTxt").html(obj.attendListTxt);
	 							var arr = ["PROCESS_GUBUN_3", "PROCESS_GUBUN_5", "PROCESS_GUBUN_6",  "PROCESS_GUBUN_7" ];
	 							if (arr.indexOf(obj.reservProcessGubun)   ){
	 								$("#tr_cancel").show();
	 								$("#sp_cancelCodeTxt").html(obj.cancelCodeTxt);
	 								$("#sp_cancelReason").html(obj.cancelReason);
	 							}else {
	 								$("#tr_cancel").hide();
	 							}
	 							if (obj.resGubun == "SWC_GUBUN_2"){
									if (result.resRoomInfo != undefined){
										$("#tr_swcGubun").show();
										var meetingInfoTxt = "동시 진행할 영상회의실: ";
										if (result.resRoomInfo.length > 0){
											for (var i =0; i < result.resRoomInfo.length; i++){
												var meetinginfo = result.resRoomInfo[i];
												meetingInfoTxt += "<span style='padding-left: 10px;'>※"+meetinginfo.seatName+"</span>";
											}
											$("#div_meetingResRoomInfo").show();
											$("#sp_meegintRoomInfo").html(meetingInfoTxt);
										}
									}
          						}else{
          							$("#tr_swcGubun").hide();
          						}
	 							
	 							if (result.resUserList.length > 0){
          							var userInfoTxt = "예약자: "+ obj.empname+"("+obj.deptname+ ") 참석자: ";
									if (obj.resPassword == "Y"){
          								for (var i=0; i < result.resUserList.length; i++){
        							  		var userInfos = result.resUserList[i];
        							  	    userInfoTxt += "<span style='padding-left: 10px;'>"+userInfos.empname+"("+userInfos.deptname+")</span>";
        							  	}	
          							}else {
          								userInfoTxt += "*****************";
          							}
          							$("#sp_resAttendInfo").html(userInfoTxt);
          						} 
 						   }else {
 							   alert(result.message);
 						   }
 					    },
 					    function(request){
 						    alert("Error:" +request.status );	       						
 					    }    		
 	      );
		
    } 
    function fn_equpChange(resEqupcheck){
    	var resEqupinfo = ckeckboxValue( "선택 하신 내용이 없습니다","equipCode");
    	
    	var params = {"resSeq" :  $("#delResSeq").val(), "resEqupcheck" : resEqupcheck, "resEqupinfo" :  resEqupinfo};
    	uniAjax("/backoffice/resManage/resEquChange.do", params, 
 	  			function(result) {
 					       if (result.status == "LOGIN FAIL"){
 					    	    alert(result.message);
 								location.href="/backoffice/login.do";
 						   }else if (result.status == "SUCCESS"){
	 							  alert("정상적으로 처리 되었습니다");
	 							  localtion.reload();
	 							  
 						   }else {
 							   alert(result.message);
 						   }
 					    },
 					    function(request){
 						    alert("Error:" +request.status );	       						
 					    }    		
 	      );
    }
    function fn_EqupStateView(resCode, equipList, resEqupcheck){
    	$("#delResSeq").val(resCode);
    	$("#hid_equpState").val(resEqupcheck);
    	if ( resEqupcheck == "RES_EQUPCHECK_4"){
    		$("#btnRental").hide();
    		$("#btnCancel").hide();
    		$("#btnReturn").show();
    	}else{
    		$("#btnRental").show();
    		$("#btnCancel").show();
    		$("#btnReturn").hide();
    	}
    	var params = {"resSeq" :  resCode, "resEqupinfo" : equipList };
    	uniAjax("/backoffice/res/resEquipChange.do", params, 
 	  			function(result) {
 					       if (result.status == "LOGIN FAIL"){
 					    	    alert(result.message);
 								location.href="/backoffice/login.do";
 						   }else if (result.status == "SUCCESS"){
	 							  $("#tb_equip > tbody").empty(); 
	 							  var setHtml = "";
		    	            	  for (var i = 0; i < result.resList.length ; i++){
		    	            	  var obj = result.resList[i];
		    	            	       setHtml = "<tr><td><input type='checkbox' name='equipCode' value='"+ obj.equp_code+"'></td>"
	    	      					               + "<td>"+obj.equipment_name +"</td>"
	    	      					             + "<td>"+obj.equipment_name +"</td>"
	    	      					               + "<td>"+obj.equip_state_txt +"</td></tr>";
		    	            				$("#tb_equip >  tbody:last").append(setHtml);	
		    	            		}
 						   }else {
 							   alert(result.message);
 						   }
 					    },
 					    function(request){
 						    alert("Error:" +request.status );	       						
 					    }    		
 	      );
    }
    var pop_up;
    function change_process(code, seq){
    	
    	$('input[id="resCode"]:checked').each(function(){
  			 seqArr += "," + $(this).val();
  		 })
  		 
		if (confirm( "승인여부를 변경 하시겠습니까?")== true){
			if($("#"+code+"").val() == "PROCESS_GUBUN_5" ){
				var url ="/backoffice/popup/reasonPop.do?resSeq="+seq;
	  			pop_up = NewWindow(url, 'name', '550', '550', 'yes');
			}else {
				 var params = {'resSeq': seq, 'cancelCode': '', 
	    				       'reservProcessGubun' : $("#"+code+"").val(), 'cancelReason' : ''
	    		              };
	    	     uniAjax("/backoffice/res/reservationProcessChange.do", params, 
	    	  			function(result) {
	    					       if (result.status == "LOGIN FAIL"){
	    					    	    alert(result.message);
	    								location.href="/backoffice/login.do";
	    						   }else if (result.status == "SUCCESS"){
	    							    alert(result.message);
	    							    location.reload();
	    						   }else {
	    							   alert(result.message);
	    						   }
	    					    },
	    					    function(request){
	    						    alert("Error:" +request.status );	       						
	    					    }    		
	    	      );
			}
		  	
   		}else{
   			document.location.reload();
   		}
    	
    }
    function search_form(){
    	if ($("#searchStartDay").val() > $("#searchEndDay").val()) {
    		alert("시작일이 종료일 보다 빠를수 없습니다.");
    		return;
    	}
    	
    	$(":hidden[name=pageIndex]").val("1");				
		$("form[name=regist]").attr("action", "/backoffice/resManage/resList.do").submit();
    }   
    function fn_ExcelDown(){    	
    	$("form[name=regist]").attr("action", "/backoffice/res/resListExcel.do").submit();
    }
    function cancel_check(){
    	//예약을취소하시겠습니까? confirm
    	var cnt = $("input[name=resCode]:checkbox:checked").length;
		var del_atch = "";
		var insert_resCode = "";
		if (cnt < 1) {
			alert("하나 이상의 체크를 선택 하셔야 합니다");
		} else {			
			
			for (var i = 0; i < document.getElementsByName("resCode").length; i++) {
				if (document.getElementsByName("resCode")[i].checked == true) {
					insert_resCode = insert_resCode + "," + document.getElementsByName("resCode")[i].value;					
				}
			}
			insert_resCode = insert_resCode.substring(1)
			if (confirm("예약을취소하시겠습니까?")== true){
				apiExecute(
						"POST",
						"/backoffice/res/reservationCancel.do",
						{
							resCancelCode : insert_resCode
						}, null, function(result) {
							if (result != null) {
								if (result == "T") {
									alert("정삭적으로 예약취소 되었습니다.");
									location.reload();
								} else {
									alert("예약취소시 문제가 생겼습니다.");
								}
							}
						}, null, null);		
				}
		}
    }
    function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);				
		$("form[name=regist]").attr("action", "/backoffice/resManage/resList.do").submit();
	}
	</script>
</body>
</html>