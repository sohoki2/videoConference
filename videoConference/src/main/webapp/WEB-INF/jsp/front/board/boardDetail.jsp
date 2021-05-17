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
    <link href="/css/frn/reset.css" rel="stylesheet" />
    <link href="/css/frn/page.css" rel="stylesheet" />
    <script src="/js/jquery.min.js"></script>
    <script src="/js/common.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script src="/js/popup.js"></script>
    <title>국민건강보험</title>
    <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script>
    
</head>
<body>
<div id="wrapper"> 
<form:form name="regist" commandName="regist" method="post" action="/front/board/boardList.do">	   	 

<c:import url="/front/inc/fnt_top_inc.do" />	 
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
<input type="hidden" name="mode" id="mode" value="${regist.mode }">
<form:hidden path="pageSize" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />

<form:hidden path="boardGubun" />
<input type="hidden" name="boardSeq" id="boardSeq" value="${regist.boardSeq }">
<input type="hidden" name="boardContent" id="boardContent" value="">
<input type="hidden" name="boardReturnContent" id="boardReturnContent" value="">

<input type="hidden" name="boardRegId" id="boardRegId" value="${regist.boardRegId }">
<input type="hidden" name="boardUpdateId" id="boardUpdateId" value="${regist.boardUpdateId }">

    <div class="Utitle subheader">
        <div class="subwidth">
            <h2>커뮤니티</h2>
            <p>스마트워크사무소에서 알려드립니다.</p>
            <div class="infomenuU rightB">
                <img src="/images/icon_home.png" alt="homeicon" />
                <span>></span>
                                   커뮤니티 
                <span>></span>
                <strong>Q&A</strong>
             </div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="subwidth">
       <div class="rightT">
           <div class="Asearch">
               <div class="intU">
                   <p><span>▶</span> Q&A 질문을 통해 궁금한 점을 해결하세요.</p>
               </div>
           </div>

           <div class="tableArea noneT cancleT">
               <table class="margin-top30 pop_table backTable margin-bottom20">
                   <tbody>
                       <tr class="tableM">
	                        <th><span class="redText">*</span>제목</th>
	                        <td colspan="3"><input type="text" name="boardTitle" id="boardTitle" value="${regist.boardTitle }" style="width:550px;" /></td>
	                    </tr>
	                    <c:choose>
	                    	<c:when test="${regist.mode eq 'Ins'}">
	                    		<tr>
		                            <th>이름</th>
		                            <td>${regist.userNm }  </td>
		                            <th>사번</th>
		                            <td>${regist.boardRegId }</td>
		                        </tr>		
		                        <tr>
		                            <th>부서</th>
		                            <td>${regist.orgName }</td>
		                            <th>직급</th>
		                            <td>${regist.posGrdNm }</td>
		                        </tr>	
		                        <tr>
		                            <th>전화번호</th>
		                            <td>${regist.offiTelNo }</td>
		                            <th>이메일</th>
		                            <td>${regist.email }</td>
		                        </tr>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<tr>
		                            <th>이름 | 사번</th>
		                            <td>${regist.userNm }  ${regist.boardRegId }</td>
		                            <th>부서</th>
		                            <td>${regist.orgName }  ${regist.posGrdNm }</td>
		                        </tr>
		                        <tr>
			                        <th>연락처</th>
			                        <td style="text-align:left">
			                        	${regist.offiTelNo }
			                        </td>
			                        <th>이메일</th>
			                        <td style="text-align:left">
			                        	${regist.email }
			                        </td>                  
			                    </tr>
	                    	</c:otherwise>
	                    </c:choose>
                        
                        <c:choose>
	                       <c:when test="${regist.boardGubun ne 'QNA'}">
		                        <tr>
		                            <th>첨부파일</th>
		                            <td colspan="3">
		                            <input name="boardFile01" id="boardFile01" type="file"  size="40"/>
		                            </td>
		                        </tr>              
                        	</c:when>
                        </c:choose>        
	                    <tr>
	                        <th><span class="redText">*</span>질문내용 </th>
	                        <td colspan="3" style="text-align:left">
	                        <textarea name="ir1" id="ir1" style="width:700px; height:100px; display:none;"></textarea>
	                        </td>
	                    </tr>
	                    
                   </tbody>
               </table>
               <div class="footerBtn">
               		<c:choose>
               			<c:when test="${regist.mode ne 'Ins' }">
               				<a href="javascript:check_form();" class="redBtn" id="btnUpdate">저장</a>		
               			</c:when>
               			<c:otherwise>
               				<a href="javascript:check_form();" class="redBtn" id="btnUpdate">등록</a>
               			</c:otherwise>
               		</c:choose>
                   <a href="javascript:linkPage('1')" class="deepBtn">목록</a>
               </div>
               <div class="clear"></div>
           </div>
       </div>
   </div>

<c:import url="/front/inc/fnt_bottom_inc.do" /> 

</form:form>    
</div>
<script type="text/javascript">
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
             fOnBeforeUnload: function () { }
            
             //예제 코드
         }, fOnAppLoad: function () {
        	 oEditors.getById["ir1"].exec("PASTE_HTML", ['${regist.boardContent }']);
         },
         fCreator: "createSEditor2"
    });
	$(document).ready(function() {    
		   
		
		$("#boardContent").val('${regist.boardContent }');
		$("#boardReturnContent").val('${regist.boardReturnContent }');
		
		
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
	    	$("#mode").val("Udt");
	    	$("#btnUpdate").text("저장");	   	    
	    }
	});	    
	function check_form(mode){		
		if (any_empt_line_id("boardTitle", "제목를 입력 하지 않았습니다.") == false) return;
		var sHTML = oEditors.getById["ir1"].getIR();		   
		$("#boardContent").val(sHTML);
		if($("#boardContent").val() == "<p>&nbsp;</p>" || $("#boardContent").val() =="<p><br></p>" || $("#boardContent").val() == "<P>&nbsp;</P>"){
			   alert("질문내용을 입력 하지 않았습니다.");
			   return;
		}	 
		document.regist.encoding = "multipart/form-data";
		
		if (confirm("등록(저장) 하시겠습니까?")== true){
			$("form[name=regist]").attr("action", "/front/board/boardUpdate.do").submit();
		return;
	    }
		  
	}
	function del_form(){
		
	    if (confirm("삭제 하시겠습니까?")== true){
	    	apiExecute(
					"POST", 
					"/front/board/boardDelete.do",
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
						$("form[name=regist]").attr("action", "/front/board/boardList.do").submit();					
					},
					null,
					null
				);	
	    }else {
	    	return;
	    } 	   
	}	
</script>  
</body>
</html>