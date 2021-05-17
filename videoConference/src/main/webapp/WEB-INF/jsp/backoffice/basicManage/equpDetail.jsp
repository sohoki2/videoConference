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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>국민건강보험</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/calendar.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/new_calendar.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/equpList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="mode" id="mode" value="${regist.mode }">
<form:hidden path="userId" />
<form:hidden path="deptId" />
<form:hidden path="equpCode" />

<input type="hidden" name="remark" id="remark" value="${regist.remark }">

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                                          기초관리
                        <span>></span>
                        <strong>비품 관리</strong>
                    </div>
                </div>
            </div>

            
            <div class="Swrap tableArea viewArea">
                <div class="view_contents">
                <table class="pop_table thStyle">
	                <tbody>
	                    <%-- <tr>
	                        
	                        <th><span class="redText">*</span>관리자명</th>
                        	<td style="text-align:left">
	                           <form:input  path="empNm" size="30" maxlength="20" id="empNm"   value="${regist.empNm }" style="width:290px;" disabled="true" />	
	                           <a href="javascript:user_search();" class="deepBtn">직원조회</a>
	                        </td>
		                    <th><span class="redText">*</span>관리부서</th>
	                        <td><input type="text" name="deptName" id="deptName" value="${regist.orgName }"  size="30" style="width:300px; " disabled="disabled"/></td>
	                    </tr> --%>
	                    <tr>
	                        <th><span class="redText">*</span>비품명</th>
	                        <td style="text-align:left">
	                        <form:input  path="equipmentName" size="30" maxlength="20" id="equipmentName"   value="${regist.equipmentName }" style="width:390px;" />
	                        </td>
	                        <th><span class="redText">*</span>입고일</th>
	                        <td style="text-align:left">
	                        <form:input  path="equpIndate" size="30" maxlength="8" id="equpIndate" class="date-picker-input-type-text" value="${regist.equpIndate }"  style="width:175px;"/>	                        
	                        </td>	                        
	                    </tr>	                    
	                    <tr>
		                    <%-- <th><span class="redText">*</span>비치사무소</th>
		                    <td>
		                            <form:select path="centerId" id="centerId" title="소속" style="width:180px;">
										         <form:option value="" label="사무소구분"/>
						                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
								    </form:select>	
		                    </td>
	                        <th><span class="redText">*</span>비치장소</th>
	                        <td style="text-align:left">
	                           <form:select path="roomId" id="roomId" title="소속" style="width:180px;">
									         <form:option value="" label="장소구분"/>
									         <form:options items="${selectSeat}" itemValue="seatId" itemLabel="seatName"/>
					                         <form:options items="${selectCodeDM}" itemValue="code" itemLabel="codeNm"/>
							    </form:select>	
	                        </td>
	                    </tr>
	                    <tr>
	                    	<th>비치회의실</th>
		                    <td>
		                     	<form:select path="seatId" id="seatId" title="회의실"  style="width:180px;">
									<form:option value="" label="비치회의실구분"/>
						        	<form:options items="${selectSeat}" itemValue="seatId" itemLabel="seatName"/>
							 	</form:select>	
								    
		                    </td> --%> 
		                    <th><span class="redText">*</span>비치사무소</th>
		                    <td>
	                            <form:select path="centerId" id="centerId" title="소속" style="width:390px;">
									         <form:option value="" label="사무소구분"/>
					                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
							    </form:select>	
	                        </td>
	                        <th><span class="redText">*</span>장소구분</th>
	                        <td style="text-align:left">
	                           <form:select path="roomType" id="roomType" title="소속"  style="width:300px; " disabled="true">
		                           <c:if test="${regist.mode != 'Ins' }"><form:option value="${regist.roomType }" label="${regist.roomTypeNm }"/></c:if>
		                           <c:if test="${regist.mode == 'Ins' }"><form:option value="" label="장소구분"/></c:if>
						           <form:options items="${selectCodeTDM}" itemValue="code" itemLabel="codeNm"/>
							   </form:select>	
	                        </td>
	                    </tr>	                    
	                    <tr>
	                        <th><span class="redText">*</span>구역구분</th>
	                        <td style="text-align:left">
	                           <form:select path="roomId" id="roomId" title="소속"  style="width:390px;" disabled="true">
	                           		<c:if test="${regist.mode != 'Ins' }"><form:option value="${regist.roomId }" label="${regist.roomIdNm }" /></c:if>
		                            <c:if test="${regist.mode == 'Ins' }"><form:option value="" label="회의실구역선택"/></c:if>
							    </form:select>	
	                        </td>
	                        <th><span class="redText">*</span>회의실(회의실)명</th>
	                        <td style="text-align:left">
	                        	<form:select path="seatId" id="seatId" title="회의실"  style="width:300px; " disabled="true">
		                           <c:if test="${regist.mode != 'Ins' }"><form:option value="${regist.seatId }" label="${regist.seatNm }"/></c:if>
		                           <c:if test="${regist.mode == 'Ins' }"><form:option value="" label="비치회의실구분"/></c:if>
							 	</form:select>	
	                        </td>
		                  </tr>	                    
	                    <tr>  
	                        <th><span class="redText">*</span>수량</th>
	                        <td style="text-align:left">
	                        <form:input  path="cnt" size="30" maxlength="8" id="cnt"   value="${regist.cnt }"  style="width:390px;" />
	                        </td>
	                        <th>제조회사</th>
	                        <td style="text-align:left">
	                        <form:input  path="company" size="30" maxlength="8" id="company"   value="${regist.company }"  style="width:300px;" />
	                        </td>
	                    </tr>	                    
	                    <tr>
	                        <th><span class="redText">*</span>사용유무</th>
	                        <td style="text-align:left" colspan="3">
	                        
	                        <c:if test="${regist.mode == 'Ins' }">
				            	<input type="radio" name="useYn" value="Y" checked="checked"/><label>사용</label>
				            </c:if>
	                        <c:if test="${regist.mode != 'Ins' }">
				            	<input type="radio" name="useYn" value="Y" <c:if test="${regist.useYn == 'Y' }"> checked </c:if> /><label>사용</label>
				            </c:if>
							<input type="radio" name="useYn" value="N" <c:if test="${regist.useYn == 'N' }"> checked </c:if> /><label>사용안함</label>	                            
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>비고 </th>
	                        <td colspan="3" style="text-align:left">
	                            <textarea name="ir1" id="ir1" style="width:100%; height:100px; display:none;">${regist.remark }</textarea>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn">
	            <a href="javascript:check_form();" class="redBtn" id="btnUpdate">저장</a>
	            <a href="javascript:linkPage('1')" class="deepBtn">목록</a>
	        </div>
        </div>
    </div>

<c:import url="/backoffice/inc/bottom_inc.do" />
</form:form>
</div>
<script type="text/javascript">
	function linkPage(pageNo) {
		if (confirm("목록으로 돌아가시겠습니까?")== true){
			$(":hidden[name=pageIndex]").val(pageNo);		
			$("form[name=regist]").submit();
		}
	}	
	var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
         oAppRef: oEditors,
         elPlaceHolder: "ir1",                        
         sSkinURI: "/js/SE/SmartEditor2Skin.html",
         htParams: { bUseToolbar: true,
             fOnBeforeUnload: function () { },
             //boolean 
             fOnAppLoad: function () { }
             //예제 코드
         },
         fCreator: "createSEditor2"
    });
	$(document).ready(function() {     
		//alert("${status}");
		
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
	    	$("#btnUpdate").text("저장");	   	    
	    }
	    
	    // modify exist Data Set
	    if ($("#mode").val() != "Ins"){
		    $("#centerId option").each(function(){
		    	if($(this).val() =="${regist.centerId}"){
		    		$(this).attr("selected", "selected");
		    	}
		    	
		    	$("#centerId").attr("disabled", false);
		    });
		    
		    $("#roomType option").each(function(){
		    	if($(this).val() =="${regist.roomType}"){
		    		$(this).attr("selected", "selected");
		    	}
		    	$("#roomType").attr("disabled", false);
		    });
		    
		    $("#roomId option").each(function(){
		    	if($(this).val() =="${regist.roomId}"){
		    		$(this).attr("selected", "selected");
		    	}
		    	$("#roomId").attr("disabled", false);
		    });
		    
		    $("#seatId option").each(function(){
		    	if($(this).val() =="${regist.seatId}"){
		    		$(this).attr("selected", "selected");
		    	}
		    	$("#seatId").attr("disabled", false);
		    });
	    }
	       
	});	
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
			//buttonImage: '/images/calendar.gif', //이미지주소
            buttonImage: '/images/invisible_image.png', //이미지주소
            // showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)
            yearRange: '1970:2030' //1990년부터 2020년까지
        };	      
        $("#equpIndate").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});	
	function check_form(){
		
		/* if ($("#empNm").val() == ""){
			alert("관리자명을 검색해 주세요");
			return ;			   
		} */
		
		if (any_empt_line_id("equipmentName", "비품명을 입력 하지 않았습니다.") == false) return;
		if (any_empt_line_id("equpIndate", "입고일을 입력 하지 않았습니다.") == false) return;
		if (any_empt_line_id("centerId", "비치사무소를 선택 하지 않았습니다.") == false) return;
		
		if (any_empt_line_id("roomType", "회의실명을 선택 하지 않았습니다.") == false) return;
		if (any_empt_line_id("roomId", "비치구역을 선택 하지 않았습니다.") == false) return;
		
		if($("#seatId").val() == "0"){
		}else{
		if (any_empt_line_id("seatId", "비치회의실을 선택 하지 않았습니다.") == false) return;
		}
		
		
		if (any_empt_line_id("cnt", "수량을 입력 하지 않았습니다.") == false) return;
		var sHTML = oEditors.getById["ir1"].getIR();
		$("#remark").val(sHTML);		   
		
		var commentTxt = "";
		 if ($("#mode").val() == "Ins"){
		commentTxt = "등록 하시겠습니까?";
		}else {
		commentTxt = "저장 하시겠습니까?";   
		}
		
		if (confirm(commentTxt)== true){
		 $("form[name=regist]").attr("action", "/backoffice/basicManage/equpUpdate.do").submit();
		}	 
		return;
	}
	function del_form(){
		
	    if (confirm("삭제 하시겠습니까?")== true){
	    	apiExecute(
					"POST", 
					"/backoffice/basicManage/equpDelete.do",
					{
						adminId : $("#adminId").val()
					},
					null,				
					function(result) {				
						if (result != null) {
							if (result == "T"){
								alert("정상적으로 삭제되었습니다.");
							}else {
								alert("삭제시 문제가 생겼습니다");
							}					
						}else {
						    alert("삭제시 문제가 생겼습니다");
						  
						}
						$("form[name=regist]").attr("action", "/backoffice/basicManage/equpList.do").submit();					
					},
					null,
					null
				);	
	    }else {
	    	return;
	    } 	   
	}	
	function user_search(){
		var url ="/backoffice/popup/empSearchList.do?code=equp&admin=Y";
		NewWindow(url, 'name', '1024', '768', 'yes');
	}
	
	 $('#cnt').keyup(function(){
			 this.value = this.value.replace(/[^0-9]/g, '');			 
		 })
	 
	 $("#centerId").change(function(){
		if($("#centerId option:selected").val().length > 0){
			$("#roomType").attr("disabled", false);
		}
	});
	
	$("#roomType").change(function(){
		if($("#centerId option:selected").val().length > 0){
			$("#roomId").attr("disabled", false);
			if($("#roomType option:selected").val() == "swc_gubun_1"){
				$("#seatName").attr("disabled", false);
			}else{
				$("#seatName").attr("disabled", true);
				$("#seatName").val("");
			}
		}

		apiExecute(
				"POST", 
				"/backoffice/basicManage/selectCode.do",
				{
					centerId : $("#centerId option:selected").val()
					,roomType : $("#roomType option:selected").val()
				},
				null,				
				function(result) {
					if (result != null) {
						$("#roomId").empty();
						
						for (var i = 0; i < result.roomList.length; i++) {
							var obj = result.roomList[i];
							$("#roomId").append($('<option></option>').attr('value', obj.roomId).text(obj.roomNm));
						}
					}
				},
				null,
				null
			);	
		
	});
	
	var seatSelCnt;
	$("#roomId").change(function(){
		if($("#roomId option:selected").val().length > 0){
			$("#seatId").attr("disabled", false);
			
			if($("#roomType option:selected").val() == "swc_gubun_1"){
				$("#seatName").attr("disabled", false);
			}else{
				$("#seatName").attr("disabled", true);
				$("#seatName").val("");
			}
		}

		apiExecute(
				"POST", 
				"/backoffice/basicManage/selectSeatCode.do",
				{
					centerId : $("#centerId option:selected").val()
					,roomType : $("#roomType option:selected").val()
					,roomId : $("#roomId option:selected").val()
				},
				null,				
				function(result) {
					if (result.areaList.length > 0 ) {
						$("#seatId").empty();
						for (var i = 0; i < result.areaList.length; i++) {
							var obj = result.areaList[i];
							$("#seatId").append($('<option></option>').attr('value', obj.seatId).text(obj.seatName));
						}
					}else{
						$("#seatId").empty();
						$("#seatId").append($('<option></option>').attr('value', "0").text("회의실없음"));
						$("#seatName").attr("disabled", true);
					}
				},
				null,
				null
			);
		
	});
	
</script>  
</body>
</html>