<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css"> 
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    
    
    <script type="text/javascript" src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/back_common.js"></script>
    <script src="/js/popup.js"></script>
    <link rel="stylesheet" href="/css/new/jquery-ui.css">
    <link rel="stylesheet" href="/css/new/needpopup.min.css">
    
    
    
    <script src="/js/jquery-ui.js"></script>
    <script type="text/javascript" src="/js/front/com_resInfo.js"></script>
    <script type="text/javascript" src="/js/front/common_res.js"></script>
    <script>
	jQuery.browser = {};
	(function () {
	    jQuery.browser.msie = false;
	    jQuery.browser.version = 0;
	    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
	        jQuery.browser.msie = true;
	        jQuery.browser.version = RegExp.$1;
	    }
	})();
	</script>
    <link rel="stylesheet" type="text/css" href="/css/toggle.css">
    <link rel="stylesheet" type="text/css" href="/css/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/resources/jqgrid/src/css/ui.jqgrid.css">
    <script type="text/javascript" src="/resources/jqgrid/src/i18n/grid.locale-kr.js"></script>
    <script type="text/javascript" src="/resources/jqgrid/js/jquery.jqGrid.min.js"></script>
     
    <script>
    $(function () {
        var clareCalendar = {
            monthNamesShort: ['1???', '2???', '3???', '4???', '5???', '6???', '7???', '8???', '9???', '10???', '11???', '12???'],
            dayNamesMin: ['???', '???', '???', '???', '???', '???', '???'],
            weekHeader: 'Wk',
            dateFormat: 'yymmdd', //??????(20120303)
            autoSize: false, //??????????????????(body??? ??????????????? ????????? ?????????)
            changeMonth: true, //???????????????
            changeYear: true, //???????????????
            showMonthAfterYear: true, //??? ?????? ??? ??????
            buttonImageOnly: true, //???????????????
            buttonText: '????????????', //?????? ????????? ??????
            buttonImage: '/images/invisible_image.png', //???????????????
            yearRange: '1970:2030' //1990????????? 2020?????????
        };	       
        $("#searchStartDay").datepicker(clareCalendar);
        $("#searchEndDay").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //??????????????? style??????
	    $("#ui-datepicker-div").hide(); //???????????? ???????????? div?????? ??????
	    // jqgrid  ?????? ??????
	    jqGridFunc.setGrid("mainGrid");
	});	
    </script>

	 <style type="text/css">
	     .ui-jqgrid .ui-jqgrid-htable th div{
			outline-style: none;
			height: 30px;
		 }
	     .ui-jqgrid tr.jqgrow {
			outline-style: none;
			height: 30px;
		 }
	 </style>
	 
    <script type="text/javascript">
      var jqGridFunc  = {
    		 setGrid : function(gridOption){
    			var grid = $('#'+gridOption);
    		    var postData = {"pageIndex": "1"};
    		    grid.jqGrid({
    		    	url : '/backoffice/resManage/resListAjax.do' ,
    		        mtype :  'POST',
    		        datatype :'json',
    		        pager: $('#pager'),  
    		        ajaxGridOptions: { contentType: "application/json; charset=UTF-8" },
    		        ajaxRowOptions: { contentType: "application/json; charset=UTF-8", async: true },
    		        ajaxSelectOptions: { contentType: "application/json; charset=UTF-8", dataType: "JSON" }, 
    		       
    		        postData : JSON.stringify( postData ),
    		        jsonReader : {
	   		             root : 'resultlist',
	   		             "page":"paginationInfo.currentPageNo",
	   		             "total":"paginationInfo.totalPageCount",
	   		             "records":"paginationInfo.totalRecordCount",
	   		             repeatitems:false
   		            },
    		        colModel :  [
    		 	                { label: 'res_seq', key: true, name:'res_seq',   index:'res_seq',      align:'center', hidden:true},
    			                { label: '??????',  name:'deptname',         index:'deptname',        align:'left',   width:'10%' },
    			                { label: '??????',  name:'empname',         index:'empname',        align:'left',   width:'10%' },
    			                { label: '??????',  name:'empno',         index:'empno',        align:'left',   width:'10%' },
    			                { label: '?????????',  name:'emphandphone',         index:'emphandphone',        align:'left',   width:'10%' },
    			                { label: '??????',  name:'center_nm',         index:'center_nm',        align:'left',   width:'10%' },
    			                { label: '??????', name:'floor_name',       index:'floor_name',      align:'center', width:'10%'},
    			                { label: '?????? ??????', name:'item_gubun_t',       index:'item_gubun_t',      align:'center', width:'10%'},
    			                { label: '???????????????', name:'item_name',       index:'item_name',      align:'center', width:'10%'},
    			                { label: '?????? ??????', name:'res_title',       index:'res_title',      align:'center', width:'20%' },
    			                { label: '?????? ?????????', name:'resStartday',       index:'resStartday',      align:'center', width:'40%' 
    			                  , formatter: jqGridFunc.resDayInfo},
    			                { label: '?????? ??????', name:'reg_date', index:'reg_date', align:'center', width:'12%', 
      			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
      			                { label: '???????????????', name:'tenn_cnt',       index:'tenn_cnt',  align:'center', width:'10%'},
    			                { label: '????????????', name:'reservprocessgubuntxt',       index:'reservprocessgubuntxt',  align:'center', width:'10%'},
    			                { label: '???????????????', name:'reserv_process_gubun',       index:'reserv_process_gubun',  align:'center', width:'10%'
    			                  , formatter: jqGridFunc.resProcess}
    			               
    			                
    			         ],  //????????? 
    		        rowNum : 10,  //????????? ???
    		        rowList : [10,20,30,40,50,100],  // ????????? ???
    		        pager : pager,
    		        refresh : true,
    	            rownumbers : true, // ????????? ??????
    		        viewrecord : true,    // ?????? ????????? ??? ?????? ??????
    		        //loadonce : false,     // true ????????? ????????? ????????? 
    		        loadui : "enable",
    		        loadtext:'???????????? ???????????? ???...',
    		        emptyrecords : "????????? ???????????? ????????????", //???????????? ?????? 
    		        height : "100%",
    		        autowidth:true,
    		        shrinkToFit : true,
    		        refresh : true,
    		        loadComplete : function (data){
    		        	 $("#sp_totcnt").text(data.paginationInfo.totalRecordCount);
    		        },loadError:function(xhr, status, error) {
    		            alert(error); 
    		        }, onPaging: function(pgButton){
    		        	  var gridPage = grid.getGridParam('page'); //get current  page
    		        	  var lastPage = grid.getGridParam("lastpage"); //get last page 
						  var totalPage = grid.getGridParam("total");
    		              if (pgButton == "next"){
    		            	  if (gridPage < lastPage ){
    		            		  gridPage += 1;
    		            	  }else{
    		            		  gridPage = gridPage;
    		            	  }
    		              }else if (pgButton == "prev"){
    		            	  if (gridPage > 1 ){
    		            		  gridPage -= 1;
    		            	  }else{
    		            		  gridPage = gridPage;
    		            	  }
    		              }else if (pgButton == "first"){
    		            	  gridPage = 1;
    		              }else if  ( pgButton == "last"){
    		            	  gridPage = lastPage;
    		              } else if (pgButton == "user"){
    		            	  var nowPage = Number($("#pager .ui-pg-input").val());
    		            	  
    		            	  if (totalPage >= nowPage && nowPage > 0 ){
    		            		  gridPage = nowPage;
    		            	  }else {
    		            		  $("#pager .ui-pg-input").val(nowPage);
    		            		  gridPage = nowPage;
    		            	  }
    		              }else if (pgButton == "records"){
    		            	  gridPage = 1;
    		              }
    		              grid.setGridParam({
		    		          	  page : gridPage,
		    		          	  rowNum : $('.ui-pg-selbox option:selected').val(),
		    		          	  postData : JSON.stringify(  {
							    		          			"pageIndex": gridPage,
							    		          			"searchDayGubun" : fn_emptyReplace($('input[name="searchDayGubun"]:checked').val(),"")	,
										    	    		"searchStartDay" : $("#searchStartDay").val(),
										    	    		"searchEndDay" : $("#searchEndDay").val(),
															"searchCenter" : $("searchCenter").val(),
															"searchFloorSeq" : fn_emptyReplace($("searchFloorSeq").val(),""),
										    	    		"searchCondition" : $("#searchCondition").val(),
										    	    		"searchKeyword" : $("#searchKeyword").val(),
										    	    		"searchReservProcessGubun" : $("#searchReservProcessGubun").val(),
										    	    		"itemGubun" : $("#itemGubun").val(),
										    	    		"pageUnit":$('.ui-pg-selbox option:selected').val()
							    		          		})
    		          		}).trigger("reloadGrid");
    		        },onSelectRow: function(rowId){
    	                if(rowId != null) {  }// ?????? ??????
    	            },ondblClickRow : function(rowid, iRow, iCol, e){
    	            	grid.jqGrid('editRow', rowid, {keys: true});
    	            },onCellSelect : function (rowid, index, contents, action){
    	            	var cm = $(this).jqGrid('getGridParam', 'colModel');
    	            	
    	                if (cm[index].name=='empname' || cm[index].name=='empno' || cm[index].name=='center_nm' || cm[index].name=='floor_name'
    	                	 || cm[index].name=='res_gubun'  || cm[index].name=='item_name' ){
    	                	fn_resinfo($(this).jqGrid('getCell', rowid, 'res_seq'));
            		    }
    	                
    	            }
    		    });
    		    
    		}, resDayInfo : function(cellvalue, options, rowObject){
    			var resdayinfo = (rowObject.item_gubun === "ITEM_GUBUN_3") ? rowObject.resstartday +"??? " + rowObject.resstarttime + " ?????? ~" + rowObject.resendday +"??? " + rowObject.resendtime  + "??????"
    					                                                   : rowObject.resstartday +"??? " + rowObject.resstarttime + "~" + rowObject.resendtime ;
    			return resdayinfo ;
    		}, resProcess : function (cellvalue, options, rowObject){
    			//?????? combo 
    			var resCombo = ""
    			if (rowObject.reserv_process_gubun == "PROCESS_GUBUN_1" || rowObject.reserv_process_gubun == "PROCESS_GUBUN_2" || rowObject.reserv_process_gubun == "PROCESS_GUBUN_4" || rowObject.reserv_process_gubun == "PROCESS_GUBUN_8"){
    				var selecte1 =  (rowObject.reserv_process_gubun == 'PROCESS_GUBUN_4') ? "selected" : "";
    				var selecte2 =  (rowObject.reserv_process_gubun == 'PROCESS_GUBUN_5') ? "selected" : "";
    				var selecte3 =  (rowObject.reserv_process_gubun == 'PROCESS_GUBUN_8') ? "selected" : "";
    				resCombo = "<select name=\"reservProcessGubun\"  id=\"reservProcessGubun_"+rowObject.res_seq+"\" onChange=\"jqGridFunc.fn_change_process('reservProcessGubun_"+rowObject.res_seq+"', '"+rowObject.res_seq+"');\">"
    			             + "   <option value=''>????????? ????????????</option>"  
    			             + "   <option value='PROCESS_GUBUN_4' "+ selecte1 +">????????? ??????</option>"
    			             + "   <option value='PROCESS_GUBUN_8' "+ selecte3 +">?????? ??????</option>"
    			             + "   <option value='PROCESS_GUBUN_5' "+ selecte2 +">????????? ??????</option>"
    			             + "</select>";
    			}else {
    				resCombo = rowObject.reservprocessgubuntxt;
    			}
    			return resCombo;
    		}, fn_change_process : function(code, seq){
    			
    	    	if (confirm( "??????????????? ?????? ???????????????????")== true){
    	    		if($("#"+code+"").val() == "PROCESS_GUBUN_5" ){
    	    			//?????? ?????? ?????? 
    	    			$("#resSeq").val(seq);
    	    			$("#btn_pop").trigger("click");
    	    			
    				}else {
    					 var params = {'resSeq': seq, 'cancelCode': '', 
    		    				       'reservProcessGubun' : $("#"+code+"").val(), 'cancelReason' : ''
    		    		              };
    		    	     uniAjax("/backoffice/resManage/reservationProcessChange.do", params, 
    		    	  			 function(result) {
    		    					       if (result.status == "LOGIN FAIL"){
    		    					    	    alert(result.message);
    		    								location.href="/backoffice/login.do";
    		    						   }else if (result.status == "SUCCESS"){
    		    							    alert(result.message);
    		    							    jqGridFunc.fn_search();
    		    						   }else {
    		    							   alert(result.message);
    		    						   }
   		    					  },function(request){
   		    						    alert("Error:" +request.status );	       						
   		    					  }    		
    		    	     );
    				}
    	   		}else{
    	   			jqGridFunc.fn_search();
    	   		}
    	    }, fn_search: function(){
    	       $("#mainGrid").setGridParam({
	    	    	 datatype	: "json",
	    	    	 postData	: JSON.stringify(  {
	    	    		 "searchDayGubun" : fn_emptyReplace($('input[name="searchDayGubun"]:checked').val(),"")	,
	    	    		 "searchStartDay" : $("#searchStartDay").val(),
	    	    		 "searchEndDay" : $("#searchEndDay").val(),
						 "searchCenter" : $("#searchCenter").val(),
						 "searchFloorSeq" : fn_emptyReplace($("#searchFloorSeq").val(),""),
	    	    		 "searchCondition" : $("#searchCondition").val(),
	    	    		 "searchKeyword" : $("#searchKeyword").val(),
	    	    		 "searchReservProcessGubun" : $("#searchReservProcessGubun").val(),
	    	    		 "itemGubun" : $("#itemGubun").val(),
	    	    		 "pageIndex": "1",
	         			 "pageUnit":$('.ui-pg-selbox option:selected').val()
	         		}),
	    	    	loadComplete	: function(data) {$("#sp_totcnt").text(data.paginationInfo.totalRecordCount);}
	    	     }).trigger("reloadGrid");

	        }, fn_cancel: function(){
	        	 if (any_empt_line_id("cancelCode", '?????? ????????? ????????? ?????????') == false) return;
	    		 if (any_empt_line_id("cancelReason", '?????? ?????????  ????????? ?????????') == false) return;
	    		 
	    		 var params = {'resSeq': $("#resSeq").val(), 'cancelCode': $("#cancelCode").val(), 
	    				       'reservProcessGubun' : 'PROCESS_GUBUN_5', 'cancelReason' : $("#cancelReason").val()};
	    	     uniAjax("/backoffice/resManage/reservationProcessChange.do", params, 
	    	  			function(result) {
	    					       if (result.status == "LOGIN FAIL"){
	    					    	   alert(result.message);
	    							   location.href="/backoffice/login.do";
	    						   }else if (result.status == "SUCCESS"){
	    							   need_close();
	   		    	                   jqGridFunc.fn_search();
	    						   }else {
	    							   alert(result.message);
	    						   }
	    					    },
	    					    function(request){
	    						    alert("Error:" +request.status );	       						
	    					    }    		
	    	      );
	        	
	        }, fn_ExcelDown : function (){
	        	
	        }
       
      }
      $(function(){
    	  document.addEventListener('keydown', function(e){
    	    const keyCode = e.keyCode;
    	    console.log('pushed key ' + e.key);

    	    if(keyCode == 13){ // Enter key
    	    	jqGridFunc.fn_search();
    	    }
    	  })
    	});
  </script>
    
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/resManage/resList.do">
<c:import url="/backoffice/inc/top_inc.do" />
	<jsp:useBean id="nowDate" class="java.util.Date" />
	<c:set var="sysday"><fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /></c:set>
	<c:set var="systime"><fmt:formatDate value="${nowDate}" pattern="HH:mm" /></c:set>
	<input type="hidden" name="pageIndex" id="pageIndex" value="${regist.pageIndex }">
	<input type="hidden" name="delResSeq" id="delResSeq">
	<input type="hidden" name="hid_equpState" id="hid_equpState">
	<input type="hidden" name="mode" id="mode">
	<input type="hidden" name="searchRoomType" id="searchRoomType" value="${regist.searchRoomType}">
    <input type="hidden" name="resSeq" id="resSeq">
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span><spring:message code="menu.menu03" /> 
                        <span>></span><strong><spring:message code="menu.menu03_1" /></strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">
                
                </div>
                <section class="Bclear">
	                <table class="pop_table searchThStyle">
		                <tr class="tableM">
			                <th style="width:90px;">
			                	??????
			                </th>
                   			<td colspan="3" style="text-align:left;padding-left: 20px;">
                   			    <input type="radio" id="searchDayGubun" name="searchDayGubun" value="REG_DATE"    />
				                <label>?????????</label>
			                    <input type="radio" id="searchDayGubun" name="searchDayGubun" value="RES_STARTDAY"   />
			                    <label>????????? </label> 
			                	&nbsp;&nbsp;&nbsp;&nbsp;
			                	<input   size="10" maxlength="20" id="searchStartDay" style="cursor:default;" class="date-picker-input-type-text" />
			                     ~
			                    <input   size="10" maxlength="20" id="searchEndDay" style="cursor:default;"  class="date-picker-input-type-text" />
	                		</td>
		                	<th style="width:90px;">?????????</th>
		                	<td colspan="5"  style="text-align:left;padding-left: 20px;">
		                		<select name="searchCondition"  id="searchCondition">
									<option value="" >??????</option>
									<option value="b.EMPNO" >??????</option>
									<option value="b.EMPNAME" >??????</option>
								</select>
								<input class="nameB " type="text" name="searchKeyword" id="searchKeyword"   size="20"  maxlength="30"    onkeydown="if(event.keyCode==13){search_form();}">
		                	</td>
		                	<td rowspan="2" class="border-left" style="width:72px">
			                    <a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">??????</span></a>
		                	</td>
						</tr>
						<tr>  
		                	<th>????????????</th>
		                	<td style="text-align:left;padding-left: 20px;" colspan="3">
		                		<form:select path="searchCenter" id="searchCenter" title="???????????????" onChange="backoffice_common.fn_floorSearch('','sp_floorCombo', 'searchFloorSeq')">
								         <form:option value="" label="???????????????"/>
				                         <form:options items="${searchCenterId}" itemValue="centerId" itemLabel="centerNm"/>
						    	</form:select>	
						    	<span id="sp_floorCombo"></span>
						    	
		                	</td>
		                	<th>?????? ??????</th>
		                	<td>
		                		<form:select path="itemGubun" id="itemGubun" title="????????????">
							    	<form:option value="" label="????????????"/>
				                    <form:options items="${selectItemGubun}" itemValue="code" itemLabel="codeNm"/>
							    </form:select>
		                	</td>
		                	<th>???????????????</th>
		                	<td>
		                		<form:select path="searchReservProcessGubun" id="searchReservProcessGubun" title="????????????">
							    	<form:option value="" label="????????????"/>
				                    <form:options items="${selectProcessType}" itemValue="code" itemLabel="codeNm"/>
							    </form:select>
		                	</td>
		                	
		                </tr>   
                    </table>
                </section>
                <div class="rightB magin-bottom20">
                	  <a href="javascript:fn_ExcelDown()" traget="_blank"><span class="deepBtn">????????????</span></a>
                </div>
                <div class="clear"></div>
            </div>

            <div class="Swrap tableArea">
                <!--  jqgrid  ?????? --> 
                 <table id="mainGrid"></table>
                 <div id="pager" class="scroll" style="text-align:center;"></div>   
                 
            </div>
            <div class="pagenum">
            </div>
        </div>
    </div>
    <c:import url="/backoffice/inc/bottom_inc.do" /> 

	    <!--  ?????? ?????? ?????? -->
	    <div id='equipPop' class="needpopup">
	        <div class="popHead">
	            <h2>?????? ??????</h2>
	        </div>
	        <div class="pop_footer">
	            <span id="join_confirm_comment" class="join_pop_main_subTxt">????????? ?????? ??? ?????? ?????? ????????? ?????? ?????????.</span>
	             <a href="javascript:fn_equpChange('EQUIP_STATE_2');" class="redBtn" id="btnRental">?????? ??????</a> 
	             <a href="javascript:fn_equpChange('EQUIP_STATE_1');" class="redBtn" id="btnReturn">?????? ??????</a>    
	             <a href="javascript:fn_equpChange('EQUIP_STATE_5');" class="redBtn" id="btnCancel">?????? ??????</a>    
	            <div class="clear"></div>
	        </div>
	        
	        <!-- pop contents-->   
	        <div class="popCon">
	            <!--// ?????? ????????????-->
	            <div class="pop_box100">
	                <div class="padding15" style="background-color:white">
	                    <table class="pop_table thStyle" id="tb_equip">
	                       <thead>
	                          <tr>
	                               <td><input type="checkbox" id="allCheck" />????????????</td>
	                               <td>?????????</td>
	                               <td>???????????????</td>
	                               <td>??????</td>
	                          </tr>
	                       </thead>
	                       <tbody>
	                       </tbody>
	                     </table>
	                </div>                
	            </div>
	            <div class="clear"></div>   
	        </div>           
	    </div> 
	    <!--  ?????? ?????? ?????? ??? ??????-->

        <!--  ?????? ?????? ?????? ?????? -->
        <div id='resInfoPopCancel' class="needpopup">
        <div class="popHead">
            <h2>?????? ??????</h2>
        </div>
	        <!-- pop contents-->   
	        <div class="popCon">
				<table class="pop_table thStyle">
					<tbody class="search">
						<tr>							         	
				        	<td style="text-align:left">
				        		<form:select path="cancelCode" id="cancelCode" title="????????????">
	                       			<form:option value="" label="????????????"/>
		                         	<form:options items="${selectCancel}" itemValue="code" itemLabel="codeNm" />
			    				</form:select>
				        	</td>
			        	</tr>
			        	<tr>
				        	<td style="text-align:left">
					        	<textarea rows="10" id="cancelReason" name="cancelReason">${regist.cancelReason }</textarea>
					        </td>
			        	</tr>
					</tbody>
				</table>
				<div class="footerBtn">
		        	<a href="#" onclick="jqGridFunc.fn_cancel()" class="redBtn">??????</a>
		        	<a href="#" onClick="need_close()" class="deepBtn">??????</a>
                </div>
			</div>
		</div>
		
        <div id='resInfoPop' class="needpopup">
        <div class="popHead">
            <h2>?????? ??????</h2>
        </div>
        <div class="popCon">
            <!--// ?????? ????????????-->
            <div class="pop_box100">
                <div class="padding15" style="background-color:white">
                <table class="pop_table thStyle">
					<tbody class="search">
						 <tr>
						  <th>?????? ??????</th>
						  <td colspan="3"><span id="sp_resTitle"></span></td>
						 </tr>
						 <tr>
						   <th>??????</th>
						   <td><span id="sp_seatName"></span></td>
						   <th>??????</th>
						   <td><span id="sp_resStartday"></span>  </td>
						 </tr>
						 <tr id="tr_coro">
						   <th>????????????</th>
						   <td><span id="sp_remark"></span></td>
						   <th>????????????</th>
						   <td><span id="sp_person"></span>  </td>
						 </tr>
						 <tr>
						   <th>?????? ??????</th>
						   <td><span id="sp_resGubunTxt"></span></td>
						   <th>????????????</th>
						   <td><span id="sp_reservProcessGubunTxt"></span>   </td>
						 </tr>
						  <tr  id="tr_swcGubun">
						   <th>?????? ?????????</th>
						   <td colspan="3">
						      <span id="sp_meegintRoomInfo"></span>
						   </td>
						 </tr>
						 <tr>
						   <th>?????????</th>
						   <td><span id="sp_empname"></span>  </td>
						   <th>?????????</th>
						   <td> <span id="sp_empmail"></span> </td>
						 </tr>
						 <tr>
						   <th>?????? ??????</th>
						   <td><span id="sp_proxyYnTxt"></span></td>
						   <th>?????????</th>
						   <td><span id="sp_proxyUserId"></span>  </td>
						 </tr>
						 <tr id="tr_attend">
						   <th>????????? ??????</th>
						   <td colspan="3">
						    <span id="sp_resAttendInfo"></span>
						   </td>
						 </tr>
					
						 <tr id="tr_cancel">
						   <th>????????????</th>
						   <td><span id="sp_cancelCodeTxt"></span>
						   </td>
						   <th>?????? ??????</th>
						   <td><span id="sp_cancelReason"></span>
						   </td>
						 </tr>
					</tbody>
				</table>
                </div>                
            </div>
            <div class="clear"></div>   
        </div>           
    </div> 
<!--  ?????? ?????? ?????? ?????? ???-->
</form:form>
<c:import url="/backoffice/inc/uni_pop.do" />
<button id="btn_pop" style="display:none" data-needpopup-show='#resInfoPopCancel'>?????? ??????</button>
</div>


 <script type="text/javascript">
    function fn_resinfo(resSeq){
    	uniAjaxSerial("/backoffice/resManage/resInfoAjax.do?resSeq="+resSeq, null, 
 	  			function(result) {
 					       if (result.status == "LOGIN FAIL"){
 					    	    alert(result.message);
 								location.href="/backoffice/login.do";
 						   }else if (result.status == "SUCCESS"){
	 							var obj = result.resInfo;
	 							$("#sp_resTitle").html(obj.res_title);
	 							$("#sp_seatName").html(obj.floor_name +" "+  obj.itme_name );
	 							var resdayinfo = (obj.item_gubun === "ITEM_GUBUN_3") ? obj.resstartday +"??? " + obj.resstarttime + " ?????? ~" + obj.resendday +"??? " + obj.resendtime  + "??????"
                                                                                      : obj.resstartday +"??? " + obj.resstarttime + "~" + obj.resendtime ;

	 							if (obj.item_gubun === "ITEM_GUBUN_3"){
	 								$("#sp_remark").html(obj.res_remark);
	 								$("#sp_person").html(obj.res_person);
	 								$("#tr_coro").show();
	 							}else {
	 								$("#tr_coro").hide();
	 							}
	 							$("#sp_resStartday").html(resdayinfo);
	 							$("#sp_resGubunTxt").html(obj.resgubuntxt);
	 							$("#sp_empname").html(obj.empname);
	 							$("#sp_empmail").html(obj.empmail);
	 							$("#sp_proxyYnTxt").html(obj.proxyyntxt);
	 							$("#sp_proxyUserId").html(obj.proxy_user_id);
	 							$("#sp_reservProcessGubunTxt").html(obj.reservprocessgubuntxt);
	 							
	 							var arr = ["PROCESS_GUBUN_3", "PROCESS_GUBUN_5", "PROCESS_GUBUN_6",  "PROCESS_GUBUN_7" ];
	 							if (arr.indexOf(obj.reserv_process_gubun) > 0 ){
	 								$("#tr_cancel").show();
	 								$("#sp_cancelCodeTxt").html(obj.cancelcodetxt);
	 								$("#sp_cancelReason").html(obj.cancel_reason);
	 							}else {
	 								$("#tr_cancel").hide();
	 							}
	 							if (obj.res_gubun == "SWC_GUBUN_2"){
									if (result.resRoomInfo != undefined){
										$("#tr_swcGubun").show();
										var meetingInfoTxt = "?????? ????????? ???????????????: ";
										if (result.resRoomInfo.length > 0){
											for (var i =0; i < result.resRoomInfo.length; i++){
												var meetinginfo = result.resRoomInfo[i];
												meetingInfoTxt += "<span style='padding-left: 10px;'>???"+meetinginfo.seatName+"</span>";
											}
											$("#div_meetingResRoomInfo").show();
											$("#sp_meegintRoomInfo").html(meetingInfoTxt);
										}
									}
          						}else{
          							$("#tr_swcGubun").hide();
          						}
	 							if (result.resRoomInfo != undefined){
	 								if (result.resUserList.length > 0){
	          							var userInfoTxt = "?????????: "+ obj.empname+"("+obj.deptname+ ") ?????????: ";
										if (obj.resPassword == "Y"){
	          								for (var i in result.resUserList){
	        							  		 var userInfos = result.resUserList[i];
	        							  	     userInfoTxt += "<span style='padding-left: 10px;'>"+userInfos.empname+"("+userInfos.deptname+")</span>";
	        							  	}	
	          							}else {
	          								userInfoTxt += "*****************";
	          							}
	          							$("#sp_resAttendInfo").html(userInfoTxt);
	          						} 
	 								$("#tr_attend").show();
	 							}else{
	 								$("#tr_attend").hide();
	 							}
	 							$("#btn_pop").attr("data-needpopup-show", "#resInfoPop").trigger("click");
	 					   }else {
 							   alert(result.message);
 						   }
 					    },
 					    function(request){
 						    alert("Error:" +request.status );	       						
 					    }    		
 	      );
		
    } 
    function fn_equpChange(resEqupcheck){
    	var resEqupinfo = ckeckboxValue( "?????? ?????? ????????? ????????????","equipCode");
    	
    	var params = {"resSeq" :  $("#delResSeq").val(), "resEqupcheck" : resEqupcheck, "resEqupinfo" :  resEqupinfo};
    	uniAjax("/backoffice/resManage/resEquChange.do", params, 
 	  			function(result) {
 					       if (result.status == "LOGIN FAIL"){
 					    	    alert(result.message);
 								location.href="/backoffice/login.do";
 						   }else if (result.status == "SUCCESS"){
	 							  alert("??????????????? ?????? ???????????????");
	 							  localtion.reload();
	 							  
 						   }else {
 							   alert(result.message);
 						   }
 					    },
 					    function(request){
 						    alert("Error:" +request.status );	       						
 					    }    		
 	      );
    }
    function fn_ExcelDown(){    	
    	$("form[name=regist]").attr("action", "/backoffice/resManage/resListExcel.do").submit();
    }
    function fn_EqupStateView(resCode, equipList, resEqupcheck){
    	$("#delResSeq").val(resCode);
    	$("#hid_equpState").val(resEqupcheck);
    	if ( resEqupcheck == "RES_EQUPCHECK_4"){
    		$("#btnRental").hide();
    		$("#btnCancel").hide();
    		$("#btnReturn").show();
    	}else{
    		$("#btnRental").show();
    		$("#btnCancel").show();
    		$("#btnReturn").hide();
    	}
    	var params = {"resSeq" :  resCode, "resEqupinfo" : equipList };
    	uniAjax("/backoffice/res/resEquipChange.do", params, 
 	  			function(result) {
 					       if (result.status == "LOGIN FAIL"){
 					    	    alert(result.message);
 								location.href="/backoffice/login.do";
 						   }else if (result.status == "SUCCESS"){
	 							  $("#tb_equip > tbody").empty(); 
	 							  var setHtml = "";
		    	            	  for (var i = 0; i < result.resList.length ; i++){
		    	            	  var obj = result.resList[i];
		    	            	       setHtml = "<tr><td><input type='checkbox' name='equipCode' value='"+ obj.equp_code+"'></td>"
	    	      					               + "<td>"+obj.equipment_name +"</td>"
	    	      					             + "<td>"+obj.equipment_name +"</td>"
	    	      					               + "<td>"+obj.equip_state_txt +"</td></tr>";
		    	            				$("#tb_equip >  tbody:last").append(setHtml);	
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
	</script>
</body>
</html>