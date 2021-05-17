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
     <link rel="stylesheet" href="/css/new/jquery-ui.css"> 
        
    <script type="text/javascript" src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="/js/front/common.js"></script>
    <script type="text/javascript" src="/js/front/uni_common.js"></script>
    <script type="text/javascript" src="/js/front/com_resInfo.js"></script>
    
    
    <script src="/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    
    <script src="/js/popup.js"></script>
</head>
<body>
 <div id="wrapper">
        <c:import url="/front/inc/fnt_top_inc.do" />
        
        
        <div id="container">
            <div class="contents">
                <h2 class="sub_tit">회의실 현황</h2>    
                <form:form name="regist" commandName="regist" method="post" action="/front/resInfo/resList.do" enctype='application/json'>  
                <input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">   
                <input type="hidden" name="searchCondition" id="searchCondition" value="0">   
                     
                <!-- contents -->
                <div class="sub01">
                    <div class="day_con">
                        <!-- top button -->
                        <div class="left_box">
                            <select id="searchCenterId"  name="searchCenterId" onChange="front_common.fn_floorState()">
                                <option value=''>선택</option>
                                <c:forEach items="${selectCenter}" var="mail">
				                            <option value="${mail.centerId}">${mail.centerNm}</option>
				                </c:forEach>
                            </select>
                            <span id="sp_floor"></span>
                            <div class="list_search">
                                <form>
                                    <fieldset>
                                        <legend>검색창</legend>
                                        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="회의실을 검색해보세요.">
                                        <a href="#" onclick="seatInfo.seatList()" class="btn_search"></a>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="right_box">
                        </div>
                        <div class="clearfix"></div>
                        <!-- // top button -->
                        <!-- list style -->
                        <table class="list_box" id="tb_seatList">
                           <thead>
                            <tr class="list_meeting">
                                <th>NO</th>
                                <th>지점명</th>
                                <th>층수</th>
                                <th>회의실명</th>
                                <th>회의실 구분</th>
                                <th>담당자</th>
                                <th>사용현황</th>
                            </tr>
                           </thead>
                           <tbody>
                           </tbody>
                        </table>                       
                        <!-- // list style -->

                        <!-- page number --> 
                        <div class="page_num" id="dv_page">
                           
                        </div>
                    </div>
                </div>
                <!-- // contents -->
            </div>            
        </div>
    </div>
    </form:form>
    <!-- 회의명 클릭 후 이미지 표출 -->
    <div id='meeting_img' class="needpopup main_pop">
        <div class="box_padding">
            <h2 class="pop_top" id="h2_SeatTitle">영상회의실</h2>  
            <div class="pop_container">
                <div id="div_SeatInfo"></div>   
            </div>
        </div>            
    </div>
    
    <!-- 회의명 클릭 후 이미지 표출 //-->
    <!--popup-->
    <script type="text/javascript">
    $(document).ready(function() { 
    	seatInfo.seatList();
	 });
    var seatInfo = {
    		seatList : function(){
    			var params = { "searchCenterId" : $("#searchCenterId").val(),
    					       "searchCondition" : $("#searchCondition").val(), 
    					       "searchKeyword" : $("#searchKeyword").val(),
    					       "pageIndex" : fn_emptyReplace($("#pageIndex").val(),"1"),
    					       "searchFloorseq" :  fn_emptyReplace($("#floorSeq").val(),"")
    					       
    			}
    			uniAjax("/front/resInfo/seatListAjax.do", params, 
  		     			function(result) {
  						       if (result.status == "LOGIN FAIL"){
  						    	   alert(result.meesage);
  		  						   location.href="/front/resInfo/noInfo.do";
  		  					   }else if (result.status == "SUCCESS"){
  		  						   $("#tb_seatList > tbody").empty();
  		  						   var objs = result.resultlist
  		  						   
  	                               if (objs.length > 0){
  	                            	   var shtml = "";
  	                            	   var useYnTxt = "";
  	                            	   for (var i in objs){
  	                            		    useYnTxt = (objs[i].meeting_useyn == "Y") ? "사용" : "사용안함";
  	                            		    console.log("page:" + (  parseInt((result.paginationInfo.currentPageNo - 1) * parseInt(result.regist.pageSize))+ parseInt(i) )  );
	  	                            		shtml = "<tr class='list_meeting'>"
			  	                                  + " <td>"+ (  parseInt((result.paginationInfo.currentPageNo - 1) * parseInt(result.regist.pageSize))+ parseInt(i) +1 ) + "</td>"
			  	   								  + " <td>"+ objs[i].center_nm +"</td>"
			  	                                  + " <td>"+ objs[i].floor_name +"</td>"
			  	                                  + " <td onclick=\"fn_viewSeat('"+objs[i].meeting_id+"')\" data-needpopup-show='#meeting_img'>"+objs[i].meeting_name+"</td>"
			  	                                  + " <td>"+ objs[i].room_type_txt +"</td>"
			  	                                  + " <td>"+ objs[i].meeting_adminid +"</td>"
			  	                                  + " <td>"+useYnTxt+"</td>"  
			  	                                  +"</tr>";
			  	                            $("#tb_seatList > tbody").append(shtml);
			  	                            shtml = "";
  	                            	   }
  		  						       //페이징 처리 
  		  						       var pageObj = result.paginationInfo
  		  						       var pageHtml = ajaxPaging(pageObj.currentPageNo, pageObj.firstPageNo, pageObj.recordCountPerPage, 
								                                 pageObj.firstPageNoOnPageList, pageObj.lastPageNoOnPageList, 
								                                 pageObj.totalRecordCount, pageObj.pageSize, "ajaxPageChange");
								        $("#dv_page").html(pageHtml+"<div class='clear'></div>");
	                               } 
  						       
  	                             
  		  					   }
  						    },
  						    function(request){
  							    alert("Error:" +request.status );	       						
  						    }    		
  		          );
    		}
    }
    function ajaxPageChange(pageNo) {
    	 $(":hidden[name=pageIndex]").val(pageNo);
    	 seatInfo.seatList();
		 
    	 /*  
    	 xhttp = new XMLHttpRequest();
    	 xhttp.open("POST", "/front/resInfo/seatList.do", true);
    	 xhttp.setRequestHeader("Content-Type", "application/json");
    	 xhttp.send( JSON.stringify( $("#regist").serializeObject())); */
    	 
		
	}
    function fn_search(){
    	$(":hidden[name=pageIndex]").val("1");
    	$("form[name=regist]").attr("action", "/front/resInfo/seatList.do").submit();	
    }
    function fn_viewSeat(swcSeq){
    	  var params = {"meetingId" : swcSeq};
   	      var url = "/backoffice/basicManage/officeMeetingDetail.do";
	   	  uniAjaxSerial(url, params, 
	        			function(result) {
	   				       if (result.status == "LOGIN FAIL"){
	   				    	   alert(result.meesage);
	     						   location.href="/backoffice/login.do";
	     					   }else if (result.status == "SUCCESS"){
	 						       //총 게시물 정리 하기
	 						        var obj  = result.regist;
	 						        $("#h2_SeatTitle").text(obj.meeting_name);
	 								var shtml = "<table border='0'><tbody>";
	 								if (result.regist.meeting_img1 != ""){
	 									shtml += "<tr><td><img src=/upload/"+obj.meeting_img1+" width='550p;'/></td></tr>";
	 								}
	 	                            if (result.regist.meeting_img2 != ""){
	 	                            	shtml += "<tr><td><img src=/upload/"+obj.meeting_img2+" width='550p;'/></td></tr>";
	 								}
	 	                            shtml += "<tr><td>"+ obj.meetingroom_remark +"</td></tr></tbody><table>"
	 								$("#div_SeatInfo").html(shtml);
					    		   
	     					   }else{
	     						   alert(result.meesage);
	     					   }
	   				    },
	   				    function(request){
	   					    alert("Error:" +request.status );	       						
	   				    }    		
	           );
    }
    </script>
    <script src="/js/needpopup.min.js"></script> 
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
    <script>
      $( function() {
        $( "#datepicker" ).datepicker();
      } );
    </script>
</body>
</html>