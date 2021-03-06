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
	<script type="text/javascript" src="/js/back_common.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    
    <link rel="stylesheet" type="text/css" href="/css/toggle.css">
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
    
    <!-- bpopup ?????? -->
    <script type="text/javascript" src="/js/bpopup.js"></script>
    <link rel="stylesheet" href="/css/kiosk/popup.css">
    
    
    
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/companyManage/companyList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="comCode" id="comCode" >
<input type="hidden" name="comPlayFloor" id="comPlayFloor" >
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span> <spring:message code="menu.menu04" /><span>></span>
                        <strong><spring:message code="menu.menu04_1" /></strong>
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
		                	    <select path="searchCenter" id="searchCenter" title="????????????" onChange="backoffice_common.fn_floorSearch('','sp_floorCombo', 'searchFloorSeq')">
								         <option value="">?????? ??????</option>
				                         <c:forEach items="${searchCenter}" var="centerList">
				                            <option value="${centerList.centerId}">${centerList.centerNm}</option>
				                         </c:forEach>
						    	</select> 
						    	<span id="sp_floorCombo"></span>
		                		<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"> 
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">??????</span></a>
		                	</td>
		                	<th>??? ?????????</th>
		                	<td>
		                	   <select id="searchMode" name="searchMode">
		                	       <option value="mode" selected>??????</option>
		                	       <option value="">??????</option>
		                	   </select>
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:jqGridFunc.fn_ComInfo('Ins','0')" ><span class="deepBtn">??????</span></a>
		                		<a href="javascript:jqGridFunc.fn_tennPop();" class="deepBtn">????????? ??????</a>
		                		<a href="javascript:jqGridFunc.fn_tennReset();" class="deepBtn">????????? Reset</a>
		                		<!-- <a href="javascript:userFunc.fn_ExcelUpload()" ><span class="deepBtn">Excel Upload</span></a> -->
		                		
		                		
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


    <div id='app_message' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>????????? ??????</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// ?????? ????????????-->
           
            
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*????????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comName" name="comName" class="input_noti" size="10"/>
                </div>                
            </div>
             <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">* ????????? ??????<span class="join_id_comment joinSubTxt"></span></p>
                    <form:select path="comGubun" id="comGubun" title="???????????????" onChange="jqGridFunc.fn_comNumber();">
				         <form:option value="" label="????????????"/>
                         <form:options items="${comGubun}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*????????????????????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comNumber" name="comNumber" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">???????????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comCeoName" name="comCeoName"> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">?????? ?????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="file" id="comLogo" name="comLogo"> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">* ????????? ??????<span class="join_id_comment joinSubTxt"></span></p>
                    <form:select path="comState" id="comState" title="???????????????">
				         <form:option value="" label="????????????"/>
                         <form:options items="${comState}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">??????<span class="join_id_comment joinSubTxt"></span></p>
                     <input type="text" id="comItem" name="comItem" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">?????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comBuscondition" name="comBuscondition" class="input_noti" size="10"/>
                </div>                
            </div>
             <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">????????????<span class="join_id_comment joinSubTxt"></span></p>
                     <input type="text" id="comTel" name="comTel" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">????????????<span class="join_id_comment joinSubTxt"></span></p>
                     <input type="text" id="comFax" name="comFax" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">??????<span class="join_id_comment joinSubTxt"></span></p>
                    <select path="centerId" id="centerId" title="????????????" onChange="backoffice_common.fn_floorInfo('', 'sp_floor', 'floorSeq');backoffice_common.fn_floorPlayState('', 'sp_floorCheck', 'floorPlaySeq');">
				         <option value="">?????? ??????</option>
                         <c:forEach items="${searchCenter}" var="centerList">
                            <option value="${centerList.centerId}">${centerList.centerNm}</option>
                         </c:forEach>
					</select> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">?????????/?????? ?????? ???<span class="join_id_comment joinSubTxt"></span></p>
                    <span id="sp_floor" />
                   
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">?????? ?????? ???<span class="join_id_comment joinSubTxt"></span></p>
                    <span id="sp_floorCheck" />
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">????????? ????????????<span class="join_id_comment joinSubTxt"></span></p>
                    <label class="switch">                                               
                   	   <input type="checkbox" id="tennUseyn" onclick="toggleValue(this);jqGridFunc.fn_TennView(this)" value="Y">
                       <span class="slider round"></span> 
                    </label> 
                    <input type="text" id="comTennentCnt" name="comTennentCnt" style="width:120px;" placeholder="??? ????????? ??????."> 
                </div>                
            </div>
            <div class="pop_box100">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.center.address" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comAddr1" name="comAddr1" size="50" />-
                    <input type="text" id="comAddr2" name="comAddr2" size="50" />
                </div>                
            </div>
            
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">????????? ?????? ????????? ??????????????????.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div> 
    
    
    <div id='dv_userInfo' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>????????? ??????</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// ?????? ????????????-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*?????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userNo" name="userNo" class="input_noti" size="10"/>
                    <span id="sp_uniCheck"></span>
                    <input type="hidden" id="uniCheck">
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*?????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userName" name="userName" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">?????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userRank" name="userRank" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">?????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userPosition" name="userPosition" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*????????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userCellphone" name="userCellphone" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*????????? <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userEmail" name="userEmail" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*??????<span class="join_id_comment joinSubTxt"></span></p>
                    <select id="userState"   style="width:120px">
                        <option value="">???????????????</option>
                        <c:forEach items="${userState}" var="state">
                            <option value="${state.code}">${state.codeNm}</option>
                         </c:forEach>
                    </select>
                </div>                
            </div>
            
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">????????? ?????? ????????? ??????????????????.</span>
            <a href="javascript:userFunc.fn_userUpdate();" class="redBtn" id="btnUserUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>   
    
   <!-- ?????????  ??????  -->
   <div id='dv_tennPopup' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>????????? ??????</h2>
        </div>
        <div class="popCon">
            <div class="con">
               <div class="pop_box">
                  <div class="padding15">
                    <input type="number" name="tennRecCount" size="40" id="tennRecCount"  onkeypress="only_num();" style="width:150px;"/>??? 
					 <a href="#" onClick="jqGridFunc.fn_tennUpdate()" class="redBtn">??????</a>
                   </div>
               </div>
            </div>
        </div>
   </div>
   <c:import url="/backoffice/inc/uni_pop.do" />
   <script src="/js/jquery-ui.js"></script>
   <script type="text/javascript">
		 $(document).ready(function() { 
			   jqGridFunc.setGrid("mainGrid");
		 });
		 //bpop ?????? ?????? 
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
		 var tenn_array = new Array();
	     var jqGridFunc  = {
	    		setGrid : function(gridOption){
	    			 var grid = $('#'+gridOption);
	    		    //ajax ?????? ?????? ?????? ?????? 
	    		     var postData = {};
	    		     grid.jqGrid({
	    		    	url : '/backoffice/companyManage/companyListAjax.do' ,
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
	    		 	                { label: 'com_code', key: true, name:'com_code',       index:'com_code',      align:'center', hidden:true},
	    		 	                { label: '', name:'',       index:'checkBox',      align:'center', width:'5%'
	    		 	                  , formatter: jqGridFunc.checkbox},
	    		 	                { label: '??????',  name:'com_logo',         index:'com_logo',        align:'left',   width:'12%', formatter: jqGridFunc.imageFomatter },
	    			                { label: '?????????', name:'com_name',       index:'com_name',      align:'center', width:'10%'},
	    			                { label: '??????', name:'com_gubun_txt',     index:'com_gubun_txt',      align:'center', width:'10%'},
	    			                { label: '????????????', name:'code_nm',     index:'com_gubun_txt',      align:'center', width:'10%'},
	    			                { label: '??????', name:'center_nm',       index:'center_nm',      align:'center', width:'10%'},
	    			                { label: '????????????', name:'floor_name',       index:'floor_name',      align:'center', width:'10%'},
	    			                { label: '??????????????????', name:'floor_nm',       index:'floor_nm',      align:'center', width:'10%'},
	    			                { label: '????????????', name:'com_ceo_name',       index:'com_ceo_name',      align:'center', width:'10%'},
	    			                { label: '??????', name:'com_addr',       index:'com_addr',      align:'center', width:'20%', formatter:jqGridFunc.address },
	    			                { label: '????????? ??????', name:'tenn_info',       index:'tenn_info',      align:'center', width:'10%'},
	    			                { label: '??? ????????? ??????', name:'com_tennent_cnt',       index:'com_tennent_cnt',      align:'center', width:'10%'},
	    			                { label: '?????? ?????????', name:'com_updateid',      index:'com_updateid',     align:'center', width:'14%'},
	    			                { label: '?????? ?????? ??????', name:'com_update', index:'com_update', align:'center', width:'12%', 
	    			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
	    			                { label: '??????', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : false, formatter:jqGridFunc.rowBtn}
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
	    		        multiselect:false, 
	    		        subGrid: true,
	    		        //?????? ?????? ?????? ?????? 
	    		        subGridRowExpanded: function(subgrid_id, row_id) {
	    		        	var param = {"comCode" : row_id, "pageIndex" : fn_emptyReplace($("#pageIndex").val(), "1"), "pageSize" : "100" }
	    		        	var subgrid_table_id, pager_id;
	    		            subgrid_table_id = subgrid_id+"_t";
	    		            pager_id = "p_"+subgrid_table_id;
	    		            jQuery("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
	    		            
	    		            jQuery("#"+subgrid_table_id).jqGrid({
	    		                url:"/backoffice/companyManage/userListAjax.do",
	    		                mtype :  'POST',
	    	    		        datatype :'json',
	    		                
	    		                ajaxGridOptions: { contentType: "application/json; charset=UTF-8" },
	    	    		        ajaxRowOptions: { contentType: "application/json; charset=UTF-8", async: true },
	    	    		        ajaxSelectOptions: { contentType: "application/json; charset=UTF-8", dataType: "JSON" }, 
	    	    		        
	    	    		        postData :  JSON.stringify(param),
	    	    		        jsonReader : {
	   		   		             root : 'resultlist',
	   		   		             "page":"paginationInfo.currentPageNo",
	   		   		             "total":"paginationInfo.totalPageCount",
	   		   		             "records":"paginationInfo.totalRecordCount",
	   		   		             repeatitems:false
	   		   		             
	   	   		                },
	    		                colModel :  [
	    		 	                { label: '??????', name:'code_nm',       index:'code_nm',      align:'center', width:'10%'},
	    		 	                { label: '?????????', name:'com_name',     index:'com_name',      align:'center', width:'10%'},
	    		 	                { label: '????????? ??????', name:'code_nm',     index:'com_name',      align:'center', width:'10%'},
	    		 	                { label: '??????', name:'user_no',       index:'user_no',      align:'center', width:'10%'},
	    		 	                { label: '??????', name:'user_name',       index:'user_name',      align:'center', width:'10%'},
	    			                { label: '??????', name:'user_position',   index:'user_position',      align:'center', width:'10%' },
	    			                { label: '??????', name:'user_rank',       index:'user_rank',      align:'center', width:'10%' },
	    			                { label: '?????????', name:'user_email',     index:'user_email',      align:'center', width:'10%' },
	    			                { label: '?????????', name:'user_cellphone', index:'user_cellphone',      align:'center', width:'10%' },
	    			                { label: '?????? ?????????', name:'user_updateid', index:'user_updateid',     align:'center', width:'10%'},
	    			                { label: '?????? ?????? ??????', name:'user_update', index:'com_update', align:'center', width:'12%', 
	    			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
	    			                { label: '??????', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : false, formatter:userFunc.rowBtn}
	    			            ],  //????????? 
	    			            rowNum : 20, 
	    		                height: '100%',
	    		                pager: pager_id,
	    		                autowidth:true,
	    	    		        shrinkToFit : true,
	    	    		        refresh : true,
	    		                rowNum:20,
	    		                sortname: 'user_update',
	    		                sortorder: "asc",
	    		                onCellSelect : function (rowid, index, contents, action){
	    	    	            	var cm = $(this).jqGrid('getGridParam', 'colModel');
	    	    	                //console.log(cm);
	    	    	                if (cm[index].name=='com_name' || cm[index].name=='user_no' ){
	    	    	                	userFunc.fn_userInfo("Edt", $(this).jqGrid('getCell', rowid, 'user_no'));
	    	            		    }
	    	    	                
	    	    	            },loadComplete : function (data){
	    	    	            	console.log(data.regist.comCode);
	    	    	            	$("#comCode").val(data.regist.comCode);
	    	    	            	$("#"+subgrid_table_id+"_btn").click(function() {
	    	    	                    //event
	    	    	                    userFunc.fn_userInfo('Ins','0', data.regist.comCode);
	    	    	                });
	    	    		        },refreshGrid : function(){
	    	    		        	$('#'+ subgrid_id).jqGrid().trigger("reloadGrid");
	    	    	            }
	    		             });
	    		             
	    		             
	    		          
	    		        },loadComplete : function (data){
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
		    		          	  postData : JSON.stringify({
							    		          			"pageIndex": gridPage,
							    		          			"mode" : $("#searchMode").val(),
							    			          		"searchCenter" :  $("#searchCenter").val(),
							    			          		"searchFloorSeq" : $("#searchFloorSeq").val(),
							    		         			"searchKeyword" : $("#searchKeyword").val(),
							    		          			"pageUnit":$('.ui-pg-selbox option:selected').val()
							    		          		    })
	    		          	 }).trigger("reloadGrid");
	    		        },onSelectRow: function(rowId){
	    		        	
	    	                if(rowId != null) { 
	    	                   //?????? ?????? ?????? ?????? ????????? ?????? ?????? ?????? ??? ?????? 	
	    	                	
	    	                }// ?????? ??????
	    	            },ondblClickRow : function(rowid, iRow, iCol, e){
	    	            	grid.jqGrid('editRow', rowid, {keys: true});
	    	            },onCellSelect : function (rowid, index, contents, action){
	    	            	var cm = $(this).jqGrid('getGridParam', 'colModel');
	    	                if (cm[index].name=='com_name'){
	    	                	jqGridFunc.fn_ComInfo("Edt", $(this).jqGrid('getCell', rowid, 'com_code'));
	            		    }
	    	                
	    	            }
	    		    });
	    	   }, checkbox : function(cellvalue, options, rowObject){
	    		    var str = "<input type=\"checkbox\" id=\"jqg_"+rowObject.com_code+"\" name=\"chk\" value=jqg_"+rowObject.com_code+">";
	    		    return str;
	    	   }, imageFomatter: function(cellvalue, options, rowObject){
	     		   var centerImg = (rowObject.center_img == "no_image.gif") ? "/img/no_image.gif": "/upload/"+ rowObject.com_logo;
	     		   return '<img src="' + centerImg + ' " style="width:120px">';
	     	   }, address : function(cellvalue, options, rowObject){
	     		   return rowObject.com_zipcode + "<br>"+ CommonJsUtil.NVL(rowObject.com_addr1) +"  "+ CommonJsUtil.NVL( rowObject.com_addr2)
	     	   },rowBtn: function (cellvalue, options, rowObject){
	               if (rowObject.com_code != "")
	            	   return '<a href="javascript:jqGridFunc.delRow(&#34;'+rowObject.com_code+'&#34;);">??????</a>';
	           }, refreshGrid : function(){
		        	$('#mainGrid').jqGrid().trigger("reloadGrid");
		       }, delRow : function (com_code){
	        	    if(com_code != "") {
	        		   var params = {'comCode':com_code };
	        		   fn_uniDelAction("/backoffice/companyManage/companyDelete.do",params, "jqGridFunc.fn_search");
			        }
	           }, fn_ComInfo : function (mode, comCode){
	        	    $("#btn_message").trigger("click");
				    $("#mode").val(mode);
			        $("#comCode").val(comCode);
			        
			        if (mode == "Edt"){
			        	$("#btnUpdate").text("??????");
			        	
			     	   var params = {"comCode" : comCode};
			     	   var url = "/backoffice/companyManage/companyDetail.do";
			     	   uniAjaxSerial(url, params, 
			          			function(result) {
			     				       if (result.status == "LOGIN FAIL"){
			     				    	   location.href="/backoffice/login.do";
			       					   }else if (result.status == "SUCCESS"){
			       						   //??? ????????? ?????? ??????
			       						    var obj  = result.regist;
			       						    $("#comName").val(obj.com_name);
			       						    $("#comGubun").val(obj.com_gubun);
				       						$("#comNumber").val(obj.com_number);
				       						$("#comCeoName").val(obj.com_ceo_name);
				       						$("#comBuscondition").val(obj.com_buscondition);
				       						$("#comItem").val(obj.com_item);
				       						$("#comAddr1").val(obj.com_addr1);
				       						$("#comAddr2").val(obj.com_addr2);
				       						$("#comState").val(obj.com_state);
				       						$("#comTel").val(obj.com_tel);
				       						$("#comState").val(obj.com_state);
								    		$("#comFax").val( obj.com_fax  );
								    		$("#centerId").val( obj.center_id);
								    		$("#comTennentCnt").val(obj.com_tennent_cnt);
								    		
								    		backoffice_common.fn_floorInfo(obj.floor_seq,'sp_floor', 'floorSeq');
								    		backoffice_common.fn_floorPlayState(obj.com_play_floor, "sp_floorCheck", "floorPlaySeq");
								    		toggleClick("tennUseyn", obj.tenn_useyn);
								    		jqGridFunc.fn_TennView();
								       }
			     				    },
			     				    function(request){
			     					    alert("Error:" +request.status );	       						
			     				    }    		
			            );
			        }else {
			        	$("#btnUpdate").text("??????");
			        	$('input:text[name^=com]').val("");
			        	$('select[name^=com]').val("");
			        	$("#centerId").val("");
			        	toggleDefault("tennUseyn");
			        	//??? ??? ?????? ??? ?????? 
			        	$("#sp_floor").html("");
			        	$("#sp_floorCheck").html("");
			        	jqGridFunc.fn_TennView();
			        }
	           },clearGrid : function() {
	                $("#mainGrid").clearGridData();
	           },fn_CheckForm  : function (){
				    if (any_empt_line_id("comName", "???????????? ??????????????????.") == false) return;	
				    if (any_empt_line_id("centerId", "????????? ????????? ?????????.") == false) return;
				    if (any_empt_line_id("floorSeq", "?????? ????????? ?????????.") == false) return;
				    if (any_empt_line_id("comState", "?????? ????????? ????????? ?????????.") == false) return;
				    if (fn_CheckBoxMsg("????????? ????????? ?????? ?????? ???????????????.", "floorPlaySeq") == false) return;	
		     		var commentTxt = ($("#mode").val() == "Ins") ? "?????? ???????????????????":"?????? ???????????????????";
		     		
		     		if (confirm(commentTxt)== true){
		     			  
		     			  //?????? ?????? ?????? ??? ???????????? 
		     			  var formData = new FormData();
		     			  formData.append('comLogo', $('#comLogo')[0].files[0]);
		     			  formData.append('comCode' , $("#comCode").val());
		     			  formData.append('comGubun' , $("#comGubun").val());
		     			  formData.append('comNumber' , $("#comNumber").val());
		     			  formData.append('comName' , $("#comName").val());
		     			  formData.append('comCeoName' , $("#comCeoName").val());
		     			  formData.append('comBuscondition' , $("#comBuscondition").val());
		     			  formData.append('comItem' , $("#comItem").val());
		     			  formData.append('comAddr1' , $("#comAddr1").val());
		     			  formData.append('centerAddr2' , $("#centerAddr2").val());
		     			  formData.append('comAddr2' , $("#comAddr2").val());
		     			  formData.append('comState' , $("#comState").val());
		     			  formData.append('mode' , $("#mode").val());
		     			  formData.append('comTel' , $("#comTel").val());
		     			  formData.append('comFax' , $("#comFax").val());
		     			  formData.append('centerId' , $("#centerId").val());
		     			  formData.append('floorSeq' ,  $("#floorSeq").val());
		     			  formData.append('comPlayFloor' , ckeckboxValue("????????? ????????? ?????? ?????? ???????????????.", "floorPlaySeq"));
		     			  formData.append('tennUseyn' , fn_emptyReplace($("#tennUseyn").val(),"N"));
		     			  formData.append('comTennentCnt' , fn_emptyReplace($("#comTennentCnt").val(),"0"));
		     			  
		     			 
		     			  uniAjaxMutipart("/backoffice/companyManage/companyUpdate.do", formData, 
		     						function(result) {
		     						       //????????? ?????? ?????? ?????? 	
		     		    	               if (result.status == "SUCCESS"){
		     		    	            	  jqGridFunc.fn_search();
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
			  }, fn_comNumber: function (){
				 //????????? ?????? ??????
			  }, fn_search : function(){
				  $("#mainGrid").setGridParam({
	    	    	 datatype	: "json",
	    	    	 postData	: JSON.stringify(  {
	    	    		"pageIndex": $("#pager .ui-pg-input").val(),
	    	    		"mode" : $("#searchMode").val(),
		          		"searchCenter" :  $("#searchCenter").val(),
		          		"searchFloorSeq" : $("#searchFloorSeq").val(),
	         			"searchKeyword" : $("#searchKeyword").val(),
	         			"pageUnit":$('.ui-pg-selbox option:selected').val()
	         		 }),
	    	    	 loadComplete	: function(data) {
	    	    		 $("#sp_totcnt").text(data.paginationInfo.totalRecordCount);
	    	    	 }
	    	      }).trigger("reloadGrid");
			  }, fn_userList :  function(comCode){
				  $("#mainGrid").attr('width', 200);
				  $("#comCode").val(comCode);
				  userFunc.fn_userList(comCode);
			  }, fn_tennUpdate : function (){
				 //?????? ??? ?????? ?????? 
				 if (parseInt($("#tennRecCount").val() ) < 1) {
					 alert("0????????? ????????? ????????? ?????????");
					 return;
				 }
				 if (confirm('?????? ???????????????????')){
					 var tennArray = new Array();
					 for (var i in tenn_array){
						  var TennantInfo = new Object();
						  TennantInfo.comCode = tenn_array[i];
						  TennantInfo.tennRecCount = $("#tennRecCount").val();
						  tennArray.push(TennantInfo);
					 }
					 var param =  new Object();
			         param.data = tennArray;
			         tenn_array = new Array();
			         var url = "/backoffice/companyManage/tennUpdate.do";
				     uniAjax(url, param, 
		   		       	     function(result) {
	   						       if (result.status == "LOGIN FAIL"){
	   						    	   alert(result.meesage);
	   		  						   location.href="/backoffice/login.do";
	   		  					   }else if (result.status == "SUCCESS"){
		   		  					   alert('??????????????? ?????? ???????????????.');
		   		  					   need_close();
		   		  					   jqGridFunc.fn_search();
		   		  					   
		   		  				   }
	   						 },
	   						 function(request){
	   							    alert("Error:" +request.status );	       						
	   						 }    		
		    		 );
				     
				 }
			  }, fn_tennPop : function (){
				  getEquipArray("mainGrid", tenn_array);
				  if (tenn_array.length > 0){
					  $("#tennRecCount").val("0");
					  $("#btn_bpop").trigger("click"); 
				  }else {
					  alert("????????? ?????? ????????????.");
					  return;
				  }
			     
			  }, fn_TennView : function(){
				  //
				  ($("#tennUseyn").val() == "Y") ?  $("#comTennentCnt").show() :$("#comTennentCnt").hide();
			  }, fn_tennReset : function(){
				  //????????? reset
				  var tenn_array = new Array();
				  getEquipArray("mainGrid", tenn_array);
				  if (tenn_array.length < 1){
					  alert("????????? ?????? ????????????.");
					  return;
				  }
				  
				  var params = {"comCode":  tenn_array};
				  
				  var url = "/backoffice/companyManage/tennReset.do";
				  uniAjax(url, params, 
		   		       	     function(result) {
	   						       if (result.status == "LOGIN FAIL"){
	   						    	   alert(result.meesage);
	   		  						   location.href="/backoffice/login.do";
	   		  					   }else if (result.status == "SUCCESS"){
		   		  					   alert('??????????????? ?????? ???????????????.');
		   		  					   jqGridFunc.fn_search();
		   		  				   }
	   						 },
	   						 function(request){
	   							    alert("Error:" +request.status );	       						
	   						 }    		
		    	  );
				  tenn_array = null;
			  }  
	    }
       
	   var userFunc  = {
			    fn_userInfo : function (mode, userNo, comCode){
				   $("#btn_user").trigger("click");
				   $("#mode").val(mode);
				   $("#comCode").val(comCode);
				   if (mode == "Ins"){
					   $("#userNo").attr("style", "width:200px;");
					   $("#sp_uniCheck").html("<a href='javascript:userFunc.fn_uniCheck()'>????????????</a>");
					   $('input:text[name^=user]').val("");
			           $('select[name^=user]').val("");
			           $("#userNo").attr('readonly', false);
			           $('#userState').val("USER_STATE_1");
			           $("#btnUserUpdate").text("??????");
				   }else {
					   $("#sp_uniCheck").text("");
					   $("#btnUserUpdate").text("??????");
					   var url = "/backoffice/companyManage/userDetail.do";
		      		   var param = {"userNo" : userNo };
		      		   uniAjaxSerial(url, param, 
	     		     			function(result) {
	     						       if (result.status == "LOGIN FAIL"){
	     								   location.href="/backoffice/login.do";
	     		  					   }else if (result.status == "SUCCESS"){
	     	                               //????????? ?????? ?????? 
	     	                                var obj = result.regist;
		     		  						$("#userNo").val(obj.user_no);
		     		  						$("#userName").val(obj.user_name);
		     		  						$("#userRank").val(obj.user_rank);
		     		  						$("#userPosition").val(obj.user_position);
		     		  						$("#userCellphone").val(obj.user_cellphone);
		     		  						$("#userEmail").val(obj.user_email);
		     		  						$("#userState").val(obj.user_state);
		     		  						$("#comCode").val(obj.com_code);
		     		  						$("#userNo").attr('readonly', true);
	     		  					   }else{
	     		  						  alert(result.message); 
	     		  					   }
	     						       
	     						},
	  						    function(request){
	  							    alert("Error:" +request.status );	       						
	  						    }    		
	     		       );
				   }
				   
			   },rowBtn: function (cellvalue, options, rowObject){
				   if (rowObject.user_no != "")
	            	   return '<a href="javascript:userFunc.delRow(&#34;'+rowObject.user_no+'&#34;,&#34;'+rowObject.com_code+'&#34;);">??????</a>';
	           },delRow : function (user_no, comCode){
	        	   if(user_no != "") {
	        		   var params = {'userNo':user_no };
	        		   fn_uniDelAction("/backoffice/companyManage/userDelete.do",params, "");
	        		   userFunc.fn_search(comCode);
	        	   }
		       }, fn_userUpdate : function (){
				   if (any_empt_line_id("userNo", "????????? ????????? ?????????.") == false) return;	
				   if ($("#mode").val() == "Ins"){
					   if (fn_UniCheckAlert("uniCheck", "userNo") == false) return;	
				   }
	     		   if (any_empt_line_id("userName", "??????????????? ??????????????????.") == false) return;
	     		   if (any_empt_line_id("userCellphone", "???????????? ????????? ?????????.") == false) return;
	     		   if (any_empt_line_id("userEmail", "???????????? ?????????  ?????????.") == false) return;
	     		   if (any_empt_line_id("userState", "????????? ????????? ?????????.") == false) return;
	     		  
	     		   
	     		  
	     		   var param = {"userNo" : $("#userNo").val(),
		     		     		"userName" : $("#userName").val(),
		     		     		"userRank" : $("#userRank").val(),
		     		     		"userPosition" : $("#userPosition").val(),
		     		     		"userCellphone" : $("#userCellphone").val(),
		     		     		"userEmail" : $("#userEmail").val(),
		     		     		"userState" : $("#userState").val(),
	     				        "mode" : $("#mode").val(),
	     				        "comCode" : $("#comCode").val()
	     		                }
	     			  
	     		   var commentTxt = ($("#mode").val() == "Ins") ? "?????? ???????????????????":"?????? ???????????????????";
	     		   
	     		   if (confirm(commentTxt)== true){
	     			   uniAjax("/backoffice/companyManage/userUpdate.do", param, 
	     		     			function(result) {
	     						       if (result.status == "LOGIN FAIL"){
	     								   location.href="/backoffice/login.do";
	     		  					   }else if (result.status == "SUCCESS"){
	     	                               //????????? ?????? ?????? 
	     		  						   userFunc.fn_search($("#comCode").val());
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
			   }, fn_userDel: function (userNo){
				   var params = {'userNo':userNo };
        		   fn_uniDelAction("/backoffice/companyManage/userDelete.do",params, "userFunc.fn_userList");
			   }, fn_uniCheck: function(){
				   //?????? ?????? 
				   var params = {"userNo" : $("#userNo").val()};
				   fn_uniCheck("/backoffice/companyManage/userUniCheck.do", params, "uniCheck");
			   }, fn_ExcelUpload : function(){
				   //?????? ????????? 
			   },fn_search : function(gridId){
				 $("#mainGrid_"+gridId+"_t").setGridParam({
		    	    	 datatype	: "json",
		    	    	 postData	: JSON.stringify(  {
		    	    		"comCode" : gridId,
		          			"pageIndex": 1,
		         		 }),
		    	    	 loadComplete	: function(data) {
		    	    	 }
			      }).trigger("reloadGrid");
			   }
	   }
  </script>
</form:form>
    <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>??????1</button>
    <button id="btn_user" style="display:none" data-needpopup-show='#dv_userInfo'>??????2</button>
    <button id="btn_needPopHide" style="display:none" >hide</button>
    <button id="btn_bpop" style="display:none" data-needpopup-show='#dv_tennPopup'>????????? ??????</button>
</div>
</body>
</html>