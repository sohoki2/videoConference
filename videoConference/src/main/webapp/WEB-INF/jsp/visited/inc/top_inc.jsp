<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
    <div class="contents">
        <h1 onclick="location.href='index.do'"><img src="img/logo.png" alt="서울관광플라자"></h1>
        <!--//menu-->
        <div class="menu">                    
            <ul>
                <!--메뉴 선택 시 li에 active 추가-->
                <li><a href="/visited/index.do">홈</a></li>
                <li><a href="/visited/visitReser.do'">방문신청하기</a></li>
                <li><a href="/visited/visitSearch.do">방문신청조회</a></li>
                <li><a href="/visited/tourReser.do">투어신청</a></li>
            </ul>
        </div>
        <div class="leftMenu">
            <span class="" onclick="openNav()">메뉴;</span>
        </div>
        <!--menu//-->
        <div class="back" id="mySidenav">
		    <div class="sidenav" id="mySidenav1">
		        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>        
		        <div class="gnb user_reser_b">
		            <p>MENU</p>
		            <ul>
		                <li onclick="location.href='/visited/index.do' ">홈</li>
		                <li onclick="location.href='/visited/visitReser.do' ">방문신청하기</li>
		                <li onclick="location.href='/visited/visitSearch.do' ">방문신청조회</li>
		                <li onclick="location.href='/visited/tourReser.do' ">투어신청</li>
		            </ul>
		        </div>
		    </div>
		    <div class="backShadow"></div>
		</div>
    </div>
</header>