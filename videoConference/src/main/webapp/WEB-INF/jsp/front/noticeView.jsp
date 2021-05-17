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
<div id="wrapper">
        <c:import url="/front/inc/fnt_top_inc.do" />
        <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/resNoticeList.do">	
        <input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }" />
        <input type="hidden" name="searchCondition" id="searchCondition" value="0" />
        <input type="hidden" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword }" />
        <input type="hidden" name="boardSeq" id="boardSeq" value="${regist.boardSeq }"/>
        <input type="hidden" name="boardGubun" id="boardGubun" value="${regist.boardGubun }"/>
        
        <div id="container">
            <div class="contents">
                <h2 class="sub_tit">공지사항</h2>                
                <!-- contents -->
                <div class="sub01">
                    <div class="day_con">
                        <div class="noti-tit">
                            <div class="left_box">${regist.boardTitle }</div>
                            <div class="right_box"><span>${regist.userNm }</span><span>${regist.boardRegdate }</span></div>
                        </div>    
                        <div class="clearfix"></div>
                        <span class="noti-txt">${regist.boardContent }</span>
                        
                        <div class="prev_next">
                        <c:if test="${regist.preBoardSeq != 0}">
                            <div class="prev_box">
                                <a href="javascript:fn_page('${regist.preBoardSeq}')">
                                    <span>이전글</span>
                                    <span>${regist.preBoardTitle}</span>
                                    <span class="date right_box">${fn:substring(regist.preBoardRegDate,0,10)}</span>
                                </a>
                            </div>
                        </c:if>
                        <c:if test="${regist.nextBoardSeq != 0}">
                            <div class="next_box">
                                <a href="javascript:fn_page('${regist.nextBoardSeq}')">
                                    <span>다음글</span>
                                    <span>${regist.nextBoardTitle}</span>
                                    <span class="date right_box">${fn:substring(regist.nextBoardRegDate,0,10)}</span>
                                </a>
                            </div>   
                        </div>    
                        </c:if>
                    </div>
                    <div class="pop_footer"><a href="javascript:linkPage()" class="pop_btn">목록으로</a></div>
                </div>
                <!-- // contents -->
            </div>            
        </div>
        </form:form>
    </div>
</body>
<script type="text/javascript">
	function linkPage() {
		$("form[name=regist]").attr("action", "/front/resInfo/resNoticeList.do").submit();
	}	
	function fn_page(boardSeq){
		 $("#boardSeq").val(boardSeq);
		 $("form[name=regist]").attr("action", "/front/resInfo/resNoticeView.do").submit();
	}

</script>
</html>