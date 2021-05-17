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
	<title><spring:message code="URL.TITLE" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/calendar.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css"> 
    
    <script type="text/javascript" src="/js/new_calendar.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/boardManage/boardList.do">
<form:hidden path="pageSize" />
<form:hidden path="pageIndex" />
<form:hidden path="mode" />
<form:hidden path="boardGubun" />
<form:hidden path="searchCondition" />
<form:hidden path="searchKeyword" />
<form:hidden path="boardSeq" />

<input type="hidden" name="fileName" id="fileName" value="${regist.boardFile01}">
<c:import url="/backoffice/inc/top_inc.do" />
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
	                        <th>제목</th>
	                        <td colspan="3">${regist.boardTitle }</td>
	                    </tr>
	                    <c:choose>
	                       <c:when test="${regist.boardGubun eq 'NOT'}">
	                           <tr>
			                        <th>이름</th>
			                        <td style="text-align:left">
			                        	${regist.userNm } 
			                        </td>
			                        <th>사번</th>
			                        <td style="text-align:left">
			                        	${regist.boardRegId }
			                        </td>
			                    </tr>
			                    <tr>
			                        <th>이메일</th>
			                        <td style="text-align:left">
			                        	${regist.email }
			                        </td>                  
			                    </tr>
			                    <tr>
			                    	<th>공지기간</th>
			                        <td style="text-align:left">
			                        ${regist.boardNoticeStartdayTxt } ~ ${regist.boardNoticeEnddayTxt }	                        
			                        </td>	   
			                        <th>목록상단에고정</th>
			                        <td style="text-align:left">
			                        <c:choose>
			                        <c:when test="${regist.boardNoticeUseyn eq 'Y' }">
			                        예
			                        </c:when>
			                        <c:otherwise>
			                        아니오
			                        </c:otherwise>
			                        </c:choose>	                        
			                        </td>	                        
			                    </tr>
			                    
			                    <tr>
		                            <th>첨부파일</th>
		                            <td colspan="3">
		                            <c:if test="${regist.boardFile01 ne null}">
		                            ${regist.boardFile01}<a href="javascript:fileDown('${regist.boardFile02}');" class="reviseBtn addB">다운로드</a>
		                            <%-- ${regist.boardFile01 }<a href="/upload/${regist.boardFile01 }" class="reviseBtn addB">다운로드</a> --%>
		                            </c:if>
		                            </td>
		                        </tr>
	                       </c:when>
	                       <c:when test="${regist.boardGubun eq 'FAQ'}">
	                       		<tr>
		                            <th>등록일</th>
		                            <td style="text-align:left" colspan="3">${regist.boardRegdate }</td>
		                        </tr>	
	                             <tr>
			                        <th>노출여부</th>
			                        <td style="text-align:left" colspan="3">
			                        <c:choose>
			                        <c:when test="${regist.boardNoticeUseyn eq 'Y' }">
			                        예
			                        </c:when>
			                        <c:otherwise>
			                        아니오
			                        </c:otherwise>
			                        </c:choose>
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
            </div>
            </div>
            <div class="footerBtn">
            <c:if test="${regist.boardGubun eq 'QNA'}" >
	            <a href="javascript:check_form();" class="blueBtn" id="btnUpdate">답변등록</a>
             </c:if>	 
             <c:if test="${regist.boardGubun ne 'QNA'}" >
	            <a href="javascript:check_form();" class="blueBtn" id="btnUpdate">수정</a>
             </c:if>	 
	            <!-- <a href="javascript:del_form();" class="redBtn">삭제</a> -->
	            <a href="javascript:linkPage('1')" class="reviseBtn">목록</a>
	        </div>
        </div>
    </div>

<c:import url="/backoffice/inc/bottom_inc.do" />
</form:form>
</div>
<script type="text/javascript">

	// 파일 다운로드
	function fileDown(downloadName){
		$("form[name=regist]").attr("action", "/backoffice/boardManage/fileDownload.do?fileName="+downloadName).submit();
	}
	function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);		
		$("form[name=regist]").attr("action", "/backoffice/boardManage/boardList.do").submit();
	}	
		
	function check_form(){		   		   
		   $("form[name=regist]").attr("action", "/backoffice/boardManage/boardDetail.do").submit();
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
						document.location.href = document.location.href;				
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