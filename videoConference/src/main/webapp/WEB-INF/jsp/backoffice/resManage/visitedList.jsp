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
	    
	    
	    fn_searchCombo();
	});	
    function fn_searchCombo(){
    	if ($("#visitedGubun").val() == "VISITED_GUBUN_1"){
    		$("#searchVisitedStatus").append("<option value='VISITED_STATE_1'>??????</option>");
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_2'>??????</option>");
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_3'>??????</option>");
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_4'>??????</option>");
    	}else {
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_1'>??????</option>");
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_2'>??????</option>");
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_3'>??????</option>");
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_4'>????????? ??????</option>");
            $("#searchVisitedStatus").append("<option value='VISITED_STATE_6'>????????? ??????</option>");
    	}
    }
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
    		    var postData = {"pageIndex": "1", "visitedGubun" : $("#visitedGubun").val()};
    		    
                if ($("#visitedGubun").val() == "VISITED_GUBUN_1"){
                	colViewR = false;
                	colViewT = true;
                	labelTxt = "????????????";
                }else {
                	colViewR = true;
                	colViewT = false;
                	labelTxt = "????????? ?????? ??????";
                }
                
    		    grid.jqGrid({
    		    	url : '/backoffice/visitedManage/visitedListAjax.do' ,
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
    		 	                { label: 'visited_code', key: true, name:'visited_code',   index:'visited_code',      align:'center', hidden:true},
    		 	                { label: 'visited_gubun',  name:'visited_gubun',   index:'visited_code',      align:'center', hidden:true},
    			                { label: '????????????',  name:'visited_req_name',         index:'visited_req_name',        align:'left',   width:'10%' },
    			                { label: '??????????????? ',  name:'visited_req_celphone',         index:'visited_req_celphone',        align:'left',   width:'10%' },
    			                { label: '?????? ?????????',  name:'visited_req_org',         index:'visited_req_org',        align:'left',   width:'10%' },
    			                
    			                { label: '????????????',  name:'center_nm',         index:'center_nm',        align:'left',   width:'10%' , hidden:colViewR},
    			                { label: '?????????',  name:'floor_name',         index:'floor_name',        align:'left',   width:'10%' , hidden:colViewR},
    			                { label: '???????????????', name:'empname',       index:'empname',      align:'center', width:'10%' , hidden:colViewR},
    			                
    			                { label: '?????????', name:'visited_group_check',       index:'empname',      align:'center', width:'10%' 
    			                	, hidden:colViewT , formatter: jqGridFunc.groupCheck},
    			                
    			                { label: '?????? ?????? ', name:'visited_person',       index:'visited_person',      align:'center', width:'10%'
    			                	, formatter: jqGridFunc.resPerson},
    			                { label: '?????????', name:'visitedregdate',       index:'visitedregdate',      align:'center', width:'20%' },
    			                { label: '?????? ?????????', name:'visited_resday',       index:'visited_resday',      align:'center', width:'30%' 
      			                  , formatter: jqGridFunc.resDayInfo},
    			                { label: labelTxt, name:'visited_purpose',       index:'visited_purpose',      align:'center', width:'20%' },
    			                { label: '??????????????????', name:'visited_remark',       index:'visited_remark',      align:'center', width:'20%' 
    			                	, hidden:colViewT},
    			                { label: '????????????', name:'code_nm',       index:'code_nm',  align:'center', width:'10%'},
    			                { label: '???????????????', name:'code',       index:'code',  align:'center', width:'10%'
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
															"searchVisitedStatus" : fn_emptyReplace($("#searchVisitedStatus").val(),""), 
										    	    		"searchCondition" : $("#searchCondition").val(),
										    	    		"searchKeyword" : $("#searchKeyword").val(),
										    	    		"pageUnit":$('.ui-pg-selbox option:selected').val()
							    		          		})
    		          		}).trigger("reloadGrid");
    		        },onSelectRow: function(rowId){
    	                if(rowId != null) {  }// ?????? ??????
    	            },ondblClickRow : function(rowid, iRow, iCol, e){
    	            	grid.jqGrid('editRow', rowid, {keys: true});
    	            },onCellSelect : function (rowid, index, contents, action){
    	            	var cm = $(this).jqGrid('getGridParam', 'colModel');
    	            	if (cm[index].name=='visited_req_name' || cm[index].name=='visited_req_celphone' || cm[index].name=='visited_req_org' ){
    	            		jqGridFunc.fn_visitedInfo($(this).jqGrid('getCell', rowid, 'visited_gubun'), $(this).jqGrid('getCell', rowid, 'visited_code'));
            		    }
    	            }
    		    });
    		    
    		}, resPerson : function(cellvalue, options, rowObject){
    			return rowObject.visited_person + "???" ;
            } ,groupCheck : function(cellvalue, options, rowObject){
    			var resdayinfo = rowObject.visited_group_check == "Y" ? "????????????:" +  rowObject.visited_group_name : "?????? ?????? ??????";
    			return resdayinfo ;
    		}, resDayInfo : function(cellvalue, options, rowObject){
    			var resdayinfo = rowObject.visited_resday + "  " + rowObject.visited_restime +"???";
    			return resdayinfo ;
    		}, resProcess : function (cellvalue, options, rowObject){
    			//?????? combo 
    			var resCombo = ""
    			console.log("rowObject.visited_gubun:" + rowObject.visited_gubun)
    			if (rowObject.visited_gubun == "VISITED_GUBUN_1" && (rowObject.code == "VISITED_STATE_1" || rowObject.code == "VISITED_STATE_2" || rowObject.code == "VISITED_STATE_3")  ){
    				var selecte1 =  (rowObject.code == 'VISITED_STATE_1') ? "selected" : "";
    				var selecte2 =  (rowObject.code == 'VISITED_STATE_2') ? "selected" : "";
    				var selecte3 =  (rowObject.code == 'VISITED_STATE_3') ? "selected" : "";
    				var selecte4 =  (rowObject.code == 'VISITED_STATE_4') ? "selected" : "";
    				resCombo = "<select name=\"reservProcessGubun\"  id=\"visited_state_"+rowObject.visited_code+"\" onChange=\"jqGridFunc.fn_change_process('visited_state_"+rowObject.visited_code+"', '"+rowObject.visited_code+"');\">"
    			             + "   <option value=''>????????? ????????????</option>"  
    			             + "   <option value='VISITED_STATE_1' "+ selecte1 +">??????</option>"
    			             + "   <option value='VISITED_STATE_2' "+ selecte2 +">??????</option>"
    			             + "   <option value='VISITED_STATE_3' "+ selecte3 +">??????</option>"
    			             + "   <option value='VISITED_STATE_4' "+ selecte4 +">??????</option>"
    			             + "</select>";
    			}else if (rowObject.visited_gubun == "VISITED_GUBUN_2" && (rowObject.code == "VISITED_STATE_1" || rowObject.code == "VISITED_STATE_2" || rowObject.code == "VISITED_STATE_3") ){
    				var selecte1 =  (rowObject.code == 'VISITED_STATE_1') ? "selected" : "";
    				var selecte2 =  (rowObject.code == 'VISITED_STATE_2') ? "selected" : "";
    				var selecte3 =  (rowObject.code == 'VISITED_STATE_3') ? "selected" : "";
    				var selecte4 =  (rowObject.code == 'VISITED_STATE_4') ? "selected" : "";
    				var selecte6 =  (rowObject.code == 'VISITED_STATE_6') ? "selected" : "";
    				resCombo = "<select name=\"reservProcessGubun\"  id=\"visited_state_"+rowObject.visited_code+"\" onChange=\"jqGridFunc.fn_change_process('visited_state_"+rowObject.visited_code+"', '"+rowObject.visited_code+"');\">"
    			             + "   <option value=''>????????? ????????????</option>"  
    			             + "   <option value='VISITED_STATE_1' "+ selecte1 +">??????</option>"
    			             + "   <option value='VISITED_STATE_2' "+ selecte2 +">??????</option>"
    			             + "   <option value='VISITED_STATE_4' "+ selecte4 +">????????? ??????</option>"
    			             + "   <option value='VISITED_STATE_6' "+ selecte4 +">????????? ??????</option>"
    			             + "</select>";
    			}else {
    				resCombo = rowObject.code_nm;
    			}
    			return resCombo;
    		}, fn_change_process : function(code, visited_code){
    			if (confirm( "??????????????? ?????? ???????????????????")== true){
    	    		     
    	    		     
    					 var params = {'visitedCode': visited_code, 'visitedStatus' : $("#"+code+"").val(), "visitedGubun":  $("#visitedGubun").val(),};
    		    	     uniAjax("/backoffice/visitedManage/visitedStateChange.do", params, 
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
	    	    		 "visitedGubun" : $("#visitedGubun").val(),
	    	    		 "searchVisitedStatus" : fn_emptyReplace($("#searchVisitedStatus").val(),""),
	    	    		 "pageIndex": $("#pager .ui-pg-input").val(),
	         			 "pageUnit":$('.ui-pg-selbox option:selected').val()
	         		}),
	    	    	loadComplete	: function(data) {$("#sp_totcnt").text(data.paginationInfo.totalRecordCount);}
	    	     }).trigger("reloadGrid");

	        }, fn_visitedInfo : function (visitedGubun, visited_code){
	        	
	        	   
            	    var params = {'visitedGubun': visitedGubun, 'visitedCode' :visited_code};
	    	        uniAjax("/backoffice/visitedManage/visitedDetailInfo.do", params, 
	    	  			 function(result) {
	    					       if (result.status == "LOGIN FAIL"){
	    					    	    alert(result.message);
	    								location.href="/backoffice/login.do";
	    						   }else if (result.status == "SUCCESS"){
	    							   
	    							   $("#dv_header > h2").html("${regist.visitedTitle}");
	    							   var obj = result.visitedInfo;
	    							   
	    							   $("#sp_visitdNm").html(obj.visited_req_name);
	    							   $("#sp_visitdPhone").html(obj.visited_req_celphone);
	    							   $("#sp_visitdOrg").html(obj.visited_req_org);
	    							   
	    							   $("#sp_visitdRegDate").html(obj.visited_regdate);
	    							   $("#sp_visitedCenterNm").html(obj.center_nm);
	    							   $("#sp_visitedPlace").html(obj.floor_name);
	    							   $("#sp_visitedEmpNm").html(obj.empname);
	    							   $("#sp_visitedPurpose").html(obj.visited_purpose);
	    							   $("#sp_visitedState").html(obj.code_nm);
	    							   
	    							   
	    							   
	    							   if ($("#visitedGubun").val() == "VISITED_GUBUN_1"){
	    							    	   
	    								   $("#tb_visitedDeatil").show();
	    								   $("#tr_visitedGubun").show();
	    								   $("#th_visitedGubun").show();
	    								   $("#td_visitedGubun").show();
	    								   $("#td_visitedGubun").show();
	    								   $("#td_visitedCol").attr("colspan","1");
	    								   
	    								   
		    							   if (result.visitedDetailInfo.length > 0){
		    								   var setHtml = "";
		    								   $("#tb_visitedDeatil > tbody").empty();
		    								   for (var i in result.visitedDetailInfo){
		    									   detail = result.visitedDetailInfo[i];
			    								   setHtml = "<tr>"
			    								   setHtml += "  <td>"+detail.visited_name+"</td>"
			    								   setHtml += "  <td>"+detail.visited_celphone+"</td>"
			    								   setHtml += "  <td>"+detail.visited_org+"</td>"
			    								   setHtml += "  <td>"+detail.visited_seq+"</td>"
			    								   setHtml += "</tr>";
			    								   $("#tb_visitedDeatil >  tbody:last").append(setHtml);
			    							   }
		    							   }
	    							   }else{
	    								   $("#tb_visitedDeatil").hide();
	    								   $("#tr_visitedGubun").hide();
	    								   $("#th_visitedGubun").hide();
	    								   $("#td_visitedGubun").hide();
	    								   $("#td_visitedCol").attr("colspan","3");
	    							   }
	    							   $("#btn_pop").attr("data-needpopup-show", "#resInfoPop").trigger("click");
	    							    
	    						   }else {
	    							   alert(result.message);
	    						   }
	    					  },function(request){
	    						    alert("Error:" +request.status );	       						
	    					  }    		
	    	     );
	    	     
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
	<input type="hidden" name="mode" id="mode">
	<input type="hidden" name="visitedGubun" id="visitedGubun" value="${regist.visitedGubun}">
    <input type="hidden" name="visitedCode" id="visitedCode">
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span><spring:message code="menu.menu03" /> 
                        <span>></span><strong>${regist.visitedTitle}</strong>
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
			                    <input type="radio" id="searchDayGubun" name="searchDayGubun" value="RES_REQDAY"   />
			                    <label>????????? </label> 
			                	&nbsp;&nbsp;&nbsp;&nbsp;
			                	<input   size="10" maxlength="20" id="searchStartDay" style="cursor:default;" class="date-picker-input-type-text" />
			                     ~
			                    <input   size="10" maxlength="20" id="searchEndDay" style="cursor:default;"  class="date-picker-input-type-text" />
	                		    <select id="searchVisitedStatus" name="searchVisitedStatus">
	                		       <option value="">?????? ??????</option>
	                		    </select>
	                		
	                		</td>
		                	<th style="width:90px;">?????????</th>
		                	<td colspan="5"  style="text-align:left;padding-left: 20px;">
		                		<select name="searchCondition"  id="searchCondition">
									<option value="" >??????</option>
									<option value="a.VISITED_REQ_NAME" >????????? ??????</option>
									<option value="a.VISITED_REQ_CELPHONE" >????????? ?????????</option>
									<option value="a.VISITED_REQ_ORG" >?????? ?????????</option>
								</select>
								<input class="nameB " type="text" name="searchKeyword" id="searchKeyword"   size="20"  maxlength="30"    onkeydown="if(event.keyCode==13){search_form();}">
		                	</td>
		                	<td class="border-left" style="width:72px">
			                    <a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">??????</span></a>
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

	    
        <div id='resInfoPop' class="needpopup">
        <div class="popHead" id="dv_header">
            <h2>?????? ??????</h2>
        </div>
        <div class="popCon">
            <!--// ?????? ????????????-->
            <div class="pop_box100">
                <div class="padding15" style="background-color:white">
                <table class="pop_table thStyle">
					<tbody class="search">
						 <tr>
						   <th>????????????</th>
						   <td><span id="sp_visitdNm"></span></td>
						   <th>???????????????</th>
						   <td><span id="sp_visitdPhone"></span>  </td>
						 </tr>
						 <tr>
						   <th>?????????</th>
						   <td><span id="sp_visitdOrg"></span></td>
						   <th>????????????</th>
						   <td><span id="sp_visitdRegDate"></span>  </td>
						 </tr>
						 <tr id="tr_visitedGubun">
						   <th>?????? ??????</th>
						   <td><span id="sp_visitedCenterNm"></span></td>
						   <th>????????????  </th>
						   <td><span id="sp_visitedPlace"></span>  </td>
						 </tr>
						 <tr>
						   <th id="th_visitedGubun">?????? ?????????</th>
						   <td id="td_visitedGubun"><span id="sp_visitedEmpNm"></span></td>
						   <th>????????????</th>
						   <td id="td_visitedCol"><span id="sp_visitedState"></span></td>
						 </tr>
					</tbody>
				</table>
				<br />
				<table class="pop_table thStyle" id="tb_visitedDeatil">
				   <thead>
				      <tr>
				        <th>??????</th>
				        <th>?????????</th>
				        <th>?????????</th>
				        <th>??????</th>
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
<!--  ?????? ?????? ?????? ?????? ???-->
</form:form>
<c:import url="/backoffice/inc/uni_pop.do" />
<button id="btn_pop" style="display:none" data-needpopup-show='#resInfoPopCancel'>?????? ??????</button>
</div>


 <script type="text/javascript">
    function fn_ExcelDown(){    	
    	$("form[name=regist]").attr("action", "/backoffice/resManage/resListExcel.do").submit();
    }
	</script>
</body>
</html>