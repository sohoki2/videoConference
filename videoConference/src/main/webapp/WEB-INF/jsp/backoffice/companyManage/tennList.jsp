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
    		    	url : '/backoffice/companyManage/userListAjax.do' ,
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
    		 	                { label: '상태', name:'code_nm',       index:'code_nm',      align:'center', width:'10%'},
    		 	                { label: '회사명', name:'com_name',     index:'com_name',      align:'center', width:'10%'},
    		 	                { label: '사번', name:'user_no',       index:'user_no',      align:'center', width:'10%'},
    			                { label: '직급', name:'user_position',   index:'user_position',      align:'center', width:'10%' },
    			                { label: '직책', name:'user_rank',       index:'user_rank',      align:'center', width:'10%' },
    			                { label: '이메일', name:'user_email',     index:'user_email',      align:'center', width:'10%' },
    			                { label: '연락처', name:'user_cellphone', index:'user_cellphone',      align:'center', width:'10%' },
    			                { label: '최종 수정자', name:'user_updateid', index:'user_updateid',     align:'center', width:'10%'},
    			                { label: '최종 수정 일자', name:'user_update', index:'com_update', align:'center', width:'12%', 
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
    		        height : "420px",
    		        autowidth:true,
    		        shrinkToFit : true,
    		        refresh : true,
    		        loadComplete : function (data){
    		        	
    		        },loadError:function(xhr, status, error) {
    		            alert("error:" + error); 
    		        }, onPaging: function(pgButton){
    		        	  var gridPage = grid.getGridParam('page'); //get current  page
    		        	  var lastPage = grid.getGridParam("lastpage"); //get last page 
    		        	  var totalPage = grid.getGridParam("total");
    		              if (pgButton == "next"){
    		            	  if (gridPage < totalPage ){
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
    		            	  gridPage = totalPage;
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
    	                if (cm[index].name=='com_name' || cm[index].name=='user_no' ){
    	                	jqGridFunc.fn_userInfo("Edt", $(this).jqGrid('getCell', rowid, 'user_no'));
            		    }
    	                
    	            }
    		    });
    	   },rowBtn: function (cellvalue, options, rowObject){
               if (rowObject.user_no != "")
            	   return '<a href="javascript:jqGridFunc.delRow(&#34;'+rowObject.user_no+'&#34;);">삭제</a>';
           }, refreshGrid : function(){
	        	$('#mainGrid').jqGrid().trigger("reloadGrid");
	       }, delRow : function (user_no){
        	    if(user_no != "") {
        		   var params = {'userNo':user_no };
        		   //여기 수정 
        		   fn_uniDelAction("/backoffice/companyManage/userDelete.do",params, "jqGridFunc.fn_search");
		        }
           }, fn_userInfo : function (mode, userNo){
        	    $("#dv_userInfo").trigger("click");
			    $("#mode").val(mode);
		        $("#userNo").val(userNo);
		        if (mode == "Ins"){
				   $("#userNo").attr("style", "width:200px;");
				   $("#sp_uniCheck").html("<a href='javascript:userFunc.fn_uniCheck()'>중복체크</a>");
				   $('input:text[name^=user]').val("");
		           $('select[name^=user]').val("");
		           
			    }else {
				   $("#sp_uniCheck").text("");
				   $("#btnUserUpdate").text("수정");
				   var url = "/backoffice/companyManage/userDetail.do";
	      		   var param = {"userNo" : userNo };
	      		   uniAjaxSerial(url, param, 
     		     			function(result) {
     						       if (result.status == "LOGIN FAIL"){
     								   location.href="/backoffice/login.do";
     		  					   }else if (result.status == "SUCCESS"){
     	                               //관련자 보여 주기 
     	                                var obj = result.regist;
	     		  						$("#userNo").val(obj.user_no);
	     		  						$("#userName").val(obj.user_name);
	     		  						$("#userRank").val(obj.user_rank);
	     		  						$("#userPosition").val(obj.user_position);
	     		  						$("#userCellphone").val(obj.user_cellphone);
	     		  						$("#userEmail").val(obj.user_email);
	     		  						$("#userState").val(obj.user_state);
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
           },clearGrid : function() {
               $("#mainGrid").clearGridData();
           },fn_CheckForm  : function (){
        	   if (any_empt_line_id("userNo", "사번을 입력해 주세요.") == false) return;	
			   if ($("#mode").val() == "Ins"){
				   if (fn_UniCheckAlert("uniCheck", "userNo") == false) return;	
			   }
     		   if (any_empt_line_id("userName", "사용자며을 입력해주세요.") == false) return;
     		   if (any_empt_line_id("userCellphone", "연락처를 기입해 주세요.") == false) return;
     		   if (any_empt_line_id("userEmail", "이메일를 기입해  주세요.") == false) return;
     		   if (any_empt_line_id("userState", "상태를 선택해 주세요.") == false) return;
     		  
     		   
     		  
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
     			  
     		   var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
     		   
     		   if (confirm(commentTxt)== true){
     			   uniAjax("/backoffice/companyManage/userUpdate.do", param, 
     		     			function(result) {
     						       if (result.status == "LOGIN FAIL"){
     								   location.href="/backoffice/login.do";
     		  					   }else if (result.status == "SUCCESS"){
     	                               //관련자 보여 주기 
     		  						  userFunc.fn_userList();
     	                              
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
			 //사업자 등록 번호
		  }, fn_search : function(){
			  $("#mainGrid").setGridParam({
    	    	 datatype	: "json",
    	    	 postData	: JSON.stringify(  {
          			"pageIndex": 1,
         			"searchKeyword" : $("#searchKeyword").val(),
         			"pageUnit":$('.ui-pg-selbox option:selected').val()
         		 }),
    	    	 loadComplete	: function(data) {
    	    		 console.log(data);
    	    	 }
    	      }).trigger("reloadGrid");
		  } 
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
                <section class="Bclear">
                   <table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>검색어</th>
		                	<td>
		                	    <select path="searchCenter" id="searchCenter" title="지점구분">
								         <option value="">지점 선택</option>
				                         <c:forEach items="${searchCenter}" var="centerList">
				                            <option value="${centerList.centerId}">${centerList.centerNm}</option>
				                         </c:forEach>
						    	</select> 
						    	<select id="searchCondition" name="searchCondition">
						    	    <option>선택</option>
						    	    <option value="comName">회사명</option>
						    	    <option value="userName">이름</option>
						    	</select>
		                		<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"> 
								<a href="javascript:search_form();"><span class="searchTableB">조회</span></a>
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
    <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>확인1</button>
    <button id="btn_user" style="display:none" data-needpopup-show='#dv_userInfo'>확인2</button>
    <button id="btn_needPopHide" style="display:none" >hide</button>
    
</div>
</body>
</html>