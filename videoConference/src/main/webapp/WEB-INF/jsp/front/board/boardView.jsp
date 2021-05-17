<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<%@ page import ="com.sohoki.backoffice.cus.org.vo.EmpInfoVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title><spring:message code="URL.TITLE" /></title>   
    <link href="/css/frn/reset.css" rel="stylesheet" />
    <link href="/css/frn//page.css" rel="stylesheet" />
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script src="/js/popup.js"></script>
    
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/front/board/boardList.do">	   	  
	 
<form:hidden path="pageSize" />
<form:hidden path="pageIndex" />
<form:hidden path="mode" />
<form:hidden path="boardGubun" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />
<form:hidden path="boardSeq" />
<%
     EmpInfoVO user = (EmpInfoVO)session.getAttribute("empInfoVO");  
     System.out.println("user:" + user);
     
     if(user == null ){
       %>
      	   <script type="text/javascript">
      	    location.href="/front/main.do";
      	   </script>
    <%        
     }else{ 
    %>
    <input type="hidden" name="userId" id="userId" value="<%=user.getEmpno() %>"/>
    <% } %>
<input type="hidden" name="empNo" id="empNo" value="${regist.boardRegId}">
    
<c:import url="/front/inc/fnt_top_inc.do" />

<div class="Utitle subheader">
        <div class="subwidth">
            <h2>커뮤니티</h2>
            <p> 국민건강보험에서 알려드립니다.</p>
                <div class="infomenuU rightB">
                    <img src="/images/icon_home.png" alt="homeicon" />
                    <span>></span>
                                   커뮤니티
                    <span>></span>
                    <strong>
                    <c:choose>
	                   <c:when test="${regist.boardGubun eq 'NOT'}">			                
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
               <div class="clear"></div>
        </div>
    </div>
    <div class="subwidth">
       <div class="rightT">
           <div class="Asearch">
               <div class="intU">
                   <c:choose>
	                   <c:when test="${regist.boardGubun eq 'NOT'}">			                
                       <p><span>▶</span> 공지사항을 통해 궁금한 점을 해결하세요.</p>
                       </c:when>
                       <c:when test="${regist.boardGubun eq 'FAQ'}">			                
                       <p><span>▶</span> FAQ에서 자주 묻는 질문을 통해 궁금한 점을 해결하세요.</p>
                       </c:when>
                       <c:otherwise>
                       <p><span>▶</span> Q&A 질문을 통해 궁금한 점을 해결하세요.</p>
                       </c:otherwise>
                     </c:choose>
               </div>
           </div>

           <div class="tableArea noneT cancleT">
               <table class="margin-top30 pop_table thStyle backTable margin-bottom20">
                   <tbody>
                       <tr class="tableM">
	                        <th>제목</th>
	                        <td colspan="3">${regist.boardTitle }</td>
	                    </tr>
	                    <c:choose>
	                       <c:when test="${regist.boardGubun eq 'NOT'}">
	                           <tr>
			                        <th>작성자</th>
			                        <td style="text-align:left" colspan="3">${regist.userNm }
			                        </td>                       
			                    </tr>
			                    <tr>
			                        <th>공지기간</th>
			                        <td style="text-align:left" colspan="3">
			                        ${regist.boardNoticeStartday }&nbsp;~&nbsp;${regist.boardNoticeEndday }	                        
			                        </td>	                        
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
			                    
			                    <tr>
		                            <th>첨부파일</th>
		                            <td colspan="3">
		                            <c:if test="${regist.boardFile01 ne null}">
		                            ${regist.boardFile01}<a href="javascript:fileDown('${regist.boardFile01}');" class="reviseBtn addB">다운로드</a>
		                            <%-- ${regist.boardFile01 }<a href="/upload/${regist.boardFile01 }" class="reviseBtn addB">다운로드</a> --%>
		                            </c:if>
		                            </td>
		                        </tr>
	                       </c:when>
	                       <c:when test="${regist.boardGubun eq 'FAQ'}">
		                       <tr class="tableM">
			                        <th>등록일</th>
			                        <td style="text-align:left" colspan="3">${regist.boardRegdate }</td>
			                    </tr>
	                             <tr>
			                        <th>작성자</th>
			                        <td style="text-align:left" colspan="3">${regist.userNm }
			                        </td>  	                        
			                    </tr>		
			                    <tr>
		                            <th>첨부파일</th>
		                            <td colspan="3">
		                            <c:if test="${regist.boardFile01 ne null}">
		                            ${regist.boardFile01}<a href="javascript:fileDown('${regist.boardFile01}');" class="reviseBtn addB">다운로드</a>
		                            <%-- ${regist.boardFile01 }<a href="/upload/${regist.boardFile01 }" class="reviseBtn addB">다운로드</a> --%>
		                            </c:if>
		                            </td>
		                        </tr>                    
	                       </c:when>
	                       <c:otherwise>
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
							<c:when test="${regist.boardGubun eq 'QNA'}">
								<tr>
			                        <th>질문내용 </th>
			                        <td colspan="3" style="text-align:left">${regist.boardContent }</td>
			                    </tr>
							</c:when>
						<c:otherwise>
								<tr>
									<th>내용 </th>
									<td colspan="3" style="text-align:left">${regist.boardContent }</td>
			                    </tr>
	                       </c:otherwise>
	                    </c:choose>
	                    <c:if test="${regist.boardGubun eq 'QNA'}" >
	                    <tr>
	                        <th>답변 내용 </th>
	                        <td colspan="3" style="text-align:left">${regist.boardReturnContent }</td>
	                    </tr>
	                    </c:if>	  
                   </tbody>
               </table>
               <div class="footerBtn">
                   <c:if test="${regist.boardGubun eq 'QNA'}">                   
                   <a href="javascript:check_form('Edt');" class="redBtn" id="btnUpdate">수정</a>
                   </c:if>
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

$(document).ready(function () {
	if($("#userId").val() != $("#empNo").val()){
		$("#btnUpdate").removeClass();
		$("#btnUpdate").html("");
	}
});

	function fileDown(downloadName){
		$("form[name=regist]").attr("action", "/backoffice/boardManage/fileDownload.do?fileName="+downloadName).submit();
	}
	function linkPage() {
		$(":hidden[name=pageIndex]").val($("#pageIndex").val());		
		$("form[name=regist]").attr("action", "/front/board/boardList.do").submit();
	}	
	function check_form(code){
		   $("#mode").val(code);
		   $("form[name=regist]").attr("action", "/front/board/boardDetail.do").submit();
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