<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
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
<form:form name="regist" commandName="regist" method="post">

        <input type="hidden" name="itemId" id="itemId" value="${regist.meeting_id}" />
		<input type="hidden" name="resReqday" id="resReqday" />
		<input type="hidden" name="hid_history" id="hid_history" />
        
        <c:import url="/web/inc/top_inc.do" />
        <!--header ??????//-->
        <!--// left menu -->
        <c:import url="/web/inc/right_menu.do" />
        <!--left menu //-->
        <!--//floor Btn-->
         <div id="allFloors">
            <div class="contents">
                <div class="flooreArea coronArea float_left" id="dv_floor">
                    <c:forEach items="${meetingList }" var="meetingList" varStatus="status">
                       <a href="#" onClick="fn_meetingView('${meetingList.meeting_id }')" name="btn_floor" id="btn_${meetingList.meeting_id}" class="<c:if test="${meetingList.meeting_id  eq regist.meeting_id}" >active</c:if>">${meetingList.meeting_name }</a>
                    </c:forEach>
                </div>               
                <div class="clear"></div>
            </div>
        </div>
        <!--floor Btn//-->
        <!--//contents -->
        <div class="contents coron" id="meeetingDetail">
           <div class="line">
           </div>
           <div class="whiteBack coronBox">
               <h5><span id="sp_roomTitle"></span></h5>
               <div class="float_left imgArea">
                 <!-- Swiper -->
                  <div class="swiper-container gallery-top">
                    <div class="swiper-wrapper">
                      <div class="swiper-slide"><img id="img_left01" name="img_left01" /></div>
                      <div class="swiper-slide"><img id="img_left02" name="img_left02"/></div>
                      <div class="swiper-slide"><img id="img_left03" name="img_left03"/></div>
                    </div>
                    <!-- Add Arrows -->
                    <div class="swiper-button-next swiper-button-white"></div>
                    <div class="swiper-button-prev swiper-button-white"></div>
                  </div>
                  <div class="swiper-container gallery-thumbs">
                    <div class="swiper-wrapper">
                      <div class="swiper-slide"><img id="img_bottom01" name="img_bottom01"/></div>
                      <div class="swiper-slide"><img id="img_bottom02" name="img_bottom02"/></div>
                      <div class="swiper-slide"><img id="img_bottom03" name="img_bottom03"/></div>
                    </div>
                  </div>
                  <!-- Swiper -->
                  <div class="notice">
                     <p>> ????????????</p>
                     <div class="notice_list" >
                     <span id="sp_remark"></span>
                     </div>
               </div>
               </div>
              
               
               <div class="float_right infoArea">
                 <table>
                   <tbody>
                     <tr>
                       <th>?????? ?????????</th>
                       <td id="td_meeting_remark01"></td>
                     </tr>
                      <tr>
                       <th>??????</th>
                       <td id="td_meeting_remark02"></td>
                     </tr>
                      <tr>
                       <th>??????</th>
                       <td id="td_meeting_remark03"></td>
                     </tr>
                      <tr>
                       <th>????????????</th>
                       <td id="td_meeting_remark04"></td>
                     </tr>
                     <tr>
                       <th>????????????</th>
                       <td id="td_meeting_remark05"></td>
                     </tr>
                      <tr>
                       <th>?????????</th>
                       <td id="td_meeting_remark06"></td>
                     </tr>
                      <tr>
                       <th>??????(8H)</th>
                       <td id="td_meeting_remark07"></td>
                     </tr>
                      <tr>
                       <th>??????</th>
                       <td id="td_meeting_remark08"></td>
                     </tr>
                      <tr>
                       <th>????????????</th>
                       <td id="td_meeting_file01"></td>
                     </tr>
                   </tbody>
                 </table>
                 <p>*?????? ??? ?????? ????????? ?????? ???????????? ???????????? ???????????????. (?????? ????????????)</p>
                 <button type="button" class="blueBtn" onclick="res.fn_meetingViewGubun('Res');">?????? ????????????</button>
               </div>
               <div class="clear"></div>
           </div>
        </div>
        <!--contetns//-->
        <!--//contents-->
        <div class="contents coron cor_detail" id="meeetingRes"> 
           <div class="line">
            <!--//date picker-->
                <div class="contents mobileM">
                  <ul>
                    <li class="float_left">
                      <div class="dateBox">
                        <span>?????? ??????</span>
                          <input type="hidden" id="resetStartday" value="${regist.searchResStartday}" >
                          <input type="text" id="searchResStartday" name="searchResStartday" class="inputSearch" value="${regist.searchResStartday}"  onchange="fn_dayIntervalCheck(this)">
                          <div class="dateIcon" onClick="fn_floorMeetingIntervalInfo('2')">
                            <a class="dateBtn">??????</a>
                          </div>
                       </div>

                    </li>
                    <li class="float_left">
                      <div class="dateBox">
                         <span>?????? ??????</span>
                          <input type="hidden" id="resetEndday" value="${regist.searchResEndday}" > 
                          <input type="text" id="searchResEndday" name="searchResEndday" class="inputSearch" value="${regist.searchResEndday}" onchange="fn_dayIntervalCheck(this)">
                          <div class="dateIcon" onClick="fn_floorMeetingIntervalInfo('2')">
                            <a class="dateBtn">??????</a>
                          </div>
                       </div>
                    </li>
                    <li><a class="searchBtn" href="#" onClick="fn_floorMeetingIntervalInfo('2')">??????</a></li>
                  </ul>
                  <div class="clear"></div>
                </div>
              <!--date picker//-->
           </div>
           
           <div class="whiteBack meet">
                <div class="infoContents float_left">
                      <span class="posSeatU">????????????</span> > 
                        <span class="posSeatD">????????????</span> > 
                        <span class="usingSeat">????????????</span>
                </div>
                <div class="cor_text float_left">
                      1. ????????? ??? ????????? ???????????? ??????????????? ????????????<br/>
                      2. ?????????????????? 7??? ??????, 90??? ?????? ????????? ???????????????<br/>
                      3. ?????? ????????????: ???????????? > ???????????? > ????????????
                </div>
                <div class="clear"></div>
               <div class="scroll">
                  <div class="clear"></div>
                    <div>
                       <table class="day_T" id="tb_seatTimeInfo">
                           <thead>
                               <tr>
                                   <th class="fixed_th">??????</th>
                                   <!-- <td colspan="2">8???</td> -->
                                   <td colspan="2">9???</td>
                                   <td colspan="2">10???</td>
                                   <td colspan="2">11???</td>
                                   <td colspan="2">12???</td>
                                   <td colspan="2">13???</td>
                                   <td colspan="2">14???</td>
                                   <td colspan="2">15???</td>
                                   <td colspan="2">16???</td>
                                   <td colspan="2">17???</td>
                                   <!--<td colspan="2">18???</td>-->
                               </tr>
                           </thead>
                           <tbody>
                               <tr>
                                   <th class="fixed_th">????????????</th>
                                   <td class="none meet_popup" onclick="myFunction()">
                                     <span class="popuptext" id="meet_booking_pop">
                                       <p class="m_room">????????????</p>
                                       <p class="m_day">2021-05-07 12:00-15:00</p>
                                       <p class="m_title">??????????????????????????????</p>
                                     </span>
                                   </td>
                                   <td class="none"></td>
                                   <td class="none"></td>
                                   <td></td>
                                   <td data-needpopup-show="#cor_reserve_popup"></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td></td>
                                   <td class="now"></td>
                                   <td class="waiting"></td>
                                   <td class="waiting"></td>
                                   <td class="waiting"></td>
                                   <td class="waiting"></td>
                               </tr>
                           </tbody>
                       </table>
                    </div>
                </div>
           </div>
        </div>
        <!--contetns//-->
        
		<!--//?????? ?????? ??????-->
		<div id="app_meeting" class="needpopup coron_pop">
		      <h5 class="pop_tit">????????????</h5>
		      <ul class="form">
		        <li>
		          <p class="pop_text">?????? ?????????</p> : <span id="res_swcName"></span>
		          <!--  ?????? ?????? ?????? ?????? -->
		          <div style="display:none">
		          
		          <input type="hidden" name="floorSeq" id="floorSeq" >
				  <input type="hidden" name="searchCenterId" id="searchCenterId" value="${regist.searchCenterId}">
				  <input type="hidden" id="itemGubun" name="itemGubun" value="${regist.itemGubun}" />
				  <input type="hidden" id="searchRoomType" name="searchRoomType" value="${regist.searchRoomType}"/>
				  <input type="hidden" name="hid_attendList" id="hid_attendList">
                  <input type="hidden" id="hid_equipList" name="hid_equipList">	
				
		          <select id="resGubun"></select>
		          <input type="radio" id="resPassword" name="resPassword" value="Y">??????
		          <input type="radio" id="resPassword" name="resPassword" value="N">?????????
		          <input type="hidden" id="conPin" name="conPin"/>
		          <input type="hidden" id="conVirtualPin" name="conVirtualPin"/>
		          <input type="hidden" id="conAllowstream" name="conAllowstream"/>
		          <input type="hidden" id="conBlackdial" name="conBlackdial"/>
		          <input type="hidden" id="conSendnoti" name="conSendnoti"/>
		          <input type="hidden" id="resEqupcheck" name="resEqupcheck"/>
		          <input type="hidden" id="proxyUserId" name="proxyUserId"/>
		          <input type="checkbox" id="proxyYn" name="proxyYn" value="Y"> <!--  ?????? ?????? ?????? ?????? --> 
		          <input type="hidden" id="seatConfirmgubun" name="seatConfirmgubun"> 
		          
		          </div>
		          <!--  ?????? ?????? ?????? ?????? -->
		        </li>
		        <li>
              <p class="pop_text">?????????</p>
              <input type="text" id="resTitle" name="resTitle" placeholder="???????????? ???????????????"/>
            </li>
		        <li class="w50_cor" style="display:none">
		          <p class="pop_text">?????????</p>
		          <span id="sp_userId"></span>
		        </li>
		        <li class="w50_cor" style="display:none">
		          <p class="pop_text">?????????</p>
		          <span id="sp_userEmail"></span>
		        </li>
				    <li>
		          <p class="pop_text">????????????</p>
		          <input type="number" id="resPerson" name="resPerson">
              ???
		        </li>
		        <li>
		          <p class="pop_text">????????????</p>
		          <input type="text" id="resRemark" name="resRemark" placeholder="?????? ????????? ???????????? ??????????????????">
		        </li>
		       
		        <li>
		          <p class="pop_text">????????????</p>
		                      ????????????<input class="date_cor" type="text" id="resStartday" name="resStartday" class="inputSearch" onChange="fn_ResDayCheck()" />
		          <select id='resStarttime' style="width:120px;"></select>
		          <br/>????????????<input class="date_cor" type="text" id="resEndday" name="resEndday" class="inputSearch"  onChange="fn_ResDayCheck()"/>
		          <select id='resEndtime' style="width:120px;"></select>
		        </li>
		        <li>
		          <p class="pop_text">????????????</p>
		          <div class="scroll">
		            1. ??????????????? ?????? ????????? ?????? 7??? ????????? ??????????????? ?????????. <br/>
		            2. ???????????? ??? ???????????? ????????? ????????? ??? ????????????.<br/>
		            3. ?????? ?????? ??? ??????????????? ????????? ?????????????????? ?????????.<br/>
		            4. ?????? ??? ????????? ???????????????.<br/>
		            5. ????????? ??????????????? ????????? ?????? ????????? ??????????????? ??????????????? ?????????.<br/>
		            6. ???????????? ??????/???????????? ??????, ?????? ?????? ????????? ?????? ????????????????????? ????????????.<br/>
		            7. ???????????? ????????????(??????)<br/>
		            ??? ??????: ?????? ????????????<br/>
		            ??? ????????????: ??????, ??????, ????????????, ?????????<br/>
		            ??? ???????????? ?????? ??? ????????????: ????????? ?????? 5???<br/>
		                                ??? ????????? ????????? ????????? ????????? ?????? ?????? ??? ?????? ????????? ???????????????.<br/>
		          </div>
				  <p class="pop_text margintop10"><input type="checkbox" id="agreeCheck" name="agreeCheck">???????????????.</p>
		          <p class="pop_text margintop10"><input type="checkbox" id="sendMessage" name="sendMessage" value="Y" checked="checked">?????? ?????? ????????? ??????</p>
		        </li>
		      </ul>
		      <div class="clear"></div>
		      <div class="footerBtn">
		        <a href="#" onClick="res.fn_ResSave()" class="blueBtn">????????????</a>
		        <a href="#" onClick="need_close()" class="grayBtn">??????</a>
		      </div>
		      <div class="clear"></div>
       </div>
       
	   <div id="ok_reserve" class="needpopup opened">
	        <ul class="form">
	          <li>
	            <span id="sp_message"></span>
	          </li>
	        </ul>
	        <div class="clear"></div>
	        <div class="footerBtn">
	          <a href="#" onClick="fn_hisInfo()" class="grayBtn" style="width: 100%;">??????</a>
	        </div>
	        <div class="clear"></div>  
	   </div>
       <button type="button" id="btn_result" style="display:none" data-needpopup-show='#ok_reserve'>????????? ?????? ??????</button>
       <button type="button" id="btn_res" style="display:none" data-needpopup-show='#app_meeting'>?????? ?????? ??????</button>
  <!--?????? ??????//-->           
        <script src="/front_res/js/needpopup.min.js"></script>
		<script type="text/javascript">
			function need_close(){
				needPopup.hide();
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
        
        <script src="/front_res/js/swiper.min.js"></script>
        <script>  
            $( function() {
            	 $( "#searchResStartday").datepicker({ dateFormat: 'yy-mm-dd' });
            	 $( "#searchResEndday").datepicker({ dateFormat: 'yy-mm-dd' });
            	 $( "#resStartday").datepicker({ dateFormat: 'yy-mm-dd' });
            	 $( "#resEndday").datepicker({ dateFormat: 'yy-mm-dd' });
            	 //fn_floorMeetingInfo();
            	 var state = "${status}";
        		 if (state == "FAILLACK"){
        	   		 alert("???????????? ???????????? ????????????");
        	   		 location.href= "/web/index.do";
        	   	 }
        		 //???????????? 
        		 res.fn_meetingViewGubun("Detail");
        		 
            });
            
            var res = {
            		fn_ResSave : function(){
            			 var resEqupcheck = "";
            			 
            			 $("#hid_history").val("res_show");
            			 if (fn_Check("agreeCheck", "???????????? ?????? ??? ?????? ????????? ???????????????.") == false) return;
            			 if (any_empt_line_span("resTitle", '???????????? ????????? ?????????.') == false) return;
            			 if (any_empt_line_span("resStarttime", '?????? ?????? ????????? ????????? ?????????.') == false) return;
	           			 if (any_empt_line_span("resEndtime", '?????? ????????? ????????? ?????????.') == false) return;
	           			 if (any_empt_line_span("resRemark", '?????? ?????? ????????? ????????? ?????????.') == false) return;
	           			 if ($("#div_equipRoomInfo").is(":visible") == true){
	           		           if (any_empt_line_span("resEqupcheck", '???????????? ????????? ????????? ?????????.') == false) return;
	           			 }
	           			 if ($("#resGubun").val() == "SWC_GUBUN_2"  && $("#meetingSeq").val() == ""){
	           				 $("#sp_message").html("??????????????? ????????? ???????????? ????????? ?????????.");	 
	           				 $("#btn_result").trigger("click");
	           				 return;
	           			 }
	           			 if ($("#resStartday").val().replaceAll("-","") ==  $("#resEndday").val().replaceAll("-","") && $("#resStarttime").val() > $("#resEndtime").val()){
	           				 $("#sp_message").html("??????????????? ??????????????? ?????? ???????????? ?????????.");
	           				 $("#btn_result").trigger("click");
	           				 return;
	           			 }
	           			 if ($("#resEqupcheck").val() == "?????? ????????????"){
	           		         resEqupcheck = "RES_EQUPCHECK_1";
	           			 }else {
	           				 //?????? ????????? ??? ?????? 
	           				 resEqupcheck = $("#resEqupcheck").val();
	           			 }
	           			 if ($("#meetingSeq").val() == "on"){
	           		          $("#meetingSeq").val("");
	           			 }
	           			 var params = {'mode': $("#mode").val(), 'itemId': $("#itemId").val(), 'itemGubun':'ITEM_GUBUN_3', 'resTitle' : $("#resTitle").val(),
	           			               'resPassword' : fn_domNullReplace( $("input:radio[name='resPassword']:checked").val() ,'Y'), 'resStartday' : $("#resStartday").val().replaceAll("-",""),
	           			               'resEndday' : $("#resEndday").val().replaceAll("-",""),
	           					       'resStarttime' : $("#resStarttime").val(), 'resEndtime' : $("#resEndtime").val(),
	           					       'proxyUserId' : $("#proxyUserId").val(), 'resGubun' : $("#resGubun").val(),
	           					       'useYn' : "Y", 'centerId': $("#searchCenterId").val(),
	           					       'proxyYn' :  $("#proxyYn").val(),  'meetingSeq' : $("#meetingSeq").val(), 
	           					       'seatConfirmgubun': $("#seatConfirmgubun").val(),
	           					       'resAttendlist' : $("#hid_attendList").val().substring(1),
	           					       'conNumber' : "", 'conPin' : $("#conPin").val(),
	           					       'conVirtualPin' :$("#conVirtualPin").val(), 'conAllowstream' : fn_domNullReplace($("#conAllowstream").val(), "N") ,
	           					       'conBlackdial' : fn_domNullReplace($("#conBlackdial").val(), "N") , 'conSendnoti' :  fn_domNullReplace($("#conSendnoti").val(), "N"),
	           					       'resEqupcheck' : fn_domNullReplace( $("#resEqupcheck").val(), "RES_EQUPCHECK_1"), 
	           					       'sendMessage' : fn_domNullReplace($("input:checkbox[name='sendMessage']:checked").val() ,'N'),
	           					       'floorSeq' : $("#floorSeq").val(), 'resRemark' : $("#resRemark").val(), 'resPerson' : fn_domNullReplace($("#resPerson").val(), "0")
	           			              };
	           			 //??? ?????? 
	           			 uniAjax("/web/resReservertionUpdate.do", params, 
	           		  			function(result) {
	           						       if (result.status == "LOGIN FAIL"){
	           								    alert(result.message);
	           									location.href="/web/Login.do";
	           							   }else{
	           								    need_close();
	           								    if (result.status == "SUCCESS"){
	           								    	$("#hid_history").val("");
	           								    }
	           								    $("#sp_message").text(result.message);
	           								    $("#btn_result").trigger("click");
	           								    fn_resCancel();
	           								    fn_floorMeetingIntervalInfo('2')
	           							   }
	           							  
	           					},
	           				    function(request){
	           					     alert("Error:" +request.status );	       						
	           				    }    		
	           		     );
           		    }, fn_meetingViewGubun : function (ViewGubun){
            			if (ViewGubun == "Detail"){
            				$("#meeetingDetail").show();
            				$("#meeetingRes").hide();
            				res.fn_meetingInfo();
            			}else {
            				$("#meeetingDetail").hide();
            				$("#meeetingRes").show();
            				fn_floorMeetingIntervalInfo("2");
            			}
            		}, fn_meetingInfo : function (){
            			var url = "/web/meetingDetail.do";
            			
            			var params = {'meetingId': $("#itemId").val()};
            			var result = uniAjaxReturnSerial(url, params);
            			if (result.result != ""){
            				var obj = result.regist;
            				$("#resReqday").val(obj.res_reqday);
            				$("#floorSeq").val(obj.floor_seq);
            				$("#searchCenterId").val(obj.center_id);
            				
            				$("#sp_roomTitle").text(obj.meeting_name);
            				
            				$("#img_left01").attr("src", "/upload/"+ obj.meeting_img1);
            				$("#img_left02").attr("src", "/upload/"+ obj.meeting_img2);
            				$("#img_left03").attr("src", "/upload/"+ obj.meeting_img3);
            				
            				$("#img_bottom01").attr("src", "/upload/"+ obj.meeting_img1);
            				$("#img_bottom02").attr("src", "/upload/"+ obj.meeting_img2);
            				$("#img_bottom03").attr("src", "/upload/"+ obj.meeting_img3);
            				$("#sp_remark").html(obj.meetingroom_remark);
            				
            				fn_trInnerTxt("td_meeting_remark01", obj.meeting_remark01);
            				fn_trInnerTxt("td_meeting_remark02", obj.meeting_remark02);
            				fn_trInnerTxt("td_meeting_remark03", obj.meeting_remark03);
            				fn_trInnerTxt("td_meeting_remark04", obj.meeting_remark04);
            				fn_trInnerTxt("td_meeting_remark05", obj.meeting_remark05);
            				fn_trInnerTxt("td_meeting_remark06", obj.meeting_remark06);
            				fn_trInnerTxt("td_meeting_remark07", obj.meeting_remark07);
            				fn_trInnerTxt("td_meeting_remark08", obj.meeting_remark08);
            				
            				var empInfoVO = result.userinfo;
            				$("#sp_userId").text(empInfoVO.empno);
            				$("#sp_userEmail").text(empInfoVO.empmail);
            				
            				if (obj.meeting_file01 != "" && obj.meeting_file01 != undefined){
 							   $("#td_meeting_file01").parent().show();
                                $("#td_meeting_remark08")[0].innerHtml = "<a href='/upload/"+obj.meeting_file01+"' target='_blank'>"+ obj.meeting_file01+ "</a>";
 							}else{
                                $("#td_meeting_file01").parent().hide();
 							}
            				var galleryThumbs = new Swiper('.gallery-thumbs', {
            		              spaceBetween: 1,
            		              slidesPerView: 3,
            		              loop: true,
            		              freeMode: true,
            		              loopedSlides: 3, //looped slides should be the same
            		              watchSlidesVisibility: true,
            		              watchSlidesProgress: true,
            		        });
            				
            				var galleryTop = new Swiper('.gallery-top', {
            		              spaceBetween: 1,
            		              loop:true,
            		              loopedSlides: 3, //looped slides should be the same
            		              navigation: {
            		                nextEl: '.swiper-button-next',
            		                prevEl: '.swiper-button-prev',
            		              },
            		              thumbs: {
            		                swiper: galleryThumbs,
            		              },
            		        });
            				
            				
            				galleryTop.params.control = galleryThumbs;
            				galleryThumbs.params.control = galleryTop;
            				
            				$("img[name=img_left01]").attr("src", "/upload/"+ obj.meeting_img1);
            				$("img[name=img_left02]").attr("src", "/upload/"+ obj.meeting_img2);
            				$("img[name=img_left03]").attr("src", "/upload/"+ obj.meeting_img3);
            				
            				$("img[name=img_bottom01]").attr("src", "/upload/"+ obj.meeting_img1);
            				$("img[name=img_bottom02]").attr("src", "/upload/"+ obj.meeting_img2);
            				$("img[name=img_bottom03]").attr("src", "/upload/"+ obj.meeting_img3);
            		        
            			}else {
            				
            			}
            			
            		} 
            }
            function res_show(){
            	$("#btn_res").trigger("click");
            }
            function fn_meetingView(code){
            	$("#dv_floor").find("[name=btn_floor]").attr('class', '');
            	$("#btn_"+code).attr('class', 'active');
            	$("#itemId").val(code);
    			res.fn_meetingViewGubun("Detail");
    		}
            function fn_ResDayCheck(){
            	//$("#hid_history").val("res_show"); //?????? ?????? ?????? 
            	if (yesterDayConfirm($("#resStartday").val().replaceAll("-","") , "?????? ????????? ?????? ????????? ????????????" ) == false ) return;
        		if (yesterDayConfirm($("#resEndday").val().replaceAll("-","") , "?????? ????????? ?????? ????????? ????????????" ) == false ) return;
        		var res_reqday = $("#resReqday").val();		
        		if (dateCheck($("#resStartday").val().replaceAll("-",""), res_reqday, "?????? ??????????????? "+  res_reqday + " ?????? ?????????.")  == false) { return; }
        		if (dateCheck($("#resEndday").val().replaceAll("-",""), res_reqday, "?????? ??????????????? "+  res_reqday + " ?????? ?????????.")  == false) { return; }
        		if (dateDiffCheck($("#resStartday").val().replaceAll("-",""), $("#resEndday").val().replaceAll("-",""), "???????????? ????????? ?????? ?????? ??? ?????????.")  == false) { return; }
        		
            }
            function fn_dayIntervalCheck(obj){
            	var calId = $(obj).attr('id');
            	var res_reqday = $("#resReqday").val();	
            	
            	var thisDay = $("#"+calId).val().replaceAll("-", "");
				
            	if (dateCheck( thisDay,  res_reqday ,  "?????? ??????????????? "+  res_reqday + " ?????? ?????????.")  == false ){ 
            		if (calId == "searchResStartday"){
                		$("#searchResStartday").val($("#resetStartday").val());
                	}else {
                		$("#searchResEndday").val($("#resetEndday").val());
                	}
            		return;
            		
            	}
            	if (dateDiffCheck(thisDay, dateAdd("90"), "????????? ?????? 7??? ?????? 90??? ?????? ????????? ?????? ?????????.")  == false ){ 
            		if (calId == "searchResStartday"){
                		$("#searchResStartday").val($("#resetStartday").val());
                	}else {
                		$("#searchResEndday").val($("#resetEndday").val());
                	}
            		return;
            	}
            	if (dateDiffCheck($("#searchResStartday").val().replaceAll("-",""), $("#searchResEndday").val().replaceAll("-",""), "???????????? ????????? ?????? ?????? ??? ?????????.")  == false) {
            		if (calId == "searchResStartday"){
                		$("#searchResStartday").val($("#resetStartday").val());
                	}else {
                		$("#searchResEndday").val($("#resetEndday").val());
                	}
            	}	
				
				
            }
            function fn_dayReset(){
            	
            }
         </script>
         <!-- Swiper JS -->
         <!--//pinch-zoom-->
         <script type="text/javascript">
              var el = document.querySelector('div.pinch-zoom');
              new PinchZoom.default(el, {});
        </script>
        <!--pinch-zoom//-->
</form:form>
</body>
</html>