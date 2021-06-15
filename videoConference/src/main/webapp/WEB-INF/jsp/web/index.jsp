<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title><spring:message code="URL.TITLE" /></title>
    <!--css-->
    <link href="/front_res/css/reset.css" rel="stylesheet" />
    <link href="/front_res/css/swiper.css" rel="stylesheet">
    <link href="/front_res/css/jquery-ui.css" rel="stylesheet" />
    <link href="/front_res/css/needpopup.min.css" rel="stylesheet" type="text/css" >
    <link href="/front_res/css/style.css" rel="stylesheet" />
    <link href="/front_res/css/paragraph.css" rel="stylesheet" />
    <link href="/front_res/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/front_res/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
     
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/jquery-ui.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/js/main.js"></script>
    
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post">
<input type="hidden" id="itemGubun" name="itemGubun" value="ITEM_GUBUN_1">
<input type="hidden" id="paeGubun" name="paeGubun" value="index">
 <div class="main_back">
            <!--//header 추가-->
            <c:import url="/web/inc/top_inc.do" />
            <!--header 추가//-->
            <!--// left menu -->
            <c:import url="/web/inc/right_menu.do" />
            <!--left menu //-->
            <!--//contents-->
            <div class="contents">
                <div class="main_titB">
                    <p>사람을 잇는 관광</p>
                    <p class="main_tit">서울관광플라자 스마트회의 예약 시스템</p>
                </div> 
                 <!--slider -->
                <div class="slider_box">
                    <!-- Add Arrows -->
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <!-- meeting -->
                            <!-- //진행중인 회의가 3개 미만일 경우-->
                            <c:forEach items="${resultlist }" var="resInfo" varStatus="status">
                                <c:choose>
                                   <c:when test="${resInfo.res_seq eq '0'}">
                                      <div class="swiper-slide">
                                            <div class="slider_box">
			                                    <p class="slide_tit meeting_loading">${resInfo.meeting_name }</p>
			                                    <p class="meeting_noti">지금 바로 회의를 시작 해보세요</p>                                   
			                                </div>
			                                <div class="meeting_btn">
			                                    <div class="padding_box">
			                                        <a href="#" data-needpopup-show='#app_meeting' onclick="fn_resInfo('${resInfo.meeting_id}','${resInfo.time_seq }','${resInfo.swc_time}','${resInfo.meeting_name}','0','${resInfo.meeting_confirmgubun}' , '${resInfo.meeting_equpgubun}', '${resInfo.res_reqday}');fn_indexView();" class="booking_btn">예약하기</a>    
			                                    </div>                                    
			                                </div>
			                            </div>
                                   </c:when>
                                   <c:otherwise>
                                        <div class="swiper-slide">
			                                <div class="slider_box">
			                                    <p class="slide_tit meeting_ing">${resInfo.meeting_name }</p>
			                                    <p class="meeting_noti">회의 진행중 입니다</p>
			                                     ${resInfo.res_title }                                    
			                                </div>
			                                <div class="meeting_btn">
			                                    <div class="padding_box">
			                                        <a href="#" onclick="fn_resView('${resInfo.res_seq}')" class="booking_btn">자세히보기</a>  
			                                    </div>                                    
			                                </div>
			                            </div>
                                   </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                        </div>                 
                    </div>
                </div>                    
                <!-- // slider -->
            </div>
            <!--contents//-->
            <!--  공지 사항 시작 -->
            <div class="main-noti" id="dv_noyice">
                    <div class="main-noti-con contents">
                        <h3 class="font18"><a href="/web/notice.do">공지사항</a></h3>
                        <span id="sp_notice"></span>
                       
                    </div>
                </div>
           
           </div>
            <!--  공지 사항 끝 -->
        

         <!-- Swiper JS -->
         <script src="/front_res/js/swiper.js"></script>
         <script>
	        $( function() {
	        	 fn_noticeList();
	        });
            var swiper = new Swiper('.swiper-container', {
              slidesPerView: 3,
              spaceBetween: 30,
              slidesPerGroup: 3,
              loop: true,
              loopFillGroupWithBlank: true,
              navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
              },
              breakpoints : { // 반응형 설정이 가능 width값으로 조정
                  1034 : {
                    slidesPerView : 1,
                    slidesPerGroup: 1,
                  },
                },
            });
            function fn_noticView(boardSeq){
            	document.location.href='/web/notice.do?board_seq='+boardSeq;
            }
            function fn_indexView(){
            	
            }
            function fn_noticeList(){
	        	var url =  "/backoffice/boardManage/boardListAjax.do";
	        	var params = { 
			    	    		"pageIndex": "1",
			    	    		"boardGubun": "NOT",
			    	    		"adminYn" : "user",
			    	    		"searchKeyword" : $("#searchKeyword").val(),
			         			"pageUnit": $("#pageUnit").val()
	     		}; 
		    	uniAjax(url, params, 
		      			function(result) {
		 				       if (result.status == "LOGIN FAIL"){
		 				    	   alert(result.meesage);
		   						   location.href="/web/Login";
		   					   }else if (result.status == "SUCCESS"){
		   						   //총 게시물 정리 하기
		   						   $("#sp_notice").empty();
		   						   if (result.resultlist.length > 0){
		   							  
		   							   var obj = result.resultlist;
		   							   var costInfo  = "";
		   							   var a = "1";
		   							  
		   							   var sHtml ="<MARQUEE width='650' height='30'>";
		   							   for (var i in result.resultlist ){
		   								  sHtml	+="<a href='#' onClick='fn_noticView(\""+obj[i].board_seq+"\")'>"
					                            +"    <span class=\"noti_tit\">"+obj[i].board_title+"</span>"
					                            +"    <span>"+obj[i].board_update_date.substring(0,10)+"</span>";
					                           	+" </a>";
		   							   }
		   							   sHtml	+="</MARQUEE>";
		   							   $("#sp_notice").append(sHtml);
		   							  
		   						   }
	
		   					   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }    		
		        );
	        }
        </script>
        <c:import url="/web/inc/unimessage.do" />
</form:form>
</body>
</html>