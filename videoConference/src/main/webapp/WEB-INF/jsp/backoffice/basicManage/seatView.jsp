<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/seatList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="mode" id="mode" value="${regist.mode }">
<form:hidden path="swcSeq" />
<form:hidden path="pageIndex" />
<form:hidden path="pageSize" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />
<form:hidden path="searchCenterId" />

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                                                                 기초관리
                        <span>></span>
                        <strong>회의실 관리</strong>
                    </div>
                </div>
            </div>

            
            <div class="Swrap tableArea viewArea">
                <div class="view_contents">
                <table class="pop_table thStyle">
	                <tbody>
	                    <tr>
	                        <th>사무소</th>
	                        <td>${registinfo.centerNm }</td>
	                        <th>회의실타입</th>
	                        <td style="text-align:left">${registinfo.roomTypeTxt }
	                    </tr>	                    
	                    <tr>
	                        
	                        <th>최대수용인원</th>
	                        <td  style="text-align:left">${registinfo.maxCnt }</td>
	                        <th>회의실 명</th>
	                        <td style="text-align:left">${registinfo.seatName }
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>메인 페이지 노출 여부</th>
	                        <td style="text-align:left">
	                        	<c:if test="${registinfo.mode == 'Ins' }">
						            <input type="radio" name="seatMainview" value="Y" checked="checked"/><label>사용</label>
					            </c:if>
		                        <c:if test="${registinfo.mode != 'Ins' }">
						            <input type="radio" name="seatMainview" value="Y" <c:if test="${registinfo.seatMainview == 'Y' }"> checked </c:if> /><label>사용</label>
					            </c:if>
								<input type="radio" name="seatMainview" value="N" <c:if test="${registinfo.seatMainview == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
							<th><span class="redText">*</span>페이지 노출 여부</th>
	                        <td style="text-align:left">
	                        	<c:if test="${registinfo.mode == 'Ins' }">
						            <input type="radio" name="seatView" value="Y" checked="checked"/><label>사용</label>
					            </c:if>
		                        <c:if test="${registinfo.mode != 'Ins' }">
						            <input type="radio" name="seatView" value="Y" <c:if test="${registinfo.seatView == 'Y' }"> checked </c:if> /><label>사용</label>
					            </c:if>
								<input type="radio" name="seatView" value="N" <c:if test="${registinfo.seatView == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                    </tr><tr>
	                        <th>회의실  이미지1</th>
	                        <td style="text-align:left">
	                        <c:if test="${registinfo.seatImg1 != '' }">
	                            <img src="/upload/${registinfo.seatImg1 }" width="450px" />
	                        </c:if>
	                        </td>
	                        <th>회의실  이미지2</th>
	                        <td style="text-align:left">
	                        <c:if test="${registinfo.seatImg2 != '' }">
	                           <img src="/upload/${registinfo.seatImg2 }" width="450px" />
	                        </c:if>
	                        </td>
	                    </tr>
	                    <tr>
						    <th><span class="redText">*</span>정렬 순서</th>
	                        <td style="text-align:left">${registinfo.seatOrder }
	                        </td>
	                        <th><span class="redText">*</span>장비 사용여부</th>
	                        <td style="text-align:left">
	                              <input type="radio" name="seatEqupgubun" value="Y" <c:if test="${registinfo.seatEqupgubun == 'Y' }"> checked </c:if> /><label>사용</label>
								  <input type="radio" name="seatEqupgubun" value="N" <c:if test="${registinfo.seatEqupgubun == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                    </tr>	                    
	                    <tr>
						    <th><span class="redText">*</span>관리자 승인여부</th>
	                        <td style="text-align:left">
	                              <c:choose>
	                                 <c:when test="${registinfo.seatConfirmgubun == 'R' }">
	                                 사용
	                                 </c:when>
	                                 <c:otherwise>
	                                 사용안함
	                                 </c:otherwise>
	                              </c:choose>
								  :<a href='#'  class='blueBtn' id='btn_Choice' onclick='fn_searchView()'>담당자 선택</a>
	                        </td>
	                        <th><span class="redText">*</span>승인 담당자</th>
	                        <td style="text-align:left">
	                             <span id="sp_seatInfo"></span>
	                             <input type="hidden"  id="seatAdminid" name="seatAdminid" >
	                             <a href='#'  class='blueBtn' id='btn_Choice' onclick='fn_searchUpdate()'>담당자 등록</a>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>사용유무</th>
	                        <td style="text-align:left">
		                      <input type="radio" name="swcUseyn" value="Y" <c:if test="${registinfo.swcUseyn == 'Y' }"> checked </c:if> /><label>사용</label>
					          <input type="radio" name="swcUseyn" value="N" <c:if test="${registinfo.swcUseyn == 'N' }"> checked </c:if> /><label>사용안함</label>	                            
	                        </td>
	                        <th>회의실 설명 </th>
	                        <td  style="text-align:left">
	                            ${registinfo.equipmentState }
	                        </td>
	                    </tr>
	                    <!--  신규 추가  -->
	                     <tr>
	                        <th><span class="redText">*</span>메일 전송 여부</th>
	                        <td style="text-align:left">
	                              <input type="radio" name="mailSendcheck" value="Y"  onClick="fn_msgView('M','Y')" <c:if test="${registinfo.mailSendcheck == 'Y' }"> checked </c:if> /><label>사용</label>
								  <input type="radio" name="mailSendcheck" value="N"  onClick="fn_msgView('M','N')" <c:if test="${registinfo.mailSendcheck == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                        <th><span class="redText">*</span>sms 전송 여부</th>
	                        <td style="text-align:left">
	                             
	                              <input type="radio" name="smsSendcheck" value="Y"   onClick="fn_msgView('S','Y')" <c:if test="${registinfo.smsSendcheck == 'Y' }"> checked </c:if> /><label>사용</label>
								  <input type="radio" name="smsSendcheck" value="N"   onClick="fn_msgView('S','N')" <c:if test="${registinfo.smsSendcheck == 'N' }"> checked </c:if> /><label>사용안함</label>
	                        </td>
	                    </tr>
	                     <c:if test="${registinfo.mailSendcheck == 'Y' }">
	                    <tr id="tr_resMial">
	                        <th><span class="redText">*</span>예약 메세지</th>
	                        <td style="text-align:left"> ${registinfo.resMessageMailTxt }
	                              
	                        </td>
	                        <th><span class="redText">*</span>취소 메세지</th>
	                        <td style="text-align:left"> ${registinfo.resMessageSmsTxt }
	                        </td>
	                    </tr>
	                    </c:if>
	                     <c:if test="${registinfo.smsSendcheck == 'Y' }">
	                    <tr id="tr_resSms">
	                        <th><span class="redText">*</span>예약 SMS</th>
	                        <td style="text-align:left"> ${registinfo.canMessageMailTxt }
	                               
	                        </td>
	                        <th><span class="redText">*</span>취소 SMS</th>
	                        <td style="text-align:left"> ${registinfo.canMessageSmsTxt }
	                              
	                        </td>
	                    </tr>
	                    </c:if>
	                    <c:if test="${registinfo.roomType == 'SWC_GUBUN_2' }">
	                   <tr>
	                        <th>AVAYA CODE</th>
	                        <td style="text-align:left">${registinfo.avayaConfiId }</td>
	                        <th>어바이어 장비명</th>
	                        <td style="text-align:left">${registinfo.avayaUserid } 
	                        </td>
	                    </tr>
	                     <tr>
	                        <th><span class="redText">*</span>어바이어 터미널아이디</th>
	                        <td style="text-align:left">${registinfo.terminalId }
	                        </td>
	                        <th>어바이어 터미널 넘버</th>
	                        <td style="text-align:left">${registinfo.terminalNumber }  
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>어바이어 터미널 전화번호</th>
	                        <td style="text-align:left">${registinfo.terminalTel }
	                        </td>
	                        <th><span class="redText">*</span>어바이어 사용자명</th>
	                        <td style="text-align:left">
	                        first: ${registinfo.userFirstNm }
	                        last: ${registinfo.userLastNm }  
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><span class="redText">*</span>이메일</th>
	                        <td style="text-align:left" colspan="3">${registinfo.userEmail }
	                        </td>
	                    </tr>
	                    </c:if>
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn">
	            <a href="javascript:check_form();" class="blueBtn" id="btnUpdate">수정</a>
	            <a href="javascript:del_form();" class="grayBtn">삭제</a>
	            <a href="javascript:linkPage()" class="reviseBtn">목록</a>
	        </div>
        </div>
    </div>

<c:import url="/backoffice/inc/bottom_inc.do" />
<script type="text/javascript">
		function fn_EmInt(empno, empname){
			var attendInfo = $("#seatAdminid").val().split(",");
			for (var i in attendInfo){
				  if (attendInfo[i] == empno)	{
					  return;
					  break;
				  }
			}
			
			var userAttendList = $("#seatAdminid").val()+","+empno;
			$("#seatAdminid").val(userAttendList);
			var span_info = $("#sp_seatInfo").html() + "<span id='sp_"+empno+"'>"+empname+" <a href='#' onclick='fn_userDel("+empno+")'>[X]</a></span>";
			$("#sp_seatInfo").html(span_info);
		    
		}
		$(document).ready(function() {     		
				if ("${status}" != ""){
					if ("${status}" == "SUCCESS") {
						alert("정상 처리 되었습니다");  
						document.location.href = document.location.href;
					}else{
						alert("작업 도중 문제가 발생 하였습니다.");
					}						
				}		
			    if ($("#mode").val() == "Ins"){
			 		$("#btnUpdate").text("등록");
			    }	else {
			    	$("#btnUpdate").text("수정");	   	    
			    }
			    //참석자 표시 하기 
			    <c:if test="${fn:length( resUserList ) > 0}">
	     		   <c:forEach items="${resUserList }" var="empinfo" varStatus="status">
				    	     fn_EmInt('${empinfo.empno}',   '${empinfo.empname}');
				   </c:forEach> 	 
			   </c:if>
			   
			});	
</script>
</form:form>
	</div>
<script type="text/javascript">
	function linkPage() {
		$("form[name=regist]").submit();
	}	
	
	function fn_searchUpdate(){
		//저장 
		var param = {"swcSeq" : $("#swcSeq").val(), "seatAdminid" : $("#seatAdminid").val()};
		var url = "/backoffice/basicManage/seatAdminUpdate.do";
		uniAjax(url, param, 
					function(result) {
			               if (result.status == "LOGIN FAIL"){
					    	   alert(result.message);
							   location.href="/backoffice/login.do";
						   }else if (result.status == "SUCCESS"){
							 alert("정상적으로 등록 되었습니다.");
						   }else {
							   alert("등록중 문제가 발생 하였습니다.");
						   }
					    },
					    function(request){
						    alert("Error:" +request.status );	       						
					    }    		
		    );
	}
	 function fn_searchView(){
	    	var url ="/backoffice/popup/empSearchList.do?code=except&admin=Y";
			NewWindow(url, 'name', '1024', '768', 'yes');
	}
	function check_form(){
		if ($("#mode").val() != "Ins"){
	 		$("#mode").val("Edt");
	    }
		   $("form[name=regist]").attr("action", "/backoffice/basicManage/seatDetail.do").submit();
	}
	//사용자 등록
	
	//사용자 삭제
	function fn_userDel(empno){
		var replaceTxt = ","+empno;
		var attendList = $("#seatAdminid").val().replace(replaceTxt,"");
		$("#seatAdminid").val(attendList);
		$("#sp_"+empno).remove();
	}
	
	function del_form(){
		fn_uniDel("/backoffice/basicManage/seatDelete.do"
				  , "swcSeq="+ $("#swcSeq").val()
		          , "/backoffice/basicManage/seatList.do");			
	}	
</script>  
</body>
</html>