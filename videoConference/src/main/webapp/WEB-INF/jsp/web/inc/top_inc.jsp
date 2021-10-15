<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="java.util.*"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"/>
<%@ page import ="com.sohoki.backoffice.cus.org.vo.EmpInfoVO" %>

<%
   EmpInfoVO loginVO = (EmpInfoVO) session.getAttribute("empInfoVO");


   if(loginVO == null ){
	   %>
	   	<script type="text/javascript">
	   		alert("로그인 되지 않았습니다.");
	   		location.href="/web/Login.do";		
	   	</script>
<%        
   }else{ 
	   
	   
%> 
<header>
     <div class="contents">
         <h1 onclick="location.href='/web/index.do'"><img src="/front_res/img/logo.png" alt="서울관광플라자"></h1>
         <!--//menu-->
         <div class="menu">
             <ul>
                 <!--메뉴 선택 시 li에 active 추가-->
                 <% if (!loginVO.getComCode().equals("C_00000004") ){ %>
                 <li class="menu01"><a href="/web/seatInfo.do">자율좌석예약</a></li>
                 <li class="menu02"><a href="/web/meetingDay.do">회의실예약</a></li>
                 <% } %>
                 <li class="menu04"><a href="/web/coronation.do">시설대관</a></li>
                 <li class="menu03"><a href="/web/myPage.do">나의예약</a></li>
             </ul>
         </div>
         <div class="leftMenu">
             <span class="" onclick="openNav()">메뉴;</span>
         </div>
         <!--menu//-->
     </div>
</header>
<%
   }
%>