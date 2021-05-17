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
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/holyList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="holySeq" id="holySeq" >

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                        기초관리
                        <span>></span>
                        <strong>휴일근무관리</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">총 <span>${totalCnt}</span>건의 휴일근무 신청자가 있습니다.</div>
                
                <section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>
		                		검색어
		                	</th>
		                	<td>
		                		<select name="searchCondition"  id="searchCondition">
									<option value="0">전체</option>
									<option value="1" <c:if test="${searchVO.searchCondition == '1' }"> selected="selected" </c:if>>이름</option>
									<option value="2" <c:if test="${searchVO.searchCondition == '2' }"> selected="selected" </c:if>>사번</option>
								</select>	
								<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}">     
								<a href="javascript:search_form();"><span class="searchTableB">조회</span></a>       
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:view_holy('Ins','0')" ><span class="deepBtn">등록</span></a>
		                	</td>		                	
						</tr>
                    </table>                
                <br/>
               
                </section>
            </div>

            <div class="Swrap tableArea">
                <table class="backTable">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>근무신청일</th>
                            <th>휴일명</th>
                            <!-- <th>휴일정보</th>
                            <th>휴일구분</th> -->
                            <th>부서</th>
                            <th>직급</th>
                            <th>이름</th>
                            <th>사번</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                     <c:forEach items="${resultList }" var="holyInfo" varStatus="status">
                        <tr>
                            <td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
                            <td><a href="javascript:view_holy('Edt','${ holyInfo.holySeq }')" class="underline" >${ holyInfo.holyDate }</a></td>
                            <td><a href="javascript:view_holy('Edt','${ holyInfo.holySeq }')" class="underline" >${ holyInfo.holyNm }</a></td>
                            <%-- <td>${ holyInfo.holyInfo }</td>
                            <td>${ holyInfo.holyGubun }</td> --%>
                            <td>${ holyInfo.orgName }</td>
                            <td>${holyInfo.posGrdNm }</td>
                            <td>${ holyInfo.empNm }</td>
                            <td>${ holyInfo.empNo }</td>
                            <td><a href="javascript:del_check('${ holyInfo.holySeq }');" class="grayBtn">삭제</a></td>
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
</form:form>
</div>
<script type="text/javascript">
   $(document).ready(function() { 
		if ("${status}" != "" ){
			if ("${status}" == "SUCCESS" ){
				alert("정상처리 되었습니다");					
			}else  {
				alert("처리 도중 문제가 발생 하였습니다.");				
			}	
		}						   
	});  
    function del_check(code){
    	if (confirm("삭제 하시겠습니까?")== true){
	    	apiExecute(
					"POST", 
					"/backoffice/basicManage/holyDelete.do",
					{
						holySeq : code
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
						document.location.href = document.location.href;	
					},
					null,
					null
				);	
	    }else {
	    	return;
	    } 	
    }
     function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);				
		$("form[name=regist]").submit();
	   }
	  function view_holy(code, code1){
		  $('#mode').val(code);
		  $('#holySeq').val(code1);
		  if (code == "Ins"){
			  $("form[name=regist]").attr("action", "/backoffice/basicManage/holyDetail.do").submit();  
		  }else {
			  $("form[name=regist]").attr("action", "/backoffice/basicManage/holyView.do").submit();
		  }
		  		  
	  }
	  function search_form(){		  
		  $("form[name=regist]").attr("action", "/backoffice/basicManage/holyList.do").submit();		  
	  }
	</script>
</body>
</html>