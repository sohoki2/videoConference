<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="kor">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><spring:message code="URL.TITLE" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    
    <link rel="stylesheet" href="/css/needpopup.min.css" />
    <link rel="stylesheet" href="/css/needpopup.css">
    
    
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/toggle.css">
    <!--popup-->
    <link rel="stylesheet" href="/css/needpopup.css">
    <!--datepicker-->
    <link rel="stylesheet" href="/css/calendar.css">
		
	<style>
	 	.equipList:hover{
			background-color: #e1e2e3;
		}
		.centerList{
			cursor: pointer;
		}
		.roleGroupList{
			cursor: pointer;
		}
		.equipListSelect{
			color:#FF0000;
			background-color: #fafbfc;
		}
		.equipList {
			cursor: pointer;
		}
		#selectEquipMsg{
			cursor: pointer;
		}
		.equipDetailConnContent{
			text-align: center;
		    color: #fff;
		    background: #dc2c33;
		    border-bottom: none !important;
		}
		.groupBasicList{
			cursor: pointer;
		}
		.groupBasicListSelect{
			color: #FF0000;
	    	background-color: #fafbfc;
		}
		.change_view_contents_area{
		    height: 745px;
    		overflow-y: auto;
		}
	</style>
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
    
   <link rel="stylesheet" type="text/css" href="/css/jquery-ui.css">
   <link rel="stylesheet" type="text/css" href="/resources/jqgrid/src/css/ui.jqgrid.css">
   <script type="text/javascript" src="/resources/jqgrid/src/i18n/grid.locale-kr.js"></script>
   <script type="text/javascript" src="/resources/jqgrid/js/jquery.jqGrid.min.js"></script>
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
	$(document).ready(function() { 
		   jqGridFunc.setGrid("mainGrid");
			timeSelSetting("deviceStartTime1","hour");
			timeSelSetting("deviceStartTime2","min");
			timeSelSetting("deviceEndTime1","hour");
			timeSelSetting("deviceEndTime2","min");
	 });
	 function timeSelSetting(tagId,type) {
		var tag = $("#"+tagId);
		tag.append("<option value=''>선택</option>");
		if(type == "hour"){
			for(var i=1; i<24; i++){
				var hour = i < 10 ? "0"+i : i;
				tag.append("<option value='" + hour + "'>" + hour + "시</option>");
			}
		} else if(type == "min") {
			for(var i=0; i<60; i+=5){
				var min = i < 10 ? "0"+i : i;
				tag.append("<option value='" + min + "'>" + min + "분</option>");
			}					
		}
	 }
     var jqGridFunc  = {
    		
    		setGrid : function(gridOption){
    			 var grid = $('#'+gridOption);
    		    //ajax 관련 내용 정리 하기 
    		    var postData = {"pageIndex": "1"};
    		    grid.jqGrid({
    		    	url : '/backoffice/basicManage/devicelistAjax.do' ,
    		        mtype :  'POST',
    		        datatype :'json',
    		        pager: $('#pager'),  
    		        ajaxGridOptions: { contentType: "application/json; charset=UTF-8" },
    		        ajaxRowOptions: { contentType: "application/json; charset=UTF-8", async: true },
    		        ajaxSelectOptions: { contentType: "application/json; charset=UTF-8", dataType: "JSON" }, 
    		       
    		        postData :  JSON.stringify( postData ),
    		        jsonReader : {
	   		             root : 'resultlist',
	   		             "page":"paginationInfo.currentPageNo",
	   		             "total":"paginationInfo.totalPageCount",
	   		             "records":"paginationInfo.totalRecordCount",
	   		             repeatitems:false
   		            },
    		        colModel :  [
    		 	                { label: 'device_id', key: true, name:'device_id',       index:'device_id',      align:'center', hidden:true},
    			                { label: '상태',  name:'net_status',         index:'net_status',        align:'left',   width:'12%', formatter: jqGridFunc.divState },
    			                { label: '지점명', name:'center_nm',       index:'center_nm',      align:'center', width:'10%'},
    			                { label: '회의실', name:'meeting_name',       index:'meeting_name',      align:'center', width:'10%'},
    			                { label: '디바이스아이디', name:'device_id',       index:'device_id',      align:'center', width:'20%' },
    			                { label: '디바이스명', name:'device_nm',       index:'device_nm',      align:'center', width:'10%'},
    			                { label: 'IP', name:'device_ip',       index:'device_ip',      align:'center', width:'10%'},
    			                { label: 'MAC', name:'device_mac',       index:'device_mac',      align:'center', width:'10%'},
    			                { label: '운영시간', name:'device_starttime',       index:'device_starttime',      align:'center', width:'10%' , 
    			                	     formatter:jqGridFunc.playTime},
    			                { label: 'OS', name:'device_os',       index:'device_os',      align:'center', width:'10%', formatter:jqGridFunc.os_icon},
    			                { label: '작성자', name:'update_id',      index:'update_id',     align:'center', width:'14%'},
    			                { label: '최종 수정 일자', name:'update_date', index:'update_date', align:'center', width:'12%', 
    			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
    			                { label: '삭제', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : false, formatter:jqGridFunc.rowBtn}
    			         ],  //상단면 
    		        rowNum : 10,  //레코드 수
    		        rowList : [10,20,30,40,50,100],  // 페이징 수
    		        pager : pager,
    		        refresh : true,
    	            rownumbers : true, // 리스트 순번
    		        viewrecord : true,    // 하단 레코드 수 표기 유무
    		        //loadonce : false,     // true 데이터 한번만 받아옴 
    		        loadui : "enable",
    		        loadtext:'데이터를 가져오는 중...',
    		        emptyrecords : "조회된 데이터가 없습니다", //빈값일때 표시 
    		        height : "480px",
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
							    		          			"searchCondition" : $("#searchCondition").val(),
							    		         			"searchKeyword" : $("#searchKeyword").val(),
							    		          			"pageUnit":$('.ui-pg-selbox option:selected').val()
							    		          		})
    		          		}).trigger("reloadGrid");
    		        },onSelectRow: function(rowId){
    	                if(rowId != null) {  }// 체크 할떄
    	            },ondblClickRow : function(rowid, iRow, iCol, e){
    	            	grid.jqGrid('editRow', rowid, {keys: true});
    	            },onCellSelect : function (rowid, index, contents, action){
    	            	var cm = $(this).jqGrid('getGridParam', 'colModel');
    	                if (cm[index].name=='meeting_name' || cm[index].name=='device_id' || cm[index].name=='meeting_name'){
    	                	jqGridFunc.fn_devicePop("Edt", $(this).jqGrid('getCell', rowid, 'device_id'));
    	                }
    	            }
    		    });
    		}, os_icon : function(cellvalue, options, rowObject){
    			var icon = "";
    			switch (rowObject.device_os){
    		    case "OS_02" :
    		    	icon ="<img src='/img/android_icon.png' width='16px' height='16px' />";
    		        break;
    		    case "OS_01":
    		    	icon ="<img src='/img/windows_icon.png' width='16px' height='16px' />";
    		        break;
    		    default :
    		    	icon ="<img src='/img/ios_icon.png' width='16px' height='16px' />";          
    		    }
    			return icon;
    		}, divState: function(cellvalue, options, rowObject){
    		    //did 상태
    		    return (rowObject.net_status == "ON") ? "<span class='onIcon'></span>": "<span class='offIcon'></span>"
    		},playTime : function(cellvalue, options, rowObject){
    			//운영시간
    			var playTime =  "";
    			if (rowObject.device_starttime != "")
    				playTime += rowObject.device_starttime.substring(0,2) + ":" + rowObject.device_starttime.substring(2,4);
    			if (rowObject.device_endtime != "")
    				playTime += " ~ " +rowObject.device_endtime.substring(0,2) + ":" + rowObject.device_endtime.substring(2,4);
    		    return playTime
    		},rowBtn: function (cellvalue, options, rowObject){
                if (rowObject.device_id != "")
            	     return '<a href="javascript:jqGridFunc.delRow(&#34;'+rowObject.device_id+'&#34;);">삭제</a>';
            },refreshGrid : function(){
	           $('#mainGrid').jqGrid().trigger("reloadGrid");
	        },fn_search: function(){
	    	   $("#mainGrid").setGridParam({
	    	    	 datatype	: "json",
	    	    	 postData	: JSON.stringify(  {
	          			"pageIndex": 1,
	          			"searchCondition" : $("#searchCondition").val(),
	         			"searchKeyword" : $("#searchKeyword").val(),
	         			"pageUnit":$('.ui-pg-selbox option:selected').val()
	         		}),loadComplete	: function(data) {
	    	    		 $("#sp_totcnt").text(data.paginationInfo.totalRecordCount);
	    	    	}
	    	     }).trigger("reloadGrid");
 
	        }, delRow : function (device_id){
        	   if(trim(device_id) != "") {
        		   var params = {'deviceId':trim(device_id) };
        		   fn_uniDelAction("/backoffice/basicManage/deviceInfoDelete.do",params, "jqGridFunc.fn_search");
		        }
            },fn_devicePop : function (mode, deviceId){
        	    $("#btn_message").trigger("click");
        	    
        	    $("#mode").val(mode);
        	    $("#deviceId").val(deviceId);
        	    if (mode == "Ins"){
        	    	$('input:text[name^=device]').val("");
    	        	$("#centerId").val("");
    	        	$("#floorSeq").remove();
    	        	$("#partSeq").remove();
    	        	$("#centerId").val("");
    				$("#meetingId").hide();		

					toggleDefault("useYn");
					toggleDefault("deviceReload");
					toggleDefault("deviceRestart");

      		    }else {
      		    	if($('#deviceId').val() != '') {
    					$(".popHead > h2").html("단말기 수정");
    					$("#btnUpdate").text("수정");	
    					url= "/backoffice/basicManage/deviceInfoDetail.do";
    					var param = {'mode' :mode,'deviceId' : deviceId};
    					uniAjax
    					(
    						url, 
    						param, 
    						function(result) {
    							if(result.status == "SUCCESS") {
    								//여기 부분 수정 어떻게 할지 추후 생각
    						  		var obj = result.deviceInfo;
    								$("#deviceId").val(obj.device_id);
    						  		$("#deviceNm").val(obj.device_nm);
    								$("#deviceRemark").val(obj.device_remark);
    								$("#deviceIp").val(obj.device_ip);
    								$("#deviceMac").val(obj.device_mac);
    								$("#centerId").val(obj.center_id);
    								jqGridFunc.fn_floorState(obj.floor_seq);
	       						    if (obj.part_seq != "0"){
	       						        jqGridFunc.fn_partState(obj.part_seq);
	       						    }
    								$("#meetingId").show();
    								toggleClick("useYn", obj.use_yn);
									toggleClick("deviceReload", obj.device_reload);
									toggleClick("deviceRestart", obj.device_restart);

									
    								
    								jqGridFunc.fn_meetingView(obj.meeting_id);
    								
    								if (obj.device_starttime.length> 3){
    									$("#deviceStartTime1").val(obj.device_starttime.substring(0,2));
        								$("#deviceStartTime2").val(obj.device_starttime.substring(2,4));
    								}
    								if (obj.device_endtime.length> 3){
    									$("#deviceEndTime1").val(obj.device_endtime.substring(0,2));
        								$("#deviceEndTime2").val(obj.device_endtime.substring(2,4));
    								}
    								$("#deviceOs").val(obj.device_os);
    						     	 
    						  	} else {
    						   		alert(result.meesage);
    						  		
    							}
    						},
    						function(request){
    							alert("Error:" +request.status );	       						
    						}    		
    					);
    				} else {
    					alert("디바이스를 선택하세요");
    				}  
      		    }
           },clearGrid : function() {
               $("#mainGrid").clearGridData();
           },fn_CheckForm  : function (){
        	    if(any_empt_line_id("deviceNm", "디바이스명을 입력하지 않았습니다.") == false) return;
	   			if(any_empt_line_id("centerId", "지점을 선택하지 않았습니다.") == false) return;
	   			if(any_empt_line_id("floorSeq", "층을 선택하지 않았습니다.") == false) return;
	   			if(any_empt_line_id("meetingId", "회의실을 선택하지 않았습니다.") == false) return;
	   		   	if(any_empt_line_id("deviceStartTime1", "시작시간을 입력 하지 않았습니다.") == false) return;
	   		   	if(any_empt_line_id("deviceStartTime2", "시작시간을 입력 하지 않았습니다.") == false) return;
	   		   	if(any_empt_line_id("deviceEndTime1", "종료시간을 입력 하지 않았습니다.") == false) return;
	   		   	if(any_empt_line_id("deviceEndTime2", "종료시간을 입력 하지 않았습니다.") == false) return;
	   		   
	   		   	if(parseInt($("#deviceStartTime1").val() + $("#deviceStartTime2").val()) > parseInt($("#deviceEndTime1").val() + $("#deviceEndTime2").val())) {
	   		    	alert("시작 시간이 종료시간보다 빠를수 없습니다.");
	   				return;
	   			}
	   		   	var params = 
	   		   	{  
	   		   		deviceId : $("#deviceId").val(),
	   				deviceNm : $("#deviceNm").val(),
	   				deviceRemark : $("#deviceRemark").val(),
	   				deviceOs : $("#deviceOs").val(),
	   				deviceStartTime : $("#deviceStartTime1").val() + $("#deviceStartTime2").val(),
	   				deviceEndTime : $("#deviceEndTime1").val() + $("#deviceEndTime2").val(),
	   				useYn :  fn_emptyReplace($('input[name="useYn"]:checked').val(),"Y"),
	   				mode : $("#mode").val(), 
	   				centerId: $("#centerId").val(), 
	   				floorSeq: $("#floorSeq").val(), 
	   				partSeq:  fn_emptyReplace($("#partSeq").val(),"0"), 
					deviceReload:  fn_emptyReplace($("deviceReload").val(),"N"), 
					deviceRestart:  fn_emptyReplace($("deviceRestart").val(),"N"), 
	   				meetingId: $("#meetingId").val()
	   			};
	   		   	uniAjax("/backoffice/basicManage/deviceInfoUpdate.do", params, 
			   				function(result) {
			   					if (result.status == "SUCCESS") {
			   						jqGridFunc.fn_search();
			   					} else {
			   	  					alert(result.message);
			   	  				   
			   	  				}
			   				    need_close();
			   				},
			   				function(request){
			   					alert("Error:" +request.status );	       						
			   				}    		
			   	      	);
	   		
     		  }, fn_floorState : function (floorSeq){
     	    	 var _url = "/backoffice/basicManage/floorListAjax.do";
    	    	 var _params = {"centerId" : $("#centerId").val(), "floorUseyn": "Y"};
    	    	 fn_comboListPost("sp_floor", "floorSeq",_url, _params, "jqGridFunc.fn_partState(); jqGridFunc.fn_meetingView()", "120px", floorSeq);  
    	      }, fn_partState : function (partSeq){
    	    	 var _url = "/backoffice/basicManage/partListAjax.do";
    	    	 var _params = {"floorSeq" : $("#floorSeq").val(), "partUseyn": "Y"};
    	    	 fn_comboListPost("sp_part", "partSeq",_url, _params, "", "120px", partSeq);  
    	      }, fn_meetingView : function (meetingId){
	    			$("#meetingId").show();
	    			var params = {"searchCenterId" : $("#centerId").val(),"searchFloorSeq" : $("#floorSeq").val()  };
	    			uniAjax("/backoffice/basicManage/officeMeetingListAjax.do", params, 
	    		 			function(result) {
	    					           if (result.status == "LOGIN FAIL"){
	    					    	        alert(result.message);
	    									location.href="/front/resInfo/noInfo.do";
	    							   }else if (result.status == "SUCCESS"){
	    								   $("#meetingId option").remove();
	    								   $("#meetingId").append("<option value=''>회의실선택</option>");
	    								   var objs = result.resultlist;
	    								   for (var i in objs){
	    									   try{
	    											var selected = ( meetingId == objs[i].meeting_id) ? "selected" : "";
	    											$("#meetingId").append("<option value='"+objs[i].meeting_id +"' "+selected+">"+objs[i].meeting_name+"</option>");
	    										}catch(err){
	    											console.log(err);
	    										}
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
    }
  </script>
</head>
<body>
<div id="wrapper">	
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/devicelist.do">
	<c:import url="/backoffice/inc/top_inc.do" />
	<input type="hidden" name="mode" id="mode" >

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                        <spring:message code="menu.menu01" />
                        <span>></span>
                        <strong><spring:message code="menu.menu01_2" /></strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">총 단말기수 <span id="sp_totcnt" /></div>
                <section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th><spring:message code="search.chooseTxt" /></th>
		                	<td>
		                		<select id="searchCondition" name="searchCondition">
                                    <option value="" selected="selected" disabled="disabled">조건검색</option>
                                    <option value="deviceNm">단말기명</option>
                                    <option value="deviceId">단말기ID</option>
                                </select>
		                		<input class="nameB" type="text" name="searchKeyword" id="searchKeyword">  
								<a href="javascript:search_form();"><span class="searchTableB"><spring:message code="button.inquire" /></span></a>
		                	</td>
		                	                	
						</tr>
                    </table>
                    <div class="text-right">
                                   <a href="#" class="deepBtn" onclick="jqGridFunc.fn_devicePop('Ins', '0');">단말기 등록</a>
                            </div>       
                    <br/>                
                </section>
            </div>
            
            <div class="Swrap tableArea">
               <table id="mainGrid"></table>
               <div id="pager" class="scroll" style="text-align:center;"></div>     
               <br />
               <div id="paginate"></div>
                        
	        </div>
	    </div>
	    </div>
         
	<div id='device_pop' class="needpopup">
				<div class="popHead">
					<h2>단말기 등록</h2>
				</div>
				<div class="popCon">
					<div class="pop_box100">
		                <div class="padding15">
		                    <p class="pop_tit">*구역 선택 <span class="join_id_comment joinSubTxt"></span></p>
		                    <select id="centerId" style="width:120px" onChange="jqGridFunc.fn_floorState()">
		                        <option value="">지점 선택</option>
		                         <c:forEach items="${selectCenter}" var="centerInfo">
		                            <option value="${centerInfo.centerId}">${centerInfo.centerNm}</option>
		                         </c:forEach>
		                    </select>
		                    <span id="sp_floor"></span>
		                    <span id="sp_part"></span>
		                </div>                
		            </div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">단말기명</p>
							<input id="deviceNm" name="deviceNm" type="text" class="input_noti" placeholder="단말기명을 입력해주세요.">
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">단말ID</p>
							<input id="deviceId" name="deviceId" type="text" class="input_noti" placeholder="자동생성 됩니다." disabled>
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">OS타입</p>
							<select id="deviceOs" name="deviceOs" class="input_noti input_noti_x2">
								<option value="OS_01">윈도우</option>
								<option value="OS_02">안드로이드</option>
								<option value="OS_03">IOS</option>
							</select>
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">회의실</p>
							<select  id="meetingId" style="width:150px;" class="input_noti input_noti_x2"></select>
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">단말IP</p>
							<input id="deviceIp" name="deviceIp" type="text" class="input_noti" placeholder="자동생성 됩니다." disabled>
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">단말MAC</p>
							<input id="deviceMac" name="deviceMac" type="text" class="input_noti" placeholder="자동생성 됩니다." disabled>
						</div>
					</div>
					
					
					<div class="pop_box1000">
			            <div class="padding15">
			               	<p class="pop_tit">운영시간</p>
			               	<select id="deviceStartTime1" name="deviceStartTime1"  class="input_noti input_noti_x2" title="시간" style="width:150px;" >
					   		</select>
					   		<select id="deviceStartTime2" name="deviceStartTime2" class="input_noti input_noti_x2" title="시간" style="width:150px;" >
					   		</select>
							~
							<select id="deviceEndTime1" name="deviceEndTime2" class="input_noti input_noti_x2" title="시간" style="width:150px;" >
							</select>
							<select id="deviceEndTime2" name="deviceEndTime2" class="input_noti input_noti_x2" title="시간" style="width:150px;" >
							</select>
			            </div>   
					</div>
					
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">비고</p>
							<input id="deviceRemark" name="deviceRemark" type="text" class="input_noti">
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">사용유무</p>
							<label class="switch">                                               
		                    	<input type="checkbox" id="useYn" onclick="toggleValue(this);" value="Y">
			                    <span class="slider round"></span> 
		                     </label>
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">화면 새로 고침</p>
							<label class="switch">                                               
		                    	<input type="checkbox" id="deviceReload" onclick="toggleValue(this);" value="Y">
			                    <span class="slider round"></span> 
		                     </label>
						</div>
					</div>
					<div class="pop_box50">
						<div class="padding15">
							<p class="pop_tit">단말기 재시작</p>
							<label class="switch">                                               
		                    	<input type="checkbox" id="deviceRestart" onclick="toggleValue(this);" value="Y">
			                    <span class="slider round"></span> 
		                     </label>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="pop_footer">
					<div class="needpopup_search_area" style="display: none;">
						<p class="search_area_title">점포검색</p>
						<input type="text" class="input_noti pop_search_input"
							placeholder="점포명을 입력해주세요.">
					</div>
					<a id="btnUpdate" class="top_btn" href="javascript:jqGridFunc.fn_CheckForm();">단말기 등록</a>
				</div>
			<a href="#" class="needpopup_remover"></a>
		</div>
	<c:import url="/backoffice/inc/bottom_inc.do" /> 
	<!-- 단말기등록pop //-->
	</form:form>
	</div>	

    
    <!--popup js-->
    <script src="/js/needpopup.js"></script> 
     <!--data-->
    <script src="/js/jquery-ui.js"></script>
    <button id="btn_message" style="display:none" data-needpopup-show='#device_pop'>확인1</button>
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
</body>
</html> 