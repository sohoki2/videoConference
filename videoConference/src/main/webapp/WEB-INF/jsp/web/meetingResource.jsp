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
    <script src="/front_res/js/com_resInfo.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
</head>
<body>
<!--//header 추가-->
<form:form name="regist" commandName="regist" method="post" >
<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }" />
<input type="hidden" name="pageSize" id="pageSize"  value="${regist.pageSize }" />
<input type="hidden" name="pageUnit" id="pageUnit"  value="${regist.pageUnit }"/>
            <c:import url="/web/inc/top_inc.do" />
            <!--header 추가//-->
            <!--// left menu -->
            <c:import url="/web/inc/right_menu.do" />
            <!--left menu //-->
        <!--//contents-->
        <div class="contents">
            <!--//floor Btn-->
            <div id="allFloors">
	            <div class="contents">
	                <div class="flooreArea float_left" id="dv_floor">
	                    <c:forEach items="${floorinfo }" var="floorList" varStatus="status">
	                       <a href="#" onClick="res.fn_floorSearch(${floorList.floor_seq })" name="btn_floor" id="btn_${floorList.floor_seq }" class="<c:if test="${floorList.floor_seq  eq regist.floorSeq}" >active</c:if>">${floorList.floor_name }</a>
	                    </c:forEach>
	                    
	                </div>               
	                <div class="clear"></div>
	            </div>
	        </div>
        <!--floor Btn//-->
        <!--//contents-->
        <div class="contents resource_margT">
           <div class="line">
            <!--//date picker-->
                <div class="contents">
                    <div class="float_right">
                    <button type="button" class="resource" onClick="location.href='/web/meetingDay.do'">회의실 예약</button>
                  </div>
                  <div class="dateBox float_left">
                      <input type="text" id="searchKeyword" name="searchKeyword" placeholder="회의실을 검색해보세요" class="inputSearch">
                      <div class="searchIcon">
                        <a href="" onClick="fn_search()" class="searchBtn">검색</a>
                      </div>
                      <div class="clear"></div>
                   </div>
                   <div class="clear"></div>
                </div>
              <!--date picker//-->
           </div>
            <div class="whiteBack resourceT">
                <h5>회의실 검색하여 해당 회의실의 상세 내용을 확인하실 수 있습니다</h5>       
                <section>
                    <table class="my_T" id="tb_meetingInfo">
                        <thead>
                            <tr>
                                <th>NO</th>
                                <th>층</th>
                                <th>회의실명</th>
                                <th>회의실설명</th>
                                <th>최대사용인원</th>
                                <th>이용크레딧</th>
                                <th>사용여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </section>
             </div>
             <div id="dv_page"></div>
        </div>
        <!--contetns//-->

        <!--//팝업-->
        <!--//퇴실 팝업-->
        <div id='cancle_popup' class="needpopup">
            <p>
                             
            </p>
        </div>
        <!--퇴실 팝업-//->

        <!--needpopup script-->
    
        <script src="/front_res/js/needpopup.min.js"></script>
        <script>  
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
        <script type="text/javascript">
		    $( function() {
		    	fn_meetingList();
		    });
            function fn_meetingList(){
            	var url = "/backoffice/basicManage/officeMeetingListAjax.do";
            	var params = { 
			    	    		"pageIndex": $("#pageIndex").val(),
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
		   						   $("#tb_meetingInfo > tbody").empty();
		   						   if (result.resultlist.length > 0){
		   							   var sHtml = "";
		   							   var obj = result.resultlist;
		   							   var costInfo  = "";
		   							   for (var i in result.resultlist ){
		   								   
		   								  costInfo  = obj[i].pay_classification === "PAY_CLASSIFICATION_2" ? obj[i].pay_classification_txt : obj[i].pay_classification_txt 
		   		                		      + ":" + obj[i].pay_gubun_txt +": 사용 크레딧:" + obj[i].pay_cost;
		   		             
		   								  sHtml	+="<tr>"
					                            +"    <td>"+i+"</td>"
					                            +"    <td>"+obj[i].floor_name+"</td>"
					                            +"    <td>"+obj[i].meeting_name+"</td>"
					                            +"    <td>"+obj[i].meetingroom_remark+"</td>"
					                            +"    <td>"+obj[i].max_cnt+"명</td>"
					                            +"    <td>"+costInfo+"</td>"
					                            +"    <td>"+obj[i].meeting_useyn+"</td>"
					                            +"</tr>";
		   							   }
		   							   $("#tb_meetingInfo > tbody").append(sHtml);
		   							   
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
            function fn_search(){
            	if (any_empt_line_id("searchKeyword", "검색어를 입력해 주세요.") == false) return;	
            	$("#pageIndex").val("1");
            	fn_meetingList();
            }
            function ajaxPageChange(pageNo) {
           	   $(":hidden[name=pageIndex]").val(pageNo);
           	   fn_meetingList();
       	    }
        </script>
</form:form>  
</body>
</html>