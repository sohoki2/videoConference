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
    <link rel="stylesheet" type="text/css" href="/css/toggle.css">
    
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
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
    		    //ajax 관련 내용 정리 하기 
    		
                var postData = {};
    		    grid.jqGrid({
    		    	url : '/backoffice/basicManage/holyDayListAjax.do' ,
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
    		 	                { label: 'holy_day', key: true, name:'holy_day',       index:'msg_seq',      align:'center', hidden:true},
    			                { label: '휴일',  name:'holy_day',         index:'holy_day',        align:'left',   width:'12%'},
    			                { label: '휴일 타이틀', name:'holy_title',       index:'holy_title',      align:'center', width:'50%'},
    			                { label: '사용유무', name:'holy_useyn',       index:'holy_useyn',      align:'center', width:'10%'},
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
    		        height : "100%",
    		        autowidth:true,
    		        shrinkToFit : true,
    		        refresh : true,
    		        loadComplete : function (data){
    		        	
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
    	                
    	                if (cm[index].name=='holy_title'){
    	                	jqGridFunc.fn_HolyInfo("Edt", $(this).jqGrid('getCell', rowid, 'holy_day'));
            		    }
    	            }
    		    });
    		},rowBtn: function (cellvalue, options, rowObject){
            	 if (rowObject.msg_seq != "")
            	    	return '<a href="javascript:jqGridFunc.delRow('+rowObject.msg_seq+');">삭제</a>';
           },refreshGrid : function(){
	        	$('#mainGrid').jqGrid().trigger("reloadGrid");
	       },delRow : function (holyDay){
        	    if(holyDay != "") {
        		   var params = {'holyDay':holyDay };
        		   fn_uniDelAction("/backoffice/holyDayDelete/holyDayDelete.do",params, "jqGridFunc.fn_search");
		        }
           },fn_HolyInfo : function (mode, holyDay){
        	    $("#btn_message").trigger("click");
        	    $("#mode").val(mode);
		        $("#holyDay").val(holyDay);
		        if (mode == "Edt"){
		           $("#btnUpdate").text("수정");
		           var params = {"holyDay" : holyDay};
		     	   var url = "/backoffice/basicManage/holyDayView.do";
		     	   uniAjaxSerial(url, params, 
		          			function(result) {
		     				       if (result.status == "LOGIN FAIL"){
		     				    	   alert(result.meesage);
		       						   location.href="/backoffice/login.do";
		       					   }else if (result.status == "SUCCESS"){
		       						   //총 게시물 정리 하기
		       						    var obj  = result.regist;
		       						    $("#holyDay").val(obj.holy_day).attr('readonly', true);
							    		$("#holyTitle").val(obj.holy_title);
							    		toggleClick("holyUseyn", obj.holy_useyn);
		       					   }
		     				    },
		     				    function(request){
		     					    alert("Error:" +request.status );	       						
		     				    }    		
		               );
		        }else{
		        	$('input[name^=holy]').val("");
		        	toggleDefault("holyUseyn");
		        }
           },clearGrid : function() {
               $("#mainGrid").clearGridData();
           },fn_CheckForm  : function (){
			     if (any_empt_line_id("holyDay", "휴일을 입력해주세요.") == false) return;		
		    	 if (any_empt_line_id("holyTitle", "휴일 타이틀을 입력해주세요.") == false) return;		
		    	 //확인 
		    	 var url = "/backoffice/basicManage/holyDayUpdate.do";
		    	 var params = { 'holyDay' : $("#holyDay").val(),
				    			'holyTitle' : $("#holyTitle").val(),
				    		   'holyUseyn' :  fn_emptyReplace($('#holyUseyn').val(),"Y"),
				    			'mode' : $("#mode").val()
		    	 }; 
		    	 uniAjax(url, params, 
		      			function(result) {
		 				       if (result.status == "LOGIN FAIL"){
		 				    	   alert(result.meesage);
		   						   location.href="/backoffice/login.do";
		   					   }else if (result.status == "SUCCESS"){
		   						   //총 게시물 정리 하기
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
	          			"searchKeyword" : $("#searchKeyword").val(),
	         			"pageUnit":$('.ui-pg-selbox option:selected').val()
	         		}),
	    	    	loadComplete	: function(data) {$("#sp_totcnt").text(data.paginationInfo.totalRecordCount);}
	    	  }).trigger("reloadGrid");
		 }   
    }
  </script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/msgList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="mode" id="mode" >

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span> <spring:message code="menu.menu01" /><span>></span>
                        <strong>휴일 관리</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">총 <span id="sp_totcnt" /> 휴일수 </div>
                <section class="Bclear">
                   
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>
		                		검색어
		                	</th>
		                	<td>
			                	<input   size="10" maxlength="20" id="searchStartDay" style="cursor:default;" class="date-picker-input-type-text" readonly="true"  />
			                     ~
			                    <input   size="10" maxlength="20" id="searchEndDay" style="cursor:default;"  class="date-picker-input-type-text" readonly="true" />
			                    
		                		<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword" > 
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">조회</span></a>
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:jqGridFunc.fn_HolyInfo('Ins','0')" ><span class="deepBtn">등록</span></a>
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
            <h2>휴일 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*휴일일자 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" name="holyDay" id="holyDay" class="input_noti" size="10"/>
                    
                </div>                
            </div>
            <div class="pop_box1000">
                <div class="padding15">
                    <p class="pop_tit">휴일 내용 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" name="holyTitle" id="holyTitle" class="input_noti" size="10"/>
                </div>                
            </div>
      
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="common.UseYn.title" /> <span class="join_id_comment joinSubTxt"></span></p>
                       <label class="switch">                                               
	                    	<input type="checkbox" id="holyUseyn" name="holyUseyn" onclick="toggleValue(this)" value="Y">
		                    <span class="slider round"></span> 
				       </label>
                </div>                
            </div>
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  
   
 </form:form>
 <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>확인1</button>
    
</div>

<script src="/js/needpopup.js"></script> 
<script src="/js/jquery-ui.js"></script>
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