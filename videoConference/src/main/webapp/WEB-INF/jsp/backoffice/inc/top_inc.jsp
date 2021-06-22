<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="egovframework.com.cmm.AdminLoginVO" %>
<%
AdminLoginVO loginVO = (AdminLoginVO)session.getAttribute("AdminLoginVO");
   
if(loginVO == null ){
	
	%>
	<script type="text/javascript">
	location.href="/backoffice/login.do";
	</script>
	<%        
}else{ 
	%> 
    <header class="Mwrap">
        <section>
            <div class="subwidth">
                <h1><a href="/backoffice/resManage/resList.do?searchRoomType=swc_gubun_1"><img src="/img/logo.png" alt="logo" /></h1>
                <nav id="topMenu">
                    <ul>
                      
                        <% 
                        if (loginVO.getAuthorCode().equals("ROLE_ADMIN")  ){
                        %>  
                        <li class="dropdown">
                            <a href="/backoffice/basicManage/centerList.do" class="dropbtn">자원 관리</a>
                            <ul class="dropdown-content">
                                <li><a href="/backoffice/basicManage/centerList.do">회의실분류관리</a></li>
                                <li><a href="/backoffice/basicManage/officeSeatList.do">좌석관리</a></li>
                                <li><a href="/backoffice/basicManage/officeMeetingList.do">회의실관리</a></li>
                                <li><a href="/backoffice/basicManage/holyDayList.do">휴일관리</a></li>
                                <li><a href="/backoffice/basicManage/devicelist.do">did관리</a></li>
                                <li><a href="/backoffice/basicManage/equpList.do">비품관리</a></li>
                                <li><a href="/backoffice/basicManage/msgList.do">메시지관리</a></li>
                            </ul>
                      </li>
                      <li class="dropdown">
                          <a href="/backoffice/basicManage/managerList.do" class="dropbtn">시스템관리</a>
                          <ul class="dropdown-content">
                              <li><a href="/backoffice/basicManage/codeList.do">코드관리</a></li>
                              <li><a href="/backoffice/orgManage/empList.do">인사관리</a></li>
                              <!-- <li><a href="/backoffice/basicManage/holyList.do">휴일근무관리</a></li> -->
                              <li><a href="/backoffice/orgManage/depthList.do">부서관리</a></li>
                              <li><a href="/backoffice/basicManage/managerList.do">관리자관리</a></li>
                              <li><a href="/backoffice/orgManage/swcInfo.do">환경설정</a></li>
                          </ul>
                      </li>
                      <li class="dropdown">
                          <a href="/backoffice/companyManage/companyList.do" class="dropbtn">입주사관리</a>
                          <ul class="dropdown-content">
                              <li><a href="/backoffice/companyManage/companyList.do">입주사관리</a></li>
                              <li><a href="/backoffice/companyManage/userList.do">사용자관리</a></li>
                              <li><a href="/backoffice/companyManage/userList.do?comCode=C_00000004">일반사용자현황</a></li>
                              <li><a href="/backoffice/companyManage/tennList.do">크레딧 관리</a></li>
                          </ul>
                      </li>
					  <li class="dropdown">
                            <a href="/backoffice/boardManage/boardList.do?boardGubun=NOT" class="dropbtn">커뮤니티</a>
                            <ul class="dropdown-content sedrop">
                                <li><a href="/backoffice/boardManage/boardList.do?boardGubun=NOT">공지사항</a></li>
                                <!-- <li><a href="/backoffice/boardManage/boardList.do?boardGubun=QNA">Q&A</a></li> -->
                                <li><a href="/backoffice/boardManage/boardList.do?boardGubun=FAQ">FAQ</a></li>
                            </ul>
                      </li>
					  <%
                        }
                      %>
                      <li class="dropdown">
                         <a href="/backoffice/resManage/resList.do?searchRoomType=swc_gubun_1" class="dropbtn">예약관리</a>
                      </li>
                    </ul>
                </nav>
                <p>                                   
                    <a href="<c:url value='/backoffice/actionLogout.do'/>">로그아웃</a>
                </p>
            </div>
        </section>
    </header>
        <% } %>	    
