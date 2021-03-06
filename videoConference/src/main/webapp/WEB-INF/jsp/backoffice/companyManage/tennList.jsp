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
    <script src="/js/popup.js"></script>
    
    
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
	 });
     var jqGridFunc  = {
    		
    		setGrid : function(gridOption){
    			 var grid = $('#'+gridOption);
    		    //ajax ?????? ?????? ?????? ?????? 
    		     var postData = {};
    		     grid.jqGrid({
    		    	url : '/backoffice/companyManage/tennSubListAjax.do' ,
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
    		        	        { label: 'his_seq', key: true, name:'his_seq',       index:'his_seq',      align:'center', hidden:true},
    		        	        { label: 'res_seq',  name:'res_seq',       index:'res_seq',      align:'center', hidden:true},
    		 	                { label: '?????????', name:'com_name',     index:'com_name',      align:'center', width:'10%'},
    		 	                { label: '????????????', name:'user_name',   index:'user_name',      align:'center', width:'10%' },
    			                { label: '????????????', name:'code_nm',       index:'code_nm',      align:'center', width:'10%' },
    			                { label: '?????????', name:'item_name', index:'item_name',      align:'center', width:'10%' },
    			                { label: '?????????', name:'res_title', index:'res_title',      align:'center', width:'10%' },
    			                { label: '????????????', name:'tenn_cnt', index:'tenn_cnt',     align:'center', width:'10%'},
    			                { label: '?????????', name:'reg_date', index:'reg_date', align:'center', width:'12%', 
    			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}}, 
    			                { label: '??????', name:'tenn_cnt', index:'tenn_cnt',     align:'center', width: 100, fixed:true, sortable : false, 
    			                	  formatter:jqGridFunc.rowBtn}
    			               
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
    		            alert("error:" + error); 
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
							    			          		"searchCondition" :  $("#searchCondition").val(),
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
    	                if (cm[index].name=='com_name' || cm[index].name=='user_no' ){
    	                	jqGridFunc.fn_userInfo("Edt", $(this).jqGrid('getCell', rowid, 'user_no'));
            		    }
    	                
    	            }
    		    });
    	   },refreshGrid : function(){
	        	$('#mainGrid').jqGrid().trigger("reloadGrid");
	       },clearGrid : function() {
               $("#mainGrid").clearGridData();
           }, fn_search : function(){
			  $("#mainGrid").setGridParam({
    	    	 datatype	: "json",
    	    	 postData	: JSON.stringify(  {
    	    		 "pageIndex": $("#pager .ui-pg-input").val(),
	          		 "searchCenter" :  $("#searchCenter").val(),
	          		 "searchCondition" :  $("#searchCondition").val(),
	          		 "searchFloorSeq" : $("#searchFloorSeq").val(),
          			 "searchKeyword" : $("#searchKeyword").val(),
         			 "pageUnit":$('.ui-pg-selbox option:selected').val()
         		 }),
    	    	 loadComplete	: function(data) {
    	    		 $("#sp_totcnt").text(data.paginationInfo.totalRecordCount);
    	    	 }
    	      }).trigger("reloadGrid");
		   }, fn_floorState : function(){
			  //?????? ???????????? 
			   var _url = "/backoffice/basicManage/floorListAjax.do";
			   var _params = {"centerId" : $("#searchCenter").val(), "floorUseyn": "Y"};
		       fn_comboListPost("sp_floorCombo", "floorSeq",_url, _params, "", "120px", "");  
		   }, rowBtn: function (cellvalue, options, rowObject){
			   if (rowObject.tenn_play_gubun == "TENN_PLAY_GUBUN_2"){
          		 var  return_Msg = '<a href="javascript:jqGridFunc.cancelTenn('+rowObject.his_seq+', &#39;C&#39;,'+rowObject.res_seq+');">??????</a>';
          	   }else  {
          		 var  return_Msg = "";
          	   }
     	       return return_Msg;
           }, rowBtn_ret: function (cellvalue, options, rowObject){
        	   if (rowObject.tenn_play_gubun == "TENN_PLAY_GUBUN_2"){
           		 var  return_Msg = '<a href="javascript:jqGridFunc.cancelTenn('+rowObject.his_seq+', &#39;R&#39;,'+rowObject.res_seq+');">??????</a>';
           	   }else  {
           		 var  return_Msg = "";
           	   }
        	   return return_Msg;
           }, cancelTenn : function(his_seq, gubun, res_seq){
        	   var message = (gubun == "C") ? "????????? ????????? ???????????????????." : "????????? ????????? ???????????????????."
        	   if (confirm(message)) {
        	        // ??????(?????????) ?????? ?????? ??? ?????????
        	        var url = "/backoffice/companyManage/tennCancel.do";
        	        var params = {"hisSeq" : his_seq, "gubun" : gubun, "resSeq" : res_seq};
        		    uniAjax(url, params, 
    		     			function(result) {
    						       if (result.status == "LOGIN FAIL"){
    								   location.href="/backoffice/login.do";
    		  					   }else if (result.status == "SUCCESS"){
    	                               //????????? ?????? ?????? 
    	                               alert("??????????????? ?????? ???????????????.");
    	                               $('#mainGrid').jqGrid().trigger("reloadGrid");
    	                               
    		  					   }else{
    		  						  alert(result.message); 
    		  					   }
    						       
    						},
 						    function(request){
 							    alert("Error:" +request.status );	       						
 						    }    		
    		        );
        	        
        	   }
           }, 
    }
  </script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/companyManage/companyList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="comCode" id="comCode" >
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span> <spring:message code="menu.menu04" /><span>></span>
                        <strong><spring:message code="menu.menu04_2" /></strong>
                    </div>
                </div>
            </div>
            <div class="Swrap Asearch">
                <div class="Atitle">??? ????????? <span id="sp_totcnt" /></div>
                <section class="Bclear">
                   <table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>?????????</th>
		                	<td>
		                	    <select path="searchCenter" id="searchCenter" title="????????????" onChange="fn_floorSearchState()">
								         <option value="">?????? ??????</option>
				                         <c:forEach items="${searchCenter}" var="centerList">
				                            <option value="${centerList.centerId}">${centerList.centerNm}</option>
				                         </c:forEach>
						    	</select> 
						    	<span id="sp_floorCombo"></span>
						    	<select id="searchCondition" name="searchCondition">
						    	    <option>??????</option>
						    	    <option value="comName">?????????</option>
						    	    <option value="userName">??????</option>
						    	</select>
		                		<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"> 
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">??????</span></a>
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:userFunc.fn_ExcelUpload()" ><span class="deepBtn">Excel DOWNLOAD</span></a>
		                	</td>
						</tr>
                    </table>
               </section>
            </div>
            <div class="Swrap tableArea">
               <table id="mainGrid"></table>
               <div id="pager" class="scroll" style="text-align:center;"></div>     
               <br />
               <div id="paginate"></div>          
            </div>
            <div id="dv_userField" class="Swrap tableArea">
               
            </div>
            
        </div>
    </div>
    <c:import url="/backoffice/inc/bottom_inc.do" />

 

   <script src="/js/needpopup.js"></script> 
   <script src="/js/jquery-ui.js"></script>
   <script>
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
</form:form>
    <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>??????1</button>
    <button id="btn_user" style="display:none" data-needpopup-show='#dv_userInfo'>??????2</button>
    <button id="btn_needPopHide" style="display:none" >hide</button>
    
</div>
</body>
</html>