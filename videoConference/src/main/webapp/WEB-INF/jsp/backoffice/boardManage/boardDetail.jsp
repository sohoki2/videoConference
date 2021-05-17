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
	<title><spring:message code="URL.TITLE" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/jquery-ui-modify.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css"> 
        
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
    <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script>
	<script>
    	var pageStatus = "";
    </script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/boardManage/boardList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="mode" id="mode" value="${regist.mode }">
<form:hidden path="pageSize" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />

<form:hidden path="boardGubun" />
<input type="hidden" name="boardSeq" id="boardSeq" value="${regist.boardSeq }">
<input type="hidden" name="boardContent" id="boardContent" value="">
<input type="hidden" name="boardReturnContent" id="boardReturnContent" value="${regist.boardReturnContent }">

<input type="hidden" name="boardRegId" id="boardRegId" value="${regist.boardRegId }">
<input type="hidden" name="boardUpdateId" id="boardUpdateId" value="${regist.boardUpdateId }">

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                                          커뮤니티관리
                        <span>></span>
                        <strong>
                          <c:choose>
			                <c:when test="${regist.boardGubun eq 'NOT'}">
			                	<script>
			                	pageStatus = "NOT";
			                	</script>			                
                                                 공지사항
                            </c:when>
                            <c:when test="${regist.boardGubun eq 'FAQ'}">			                
                            FAQ
                            </c:when>
                            <c:otherwise>
                            Q&A
                            </c:otherwise>
                          </c:choose>
                         </strong>
                    </div>
                </div>
            </div>

            
            <div class="Swrap tableArea viewArea">
                <div class="view_contents">
                <table class="margin-top30 pop_table thStyle">
	                <tbody>
	                    <tr class="tableM">
	                        <th><span class="redText">*</span>제목</th>
	                        <c:choose>
		                        <c:when test="${regist.boardGubun ne 'QNA'}">
		                        	<td colspan="3"><input type="text" name="boardTitle" id="boardTitle" value="${regist.boardTitle }" style="width:470px;" /></td>
		                        </c:when>
		                        <c:otherwise>
		                        	<td colspan="3">
		                        		${regist.boardTitle }
		                        		<input type="hidden" name="boardTitle" id="boardTitle" value="${regist.boardTitle }" style="width:470px;" />
		                        	</td>
		                        </c:otherwise>
	                        </c:choose>
	                    </tr>
	                    <c:choose>
	                       <c:when test="${regist.boardGubun eq 'NOT'}">
	                           <tr>
			                        <th><span class="redText">*</span>작성자</th>
			                        <td style="text-align:left" class="preview_userNm">${regist.userNm }</td>
			                        <th><span class="redText">*</span>아이디</th>
			                        <td style="text-align:left" class="preview_userNm">${regist.boardRegId }</td>
		                      </tr>
		                      <tr>
			                    	<th>연락처</th>
			                        <td style="text-align:left" class="preview_offiTelNo">
			                        	${regist.mobTelNo }
			                        </td>
			                        <th>이메일</th>
			                        <td style="text-align:left" class="preview_email">
			                        	${regist.email }
			                        </td>                  
			                    </tr>
		                      <tr>
		                      		<th>공지기간</th>
			                        <td style="text-align:left">
			                        <form:input  path="boardNoticeStartday" size="10" maxlength="8" id="boardNoticeStartday" class="date-picker-input-type-text" value="${regist.boardNoticeStartday }" />
			                        ~ &nbsp;&nbsp;&nbsp;
			                        <form:input  path="boardNoticeEndday" size="10" maxlength="8" id="boardNoticeEndday" class="date-picker-input-type-text" value="${regist.boardNoticeEndday }" />	                        
			                        </td>
		                            <th><span class="redText">*</span>목록상단에고정</th>
			                        <td style="text-align:left">
			                        <c:if test="${regist.mode == 'Ins' }">
			                        	<input type="radio" name="boardNoticeUseyn" value="Y" checked="checked"/><label>예</label>
			                        </c:if>
			                        <c:if test="${regist.mode != 'Ins' }">
			                        	<input type="radio" name="boardNoticeUseyn" value="Y" <c:if test="${regist.boardNoticeUseyn == 'Y' }"> checked </c:if> /><label>예</label>
			                        </c:if>
							        <input type="radio" name="boardNoticeUseyn" value="N" <c:if test="${regist.boardNoticeUseyn == 'N' }"> checked </c:if> /><label>아니요</label>	                        
			                        </td>
			                    </tr>
			                    
			                    <tr>
		                            <th>첨부파일</th>
		                            <c:if test="${regist.boardFile01 eq null}">
		                            	<td colspan="3"><a class="preview_fileNm"></a><input name="boardFile01" id="boardFile01" type="file" size="20"/></td>
		                            </c:if>
		                            <c:if test="${regist.boardFile01 ne null}">
		                            	<td colspan="3"><a class="preview_fileNm">${regist.boardFile01}</a>&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;파일변경<input name="boardFile01" id="boardFile01" type="file" size="20"/></td>
		                            </c:if>
		                        </tr>
	                       </c:when>
	                       <c:when test="${regist.boardGubun eq 'FAQ'}">
	                             <tr>
			                        <th>FAQ 구분</th>
			                        <td style="text-align:left">
			                        <form:select path="boardFaqGubun" id="boardFaqGubun" title="소속">
										         <form:option value="" label="FAQ구분"/>
						                         <form:options items="${selectFaq}" itemValue="code" itemLabel="codeNm"/>
								    </form:select>
			                        </td>
			                        <th><span class="redText">*</span>노출여부</th>
			                        <td style="text-align:left">
			                        <c:if test="${regist.mode == 'Ins' }">
			                        	<input type="radio" name="boardNoticeUseyn" value="Y"  checked="checked"><label>예</label>
			                        </c:if>
			                        <c:if test="${regist.mode != 'Ins' }">
			                        	<input type="radio" name="boardNoticeUseyn" value="Y" <c:if test="${regist.boardNoticeUseyn == 'Y' }"> checked </c:if> /><label>예</label>
			                        </c:if>
							        	<input type="radio" name="boardNoticeUseyn" value="N" <c:if test="${regist.boardNoticeUseyn == 'N' }"> checked </c:if> /><label>아니요</label>	                           
			                        </td>          
			                    </tr>			
			                    <tr>
		                            <th>첨부파일</th>
		                            <c:if test="${regist.boardFile01 eq null}">
		                            	<td colspan="3"><a class="preview_fileNm"></a><input name="boardFile01" id="boardFile01" type="file" size="20"/></td>
		                            </c:if>
		                            <c:if test="${regist.boardFile01 ne null}">
		                            	<td colspan="3"><a class="preview_fileNm">${regist.boardFile01}</a>&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;파일변경<input name="boardFile01" id="boardFile01" type="file" size="20"/></td>
		                            </c:if>
		                        </tr>
	                       </c:when>
	                       <c:otherwise>
	                            <tr>
		                            <th><span class="redText">*</span>이름</th>
		                            <td>${regist.userNm }</td>
		                            <th><span class="redText">*</span>사번</th>
		                            <td>${regist.boardRegId }</td>
		                        </tr>	
		                        <tr>
		                            <th><span class="redText">*</span>부서</th>
		                            <td>${regist.orgName }</td>
		                            <th><span class="redText">*</span>직급</th>
		                            <td>${regist.posGrdNm }</td>
		                        </tr>		
		                        <tr>
		                            <th><span class="redText">*</span>질문내용</th>
		                            <td colspan="3">${regist.boardContent }</td>
		                        </tr>                        
	                       </c:otherwise>
	                    </c:choose>	                    
	                    <c:if test="${regist.boardGubun eq 'QNA'}" >
	                    <tr>
	                        <th><span class="redText">*</span>답변 내용 </th>
	                        <td colspan="3" style="text-align:left">
	                            <textarea name="ir1" id="ir1" style="width:700px; height:100px; display:none;">
	                            ${regist.boardReturnContent }
	                            </textarea>
	                        </td>
	                    </tr>
	                    </c:if>
	                    <c:if test="${regist.boardGubun ne 'QNA'}" >
	                    <tr>
	                        <th><span class="redText">*</span>내용</th>
	                        <td colspan="3" style="text-align:left">
	                            <textarea name="ir1" id="ir1" style="width:700px; height:100px; display:none;">
	                            </textarea>
	                        </td>
	                    </tr>
	                    </c:if>            
	                    
	                </tbody>
	            </table>
            </div>
            </div>
            <div class="footerBtn">
	            <a href="javascript:check_form();" class="blueBtn" id="btnUpdate">저장</a>
	            <c:if test="${regist.mode != 'Ins' }">
	            <!-- <a href="javascript:del_form();" class="redBtn">삭제</a> -->
	            </c:if>
	            <a href="javascript:linkPage('1')" class="reviseBtn">목록</a>
				<c:if test="${regist.boardGubun ne 'QNA'}" >
	            <a href="javascript:preview()" class="lightgrayBtn">미리보기</a>
	            </c:if>
	        </div>
        </div>
    </div>

    <c:if test="${regist.boardGubun ne 'QNA'}" >
	    <!-- 미리보기 세팅 -->
		<div id="preview_value_page"></div>
		<div id="preview_value_userNm"></div>
		<div id="preview_value_offiTelNo"></div>
		<div id="preview_value_email"></div>
		<div id="preview_value_useYn"></div>
		<div id="preview_value_fileNm"></div>
		<div id="preview_value_fileChange"></div>
	</c:if>

<c:import url="/backoffice/inc/bottom_inc.do" />
</form:form>
</div>
<script type="text/javascript">

	/* 화면 미리보기 구현부 START */
	$("#preview_value_page").hide();
	$("#preview_value_userNm").hide();
	$("#preview_value_offiTelNo").hide();
	$("#preview_value_email").hide();
	$("#preview_value_useYn").hide();
	$("#preview_value_fileNm").hide();
	$("#preview_value_filePath").hide();
	
	$("#preview_value_fileNm").val("N");
	$("#preview_value_fileChange").val("N");
	
	$("#boardFile01").change(function(event){
		// input type file에 변동사항 발생시 local url 및 파일명 새로 가져오기, 다운로드 구현을 위한 작업
		$("#preview_value_fileNm").val(event.target.files[0].name);
		$("#preview_value_fileChange").val("Y");
		
	});
	
	var previewWindow;
	function preview(){
		
		var popSpec = "";
		if(pageStatus == "NOT"){
			popSpec = "width=920,height=600,top=10,left=350,scrollbars=yes";
		} else {
			popSpec = "width=920,height=480,top=10,left=350,scrollbars=yes";
		}
		
		$("#preview_value_page").val(pageStatus);
		$("#boardContent").val(oEditors.getById["ir1"].getIR());
		$("#preview_value_userNm").val($(".preview_userNm").html());
		$("#preview_value_offiTelNo").val($(".preview_offiTelNo").html());
		$("#preview_value_email").val($(".preview_email").html());
		$("#preview_value_useYn").val($(":input:radio[name=boardNoticeUseyn]:checked").val());

		
		if($("#preview_value_fileNm").val() == "N"){
			$("#preview_value_fileNm").val($(".preview_fileNm").html());
			
		}
		
		
		
		
		window.open("/backoffice/boardManage/boardPreview.do", "preview", popSpec);
	}
	/* 화면 미리보기 구현부 FINISH */


	function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);		
		$("form[name=regist]").submit();
	}	
	var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
         oAppRef: oEditors,
         elPlaceHolder: "ir1",                        
         sSkinURI: "/js/SE/SmartEditor2Skin.html",
         htParams: { bUseToolbar: true,
             fOnBeforeUnload: function () {},
             //boolean 
         }, fOnAppLoad: function () {
        	 
			 oEditors.getById["ir1"].exec("PASTE_HTML", ['${regist.boardContent}']);
		 },
         fCreator: "createSEditor2"
    });
	$(document).ready(function() {     
		//alert("${status}");

		var contentValue = '${regist.boardContent}';
		$("#boardContent").val(contentValue)

		
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
            buttonImage: '/images/invisible_image.png', //이미지주소
            showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)
            yearRange: '1970:2030' //1990년부터 2020년까지
        };	      
        $("#boardNoticeStartday").datepicker(clareCalendar);
        $("#boardNoticeEndday").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});	
	function check_form(){
		var sHTML = oEditors.getById["ir1"].getIR();
		// sHTML = tagFilter(sHTML);
		if ($("#boardGubun").val() == "QNA"){
			$("#boardReturnContent").val(sHTML);
			if($("#boardReturnContent").val() == "<p>&nbsp;</p>" || $("#boardReturnContent").val() =="<p><br></p>" || $("#boardReturnContent").val() == "<P>&nbsp;</P>"){
				   alert("답변내용을 입력 하지 않았습니다.");
				   return;
			}	 
		}else {
			if (any_empt_line_id("boardTitle", "제목를 입력 하지 않았습니다.") == false) return;
			$("#boardContent").val(sHTML);
			if($("#boardContent").val() == "<p><br></p>"){
				   alert("내용을 입력 하지 않았습니다.");
				   return;
			}	 
		} 
		   
		var commentTxt = "";
		if ($("#mode").val() == "Ins"){
			commentTxt = "등록 하시겠습니까?";
		}	else {
			commentTxt = "저장 하시겠습니까?";	   	    
		}
		   
		if (confirm(commentTxt)== true){
			document.regist.encoding = "multipart/form-data";		   
			$("form[name=regist]").attr("action", "/backoffice/boardManage/boardUpdate.do").submit();
		}
		   
		return;
	}
	function del_form(){
		
	    if (confirm("삭제 하시겠습니까?")== true){
	    	apiExecute(
					"POST", 
					"/backoffice/boardManage/boardDelete.do",
					{
						boardSeq : $("#boardSeq").val()
					},
					null,				
					function(result) {				
						if (result != null) {
							if (result == "O"){
								alert("정상적으로 삭제되었습니다.");
							}else {
								alert("삭제시 문제가 생겼습니다");
							}					
						}else {
						    alert("삭제시 문제가 생겼습니다");
						}
						$("form[name=regist]").attr("action", "/backoffice/boardManage/boardList.do").submit();					
					},
					null,
					null
				);	
	    }else {
	    	return;
	    } 	   
	}	
	
	
	var day = new Date();
    var dateNow = fnLPAD(String(day.getDate()), "0", 2); //일자를 구함
    var dateNow1 = fnLPAD(String(day.getDate() + 1), "0", 2); //일자를 구함
    var monthNow = fnLPAD(String((day.getMonth() + 1)), "0", 2); // 월(month)을 구함
    var monthNow1 = fnLPAD(String((day.getMonth() + 2)), "0", 2); // 월(month)을 구함
    var yearNow = String(day.getFullYear()); //년(year)을 구함
    var today = yearNow + monthNow + dateNow;
    var nextday = yearNow + monthNow1 + dateNow1;		 
    
	$("#boardNoticeEndday").datepicker({ dateFormat: 'yymmdd' }).bind("change",function(){
        var dayValue = $(this).val();
        if(dayValue < today){
        	$(this).val("");
        	alert("과거 일자는 선택할 수 없습니다.");
        	$(this).focus();
        }else if(dayValue < $("#boardNoticeStartday").val()){
        	$(this).val("");
        	alert("종료일이 시작일보다 빠를 수 없습니다.");
        	$(this).focus();
        }
    });
	
	$("#boardNoticeStartday").datepicker({ dateFormat: 'yymmdd' }).bind("change",function(){
        var dayValue = $(this).val();
        if(dayValue < today){
        	$(this).val("");
        	alert("과거 일자는 선택할 수 없습니다.");
        	$(this).focus();
        }
    });
	
</script>  
</body>
</html>