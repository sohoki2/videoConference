<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
    <div class="contents">
        <h1 onclick="location.href='/visit/Index.do'"><img src="/visited/img/logo.png" alt="서울관광플라자"></h1>
        <!--//menu-->
        <div class="menu">                    
            <ul>
                <!--메뉴 선택 시 li에 active 추가-->
                <li><a href="/visit/Index.do">홈</a></li>
                <li><a href="/visit/VisitReser.do">방문신청하기</a></li>
                <li><a href="/visit/VisitSearch.do?visitedGubun=VISITED_GUBUN_1">방문신청조회</a></li>
                <li><a href="/visit/TourReser.do">투어신청</a></li>
                <li><a href="/visit/VisitSearch.do?visitedGubun=VISITED_GUBUN_2">투어신청조회</a></li>
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
		                <li onclick="location.href='/visit/Index.do'">홈</li>
		                <li onclick="location.href='/visit/VisitReser.do'">방문신청하기</li>
		                <li onclick="location.href='/visit/VisitSearch.do?visitedGubun=VISITED_GUBUN_1'">방문신청조회</li>
		                <li onclick="location.href='/visit/TourReser.do'">투어신청</li>
		                <li onclick="location.href='/visit/VisitSearch.do?visitedGubun=VISITED_GUBUN_2'">투어신청조회</li>
		            </ul>
		        </div>
		    </div>
		    <div class="backShadow"></div>
		</div>
    </div>
</header>