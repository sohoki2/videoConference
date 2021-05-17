<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    
    <link rel="stylesheet" href="/css/new/paragraph.css">    
    <link rel="stylesheet" href="/css/new/reset.css"> 
    <link rel="stylesheet" href="/css/new/swiper.css">
    
        
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    
    <link rel="stylesheet" href="/css/new/jquery-ui.css">
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    
    <script src="/js/popup.js"></script>
    
    <script type="text/javascript" src="/js/com_resInfo.js"></script>
    <script type="text/javascript" src="/js/common_res.js"></script>
</head>
<body>
<div id="wrapper" >
        <c:import url="/front/inc/fnt_top_inc.do" />
        
        <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/resNoticeList.do">	
        <input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }" />
        <input type="hidden" name="searchCondition" id="searchCondition" value="0" />
        <input type="hidden" name="boardSeq" id="boardSeq" />
        <div id="container">
            <div class="contents">
                <h2 class="sub_tit">공지사항</h2>                
                <!-- contents -->
                <div class="sub01">
                    <div class="day_con">
                        <!-- top button -->
                        <div class="right_box">
                            <div class="list_search">
                                <form>
                                    <fieldset>
                                        <legend>검색창</legend>
                                        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력해 주세요">
                                        <a href="fn_search()" class="btn_search"></a>                                        
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <!-- // top button -->
                        <!-- list style -->
                        <table class="list_box noti-table">
                            <tr class="list_meeting">
                                <th class="noti-num">NO</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>조회수</th>
                                <th>날짜</th>
                            </tr>
                            <c:forEach items="${resultlist }" var="boardinfo" varStatus="status">
                            <tr class="list_meeting">
                                <td class="noti-num"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
                                <td><a href="javascript:view_Board('${ boardinfo.boardSeq }')" class="underline" style="float:left;">${ boardinfo.boardTitle }</a></td>
                                <td>${ boardinfo.userNm }</td>			                          
			                    <td>${ boardinfo.boardVisited }</td>	                         
                                <td>${ boardinfo.boardRegdate }</td>
                            </tr>
                            </c:forEach>                            
                        </table>                       
                        <!-- // list style -->

                        <!-- page number --> 
                        <div class="page_num">
                           <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
                        </div>
                    </div>
                </div>
                <!-- // contents -->
            </div>            
        </div>
      </form:form>        
</div>        
<script type="text/javascript">
   function fn_search(){
	   $("form[name=regist]").attr("action", "/front/resInfo/resNoticeList.do").submit();
   }
   function view_Board(boardSeq){
		  $("#boardSeq").val(boardSeq);
		  $("form[name=regist]").attr("action", "/front/resInfo/resNoticeView.do").submit();  			  			  
		  		  
	}

</script>
</body>
</html>