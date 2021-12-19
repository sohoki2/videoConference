<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title><spring:message code="URL.TITLE" /></title>

    <!--css-->
    <link href="/visited/css/reset.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/visited/css/needpopup.min.css">
    <link href="/visited/css/jquery-ui.css" rel="stylesheet" />
    
    <link href="/visited/css/style.css" rel="stylesheet" />
    <link href="/visited/css/paragraph.css" rel="stylesheet" />
    <link href="/visited/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/visited/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
     
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/visited/js/jquery-ui.js"></script>
    <script src="/visited/js/common.js"></script>
</head>
<body>
    <div class="wrapper main_back">
        <!--//header 추가-->
        <c:import url="/visit/inc/top_inc.do" />
        <!--header 추가//-->
        <!--left menu //-->
        <!--//contents-->
        <div class="contents">
            <div class="main_tit">
                <p>새로운 서울, 새로운 관광</p>
                                   안녕하세요 서울관광플라자 방문 예약시스템입니다.
            </div>
            <div class="main_wbox">
                <p class="main_wtit">방문 절차 안내</p>
                <div class="main_scroll">
                    <ul class="main_step">
                        <li><i></i><span>1. 방문 신청</span></li>
                        <li><i></i><span>2. 피방문자 통보</span></li>
                        <li><i></i><span>3. 내부 승인</span></li>
                        <li><i></i><span>4. 방문 소속</span></li>
                        <li><i></i><span>5. 방문 완료</span></li>
                    </ul>    
                </div>
                
            </div>
            <div class="row">
                <div class="mg-3">
                    <div class="main_wbox main_wxbox dis_flex" onclick="location.href='/visit/VisitReser.do' ">
                        <div>
                            <i class="main_icon_reser"></i>
                            <p class="main_wtit">방문신청하기</p>
                            <span class="main_wsubtit">방문자 예약 시스템으로 편리한
                                                              방문 신청이 가능합니다.</span>
                        </div>                        
                    </div>
                </div>
                <div class="mg-3">
                    <div class="main_wbox main_wxbox dis_flex" onclick="location.href='/visit/VisitSearch.do??visitedGubun=VISITED_GUBUN_1' ">
                        <div>
                            <i class="main_icon_reser"></i>
                            <p class="main_wtit">방문신청 조회</p>
                            <span class="main_wsubtit">방문신청 목록을 조회할 수 있습니다.</span>
                        </div>                        
                    </div>                  
                </div>
				<div class="mg-3">
                    <div class="main_wbox main_wxbox dis_flex" onclick="location.href='/visit/TourReser.do' ">
                        <div>
                            <i class="main_icon_tour"></i>
                            <p class="main_wtit">투어신청하기</p>
                            <span class="main_wsubtit">서울관광플라자 투어신청이 가능합니다.</span>
                        </div>                        
                    </div>                  
                </div>
				<div class="mg-3">
                    <div class="main_wbox main_wxbox dis_flex" onclick="location.href='/visit/VisitSearch.do?visitedGubun=VISITED_GUBUN_2' ">
                        <div>
                            <i class="main_icon_search"></i>
                            <p class="main_wtit">투어신청 조회</p>
                            <span class="main_wsubtit">투어신청 목록을 조회할 수 있습니다.</span>
                        </div>                        
                    </div>                  
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</body>
</html>
