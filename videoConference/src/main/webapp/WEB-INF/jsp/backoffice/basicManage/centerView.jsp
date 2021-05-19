<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><spring:message code="URL.TITLE" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css">
    <link rel="stylesheet" href="/css/new/paragraph_new.css"> 
    <link rel="stylesheet" href="/css/needpopup.min.css" />
    <link rel="stylesheet" href="/css/needpopup.css">
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    
    <!-- bpopup 사용 -->
    <script type="text/javascript" src="/js/bpopup.js"></script>
    <link rel="stylesheet" href="/css/kiosk/popup.css">
    
    <!-- 우측 슬라이드 만들기 -->
    <script type="text/javascript" src="/js/modernizr.custom.js"></script>
    <script type="text/javascript" src="/js/classie.js"></script>
    
    <script type="text/javascript" src="/js/dragmove.js"></script>
    
    <style>
      .cbp-spmenu {
			background: #47a3da;
			position: fixed;
	  }
      .cbp-spmenu a {
			display: block;
			color: #fff;
			font-size: 1.1em;
			font-weight: 300;
		}
		.cbp-spmenu a:hover {
			background: #258ecd;
		}
		
		.cbp-spmenu a:active {
			background: #afdefa;
			color: #47a3da;
		}
		.cbp-spmenu-right {
			right: -1700px;
		}
		.cbp-spmenu-right.cbp-spmenu-open {
			right: 0px;
		}
		.cbp-spmenu-vertical {
			width: 1700px;
			height: 100%;
			top: 0;
			z-index: 1000;
		}
		.cbp-spmenu-push {
			overflow-x: hidden;
			position: relative;
			left: 0;
		}
		.cbp-spmenu-push-toright {
			left: 840px;
		}
		.cbp-spmenu,
		.cbp-spmenu-push {
			-webkit-transition: all 0.3s ease;
			-moz-transition: all 0.3s ease;
			transition: all 0.3s ease;
		}
		.drag {
            -webkit-transition: all 150ms ease-out;
            -moz-transition: all 150ms ease-out;
            -o-transition: all 150ms ease-out;
            transition: all 150ms ease-out;
        }
    </style>
    
</head>
<body>
 <div id="wrapper">	
<form:form name="regist" commandName="regist" method="post"   action="/backoffice/basicManage/empList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right" id="cbp-spmenu-s2">
	<a href="javascript:showLeft()">닫기</a>
	<!-- contents -->
			<div class="content">
				<h2 class="title only_tit"><span class="sp_title"></span> 위치 GUI Mode</h2>
			</div>
			<div class="content back_map">
				<div class="box_shadow w1100 float_left">
					<div class="box_padding">						
				        <div class="page pinch-zoom-parent">
				            <div class="pinch-zoom" style="transform:unset !important;">
								<div class="map_box_sizing">
									<div class="mapArea floatL">
										<ul id="seat_list">
										</ul>
									</div>
								</div>
				            </div>
				        </div>
    				</div>
    			</div>
				<div class="box_shadow w400 float_left left24">
					<div class="custom_bg">
						<div class="txt_con">
							<p>Business area</p>
							<div class="btn_bot">
								<a href="javascript:search()" class="defaultBtn">검색</a>
								<a href="" class="defaultBtn">초기화</a>
							</div>
						</div>
						<table class="search_tab">
							<tbody>
								<tr>
									<th>층</th>
									<td>
										<select class="" id="floor_id" name="floor_id"></select>
									</td>
									<th>구역</th>
									<td>
										<select class="" id="area_id" name="area_id"></select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="box_padding">
						<div class="gui_text">
							<div class="txt_con">
								<p><span class="sp_title"></span> 위치</p>
								<a href="javascript:save('0')" class="defaultBtn">저장</a>
							</div>
							<div class="scroll_table">
								<div class="scroll_div">
									<table class="total_tab gui_table" id="seat_resultList">
										<thead>
											<th style="float: left;"><span class="sp_title"></span>이름</th>
											<th style="left: 14%; float: left;">Top</th>
											<th style="right: 19.6%; float: right;">Left</th>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
							</div>
						</div>				        
    				</div>
    			</div>

			</div>
</nav>
    


<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="centerId" id="centerId" value="${regist.center_id}">
<input type="hidden" name="floorSeq" id="floorSeq" >
<input type="hidden" name="floorInfos" id="floorInfos" value="${regist.floor_info}">
<input type="hidden" name="nowVal" id="nowVal" >
<input type="hidden" name="newVal" id="newVal" >
<input type="hidden" name="partSeq" id="partSeq" >
<input type="hidden" name="viewMode" id="viewMode" >
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                        <spring:message code="menu.menu01" />
                        <span>></span>
                        <strong>각 층정보</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle" id="div_totalInfo"></div>
                <section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th><spring:message code="search.chooseTxt" /></th>
		                	<td>
		                		<input class="nameB" type="text" name="searchKeyword" id="searchKeyword" >  
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB"><spring:message code="button.inquire" /></span></a>
		                	</td>
		                	<td class="text-right">
		                		  <a href="#" onclick="floorService.fn_floorInfo('Ins','0')"><span class="deepBtn"> <spring:message code="button.create" /></span></a>
		                	</td>		                	
						</tr>
                    </table>
                    <br/>                
                </section>
            </div>
            
            <div class="Swrap tableArea">
            
                        <!--// 단말기리스트-->
                        <table class="list01 basicBox">
                            <thead>
                                <tr>
                                    <th>설정</th>
                                    <th>도면 이미지</th>
                                    <th>층수</th>
                                    <th>층이름</th>
                                    <th>좌석상태</th>
                                    <th>회의실상태</th>
                                    <th>사용유무</th>
                                    <th>구역사용</th>
                                    <th>최종 수정 일자</th>
                                    <th>최종 수정자</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody class="equipListBody">
                            <c:forEach items="${resultlist}" var="floorInfo" varStatus="status">
								<tr class="equipList" id="floor_${floorInfo.floor_seq}">
								    <td><c:if test="${floorInfo.floor_part eq 'FLOOR_PART_1' }"><a href="#" onclick="partService.fn_partList('${floorInfo.floor_seq}')">▼</a></c:if></td>
									<td onclick="floorService.fn_floorInfo('Edt','${floorInfo.floor_seq}')"><img src="/upload/${floorInfo.floor_map}" style="width:120px;"/></td>
									<td onclick="floorService.fn_floorInfo('Edt','${floorInfo.floor_seq}')">${floorInfo.floor_info_txt}</td>
									<td onclick="floorService.fn_floorInfo('Edt','${floorInfo.floor_seq}')">${floorInfo.floor_name}</td>
									<td onclick="floorService.fn_floorInfo('Edt','${floorInfo.floor_seq}')">${floorInfo.seat_cnt}</td>
									<td onclick="floorService.fn_floorInfo('Edt','${floorInfo.floor_seq}')">${floorInfo.meet_cnt}</td>
									<td onclick="floorService.fn_floorInfo('Edt','${floorInfo.floor_seq}')">${floorInfo.floor_useyn}</td>
									<td>
										<c:choose>
											<c:when test="${floorInfo.floor_part eq 'FLOOR_PART_1' }">
												<a href="#" onClick="partService.fn_partInfo('Ins', '0','${floorInfo.floor_seq}','${floorInfo.floor_info}')">[구역 등록]</a>
											</c:when>
											<c:otherwise>
												<a href="#" onClick="floorService.fn_SeatSetting('S','${floorInfo.floor_seq}', '0')">[좌석 설정]</a>
												<a href="#" onClick="floorService.fn_SeatSetting('M','${floorInfo.floor_seq}', '0')">[회의실 설정]</a>
											</c:otherwise>
										</c:choose>
										
									</td>
									<td>${floorInfo.update_date}</td>
									<td>${floorInfo.update_id}</td>
									<td><a href="#" onclick="floorService.fn_delCheck('${floorInfo.floor_seq}')">삭제</a></td>
								<tr>
							</c:forEach>	
                            </tbody>
                        </table>
                        <!--단말기리스트 //-->
                 </div>
	           
        </div>
    </div>
    
   
   <div id='floorPop' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>층 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*층명 <span class="join_id_comment joinSubTxt"></span></p>
                    <input name="floorName" id="floorName" class="input_noti" size="10"/>    
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*구역 사용여부 <span class="join_id_comment joinSubTxt"></span></p>
                    <select id="floorPart" style="width:120px">
                        <option value="">구역 사용여부</option>
                         <c:forEach items="${floorPart}" var="partGubun">
                            <option value="${partGubun.code}">${partGubun.codeNm}</option>
                         </c:forEach>
                    </select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">웹도면이미지 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="file" id="floorMap" name="floorMap"> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">키오스크 도면 이미지 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="file" id="floorMap1" name="floorMap1"> 
                </div>                
            </div>
            
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">* 층 선택 <span class="join_id_comment joinSubTxt"></span></p>
                    <select id="floorInfo" style="width:120px" onChange="floorService.fn_floorState()">
                        <option value="">층 선택</option>
                         <c:forEach items="${floorlistInfo}" var="floorList">
                            <option value="${floorList.code}">${floorList.codeNm}</option>
                         </c:forEach>
                    </select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="common.UseYn.title" /> <span class="join_id_comment joinSubTxt"></span></p>
                       <input type="radio" id="floorUseyn" name="floorUseyn" value="Y"  /><label>사용</label>
			           <input type="radio" id="floorUseyn" name="floorUseyn" value="N"  /><label>사용안함</label>
                </div>                
            </div>
              
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:floorService.fn_floorUpdate();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  
    
    <div id='partPop' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>구역 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
                 <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">* 층 선택 <span class="join_id_comment joinSubTxt"></span></p>
	                    <select id="part_floorSeq" style="width:120px" onChange="floorService.fn_floorState()">
                        <option value="">층 선택</option>
                         <c:forEach items="${floorListSeq}" var="floorList">
                            <option value="${floorList.floor_seq}">${floorList.floor_name}</option>
                         </c:forEach>
                    </select>
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">*구역명 <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="text" id="partName" name="partName">    
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">*구역 css <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="text" id="partCss" name="partCss">    
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">웹도면이미지 <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="file" id="partMap1" name="partMap1"> 
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">키오스크 도면 이미지 <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="file" id="partMap2" name="partMap2"> 
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">좌석 규칙 <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="text" id="partSeatrule" name="partSeatrule">    
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">미니맵 Top <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="number" id="partMiniTop" name="partMiniTop" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">    
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">미니맵 Left <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="number" id="partMiniLeft" name="partMiniLeft" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">    
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">미니맵 Css <span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="text" id="partMiniCss" name="partMiniCss">    
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">정렬순서<span class="join_id_comment joinSubTxt"></span></p>
	                    <input type="number" id="partOrder" name="partOrder" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
	                </div>                
	            </div>
	            <div class="pop_box50">
	                <div class="padding15">
	                    <p class="pop_tit">*<spring:message code="common.UseYn.title" /> <span class="join_id_comment joinSubTxt"></span></p>
	                       <input type="radio" id="partUseyn" name="partUseyn" value="Y" /><label>사용</label>
				           <input type="radio" id="partUseyn" name="partUseyn" value="N" /><label>사용안함</label>
	                </div>                
	            </div>
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:partService.fn_partUpdate();" class="redBtn" id="btnPartUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  
    
    <!-- 좌석 설정  -->
     <div data-popup="dv_seatSetting" class="popup focusPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <div class="top" id="dv_Title">좌석 등록</div>
            <div class="con">
               <select id="seatStr" name="seatStr">
                  <c:forEach var="cnt" begin="1" end="100" step="1">
                     <option value="${cnt}">${cnt}</option>
                  </c:forEach> 
               </select>~
               <select id="seatEnd" name="seatEnd">
                  <c:forEach var="cnt" begin="1" end="100" step="1">
                     <option value="${cnt}">${cnt}</option>
                  </c:forEach> 
               </select>
            </div>
            <a href="#" onClick="floorService.fn_SeatUpdate()" class="greenBtn">확인</a>
        </div>
    </div>
    
<c:import url="/backoffice/inc/bottom_inc.do" /> 
<button id="btn_message" style="display:none" data-needpopup-show='#floorPop'>확인1</button>
<button id="btn_part" style="display:none" data-needpopup-show='#partPop'>확인1</button>

<a data-popup-open="dv_seatSetting"  style="display:none"  class="rightGBtn" id="btn_bpop" >좌석 세팅</a>


<script src="/js/needpopup.js"></script> 
<script src="/js/jquery-ui.js"></script>


</form:form>
</div>       
 <script type="text/javascript">
     var menuRight = document.getElementById('cbp-spmenu-s2'),
		 floor_arrow = ['▼','▲'],
		 body = document.body;
     /* popup */
     $('[data-popup-open]').bind('click', function () {
       var targeted_popup_class = jQuery(this).attr('data-popup-open');
       $('[data-popup="' + targeted_popup_class + '"]').bPopup();
     });
     $('[data-popup-close]').on('click', function(e)  {
     	 var targeted_popup_class = jQuery(this).attr('data-popup-close');
     	$('[data-popup="' + targeted_popup_class + '"]').fadeOut(1000).bPopup().close();
     	$('body').css('overflow', 'auto');
         e.preventDefault(); 
     });
     function partTable(_id) {
    	 var tabbleInfo ="<table id='part_"+_id+"' class='list01 basicBox'>"
					   +"  <thead>"
					   +"       <tr>"
					   +"          <th>구역명</th>"
					   +"          <th>도면 이미지</th>"
					   +"          <th>좌석명령규칙</th>"
			  	       +"          <th>미니맵Top</th>"
			 		   +"          <th>미니맵Left</th>"
			 		   +"          <th>미니맵Css</th>"
			 		   +"          <th>정렬순사</th>"
			 		   +"          <th>사용유무</th>"
			 		   +"          <th>좌석 설정</th>"
			 		   +"          <th>회의실 설정</th>"
			 	  	   +"          <th>최종 수정 일자</th>"
			 	  	   +"          <th>최종 수정자</th>"
			 	  	   +"          <th>삭제</th>"
			 	  	   +"       </tr>"
			 	  	   +"     </thead>"
			 	  	   +"    <tbody class=\"equipListBody\">"
			 	  	   +"    </tbody>"
			 	  	   +"</table>";  
		  return tabbleInfo;
     }
       
     var partService = {
    		 fn_partInfo : function(mode, partSeq, floor_seq){
    			 $("#btn_part").trigger("click");
    	      	 $("#mode").val(mode);
    	      	 $("#partSeq").val(partSeq);
    	      	 $("#floorSeq").val(floorSeq);
    	      	 if (mode == "Ins"){
    	      		  $('input:text[name^=part]').val("");
    	      		  $("#part_floorSeq").val(floor_seq);
    	      		  $('input:radio[name=partUseyn]:radio[value=Y]').prop("checked", true);	
    	      	 }else{
    	      		  var url = "/backoffice/basicManage/partDetail.do";
	      			  var param = {"partSeq" : partSeq};
	      			  uniAjaxSerial(url, param, 
	      		     			function(result) {
	      						       if (result.status == "LOGIN FAIL"){
	      						    	   alert(result.meesage);
	      		  						   location.href="/backoffice/login.do";
	      		  					   }else if (result.status == "SUCCESS"){
	      	                                $("#partPop .popHead > h2").html("구역 정보 수정");
	      			                        $("#btnPartUpdate").text('수정');
	      		  						    var obj = result.regist;
	      		  						    $("#part_floorSeq").val(obj.floor_seq);
	      		 		            	    $("#partName").val(obj.part_name);
	      		 		            	    $("#partCss").val(obj.part_css);
	      		 		            	    $("#partSeatrule").val(obj.part_seatrule);
	      		 		            	    $("#partMiniTop").val(obj.part_mini_top);
	      		 		            	    $("#partMiniLeft").val(obj.part_mini_left);
	      		 		            	    $("#partMiniCss").val(obj.part_mini_css);
	      		 		            	    $("#partOrder").val(obj.part_order);
	      		 		            	    $('input:radio[name=partUseyn]:radio[value=' + obj.part_useyn + ']').prop("checked", true);	 
	      		 		               }
	      						    },
	      						    function(request){
	      							    alert("Error:" +request.status );	       						
	      						    }    		
	      		       ); 
    	      	 }
    		 }, fn_partUpdate : function(){
       		      //구역 업데이트
       		      if (any_empt_line_id("partName", "구역명을 입력해주세요.") == false) return;		  
        		  if (any_empt_line_id("part_floorSeq", "층를 선택해주세요.") == false) return;
        		  var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
        		  if (confirm(commentTxt)== true){
        			   
        			  //체크 박스 체그 값 알아오기 
        			  var formData = new FormData();
        			  formData.append('partMap1', $('#partMap1')[0].files[0]);
        			  formData.append('partMap2', $('#partMap2')[0].files[0]);
        			  formData.append('centerId' , $("#centerId").val());
        			  formData.append('partCss' , $("#partCss").val());
        			  formData.append('floorSeq' , $("#part_floorSeq").val());
        			  formData.append('partSeq' , $("#partSeq").val());
        			  formData.append('partSeatrule' , $("#partSeatrule").val());
        			  formData.append('partName' , $("#partName").val());
        			  formData.append('partMiniTop' , fn_emptyReplace($("#partMiniTop").val(),"0"));
        			  formData.append('partMiniLeft' , fn_emptyReplace($("#partMiniLeft").val(),"0"));
        			  formData.append('partMiniCss' , $("#partMiniCss").val());
        			  formData.append('partOrder' , fn_emptyReplace($("#partOrder").val(),"0"));
        			  formData.append('partUseyn' , fn_emptyReplace($('input[name=partUseyn]:checked').val(),"Y"));
        			  formData.append('mode' , $("#mode").val());
        			  
        		      uniAjaxMutipart("/backoffice/basicManage/partUpdate.do", formData, 
        						function(result) {
        						       if (result.status == "SUCCESS"){
        		    	                 // 닫기 이후 다시 요청 하기 
        		    	                 $("#floor_"+$("#part_floorSeq").val()).next().remove();
       			                         $("#floor_"+$("#part_floorSeq").val() +" > td").eq(0).find("a").text(floor_arrow[0]);
        		    	                 partService.fn_partList($("#part_floorSeq").val());
        		    	                 
        		    	               }else if (result.status == "LOGIN FAIL"){
        								  document.location.href="/backoffice/login.do";
        				               }else {
        				            	  alert(result.message);
        				               }
        						       need_close();
        						    },
        						    function(request){
        							    alert("Error:" +request.status );	       						
        						    }    		
        				 );
        		  } 
       	  }, fn_partList : function (floorSeq){
       		 var floorArrow = $("#floor_"+floorSeq +">td").eq(0).text();
       		 if (floorArrow == floor_arrow[0]){
       			$("#floor_"+floorSeq).eq(-1).after("<tr><td colspan='11'>"+partTable(floorSeq)+"</td></tr>");
       			$("#floor_"+floorSeq +" > td").eq(0).find("a").text(floor_arrow[1]);
       			$("#floorSeq").val(floorSeq);
       		    //리스트 보여 주기 
       			partService.fn_partReload();
       		 }else {
       			$("#floorSeq").val(""); 
       			$("#floor_"+floorSeq).next().remove();
       			$("#floor_"+floorSeq +" > td").eq(0).find("a").text(floor_arrow[0]);
       		 }
       	  }, fn_partDel : function (part_seq, floorSeq){
	       		$("#floorSeq").val(floorSeq);
	       		var params = {"partSeq": part_seq}
	       		fn_uniDelAction("/backoffice/basicManage/partDelete.do",params, "partService.fn_partReload");
       	  }, fn_partReload : function (){
       		    var floorSeq = $("#floorSeq").val();
	       		var url = "/backoffice/basicManage/partListAjax.do";
			    var param = {"floorSeq" : floorSeq};
			    uniAjax(url, param, 
		     			function(result) {
						       if (result.status == "LOGIN FAIL"){
						    	   alert(result.meesage);
		  						   location.href="/backoffice/login.do";
		  					   }else if (result.status == "SUCCESS"){
	                                $("#part_"+floorSeq + " > tbody").empty();
	                                var sHtml = "";
		  						    var obj = result.resultlist;
		  						    for (var i = 0; i < result.resultlist.length; i ++){
		  						    	sHtml += " <tr>";
		  						    	sHtml += " <td onclick=\"partService.fn_partInfo('Edt','"+obj[i].part_seq+"')\">"+obj[i].part_name+"</td>";
		  						    	sHtml += " <td onclick=\"partService.fn_partInfo('Edt','"+obj[i].part_seq+"')\"><img src='/upload/"+obj[i].part_map1+"'>'</td>";
		  						    	sHtml += " <td onclick=\"partService.fn_partInfo('Edt','"+obj[i].part_seq+"')\">"+obj[i].part_seatrule+"</td>";
		  						    	sHtml += " <td>"+obj[i].part_mini_top+"</td>";
		  						    	sHtml += " <td>"+obj[i].part_mini_left+"</td>";
		  						    	sHtml += " <td>"+obj[i].part_mini_css+"</td>";
		  						    	sHtml += " <td>"+obj[i].part_order+"</td>";
		  						    	sHtml += " <td>"+obj[i].part_useyn+"</td>";
		  						    	sHtml += " <td onclick=\"floorService.fn_SeatSetting('S','"+obj[i].floor_seq+"','"+obj[i].part_seq+"')\">좌석 설정</td>";
		  						    	sHtml += " <td onclick=\"floorService.fn_SeatSetting('M','"+obj[i].floor_seq+"','"+obj[i].part_seq+"')\">회의실 설정</td>";
		  						    	sHtml += " <td>"+obj[i].update_date+"</td>";
		  						    	sHtml += " <td>"+obj[i].update_id+"</td>";
		  						    	sHtml += " <td onclick=\"partService.fn_partDel('"+obj[i].part_seq+"','"+obj[i].floor_seq+"')\">삭제</td>";
		  						    	sHtml += "</tr>"
		  						    	$("#part_"+floorSeq + " > tbody").append(sHtml);
		  						    	sHtml = "";
		  						    }
		  						    
		  						    
		  						    
		 		        	   }
						    },
						    function(request){
							    alert("Error:" +request.status );	       						
						    }    		
		          ); 
       	  }
     }
     var floorService = {
    	 fn_floorInfo : function(mode, floorSeq){
    		
    		$("#btn_message").trigger("click");
      	    $("#mode").val(mode);
      	    $("#floorSeq").val(floorSeq);
      	    if (mode == "Ins"){
    			  $("#floorName").val("");
    			  $("#floorInfo").val("");
    			  $("#floorPart").val("");
    			  $('input:radio[name=floorUseyn]:radio[value=Y]').prop("checked", true);	 
    		  }else {
    			  var url = "/backoffice/basicManage/floorDetail.do";
    			  var param = {"floorSeq" : floorSeq};
    			  uniAjaxSerial(url, param, 
    		     			function(result) {
    						       if (result.status == "LOGIN FAIL"){
    						    	   alert(result.meesage);
    		  						   location.href="/backoffice/login.do";
    		  					   }else if (result.status == "SUCCESS"){
    	                                $(".popHead > h2").html("층 정보 수정");
    			                        $("#btnUpdate").text('수정');
    		  						    var obj = result.regist;
    		  						    $("#floorName").val(obj.floor_name);
    		 		            	    $("#floorInfo").val(obj.floor_info);
    		 		            	    $("#floorPart").val(obj.floor_part);
    		 		            	    $("#nowVal").val(obj.floor_info.replace("CNETER_FLOOR_", ""));
    		 		            	    $('input:radio[name=floorUseyn]:radio[value=' + obj.floor_useyn + ']').prop("checked", true);	 
    		 		               }
    						    },
    						    function(request){
    							    alert("Error:" +request.status );	       						
    						    }    		
    		       );
    		  }
    	  }, fn_delCheck : function(floorSeq){
	   		   var params = {'floorSeq':trim(floorSeq) };
	   		   fn_uniDel("/backoffice/basicManage/floorDelete.do",params, "/backoffice/basicManage/centerView.do");
    	  }, fn_floorUpdate : function(){
    		  //층 업데이트
    		  if (any_empt_line_id("floorName", "층명을 입력해주세요.") == false) return;		  
     		  if (any_empt_line_id("floorInfo", "층를 선택해주세요.") == false) return;
     		  if (any_empt_line_id("floorPart", "구역 사용 여부를 선택해 주세요.") == false) return;
     		  var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
     		  if (confirm(commentTxt)== true){
     			   
     			  //체크 박스 체그 값 알아오기 
     			  var formData = new FormData();
     			  formData.append('floorMap', $('#floorMap')[0].files[0]);
     			  formData.append('floorMap1', $('#floorMap1')[0].files[0]);
     			  formData.append('centerId' , $("#centerId").val());
     			  formData.append('floorName' , $("#floorName").val());
     			  formData.append('floorInfo' , $("#floorInfo").val());
     			  formData.append('floorPart' , $("#floorPart").val());
     			  formData.append('floorSeq' , $("#floorSeq").val());
     			  formData.append('nowVal' , $("#nowVal").val());
     			  formData.append('newVal' , fn_domNullReplace( $("#newVal").val(), $("#nowVal").val()) );
     			  formData.append('floorInfos' , $("#floorInfos").val());
     			  formData.append('floorUseyn' , fn_emptyReplace($('input[name="floorUseyn"]:checked').val(),"Y"));
     			  formData.append('mode' , $("#mode").val());
     			  
     		      uniAjaxMutipart("/backoffice/basicManage/floorUpdate.do", formData, 
     						function(result) {
     						       if (result.status == "SUCCESS"){
     		    	                  document.location.reload();
     		    	               }else if (result.status == "LOGIN FAIL"){
     								  document.location.href="/backoffice/login.do";
     				               }else {
     				            	  alert(result.message);
     				            	  need_close();
     				               }
     						    },
     						    function(request){
     							    alert("Error:" +request.status );	       						
     						    }    		
     			 );
     		    	
     		  } 
    	  }, fn_floorState: function (){
    		  //변경 층 정보
    		  if ($("#floorInfo").val() != $("#nowVal").val())
    			  $("#newVal").val($("#floorInfo").val().replace("CNETER_FLOOR_", "") );
    	  }, fn_SeatSetting : function(mode, floorSeq, partSeq){
    		  //좌석 설정 
    		  $("#viewMode").val(mode);
    		  $("#floorSeq").val(floorSeq);
    		  if (partSeq != "0")
    			  $("#partSeq").val(partSeq);  
    		     // 좌석 등록 되어 있는지 아닌지 
    		  var title =  (mode == "M") ? "회의실 설정" :  "좌석 설정";
    		  $("#dv_Title").html(title);
    		  var params = {"floorSeq" : $("#floorSeq").val(), "partSeq" : $("#partSeq").val(), "type" : mode};
    		  var floorCheck = fn_returnVal("/backoffice/basicManage/seatCount.do",params, "fn_seatCheck");
    	  }, fn_SeatUpdate : function (){
    		  //좌석 업데이트 하기 
    		  if (any_empt_line_id("seatStr", "장비 시작명을 선택해주세요.") == false) return;		  
     		  if (any_empt_line_id("seatEnd", "장비 종료명를 선택해주세요.") == false) return;
     		  if (fnIntervalCheck($("#seatStr").val(), $("#seatEnd").val(), "시작이 종료 보다 클수 없습니다.") == false) return;
     		  
    		  var url = "/backoffice/basicManage/floorSeatUpdate.do";
    		  var params = {"floorSeq" : $("#floorSeq").val(),
    				        "partSeq" : $("#partSeq").val(), 
    				        "seatStr": $("#seatStr").val(), 
    				        "viewMode": $("#viewMode").val(), 
    				        "seatEnd" : $("#seatEnd").val()
    				        };
    		  uniAjax(url, params, 
		     			function(result) {
    			               //alert(result.status);
    			               
						       if (result.status == "LOGIN FAIL"){
						    	   alert(result.meesage);
		  						   location.href="/backoffice/login.do";
		  					   }else if (result.status == "SUCCESS"){
	                               //정상적으로 좌석 등록 되었으면 좌석 세팅 페이지로 넘어가기
	                               $('[data-popup="dv_seatSetting"]').bPopup().close();
	                               fn_GuiSearch();
	                    	   }else {
	                    		   alert(result.message);
	                    	   }
						    },
						    function(request){
							    alert("Error:" +request.status );	       						
						    }    		
		          ); 
    	  } 
     }
     function fn_GuiSearch(){
    	  
    	  var url = "";
    	  var title = "";
    	  switch ($("#viewMode").val()){
		    case "S":
		    	url ="officeSeatListAjax.do";
		    	title = "좌석";
		    	break;
		    case "M":
		    	url ="officeMeetingListAjax.do";
		    	title = "회의실";
		    	break;
		    default :
		    	url ="officeSeatListAjax.do"; 
		        title = "좌석";
    	  }
    	  
    	  $(".sp_title").text(title);
    	  var params = {"floorSeq" : $("#floorSeq").val(), "partSeq" : $("#partSeq").val()};
		  uniAjax("/backoffice/basicManage/"+url, params, 
		 			function(result) {
					       if (result.status == "LOGIN FAIL"){
					    	        alert(result.message);
					    	        location.href="/backoffice/login.do";
							   }else if (result.status == "SUCCESS"){
								    //테이블 정리 하기
 								 if(result.seatMapInfo != null){
 									var img=   $("#partSeq").val() != "" ? result.seatMapInfo.part_map1 : result.seatMapInfo.floor_map;
 									$('.mapArea').css({"background":"#fff url("+img+")", 'background-repeat' : 'no-repeat', 'background-position':' center'});
 								 }else{
 									$('.mapArea').css({"background":"#fff url()", 'background-repeat' : 'no-repeat', 'background-position':' center'});
 								 }
 								
 								 if(result.resultlist.length > 0){
 									var shtml = '';
 									var obj = result.resultlist;
 									
 									if ($("#viewMode").val() == "S" ){
 										for (var i in result.resultlist) {
 	 										shtml += '<li id="s'+CommonJsUtil.NVL(obj[i].seat_name) +'" class="seat" seat-id="'+ obj[i].seat_id +'" name="'+obj[i].seat_id +'" >'+ CommonJsUtil.NVL(obj[i].seat_name) +'</li>';
 	 									}
 	 									$('#seat_list').html(shtml);
 	 									for (var i in result.resultlist) {
 	 										$('.mapArea ul li#s' + CommonJsUtil.NVL(obj[i].seat_name) ).css({"top" : CommonJsUtil.NVL(obj[i].seat_top)+"px", "left" : CommonJsUtil.NVL(obj[i].seat_left)+"px"});
 	 									}
 	 									$('.seat').dragmove();
 	 									$("#seat_resultList > tbody").empty();
 	 									if(result.resultlist.length > 0 ){
 	 										var obj = result.resultlist;
 	 										var shtml = "";
 				  							for ( var i in obj) {
 				  								shtml += "<tr>"
 				  								      +  "   <td>"  + obj[i].seat_name +""
 				  								      +  "   <input type='hidden' id='seat_id' name='seat_id' value='"+ obj[i].seat_id + "'></td>"
 				  								      +  "   <td><a href='javascript:top_up(&#34;" + obj[i].seat_id + "&#34;)' class='up'></a>"
 				  								      +  "   <input type='text' id='top_"+obj[i].seat_id+"' name='top_"+obj[i].seat_id+"' value='"+obj[i].seat_top +"' onchange='top_chage(&#34;"+obj[i].seat_id +"&#34;, this.value)'>"
 				  								      +  "   <a href='javascript:top_down(&#34;" + obj[i].seat_id + "&#34;)' class='down'></a></td>"
 				  								      +  "   <td><a href='javascript:left_up(&#34;" + obj[i].seat_id + "&#34;)' class='leftB'></a>"
 				  								      +  "   <input type='text' id='left_"+obj[i].seat_id+"' name='left_"+obj[i].seat_id+"' value='"+ obj[i].seat_left +"' onchange='left_chage(&#34;"+obj[i].seat_id+"&#34, this.value)'>"
 				  								      +  "   <a href='javascript:left_down(&#34;" + obj[i].seat_id  + "&#34;)' class='rightB'></a></td>"
 				  								      +  "</tr>";
 				  								$("#seat_resultList > tbody").append(shtml);
 				  								shtml = "";
 				  							}
 				  							
 			  						    }
 									}else {
 										for (var i in result.resultlist) {
 	 										shtml += '<li id="s'+CommonJsUtil.NVL(obj[i].meeting_name) +'" class="seat" seat-id="'+ obj[i].meeting_id +'" name="'+obj[i].meeting_id +'" >'+ CommonJsUtil.NVL(obj[i].meeting_name) +'</li>';
 	 									}
 	 									$('#seat_list').html(shtml);
 	 									for (var i in result.resultlist) {
 	 										$('.mapArea ul li#s' + CommonJsUtil.NVL(obj[i].meeting_name) ).css({"top" : CommonJsUtil.NVL(obj[i].meeting_top)+"px", "left" : CommonJsUtil.NVL(obj[i].meeting_left)+"px"});
 	 									}
 	 									$('.seat').dragmove();
 	 									$("#seat_resultList > tbody").empty();
 	 									if(result.resultlist.length > 0 ){
 	 										var obj = result.resultlist;
 	 										var shtml = "";
 				  							for ( var i in obj) {
 				  								shtml += "<tr>"
 				  								      +  "   <td>"  + obj[i].meeting_name +""
 				  								      +  "   <input type='hidden' id='seat_id' name='seat_id' value='"+ obj[i].meeting_id + "'></td>"
 				  								      +  "   <td><a href='javascript:top_up(&#34;" + obj[i].meeting_id + "&#34;)' class='up'></a>"
 				  								      +  "   <input type='text' id='top_"+obj[i].meeting_id+"' name='top_"+obj[i].meeting_id+"' value='"+obj[i].meeting_top +"' onchange='top_chage(&#34;"+obj[i].meeting_id +"&#34;, this.value)'>"
 				  								      +  "   <a href='javascript:top_down(&#34;" + obj[i].meeting_id + "&#34;)' class='down'></a></td>"
 				  								      +  "   <td><a href='javascript:left_up(&#34;" + obj[i].meeting_id + "&#34;)' class='leftB'></a>"
 				  								      +  "   <input type='text' id='left_"+obj[i].meeting_id+"' name='left_"+obj[i].meeting_id+"' value='"+ obj[i].meeting_left +"' onchange='left_chage(&#34;"+obj[i].meeting_id+"&#34, this.value)'>"
 				  								      +  "   <a href='javascript:left_down(&#34;" + obj[i].meeting_id  + "&#34;)' class='rightB'></a></td>"
 				  								      +  "</tr>";
 				  								$("#seat_resultList > tbody").append(shtml);
 				  								shtml = "";
 				  							}
 				  							
 			  						    }
 									}
 									
 								}else{
 									$('#seat_list').html('');""
 								}
 								
 								
							   }else {
								    alert(result.message);
							   }
					    },
					    function(request){
						    alert("Error:" +request.status );	       						
					    }    		
		       );
		  
     }
     function fn_seatCheck(count){
    	 if (parseInt(count) > 0){
			  showLeft();
			  fn_GuiSearch();	
		 }else{
			   //초기화 설정 
			   $("#seatStr").val("1");
			   $("#seatEnd").val("1");
			   $("#btn_bpop").trigger("click");  
		 }
     }
	 function need_close(){
     	needPopup.hide();
     }			
	 function showLeft(){
		classie.toggle( menuRight, 'cbp-spmenu-open' );
	 }
	 function save(){
			if(confirm('저장 하시겠습니까?')){
				var SeatsArray = new Array();
		        $('.seat').each(function () {
		        	var SeatsView = new Object();
		            SeatsView.seatId = $(this).attr('seat-id');
		            SeatsView.seatTop = $(this).css('top').replace('px', '');
		            SeatsView.seatLeft = $(this).css('left').replace('px', '');
		            SeatsArray.push(SeatsView);
		        });
		        var param =  new Object();
		        param.data = SeatsArray;
		        if(SeatsArray.length == 0){
		        	alert('저장할 내용이 없습니다.');
		        	return false;
		        }
		        param.type = $("#viewMode").val();
		        
		        var url = "/backoffice/basicManage/officeSeatGuiUpdate.do";
		        uniAjax(url, param, 
   		     			function(result) {
   						       if (result.status == "LOGIN FAIL"){
   						    	   alert(result.meesage);
   		  						   location.href="/backoffice/login.do";
   		  					   }else if (result.status == "SUCCESS"){
	   		  					   alert('수정되었습니다.');
	   		  					   fn_GuiSearch();
   		  					   }
   						},
   						function(request){
   							    alert("Error:" +request.status );	       						
   						}    		
    		    );
				
			}
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

</body>    
</html>