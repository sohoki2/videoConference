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
    <link rel="stylesheet" href="/css/needpopup.min.css" />
    <link rel="stylesheet" href="/css/needpopup.css">
    
    <script type="text/javascript" src="/js/jquery-2.2.4.min.js"></script>
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
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/back_common.js"></script>
    <script src="/js/popup.js"></script>
    
    
    <link rel="stylesheet" type="text/css" href="/css/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/resources/jqgrid/src/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="/css/toggle.css">
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
	 });
    var jqGridFunc  = {
    		
    		setGrid : function(gridOption){
    			 var grid = $('#'+gridOption);
    		    //ajax 관련 내용 정리 하기 
    		
                var postData = {};
    		    grid.jqGrid({
    		    	url : '/backoffice/basicManage/officeSeatListAjax.do' ,
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
	    		 	                { label: 'seat_id', key: true, name:'seat_id',       index:'seat_id',      align:'center', hidden:true},
	    		 	                { label: '지점명',  name:'center_nm',         index:'center_nm',        align:'left',   width:'10%'},
	    		 	                { label: '층수',  name:'floor_name',         index:'floor_name',        align:'left',   width:'10%'},
	    		 	                { label: '좌석명',  name:'seat_name',         index:'seat_name',        align:'left',   width:'10%'},
	    		 	                { label: '좌석구분',  name:'code_nm',         index:'code_nm',        align:'left',   width:'10%'},
	    		 	                { label: '관리자승인여부',  name:'seat_confirmgubun',   index:'seat_confirmgubun',        align:'left',   width:'10%'},
	    		 	                { label: '비용 구분', name:'pay_classification',       index:'mail_sendcheck',      align:'center', width:'20%', 
		    			                  sortable : false,	formatter:jqGridFunc.classinfo},
	    			                { label: '좌석 Top', name:'seat_top',          index:'seat_top',        align:'center', width:'12%'},
	    			                { label: '좌석 Left', name:'seat_left',        index:'seat_left',       align:'center', width:'12%'},
	    			                { label: '고정석여부', name:'seat_fix_useryn',  index:'seat_fix_useryn',  align:'center', width:'12%' , 
	    			                  formatter:jqGridFunc.fixGubun },
	    			                { label: '부서명', name:'org_cd',       index:'org_cd',      align:'center', width:'10%'},
	    			                { label: '정렬순서', name:'seat_order',       index:'seat_order',      align:'center', width:'7%'},
	    			                { label: 'qr사용유무', name:'qr_playyn',       index:'qr_playyn',      align:'center', width:'7%'},
	    			                { label: '사전예약일', name:'res_reqday',       index:'res_reqday',      align:'center', width:'10%'},
	    			                { label: '수정자', name:'update_id',      index:'update_id',     align:'center', width:'14%'},
	    			                { label: '수정 일자', name:'update_date', index:'update_date', align:'center', width:'12%', 
	    			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
	    			                { label: '삭제', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : 
	    			                  false, formatter:jqGridFunc.rowBtn}
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
    		        height : "100%",
    		        autowidth:true,
    		        shrinkToFit : true,
    		        refresh : true,
    		        multiselect:true, 
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
							    		          			"searchCenter" :  $("#searchCenter").val(),
							    		          			"searchFloorSeq" : $("#searchFloorSeq").val(),
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
    	                //console.log(cm);
    	                if (cm[index].name=='seat_name' || cm[index].name=='code_nm'){
    	                	jqGridFunc.fn_SeatInfo("Edt", $(this).jqGrid('getCell', rowid, 'seat_id'));
            		    }
    	            }
    		    });
    		},rowBtn: function (cellvalue, options, rowObject){
            	if (rowObject.seat_id != "")
            	     return "<a href='javascript:jqGridFunc.delRow(\""+rowObject.seat_id+"\");'>삭제</a>";
            },fixGubun: function (cellvalue, options, rowObject){
           	    return rowObject.seat_fix_useryn == "Y" ? "고정석: [" +  CommonJsUtil.NVL(rowObject.user_name) + "]": "일반";
     	    },refreshGrid : function(){
     	    	$('#mainGrid').jqGrid().trigger("reloadGrid");
	        },fn_delCheck  : function(){                        
		    	 var ids = $('#mainGrid').jqGrid('getGridParam','selarrrow'); //체크된 row id들을 배열로 반환
		    	 if (ids.length < 1) {
		    		 alert("선택한 값이 없습니다.");
		    		 return false;
		    	 }
		    	 var SeatsArray = new Array();
		    	 for(var i=0; i <ids.length; i++){
		    	        var rowObject = ids[i]; //체크된 id의 row 데이터 정보를 Object 형태로 반환
		    	        SeatsArray.push(ids[i]);
		    	 } 
		    	 var params = {'seatId':SeatsArray.join(',')};
      		     fn_uniDelAction("/backoffice/basicManage/officeSeatDelete.do",params, "jqGridFunc.fn_search");
		    },delRow : function (seat_id){
		    	if(seat_id != "") {
        		   var params = {'seatId':seat_id };
        		   fn_uniDelAction("/backoffice/basicManage/officeSeatDelete.do",params, "jqGridFunc.fn_search");
		        }
           },fn_SeatInfo : function (mode, seat_id){
        	    $("#btn_message").trigger("click");
			    $("#mode").val(mode);
		        $("#seatId").val(seat_id);
		        jqGridFunc.fn_seatChoic("V");
		        if (mode == "Edt"){
		        	$("#btnUpdate").text("수정");
		        	var params = {"seatId" : seat_id};
		     	    var url = "/backoffice/basicManage/officeSeatDetail.do";
		     	    uniAjaxSerial(url, params, 
		          			function(result) {
		     				       if (result.status == "LOGIN FAIL"){
		     				    	   alert(result.meesage);
		       						   location.href="/backoffice/login.do";
		       					   }else if (result.status == "SUCCESS"){
	       						       //총 게시물 정리 하기
	       						       var obj  = result.regist;
	       						       $("#centerId").val(obj.center_id);
	       						       jqGridFunc.fn_floorState(obj.floor_seq);
	       						       if (obj.part_seq != "0"){
	       						    	  jqGridFunc.fn_partState(obj.part_seq);
	       						       }
	       						       $("#payClassification").val( obj.pay_classification);
						    		   jqGridFunc.fn_payClassGubun(obj.pay_gubun, obj.pay_cost)
						    		   $("#seatName").val( obj.seat_name);
						    		   $("#seatTop").val( obj.seat_top);
						    		   $("#seatLeft").val( obj.seat_left);
						    		   $("#seatOrder").val( obj.seat_order);
						    		   $("#seatGubun").val( obj.seat_gubun);
						    		   $("#seatNumber").val( obj.seat_number);
						    		   $("#orgCd").val(obj.org_cd);
						    		   $("#seatFixGubun").val(obj.seat_fix_gubun);
						    		   $("#seatFixUserId").val(obj.seat_fix_user_id);
						    		   $('#resReqday').val(obj.res_reqday);
						    		   if (obj.empname !== ""){
						    			   $("#sp_fixUser").html(obj.empname + "<a href='#' onClick='jqGridFunc.fn_seatChoic(\"S\")'>[변경]</a>");
						    		   }else {
						    			   $("#sp_fixUser").html("<a href='#' onClick='jqGridFunc.fn_seatChoic(\"S\")'>[선택]</a>");
						    		   }
						    		   toggleClick("qrPlayyn", obj.qr_playyn);
						    		   toggleClick("seatFixUseryn", obj.seat_fix_useryn);
						    		   toggleClick("seatUseyn", obj.seat_useyn);
						    		   toggleClick("seatConfirmgubun", obj.seat_confirmgubun);
						    		   
						    		   //좌석 관리 세팅으로 이동
						    		   jqGridFunc.fn_seatChoic("V");
		       					   }else{
		       						   alert(result.meesage);
		       					   }
		     				    },
		     				    function(request){
		     					    alert("Error:" +request.status );	       						
		     				    }    		
		               );
		        }else{
		        	$('input:text[name^=seat]').val("");
		        	$("#centerId").val("");
		        	$("#orgCd").val("");
		        	$('#resReqday').val("")
		        	$("#floorSeq").remove();
		        	$("#partSeq").remove();
		        	toggleDefault("seatFixUseryn");
		        	toggleDefault("seatConfirmgubun");
		        	toggleDefault("seatUseyn");
		        	toggleDefault("qrPlayyn");
		        	
		        }
           },clearGrid : function() {
                $("#mainGrid").clearGridData();
           },fn_CheckForm  : function (){
			    if (any_empt_line_id("centerId", "지점을 선택해주세요.") == false) return;
			    if (any_empt_line_id("floorSeq", "층수을 선택해주세요.") == false) return;
		    	if (any_empt_line_id("seatName", "좌석명 입력해 주세요.") == false) return;	
		    	
		    	
		    	//확인 
		    	
		    	var url = "/backoffice/basicManage/officeSeatUpdate.do";
		    	var params = {   'centerId' : $("#centerId").val(),
				    		     'floorSeq' : $("#floorSeq").val(),
				    		     'partSeq' : fn_emptyReplace($("#partSeq").val(),"0"),
				    			 'seatId' : $("#seatId").val(),
				    			 'seatName' : $("#seatName").val(),
				    			 'seatTop' : fn_emptyReplace($("#seatTop").val(),"0"),
				    			 'seatLeft' : fn_emptyReplace($("#seatLeft").val(),"0"),
				    			 'seatOrder' : fn_emptyReplace($("#seatOrder").val(),"0"),
				    			 'seatFixUseryn' : fn_emptyReplace($("#seatFixUseryn").val(),"Y"),
				    			 'seatGubun' : $("#seatGubun").val(),
				    			 'payClassification' : fn_emptyReplace($("#payClassification").val(),"PAY_CLASSIFICATION_2"),
				     			 'payGubun' : fn_emptyReplace($("#payGubun").val(),""),
				     			 'payCost' : fn_emptyReplace($("#payCost").val(),"0"),
				    			 'orgCd' : $("#orgCd").val(),
				    			 'seatUseyn' :  $('#seatUseyn').val(),
				    			 'seatConfirmgubun' :  fn_emptyReplace($('#seatConfirmgubun').val(),"N"),
				    			 'seatNumber' :  $('#seatNumber').val(),
				    			 'qrPlayyn' :  $('#qrPlayyn').val(),
				    			 'seatFixGubun' :  $('#seatFixGubun').val(),
				    			 'seatFixUserId' :  $('#seatFixUserId').val(),
				    			 'resReqday' :  $('#resReqday').val(),
				    			 'mode' : $("#mode").val()
		    	               }; 
		    	uniAjax(url, params, 
		      			function(result) {
		 				       if (result.status == "LOGIN FAIL"){
		 				    	   alert(result.meesage);
		   						   location.href="/backoffice/login.do";
		   					   }else if (result.status == "SUCCESS"){
		   						   //총 게시물 정리 하기'
		   						   need_close();
		   						   jqGridFunc.fn_search();
		   					   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }    		
		        );
		    	
		  },fn_search: function(){
			  //검색 
	    	  $("#mainGrid").setGridParam({
	    	    	datatype	: "json",
	    	    	postData	: JSON.stringify({
	          			"pageIndex": $("#pager .ui-pg-input").val(),
	          			"searchCenter" :  $("#searchCenter").val(),
	          			"searchFloorSeq" : $("#searchFloorSeq").val(),
	         			"searchKeyword" : $("#searchKeyword").val(),
	         			"pageUnit":$('.ui-pg-selbox option:selected').val()
	         		}),
	    	    	loadComplete	: function(data) {$("#sp_totcnt").text(data.paginationInfo.totalRecordCount);}
	    	  }).trigger("reloadGrid");
		 }, fn_floorState : function (floorSeq){
	    	 var _url = "/backoffice/basicManage/floorListAjax.do";
	    	 var _params = {"centerId" : $("#centerId").val(), "floorUseyn": "Y"};
	    	 fn_comboListPost("sp_floor", "floorSeq",_url, _params, "jqGridFunc.fn_partState()", "120px", floorSeq);  
	     }, fn_partState : function (partSeq){
	    	 var _url = "/backoffice/basicManage/partListAjax.do";
	    	 var _params = {"floorSeq" : $("#floorSeq").val(), "partUseyn": "Y"};
	    	 fn_comboListPost("sp_part", "partSeq",_url, _params, "", "120px", partSeq);  
	     }, fn_payClassGubun : function(payGubun, payCost){
	    	 //유료 무료 구분 PAY_CLASSIFICATION_1 -> 유료 
	    	  var payHtml = "";
	    	  if ( $("#payClassification").val() == "PAY_CLASSIFICATION_1"){
	        	 var _url = "/backoffice/basicManage/CmmnDetailAjax.do"
		    	 var _params = {"codeId" : "PAY_GUBUN"}
	        	 fn_comboList("sp_PayInfo", "payGubun",_url, _params, "", "120px", payGubun);
	        	 payHtml = $("#sp_PayInfo").html() + "<input type='number' id='payCost' name='payCost' value='"+payCost+"' onkeypress='only_num();' style='width:120px;'>";
	         }else {
	        	 payHtml = "";
	         }	 
	    	  $("#sp_PayInfo").html(payHtml);
	     }, fn_adminChoic : function (empId){
	    	 var empTxt =  $("#seatConfirmgubun").val() == "Y" ? "[관리자 선택]" : "";
	    	 $("#sp_empView").html(empTxt);
	     },classinfo : function(cellvalue, options, rowObject){
             var costInfo  = rowObject.pay_classification === "PAY_CLASSIFICATION_2" ? rowObject.pay_classification_txt : rowObject.pay_classification_txt 
       		      + ":" + rowObject.pay_gubun_txt +": 사용 크레딧:" + rowObject.pay_cost;
             return costInfo;
        }, fn_seatChoic : function (viewGubun){
             //고정석 일때 사용자 정보 선택 
             if (viewGubun === "S" && $("#seatFixUseryn").val() === "Y" ){
            	 $("#tb_seatInfo").hide();
                 $("#tb_userInfo").show();
             }else {
            	 $("#searchUserGubun").val("");
            	 $("#searchUserKeyword").val("");
            	 $("#tb_seatInfo").show();
                 $("#tb_userInfo").hide();
             }
        } 
    }
  </script>
  
  
  
  
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/msgList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" >
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="seatId" id="seatId" >
<input type="hidden" name="partCheck" id="partCheck" >
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span> <spring:message code="menu.menu01" /><span>></span>
                        <strong>좌석 관리</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">총 좌석수 <span id="sp_totcnt" /></div>
                <section class="Bclear">
                   
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>지점</th>
		                	<td  style="text-align:left;padding-left: 20px;">
		                	    <select path="searchCenter" id="searchCenter" title="지점구분" onChange="backoffice_common.fn_floorSearch('','sp_floorCombo', 'searchFloorSeq')">
		                	        <option value="">지점 선택</option>
			                         <c:forEach items="${centerInfo}" var="centerInfo">
			                            <option value="${centerInfo.centerId}">${centerInfo.centerNm}</option>
			                         </c:forEach>
			                    </select>
			                    <span id="sp_floorCombo"></span>
		                	</td>
		                	<th>검색</th>
		                	<td>
		                		<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}"> 
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">조회</span></a>
		                	</td>
		                	<td class="text-right">
		                	    <a href="#" ><span class="deepBtn">라벨등록</span></a>
		                	    <a href="javascript:fn_qrCreate('Seat')" ><span class="deepBtn">QR생성</span></a>
		                		<a href="javascript:jqGridFunc.fn_SeatInfo('Ins','0')" ><span class="deepBtn">등록</span></a>
		                		<a href="#" onClick="jqGridFunc.fn_delCheck()"><span class="deepBtn">삭제</span></a>
		                	</td>
						</tr>
                    </table>
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
<c:import url="/backoffice/inc/bottom_inc.do" />


<div id='app_message' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>좌석 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box100">
             <div class="padding15">
                   <table class="pop_table thStyle" id="tb_seatInfo">
		                <tbody>
		                    <tr>
		                        <th style="width:180px"><span class="redText">*</span>구역 선택</th>
		                        <td style="text-align:left" colspan="3">
		                        	 <select id="centerId" style="width:120px" onChange="jqGridFunc.fn_floorState()">
				                         <option value="">지점 선택</option>
				                         <c:forEach items="${centerInfo}" var="centerInfo">
				                            <option value="${centerInfo.centerId}">${centerInfo.centerNm}</option>
				                         </c:forEach>
				                    </select>
				                    <span id="sp_floor"></span>
                                    <span id="sp_part"></span>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th><span class="redText">*</span> 유료구분</th>
		                        <td style="text-align:left" colspan="3">
		                            <select id="payClassification" style="width:120px" onChange="jqGridFunc.fn_payClassGubun('0','0')">
				                        <option value=""> 선택</option>
				                         <c:forEach items="${payGubun}" var="payGubun">
				                            <option value="${payGubun.code}">${payGubun.codeNm}</option>
				                         </c:forEach>
				                    </select>
				                    <span id="sp_PayInfo"/>
		                        </td>
		                    </tr>
		                    <tr>
		                       <th><span class="redText">*</span>예약 구분</th>
		                       <td>
		                           <select id="seatGubun" style="width:120px">
				                        <option value="">구분 선택</option>
				                         <c:forEach items="${seatGubun}" var="seatGubun">
				                            <option value="${seatGubun.code}">${seatGubun.codeNm}</option>
				                         </c:forEach>
				                    </select>
		                       </td>
		                       <th><span class="redText">*</span>좌석명</th>
		                       <td><input type="text" name="seatName" id="seatName" class="input_noti" size="10"/></td>
		                    </tr>
		                    <tr>
		                       <th><span class="redText">도명 Top 위치</th>
		                       <td><input type="number" name="seatTop" id="seatTop" class="input_noti" size="10"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" /></td>
		                       <th><span class="redText"> 도명 Left 위치 </th>
		                       <td><input type="number" name="seatLeft" id="seatLeft" class="input_noti" size="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" /></td>
		                    </tr>
		                    <tr>
		                       <th><span class="redText">고정여부 </th>
		                       <td>
			                        <label class="switch">                                               
				                    	<input type="checkbox" id="seatFixUseryn" onclick="toggleValue(this);jqGridFunc.fn_seatChoic('S')" value="Y">
					                    <span class="slider round"></span> 
				                    </label> 
				                    <!--  고정 여부에 대한 정보 보여주기  -->
				                    <span id="sp_fixUser"></span>
				                    <input type="hidden" id="seatFixGubun">
				                    <input type="hidden" id="seatFixUserId">
		                       </td>
		                       <th><span class="redText">정렬 순서</th>
		                       <td><input type="number" name="seatOrder" id="seatOrder" class="input_noti" size="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" /></td>
		                    </tr>
		                    <tr>
		                       <th><span class="redText">관련 부서</th>
		                       <td>
		                            <select id="orgCd" style="width:120px">
				                        <option value="">예약 관련 부서 선택</option>
				                         <c:forEach items="${orgInfo}" var="orgCombo">
				                            <option value="${orgCombo.deptcode}">${orgCombo.deptname}</option>
				                         </c:forEach>
				                    </select>
		                       </td>
		                       <th><span class="redText">*<spring:message code="common.UseYn.title" /> <span class="join_id_comment joinSubTxt"></span> </th>
		                       <td>
			                        <label class="switch">                                               
				                    	<input type="checkbox" id="seatUseyn" name="seatUseyn" onclick="toggleValue(this)" value="Y">
					                    <span class="slider round"></span> 
				                    </label> 
		                       </td>
		                    </tr>
		                    <tr>
		                       <th><span class="redText">관리자 승인여부</th>
		                       <td>
		                            <label class="switch">                                               
				                    	<input type="checkbox" id="meetingConfirmgubun" onclick="toggleValue(this);jqGridFunc.fn_adminChoic('')" value="Y">
					                    <span class="slider round"></span> 
				                    </label> 
				                    <span id="sp_empView" /
		                       </td>
		                       <th><span class="redText">좌석 기본번호</th>
		                       <td><input type="text" name="seatNumber" id="seatNumber" class="input_noti" size="10"/></td>
		                    </tr>
		                    <tr>
		                       <th><span class="redText">사전예약일수</th>
		                       <td><input type="number" name="resReqday" id="resReqday" class="input_noti" size="10"/></td>
		                       <th><span class="redText">QR 사용여부</th>
		                       <td><label class="switch">                                               
				                    	<input type="checkbox" id="qrPlayyn" name="qrPlayyn" onclick="toggleValue(this)" value="Y">
					                    <span class="slider round"></span> 
				                    </label> 
		                       </td>
		                    </tr>
		                 </tbody>
                    </table>
                    
                    <table class="pop_table thStyle" id="tb_userInfo">
                        <thead>
                           <tr>
                              <td>
	                              <select id="searchUserGubun" style="width:120px;">
	                                 <option value=""></option>
	                                 <option value="G">사용자</option>
	                                 <option value="U">입주사</option>
	                              </select>
	                           </td>
	                           <td colspan="2">
	                           <input class="nameB"  type="text" name="searchUserKeyword" id="searchUserKeyword" > 
							   <a href="javascript:fn_userSearch();"><span class="searchTableB">조회</span></a>
							   </td>
							   <td><a href="#" onClick="jqGridFunc.fn_seatChoic('V')">닫기</a>
							   </td>
                           </tr>
                           <tr>
                              <th>회사명</th>
                              <th>이름</th>
                              <th>사번</th>
                              <th>연락처</th>
                           </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
               </div>                
            </div>
        </div>
        
        
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  

   <script src="/js/needpopup.js"></script> 
   <script src="/js/jquery-ui.js"></script>

</form:form>
    <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>확인1</button>

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
	
	    
</div>
</body>
</html>