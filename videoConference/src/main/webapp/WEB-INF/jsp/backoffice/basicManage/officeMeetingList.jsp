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
    <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script>
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
    		    //ajax ?????? ?????? ?????? ?????? 
    		
                var postData = {};
    		    grid.jqGrid({
    		    	url : '/backoffice/basicManage/officeMeetingListAjax.do' ,
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
	    		 	                { label: 'meeting_id', key: true, name:'meeting_id',       index:'seat_id',      align:'center', hidden:true},
	    		 	                { label: '?????????',  name:'center_nm',         index:'center_nm',        align:'left',   width:'10%'},
	    		 	                { label: '??????',  name:'floor_name',         index:'floor_name',        align:'left',   width:'10%'},
	    		 	                { label: '????????????',  name:'meeting_img1',         index:'meeting_img1',        align:'left',   width:'12%'
	    		 	                	, formatter: jqGridFunc.imageFomatter },
	    		 	                { label: '????????????',  name:'meeting_name',         index:'meeting_name',        align:'left',   width:'12%'},
	    			                { label: '???????????????', name:'room_type_txt',          index:'room_type_txt',        align:'center', width:'12%'},
	    			                { label: '????????? ??????', name:'meeting_view',        index:'meeting_view',       align:'center', width:'12%'},
	    			                { label: '????????? ??????', name:'meeting_confirmgubun',        index:'meeting_confirmgubun',       align:'center', width:'12%',  
	    			                  formatter:jqGridFunc.confirmGubun },
	    			                { label: '????????????', name:'meeting_order',       index:'meeting_order',      align:'center', width:'12%'},
	    			                { label: '?????? ??????', name:'pay_classification',       index:'mail_sendcheck',      align:'center', width:'20%', 
	    			                  sortable : false,	formatter:jqGridFunc.classinfo},
	    			                { label: '?????? ?????? ??????', name:'mail_sendcheck',       index:'mail_sendcheck',      align:'center', width:'8%'},
	    			                { label: 'SMS ?????? ??????', name:'sms_sendcheck',       index:'seat_order',      align:'center', width:'8%'},
	    			                { label: 'QR????????????', name:'qr_playyn',       index:'qr_playyn',      align:'center', width:'8%'},
	    			                { label: '???????????????', name:'res_reqday',       index:'res_reqday',      align:'center', width:'10%'},
	    			                { label: '?????????', name:'update_id',      index:'update_id',     align:'center', width:'14%'},
	    			                { label: '?????? ??????', name:'update_date', index:'update_date', align:'center', width:'12%', 
	    			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
	    			                { label: '??????', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : 
	    			                  false, formatter:jqGridFunc.rowBtn}
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
		    		          	  postData : JSON.stringify({
							    		          			"pageIndex": gridPage,
							    		          			"searchCenter" :  $("#searchCenter").val(),
							    		          			"searchFloorSeq" : $("#searchFloorSeq").val(),
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
    	                //console.log(cm);
    	                if (cm[index].name=='meeting_img1' || cm[index].name=='meeting_name'){
    	                	jqGridFunc.fn_ObjectInfo("Edt", $(this).jqGrid('getCell', rowid, 'meeting_id'));
            		    }
    	            }
    		    });
    		}, imageFomatter: function(cellvalue, options, rowObject){
    			var meetingImg = (rowObject.meeting_img1 == "no_image.gif"  || rowObject.meeting_img1 == undefined) ? "/img/no_image.gif": "/upload/"+ rowObject.meeting_img1;
     		    return '<img src="' + meetingImg + ' " style="width:120px">';
     		},rowBtn: function (cellvalue, options, rowObject){
            	if (rowObject.meeting_id != "")
            	     return "<a href='javascript:jqGridFunc.delRow(\""+rowObject.meeting_id+"\");'>??????</a>";
            },classinfo : function(cellvalue, options, rowObject){
                var costInfo  = rowObject.pay_classification === "PAY_CLASSIFICATION_2" ? rowObject.pay_classification_txt : rowObject.pay_classification_txt 
                		      + ":" + rowObject.pay_gubun_txt +": ?????? ?????????:" + rowObject.pay_cost;
                return costInfo;
            },confirmGubun: function (cellvalue, options, rowObject){
           	    return rowObject.meeting_confirmgubun == "Y" ? "???????????????: [" +  CommonJsUtil.NVL(rowObject.seat_admini_txt) + "]": "????????????";
     	    },refreshGrid : function(){
	        	$('#mainGrid').jqGrid().trigger("reloadGrid");
	        }, delRow : function (meeting_id){
	        	//?????? ?????? 
        	    if(meeting_id != "") {
        	    	var params = {'meetingId':meeting_id};
        		    fn_uniDelAction("/backoffice/basicManage/officeMeetingDelete.do",params, "jqGridFunc.fn_search");
		        }
            }, fn_delCheck  : function(){
   	    	    //????????? ?????? 
	   	    	var ids = $('#mainGrid').jqGrid('getGridParam','selarrrow'); //????????? row id?????? ????????? ??????
	   	    	if (ids.length < 1) {
	   	    		 alert("????????? ?????? ????????????.");
	   	    		 return false;
	   	    	}
	   	    	var SeatsArray = new Array();
	   	    	for(var i=0; i <ids.length; i++){
	   	    	        var rowObject = ids[i]; //????????? id??? row ????????? ????????? Object ????????? ??????
	   	    	        SeatsArray.push(ids[i]);
	   	    	} 
	   	    	var params = {'meetingId':SeatsArray.join(',')};
	   	    	fn_uniDelAction("/backoffice/basicManage/officeMeetingDelete.do",params, "jqGridFunc.fn_search");
   	        },fn_ObjectInfo : function (mode, meeting_id){
        	    $("#btn_message").trigger("click");
			    $("#mode").val(mode);
		        $("#meetingId").val(meeting_id);
		        backoffice_common.fn_adminForm("form");
		        if (mode == "Edt"){
		        	$("#btnUpdate").text("??????");
		        	var params = {"meetingId" : meeting_id};
		     	    var url = "/backoffice/basicManage/officeMeetingDetail.do";
		     	    uniAjaxSerial(url, params, 
		          			function(result) {
		     				       if (result.status == "LOGIN FAIL"){
		     				    	   alert(result.meesage);
		       						   location.href="/backoffice/login.do";
		       					   }else if (result.status == "SUCCESS"){
	       						       //??? ????????? ?????? ??????
	       						       var obj  = result.regist;
	       						       $("#centerId").val(obj.center_id);
	       						       jqGridFunc.fn_floorState(obj.floor_seq);
	       						       if (obj.part_seq != "0"){
	       						    	  jqGridFunc.fn_partState(obj.part_seq);
	       						       }
	       						       
						    		   $("#meetingName").val( obj.meeting_name);
						    		   $("#roomType").val( obj.room_type);
						    		   jqGridFunc.fn_MeetingFieldView();
						    		   $("#payClassification").val( obj.pay_classification);
						    		   jqGridFunc.fn_payClassGubun(obj.pay_gubun, obj.pay_cost)
						    		   $("#maxCnt").val( obj.max_cnt);
						    		   $("#meetingOrder").val( obj.meeting_order);
						    		   $("#meetingAdminid").val( obj.meeting_adminid);
						    		   $("#resReqday").val( obj.res_reqday);
						    		   toggleClick("meetingUseyn", obj.meeting_useyn);
						    		   toggleClick("meetingConfirmgubun", obj.meeting_confirmgubun);
						    		   toggleClick("meetingMainview", obj.meeting_mainview);
						    		   toggleClick("meetingView", obj.meeting_view);
						    		   toggleClick("meetingEqupgubun", obj.meeting_equpgubun);
						    		   toggleClick("mailSendcheck", obj.mail_sendcheck);
						    		   toggleClick("smsSendcheck", obj.sms_sendcheck);
						    		   toggleClick("qrPlayyn", obj.qr_playyn);
						    		   
						    		   jqGridFunc.fn_msgView("M", obj.mail_sendcheck);
						    		   jqGridFunc.fn_msgView("S", obj.sms_sendcheck);
						    		   
						    		   $("#ir1").val(obj.meetingroom_remark);
						    		   $("#resMessageMail").val( obj.res_message_mail);
						    		   $("#canMessageMail").val( obj.can_message_mail);
						    		   $("#resMessageSms").val( obj.res_message_sms);
						    		   $("#canMessageSms").val( obj.can_message_sms);
						    		   $("#avayaConfiId").val( obj.avaya_confi_id);
						    		   $("#avayaUserid").val( obj.avaya_userid);
						    		   $("#terminalId").val( obj.terminal_id);
						    		   $("#terminalNumber").val( obj.terminal_number);
						    		   $("#terminalTel").val( obj.terminal_tel);
						    		   $("#userFirstNm").val( obj.user_first_nm);
						    		   $("#userLastNm").val( obj.user_last_nm);
						    		   $("#userEmail").val( obj.user_email);
						    		   //?????? ?????? 
						    		   $("#sp_empView").html(obj.seat_admin_txt);
						    		   
						    		   $("#meetingRemark01").val( obj.meeting_remark01);
						    		   $("#meetingRemark02").val( obj.meeting_remark02);
						    		   $("#meetingRemark03").val( obj.meeting_remark03);
						    		   $("#meetingRemark04").val( obj.meeting_remark04);
						    		   $("#meetingRemark05").val( obj.meeting_remark05);
						    		   $("#meetingRemark06").val( obj.meeting_remark06);
						    		   $("#meetingRemark07").val( obj.meeting_remark07);
						    		   $("#meetingRemark08").val( obj.meeting_remark08);
						    		   
						    		   $("#meetingImg1").val("");
						    		   $("#meetingImg2").val("");
						    		   $("#meetingImg3").val("");
						    		   $("#meetingFile01").val("");
						    		   $("#meetingFile02").val("");
						    		   
						    		  
						    		   
						    		   
		       					   }else{
		       						   alert(result.meesage);
		       					   }
		     				    },
		     				    function(request){
		     					    alert("Error:" +request.status );	       						
		     				    }    		
		               );
		        }else{
		        	$('input[name^=meeting]').val("");
		        	//roomType
		        	$("#meetingImg1").val("");
		        	$("#roomType").val("");
	    		    $("#meetingImg2").val("");
	    		    $("#meetingImg3").val("");
	    		    $("#meetingFile01").val("");
	    		    $("#meetingFile02").val("");
		        	$("#ir1").val("");
		        	$("#centerId").val("");
		        	toggleDefault("meetingUseyn");
		        	toggleDefault("meetingConfirmgubun");
		        	toggleDefault("meetingMainview");
		        	toggleDefault("meetingView");
		        	toggleDefault("meetingEqupgubun");
		        	toggleDefault("mailSendcheck");
		        	toggleDefault("smsSendcheck");
		        	toggleDefault("qrPlayyn");
		    		
		        	$("#floorSeq").remove();
		        	$("#partSeq").remove();
		        	//????????? 
		        	$("#tr_resMial").hide();
		        	$("#tr_resSms").hide();
		        	$(".avayaView").hide();
		        	$(".meetingRemark").hide();
		        	$("#btnUpdate").text("??????");
		        	
		        	???????????????
		        	
		        }
           },clearGrid : function() {
                $("#mainGrid").clearGridData();
           },fn_CheckForm  : function (){
			    if (any_empt_line_id("centerId", "????????? ??????????????????.") == false) return;
			    if (any_empt_line_id("floorSeq", "????????? ??????????????????.") == false) return;
		    	if (any_empt_line_id("meetingName", "???????????? ????????? ?????????.") == false) return;
		    	if (any_empt_line_id("roomType", "????????? ????????? ????????? ?????????.") == false) return;
		    	if (fn_emptyReplace($("#meetingConfirmgubun").val(),"N") == "Y"){
		    		if (any_empt_line_id("meetingAdminid", "???????????? ????????? ?????????.") == false) return;
		    	}
		    	
		    	//?????? 
		    	var sHTML = oEditors.getById["ir1"].getIR();
     			$("#meetingroomRemark").val(sHTML); 
		    	var formData = new FormData();
	     	 	    formData.append('meetingImg1', $('#meetingImg1')[0].files[0]);
	     			formData.append('meetingImg2', $('#meetingImg2')[0].files[0]);
	     			formData.append('meetingImg3', $('#meetingImg3')[0].files[0]);
	     			formData.append('meetingFile01', $('#meetingFile01')[0].files[0]);
	     			formData.append('meetingFile02', $('#meetingFile02')[0].files[0]);
	     			formData.append('partSeq' , fn_emptyReplace($("#partSeq").val(),"0"));
	     			formData.append('floorSeq' , $("#floorSeq").val());
	     			formData.append('centerId' , $("#centerId").val());
	     			formData.append('meetingId' , $("#meetingId").val());
	     			formData.append('meetingName' , $("#meetingName").val());
	     			formData.append('roomType' , $("#roomType").val());
	     			formData.append('payClassification' , fn_emptyReplace($("#payClassification").val(),"PAY_CLASSIFICATION_2"));
	     			formData.append('payGubun' , fn_emptyReplace($("#payGubun").val(),""));
	     			formData.append('payCost' , fn_emptyReplace($("#payCost").val(),"0"));
	     			formData.append('maxCnt' , fn_emptyReplace($("#maxCnt").val(),"0"));
	     			formData.append('meetingOrder' , fn_emptyReplace($("#meetingOrder").val(),"999"));
	     			formData.append('meetingUseyn' , fn_emptyReplace($("#meetingUseyn").val(),"Y"));
	     			formData.append('meetingConfirmgubun' , fn_emptyReplace($("#meetingConfirmgubun").val(),"N"));
	     			formData.append('meetingAdminid' , fn_emptyReplace($("#meetingAdminid").val(),""));
	     			formData.append('meetingMainview' , $("#meetingMainview").val());
	     			formData.append('meetingView' , $("#meetingView").val());
	     			formData.append('meetingEqupgubun' , $("#meetingEqupgubun").val());
	     			formData.append('meetingroomRemark' , $("#meetingroomRemark").val());
	     			formData.append('mailSendcheck' , fn_emptyReplace($("#mailSendcheck").val(),"N"));
	     			formData.append('smsSendcheck' , fn_emptyReplace($("#smsSendcheck").val(),"N"));
	     			formData.append('qrPlayyn' , fn_emptyReplace($("#qrPlayyn").val(),"N"));
	     			formData.append('resMessageMail' , fn_emptyReplace($("#resMessageMail").val(),"0"));
	     			formData.append('canMessageMail' , fn_emptyReplace($("#canMessageMail").val(),"0"));
	     			formData.append('resMessageSms' , fn_emptyReplace($("#resMessageSms").val(),"0"));
	     			formData.append('canMessageSms' , fn_emptyReplace($("#canMessageSms").val(),"0"));
	     			formData.append('avayaConfiId' , $("#avayaConfiId").val());
	     			formData.append('avayaUserid' , $("#avayaUserid").val());
	     			formData.append('terminalId' , $("#terminalId").val());
	     			formData.append('terminalNumber' , fn_emptyReplace($("#terminalNumber").val(),"0"));
	     			formData.append('terminalTel' , $("#terminalTel").val());
	     			formData.append('userFirstNm' , $("#userFirstNm").val());
	     			formData.append('userLastNm' , $("#userLastNm").val());
	     			formData.append('userEmail' , $("#userEmail").val());
	     			
	     			formData.append('meetingRemark01' , $("#meetingRemark01").val());
	     			formData.append('meetingRemark02' , $("#meetingRemark02").val());
	     			formData.append('meetingRemark03' , $("#meetingRemark03").val());
	     			formData.append('meetingRemark04' , $("#meetingRemark04").val());
	     			formData.append('meetingRemark05' , $("#meetingRemark05").val());
	     			formData.append('meetingRemark06' , $("#meetingRemark06").val());
	     			formData.append('meetingRemark07' , $("#meetingRemark07").val());
	     			formData.append('meetingRemark08' , $("#meetingRemark08").val());
	     			
	     			formData.append('resReqday' ,fn_emptyReplace( $("#resReqday").val(),"0"));
	     			formData.append('mode' , $("#mode").val());
     			  
     			  
     		        uniAjaxMutipart("/backoffice/basicManage/officeMeetingUpdate.do", formData, 
     						function(result) {
     						       //????????? ?????? ?????? ?????? 	
     						       if (result.status == "SUCCESS"){
     		    	            	   
     		    	               }else if (result.status == "LOGIN FAIL"){
     								   document.location.href="/backoffice/login.do";
     				               }else {
     				            	   alert("?????? ?????? ????????? ?????? ???????????????");
     				               }
     		    	               need_close();
   		    	                   jqGridFunc.fn_search();
     		    	              
     						    },
     						    function(request){
     							    alert("Error:" +request.status );	       						
     						    }    		
     			  );
		  },fn_search: function(){
	    	 $("#mainGrid").setGridParam({
	    	    	datatype	: "json",
	    	    	postData	: JSON.stringify({
	    	    		"pageIndex": $("#pager .ui-pg-input").val(),
	    	    		"searchRoomType" : $("#searchRoomType").val(), 
	    	    		"searchCenter" :  $("#searchCenter").val(),
	          			"searchFloorSeq" : $("#searchFloorSeq").val(),
	         			"searchKeyword" : $("#searchKeyword").val(),
	         			"pageUnit":$('.ui-pg-selbox option:selected').val()
	         		}),
	    	    	loadComplete	: function(data) { $("#sp_totcnt").text(data.paginationInfo.totalRecordCount);}
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
	    	 //?????? ?????? ?????? PAY_CLASSIFICATION_1 -> ?????? 
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
	     }, fn_msgView : function(msgType){
	    	if (msgType == "M" && $("#mailSendcheck").val() == "Y"){
	 			$("#tr_resMial").show();
	 		}else if (msgType == "M" && $("#mailSendcheck").val() == "N") {
	 			$("#tr_resMial").hide();	
	 		}else if (msgType == "S" && $("#smsSendcheck").val() == "Y") {
	 			$("#tr_resSms").show();			
	 		}else if (msgType == "S" && $("#smsSendcheck").val() == "N") {
	 			$("#tr_resSms").hide();			
	 		}
	     }, fn_MeetingFieldView : function(){
	    	 
	    	 
	    	 
	    	 $("#roomType").val() == "SWC_GUBUN_2" ? $(".avayaView").show() : $(".avayaView").hide();
	    	 $("#roomType").val() == "SWC_GUBUN_3" ? $(".meetingRemark").show() : $(".meetingRemark").hide();
	    	 
	     }, fn_adminChoic : function (empId){
	    	 var empTxt =  $("#meetingConfirmgubun").val() == "Y" ? "<a href='javascript:backoffice_common.fn_adminForm(&#34;admin&#34;)'>[????????? ??????]</a>" : "";
	    	 $("#sp_empView").html(empTxt);
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
<input type="hidden" name="meetingId" id="meetingId" >


<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span> <spring:message code="menu.menu01" /><span>></span>
                        <strong>????????? ??????</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">??? ???????????? <span id="sp_totcnt" /></div>
                <section class="Bclear">
                   
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>??????</th>
		                	<td  style="text-align:left;padding-left: 20px;">
		                	    <select path="searchCenter" id="searchCenter" title="????????????" onChange="backoffice_common.fn_floorSearch('','sp_floorCombo', 'searchFloorSeq')">
		                	        <option value="">?????? ??????</option>
			                         <c:forEach items="${centerInfo}" var="centerInfo">
			                            <option value="${centerInfo.centerId}">${centerInfo.centerNm}</option>
			                         </c:forEach>
			                    </select>
			                    <span id="sp_floorCombo"></span>
		                	</td>
		                	<th>????????? ??????</th>
		                	<td>
		                	<select path="searchRoomType" id="searchRoomType" title="????????? ??????">
		                	    <option value="">????????? ?????? ??????</option>
		                         <c:forEach items="${selectSwcGubun}" var="code">
		                            <option value="${code.code}">${code.codeNm}</option>
		                         </c:forEach>
		                	</select>
		                	</td>
		                	<th>??????</th>
		                	<td>
		                		<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}"> 
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">??????</span></a>
		                	</td>
		                	
						</tr>
                    </table>
                    <div class="text-right">
		                	    <a href="#" ><span class="lightgrayBtn">QR??????</span></a>
		                		<a href="javascript:jqGridFunc.fn_ObjectInfo('Ins','0')" ><span class="deepBtn">??????</span></a>
		                		<a href="#" onClick="jqGridFunc.fn_delCheck()"><span class="redBtn">??????</span></a>
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
<c:import url="/backoffice/inc/bottom_inc.do" />


<div id='app_message' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>????????? ??????</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// ?????? ????????????-->
            <div class="pop_box100">
                <div class="padding15">
	                   <table class="pop_table thStyle" id="tb_formInfo">
		                <tbody>
		                    <tr>
		                        <th style="width:180px"><span class="redText">*</span>?????? ??????</th>
		                        <td style="text-align:left" colspan="3">
		                        	 <select id="centerId" style="width:120px" onChange="jqGridFunc.fn_floorState()">
				                         <option value="">?????? ??????</option>
				                         <c:forEach items="${centerInfo}" var="centerInfo">
				                            <option value="${centerInfo.centerId}">${centerInfo.centerNm}</option>
				                         </c:forEach>
				                    </select>
				                    <span id="sp_floor"></span>
                                    <span id="sp_part"></span>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th><span class="redText">*</span>????????? ???</th>
		                        <td style="text-align:left">
		                        	<input type="text" name="meetingName" size="20" maxlength="80" id="meetingName" style="width:150px;"/>
		                        </td>
		                        <th><span class="redText">*</span>???????????????</th>
		                        <td style="text-align:left">
		                            <select id="roomType" name="roomType" style="width:120px" onChange="jqGridFunc.fn_MeetingFieldView()">
		                                 <option value="">????????? ??????</option>
				                         <c:forEach items="${selectSwcGubun}" var="code">
				                            <option value="${code.code}">${code.codeNm}</option>
				                         </c:forEach>
		                            </select>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th><span class="redText">*</span> ????????????</th>
		                        <td style="text-align:left" colspan="3">
		                            <select id="payClassification" style="width:120px" onChange="jqGridFunc.fn_payClassGubun('0','0')">
				                        <option value=""> ??????</option>
				                         <c:forEach items="${payGubun}" var="payGubun">
				                            <option value="${payGubun.code}">${payGubun.codeNm}</option>
				                         </c:forEach>
				                    </select>
				                    <span id="sp_PayInfo"/>
		                        </td>
		                        
		                    </tr>	
		                    <tr>
		                        <th><span class="redText">*</span>??????????????????</th>
		                        <td style="text-align:left">
		                           <input type="number" name="maxCnt" size="20" maxlength="80" id="maxCnt"  style="width:100px;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
		                        </td>
		                        <th><span class="redText">*</span>????????????</th>
		                        <td style="text-align:left">
		                           <input type="number" name="meetingOrder" id="meetingOrder" onkeypress="only_num();"  style="width:100px;"/>	
		                        </td>
		                    </tr>                    
		                    <tr>
		                        <th><span class="redText">*</span>????????????</th>
		                        <td style="text-align:left">
			                         <label class="switch">                                               
				                    	<input type="checkbox" id="meetingUseyn" onclick="toggleValue(this)" value="Y">
					                    <span class="slider round"></span> 
				                     </label>				                                                 
		                        </td>
		                        <th><span class="redText">*</span>????????? ????????????</th>
		                        <td style="text-align:left">
		                              <input type="hidden" name="meetingAdminid" id="meetingAdminid" />
		                              <label class="switch">                                               
				                    	<input type="checkbox" id="meetingConfirmgubun" onclick="toggleValue(this);jqGridFunc.fn_adminChoic('')" value="Y">
					                    <span class="slider round"></span> 
				                      </label> 
				                      <span id="sp_empView" />
				                      
				                      
		                        </td>
		                    </tr>
		                    <tr>
		                        <th><span class="redText">*</span>?????? ??????</th>
		                        <td style="text-align:left">
		                        	
		                        	<label class="switch">                                               
				                    	<input type="checkbox" id="meetingMainview" onclick="toggleValue(this)" value="Y">
					                    <span class="slider round"></span> 
				                    </label>                
		                        </td>
		                        <th><span class="redText">*</span>?????? ????????? ??????</th>
		                        <td style="text-align:left">
				                    <label class="switch">                                               
				                    	<input type="checkbox" id="meetingView" onclick="toggleValue(this)" value="Y">
					                    <span class="slider round"></span> 
				                    </label> 
		                        </td>
		                    </tr>
		                    <tr>
		                        <th><span class="redText">*</span>?????? ????????????</th>
		                        <td style="text-align:left">
		                              <label class="switch">                                               
				                    	<input type="checkbox" id="meetingEqupgubun" onclick="toggleValue(this)" value="Y">
					                    <span class="slider round"></span> 
				                     </label>
		                        </td>
		                        <th><span class="redText">*</span>?????? ?????????</th>
		                        <td style="text-align:left">
				                    <input type="number" name="resReqday" id="resReqday" onkeypress="only_num();"  style="width:100px;"/>??????
		                        </td>
		                    </tr>
		                    <tr>
		                        <th><span class="redText">*</span>?????????1</th>
		                        <td style="text-align:left">
		                         <input name="meetingImg1" id="meetingImg1" type="file"  size="20"/>  
		                        </td>
		                        <th><span class="redText">*</span>?????????2</th>
		                        <td style="text-align:left">
		                        <input name="meetingImg2" id="meetingImg2" type="file"  size="20"/>
		                        </td>
		                    </tr>
		                    
							<tr>
							    <th><span class="redText">*</span>?????????3</th>
		                        <td style="text-align:left">
		                         <input name="meetingImg3" id="meetingImg3" type="file"  size="20"/>  
		                        </td>
		                        <th><span class="redText">QR ????????????</th>
		                        <td><label class="switch">                                               
				                    	<input type="checkbox" id="qrPlayyn" name="qrPlayyn" onclick="toggleValue(this)" value="Y">
					                    <span class="slider round"></span> 
				                    </label> 
		                        </td>
		                    </tr>
		                    <tr>
		                        <th><span class="redText">*</span>????????????1</th>
		                        <td style="text-align:left">
		                             <input name="meetingFile01" id="meetingFile01" type="file"  size="20"/>
		                        </td>
		                        <th><span class="redText">*</span>????????????2</th>
		                        <td style="text-align:left">
		                             <input name="meetingFile02" id="meetingFile02" type="file"  size="20"/>
		                        </td>
		                    </tr>
		                    <tr style="display:none">
		                        <th><span class="redText">*</span>?????? ?????? ??????</th>
		                        <td style="text-align:left">
		                             <label class="switch">                                               
				                    	<input type="checkbox" id="mailSendcheck" onclick="toggleValue(this);jqGridFunc.fn_msgView('M')" value="Y">
					                    <span class="slider round"></span> 
				                     </label>
		                        </td>
		                        <th><span class="redText">*</span>sms ?????? ??????</th>
		                        <td style="text-align:left">
		                              <label class="switch">                                               
				                    	<input type="checkbox" id="smsSendcheck" onclick="toggleValue(this);jqGridFunc.fn_msgView('S')" value="Y">
					                    <span class="slider round"></span> 
				                      </label>
		                        </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>?????? ?????????</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark01" id="meetingRemark01" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>??????</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark02" id="meetingRemark02" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>??????</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark03" id="meetingRemark03" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>????????????</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark04" id="meetingRemark04" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>????????????</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark05" id="meetingRemark05" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>?????????</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark06" id="meetingRemark06" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>??????(8H)</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark07" id="meetingRemark07" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    <tr class='meetingRemark'>
		                       <th>??????</th>
		                       <td style="text-align:left" colspan="3">
		                         <input name="meetingRemark08" id="meetingRemark08" type="text" size="20"/>  
		                       </td>
		                    </tr>
		                    
		                    <tr>
		                        <th colspan="4">????????? ?????? ??????</th>
		                    </tr>
		                    <tr>
		                       <td colspan="4">
		                       <textarea name="ir1" id="ir1" style="width:700px; height:20px; display:none;"></textarea>
		                       <input type="hidden" name="meetingroomRemark" id="meetingroomRemark" />
		                       </td>
		                    </tr>
		                    
		                    
		                    
		                    
		                    
		                    <tr id="tr_resMial">
		                        <th><span class="redText">*</span>?????? ?????????</th>
		                        <td style="text-align:left">
		                            <select id="resMessageMail" style="width:120px" onChange="jqGridFunc.fn_payClassGubun('0','0')">
				                        <option value=""> ??????</option>
				                         <c:forEach items="${selectMail}" var="mail">
				                            <option value="${mail.msgSeq}">${mail.msgTitle}</option>
				                         </c:forEach>
				                    </select>
		                        </td>
		                        <th><span class="redText">*</span>?????? ?????????</th>
		                        <td style="text-align:left">
		                            <select id="canMessageMail" style="width:120px" onChange="jqGridFunc.fn_payClassGubun('0','0')">
				                        <option value=""> ??????</option>
				                         <c:forEach items="${selectMail}" var="mail">
				                            <option value="${mail.msgSeq}">${mail.msgTitle}</option>
				                         </c:forEach>
				                    </select>
		                        </td>
		                    </tr>
		                    <tr id="tr_resSms">
		                        <th><span class="redText">*</span>?????? SMS</th>
		                        <td style="text-align:left">
		                            <select id="resMessageSms" style="width:120px" onChange="jqGridFunc.fn_payClassGubun('0','0')">
				                        <option value=""> ??????</option>
				                         <c:forEach items="${selectSms}" var="sms">
				                            <option value="${sms.msgSeq}">${sms.msgTitle}</option>
				                         </c:forEach>
				                    </select>
		                        </td>
		                        <th><span class="redText">*</span>?????? SMS</th>
		                        <td style="text-align:left">
		                            <select id="canMessageSms" style="width:120px" onChange="jqGridFunc.fn_payClassGubun('0','0')">
				                        <option value=""> ??????</option>
				                         <c:forEach items="${selectSms}" var="sms">
				                            <option value="${sms.msgSeq}">${sms.msgTitle}</option>
				                         </c:forEach>
				                    </select>
		                        </td>
		                    </tr>
		                    
		                    <tr class="avayaView">
		                      <th>AVAYA CODE</th>
		                        <td style="text-align:left">
		                           <input type="text" name="avayaConfiId" size="40" maxlength="80" id="avayaConfiId" style="width:260px;"/>
		                       </td>
		                       <th>???????????? ?????????</th>
		                        <td style="text-align:left">
		                         <input type="text" name="avayaUserid" size="40" maxlength="80" id="avayaUserid" style="width:250px;"/> 
		                        </td>
		                    </tr>
		                    <tr class="avayaView">
		                        <th><span class="redText">*</span>???????????? ??????????????????</th>
		                        <td style="text-align:left">
		                        <input type="text" name="terminalId" size="40" maxlength="80" id="terminalId" style="width:250px;"/>
		                        </td>
		                        <th>???????????? ????????? ??????</th>
		                        <td style="text-align:left">
		                        <input type="number" name="terminalNumber" size="40" maxlength="80" id="terminalNumber"  onkeypress="only_num();" style="width:250px;"/>  
		                        </td>
		                    </tr>
		                    <tr class="avayaView">
		                        <th>???????????? ????????? ????????????</th>
		                        <td style="text-align:left">
		                        <input type="number" name="terminalTel" size="40" maxlength="80" id="terminalTel" onkeypress="only_num();" style="width:250px;"/>
		                        </td>
		                        <th><span class="redText"></span>???????????? ????????????</th>
		                        <td style="text-align:left">
		                        first: <input type="text" name="userFirstNm" size="20" maxlength="80" id="userFirstNm" style="width:120px;"/>
		                        last: <input type="text" name="userLastNm" size="20" maxlength="80" id="userLastNm" style="width:120px;"/>  
		                        </td>
		                    </tr>
		                    <tr class="avayaView">
		                        <th><span class="redText"></span>?????????</th>
		                        <td style="text-align:left" colspan="3">
		                        <input type="text" name="userEmail" size="20" maxlength="80" id="userEmail" style="width:250px;"/>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		            
		            
		            
		            <table class="pop_table thStyle" id="tb_searchform">
                        <thead>
                           <tr>
                              <td colspan="2">
                                <select name="emSearchCondition"  id="emSearchCondition" style="width:150px;">
											<option value="empname">?????????/??????</option>
								</select>
	                           
	                             <input class="nameB" type="text" name="emSearchKeyword" id="emSearchKeyword" />      
								 
							   </td>
							   <td>
							   <a href="javascript:backoffice_common.fn_empSearch();"><span class="lightgrayBtn">??????</a>  
							   <a href="#" onClick="backoffice_common.fn_adminForm('form')" class='lightgrayBtn'>??????</a>
							   </td>
                           </tr>
                           <tr>
                              <th>??????</th>
                              <th>??????</th>
                              <th>??????</th>
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
            <span id="join_confirm_comment" class="join_pop_main_subTxt">????????? ?????? ????????? ??????????????????.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  

   
   <script src="/js/jquery-ui.js"></script>

 </form:form>
 <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>??????1</button>
 <c:import url="/backoffice/inc/uni_pop.do" />
 <script>
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "ir1",                        
	    sSkinURI: "/js/SE/SmartEditor2Skin.html",
	    htParams: { 
	   	 bUseToolbar: true,
	        fOnBeforeUnload: function () { },
	        //boolean 
	        fOnAppLoad: function () { }
	        //?????? ??????
	    },
	    fCreator: "createSEditor2"
	});
 </script>	    
</div>
</body>
</html>