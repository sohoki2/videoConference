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
    <link rel="stylesheet" href="/css/new/reset.css"> 
    
    
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/boardManage/boardList.do">	   	  
<c:import url="/backoffice/inc/top_inc.do" />	
<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }">
<form:hidden path="boardGubun" />
<input type="hidden" name="boardSeq" id="boardSeq">
<input type="hidden" name="mode" id="mode">
 
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>커뮤니티관리<span>></span>
                        <strong>
                          <c:choose>
			                <c:when test="${searchVO.boardGubun eq 'NOT'}">			                
                                                 공지사항
                            </c:when>
                            <c:when test="${searchVO.boardGubun eq 'FAQ'}">			                
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

            <div class="Swrap Asearch">
            <div class="Atitle">총 <span>${totalCnt}</span>건의 
            <c:choose>
				<c:when test="${searchVO.boardGubun eq 'NOT'}">			                
				공지사항이
				</c:when>
				<c:when test="${searchVO.boardGubun eq 'FAQ'}">			                
				FAQ가 
				</c:when>
				<c:otherwise>
				Q&A가 
				</c:otherwise>
			</c:choose>
				있습니다.
				</div>
                <section class="Bclear">
                <table class="pop_table searchThStyle">
                   
                   <tr>
                   <th>
                   		검색어
                   </th>
                   <td>
                   	<select name="searchCondition"  id="searchCondition">
                   		<option value="0">전체</option>
								<option value="1" <c:if test="${searchVO.searchCondition == '1' }"> selected="selected" </c:if>>제목</option>
								<option value="2" <c:if test="${searchVO.searchCondition == '2' }"> selected="selected" </c:if>>내용</option>
						</select>	
						<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}" class="margin-left10">
						<a href="javascript:search_form();" ><span class="lightgrayBtn">조회</span></a>
					</td>
					<c:if test="${regist.boardGubun ne 'QNA'}" >
                    <td class="text-right">
                        <a href="javascript:view_Board('Ins','0')"><span class="blueBtn">등록</span></a>
                      </td>
                     </c:if>
                    </tr>
                     </section>
                 </table>
                <Br/>
                 
                
            </div>

            <div class="Swrap tableArea">
                <table class=" backTable">
                   <c:choose>
			                <c:when test="${searchVO.boardGubun eq 'NOT'}">
			                    <thead>
			                        <tr>
			                            <th>번호</th>
			                            <th>제목</th>
			                            <th>등록일</th>
			                            <th>작성자</th>
			                            <th>아이디</th>
			                            <th>조회수</th>
			                            <th>삭제</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                       <c:forEach items="${resultList }" var="boardinfo" varStatus="status">
			                        <tr>
			                            <td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
			                            <td><a href="javascript:view_Board('Edt','${ boardinfo.boardSeq }')" class="underline" style="float:left;">${ boardinfo.boardTitle }</a></td>
			                            <td>${ boardinfo.boardUpdateDate }</td>
			                            <td>${ boardinfo.userNm }</td>
			                            <td>${boardinfo.boardRegId }</td>
			                            <td>${ boardinfo.boardVisited }</td>			                            
			                            <td><a href="javascript:del_check('${ boardinfo.boardSeq }');" class="grayBtn">삭제</a></td>
			                        </tr>
			                        </c:forEach>                       
			                    </tbody>
			                </c:when>
			                <c:when test="${searchVO.boardGubun eq 'FAQ'}">
			                    <thead>
			                        <tr>
			                            <th>번호</th>
			                            <th>제목</th>
			                            <th>등록일</th>
			                            <th>작성자</th>
			                            <th>아이디</th>
			                            <th>조회수</th>
			                            <th>노출여부</th>
			                            <th>삭제</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                       <c:forEach items="${resultList }" var="boardinfo" varStatus="status">
			                        <tr>
			                            <td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
			                            <td><a href="javascript:view_Board('Edt','${ boardinfo.boardSeq }')" class="underline" style="float:left;">${ boardinfo.boardTitle }</a></td>
			                            <td>${ boardinfo.boardUpdateDate }</td>
			                            <td>${ boardinfo.userNm }</td>
			                            <td>${boardinfo.boardRegId }</td>
			                            <td>${ boardinfo.boardVisited }</td>
			                            <td>${ boardinfo.boardNoticeUseyn }</td>			                            
			                            <td><a href="javascript:del_check('${ boardinfo.boardSeq }');" class="grayBtn">삭제</a></td>
			                        </tr>
			                        </c:forEach>                       
			                    </tbody>
			                </c:when>
			        		<c:otherwise>
			        		    <thead>
			                        <tr>
			                            <th>번호</th>
			                            <th>제목</th>
			                            <th>등록일</th>
			                            <th>부서</th>
			                            <th>직급</th>
			                            <th>이름</th>
			                            <th>사번</th>
			                            <th>조회수</th>
			                            <th>삭제</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                       <c:forEach items="${resultList }" var="boardinfo" varStatus="status">
			                        <tr>
			                            <td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
			                            <td><a href="javascript:view_Board('Edt','${ boardinfo.boardSeq }')" class="underline" style="float:left;">${ boardinfo.boardTitle }</a></td>
			                            <td>${ boardinfo.boardUpdateDate }</td>
			                            <td>${ boardinfo.orgName }</td>
			                            <td>${ boardinfo.posGrdNm }</td>
			                            <td>${ boardinfo.userNm }</td>
			                            <td>${ boardinfo.boardRegId }</td>
			                            <td>${ boardinfo.boardVisited }</td>		                            
			                            <td><a href="javascript:del_check('${ boardinfo.boardSeq }');" class="grayBtn">삭제</a></td>
			                        </tr>
			                        </c:forEach>                       
			                    </tbody>
			        		</c:otherwise>					        							        
				    </c:choose>
                   
                    
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
</form:form>    
</div>
<script type="text/javascript">

	function search_form(){		  
		  $("form[name=regist]").attr("action", "/backoffice/boardManage/boardList.do").submit();		  
	}
	function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);		
		$("form[name=regist]").submit();
	}
	function view_Board(code, code1){
		  $("#mode").val(code);
		  $("#boardSeq").val(code1);  
		  if (code == "Ins"){
			  $("form[name=regist]").attr("action", "/backoffice/boardManage/boardDetail.do").submit();
		  }else {
			  $("form[name=regist]").attr("action", "/backoffice/boardManage/boardView.do").submit();  			  			  
		  }		  
	}
	function del_check(code){
		 if (confirm("삭제 하시겠습니까?")== true){
		    	apiExecute(
						"POST", 
						"/backoffice/boardManage/boardDelete.do",
						{
							boardSeq : code
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
    </script>
</body>
</html>