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
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/jquery-ui.js"></script>
    
    <script src="/front_res/js/com_resInfo.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>    
</head>
<body>
<form:form name="regist" commandName="regist" method="post" >
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }" />
<input type="hidden" name="pageSize" id="pageSize"  value="${regist.pageSize }" />
<input type="hidden" name="pageUnit" id="pageUnit"  value="${regist.pageUnit }"/>

 <!--//header 추가-->
            <c:import url="/web/inc/top_inc.do" />
            <!--header 추가//-->
            <!--// left menu -->
            <c:import url="/web/inc/right_menu.do" />
            <!--left menu //-->
        <!--//contents-->
        <div class="contents">
            <div class="whiteBack mybooking">
                <h5>서울관광플라자 공지사항입니다</h5>      
                <section>
                <table class="my_T notice" id="tb_notice">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>조회수</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr onClick="location.href='noticeView.html'">
                            <td>1</td>
                            <td>공지사항입니다</td>
                            <td>관리자</td>
                            <td>20</td>
                            <td>2021-05-20</td>
                        </tr>
                    </tbody>
                </table>
                </section>
                <!--//page number-->
               <div id="dv_page"></div>
               <!--page number//-->
             </div>
        </div>
        <!--contetns//-->

        <!--needpopup script-->
        <script src="/front_res/js/needpopup.min.js"></script>
        <script type="text/javascript">
	        $( function() {
			    	$("#boardGubun").val("res");
			    	fn_noticeList();
			});
	        function fn_noticeList(){
	        	var gubun = $("#boardGubun").val();
	        	var url =  "/backoffice/boardManage/boardListAjax.do";
	        	var params = { 
			    	    		"pageIndex": $("#pageIndex").val(),
			    	    		"boardGubun": "Not",
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
		   						   $("#tb_notice > tbody").empty();
		   						   if (result.resultlist.length > 0){
		   							   var sHtml = "";
		   							   var obj = result.resultlist;
		   							   var costInfo  = "";
		   							   var a = "1";
		   							   for (var i in result.resultlist ){
		   								  
		   								  sHtml	+="<tr onClick='fn_noticView(\""+obj[i].board_seq+"\")'>"
					                            +"    <td>"+a+"</td>"
					                            +"    <td>"+obj[i].board_title+"</td>"
					                            +"    <td>"+obj[i].user_nm+"</td>"
					                            +"    <td>"+obj[i].board_visited+"</td>"
					                            +"    <td>"+obj[i].board_update_date.substring(0,10)+"</td>";
					                           	+" </tr>";
		   								  a = parseInt(a)+1;
		   							   }
		   							   $("#tb_notice > tbody").append(sHtml);
		   							   
		   							   //페이지 설정 
		   							   var pageObj = result.paginationInfo
		  						       var pageHtml = ajaxPaging(pageObj.currentPageNo, pageObj.firstPageNo, pageObj.recordCountPerPage, 
								                                 pageObj.firstPageNoOnPageList, pageObj.lastPageNoOnPageList, 
								                                 pageObj.totalRecordCount, pageObj.pageSize, "ajaxPageChange");
								        $("#dv_page").html(pageHtml);
		   						   }
	
		   					   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }    		
		        );
	        }
            needPopup.config.custom = {
                'removerPlace': 'outside',
                'closeOnOutside': false,
                onShow: function() {
                    console.log('needPopup is shown');
                },
                onHide: function() {
                    console.log('needPopup is hidden');
                }
            };
            needPopup.init();
        </script>
</form:form>
</body>
</html>