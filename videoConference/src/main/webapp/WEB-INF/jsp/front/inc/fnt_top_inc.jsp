<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"/>
<%@ page import ="com.sohoki.backoffice.cus.org.vo.EmpInfoVO" %>
<%
EmpInfoVO loginVO = (EmpInfoVO) session.getAttribute("empInfoVO");
if(loginVO == null ){
%>
	<script type="text/javascript">
		alert("로그인 되지 않았습니다.");
		location.href="/front/resInfo/noInfo.do";		
	</script>
<%        
}else{ 
%> 
    <link rel="stylesheet" href="/css/main/menu.css">  
      <div id="header" class="subHeader">
            <div class="contents">
                <a href="/front/resInfo/Index.do"><h1 class="logo" ></h1></a>
                <ul class="nav">
                    <li>
                    	<a href="/front/resInfo/seatList.do" class="dropbtn">회의 자원 현황</a>
                    </li>
                    <li class="dropdown">
                    	<a href="/front/resInfo/resListInfo.do" class="dropbtn">예약현황</a>
						<!--
                    	<div class="dropdown-content">
						  <a href="/front/resInfo/resListInfo.do">시간별예약현황</a>
					      <a href="/front/resInfo/resMonthList.do">월별예약현황</a>
					      <a href="/front/resInfo/resList.do">목록보기</a>
					      <a href="/front/resInfo/resListInfo.do?searchRoomType=SWC_GUBUN_2">영상회의전체</a>
						  <a href="/front/resInfo/resListInfo.do?searchRoomType=SWC_GUBUN_1">일반회의전체</a>
					    </div>
						-->
                    </li>
                    <li><a href="/front/resInfo/resMypage.do">나의예약</a></li>
                    <li><a href="/front/resInfo/resNoticeList.do">공지사항</a></li>
                    
                    <% if (!loginVO.getAdminGubun().equals("")){ %>
	                <li><a href="javascript:fn_admin();" >관리자</a></li>
	                <%  }%>
                </ul>
                <div class="clearfix"></div>
            </div>
        </div>
<%
	}
%>   
	<script type="text/javascript">
	function fn_admin(){
		var url ="/backoffice/login.do";
		NewWindow(url, 'admin', '1024', '768', 'yes');
	}
	function fn_equip(){
		var url ="https://slcequinoxaawg.slc.or.kr:8443/portal";
		NewWindow(url, 'equip', '1024', '768', 'yes');
	}
    </script>

