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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <style>
    .pop_contents{width:96%;}
    </style>
</head>
<body>
<form:form name="regist" commandName="regist" method="post" action="/backoffice/popup/empSearchList.do">	   	   
<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }">
<input type="hidden" name="admin" id="admin" value="${searchVO.admin }">
<input type="hidden" name="code" id="code" value="${searchVO.code }">
<input type="hidden" name="mode" id="mode" value="${searchVO.mode }">

     <div class="pop_container">
		<!--//팝업 타이틀-->
		<div class="pop_header">
		    <div class="pop_contents">
				<h2 style="padding-left:8px;">
					<c:choose>
					     <c:when test="${searchVO.mode eq 'excep' }">
					        담당 직원 선택
					     </c:when>
					     <c:otherwise>
					         직원조회
					     </c:otherwise>
					</c:choose>
				</h2>	
			</div>	
		</div>
		<!--팝업타이틀//-->
		<!--//팝업 내용-->
		<div class="pop_contents" style="padding-top:8px;">
            <div id="dv_searchGubun">
            <select name="searchCondition"  id="searchCondition" style="ime-mode:active;">
				<option value="deptname" <c:if test="${searchVO.searchCondition == 'deptname' }"> selected="selected" </c:if>>부서명</option>
				<option value="empname" <c:if test="${searchVO.searchCondition == 'empname' }"> selected="selected" </c:if>>이름</option>
			</select>
			&nbsp;&nbsp;	
            <input type="text" name="searchKeyword" id="searchKeyword" value="${searchVO.searchKeyword}" size="15" style="ime-mode:active;" />
			<a href="javascript:search_confirm();"><span class="blueBtn">조회</span></a>
            <p class="searchP">이름을 선택해 주세요.</p>
            </div>
            
            
			<table class="pop_table thStyle searchT">
				<tbody class="search">
					<tr>
						<th style="width:35%">부서명</th>
						<th style="width:20%">이름</th>
						<th style="width:20%">사번</th>
					</tr>
					<c:forEach items="${resultList }" var="userinfo" varStatus="status">
					<tr class="click">
						<td style="width:35%; cursor: default;">${userinfo.deptname }</td>
						<td style="width:20%"><a href="javascript:userInfoJ('${userinfo.deptname }','${userinfo.empname }','${userinfo.empno }','${userinfo.empid }','${userinfo.empmail }','${userinfo.deptcode }','${userinfo.emptelphone }')">${userinfo.empname }</a></td>
                        <td style="width:20%; cursor: default;">${userinfo.empno }</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</div>
		<div class="footerBtn">
            <a href="javascript:self.close();" class="deepBtn">닫기</a>
        </div>
	</div>
</form:form>
<script type="text/javascript">
   function userInfoJ(deptname, empname, empno, empid, empmail, deptcode, emptelphone){
	   if ($("#code").val() == "adm"){
		   $(opener.document).find("#deptName").removeAttr();
		   $(opener.document).find("#adminName").removeAttr();
		   
		   $("#deptName", opener.document).val(deptname);
		   $("#adminName", opener.document).val(empname); 
		   $(opener.document).find("#deptName").attr("readonly",true);
		   $(opener.document).find("#adminName").attr("readonly",true);
		   
		   $("#adminId", opener.document).val(empid);
		   $("#empNo", opener.document).val(empno);
		   $("#adminEmail", opener.document).val(empmail);
		   $("#deptId", opener.document).val(deptcode);
		   $("#adminTel", opener.document).val(emptelphone);
		   self.close();
	   }else {

		   opener.parent.fn_EmInt(empno, empname);
	   }	   
   }
   $(document).ready(function() {     
		//alert("${status}");
		if ($("#code").val() == "except"){
			$("#dv_searchGubun").hide();
		}else {
			$("#dv_searchGubun").show();
		}
			
	});	
   function search_confirm(){
	   if (any_empt_line_id("searchCondition", "검색방법을 선택 하지 않았습니다.") == false) return;	
	   if (any_empt_line_id("searchKeyword", "검색어를 입력 하지 않았습니다.") == false) return;	
	   $("form[name=regist]").attr("action", "/backoffice/popup/empSearchList.do").submit();
	   return;
   }
</script>
</body>
</html>