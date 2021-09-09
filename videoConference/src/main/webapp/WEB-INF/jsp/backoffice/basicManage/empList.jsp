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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/new/reset.css"> 
    <link rel="stylesheet" href="/css/needpopup.min.css" />
    <link rel="stylesheet" href="/css/needpopup.css">
    
    <script type="text/javascript" src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/back_common.js"></script>
    <script src="/js/popup.js"></script>   
    <link rel="stylesheet" type="text/css" href="/css/toggle.css">
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
    
    <!--  react 정리 하기  -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script>
    <!--  react 정리 하기  -->
    
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
		 jqGridFunc.fn_empView("basic");
		 jqGridFunc.setGrid("mainGrid");
	 });
     var jqGridFunc  = {
    		setGrid : function(gridOption){
    			 var grid = $('#'+gridOption);
    		    //ajax 관련 내용 정리 하기 
    		     var postData = {};
    		     grid.jqGrid({
    		    	url : '/backoffice/basicManage/managerListAjax.do' ,
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
    		 	                { label: '부서(직급)', name:'dept_name',       index:'dept_name',      align:'center', width:'10%'},
    		 	                { label: '이름(사번)', name:'admin_name',     index:'admin_name',      align:'center', width:'10%'},
    		 	                { label: '아이디', name:'admin_id',       index:'admin_id',      align:'center', width:'10%'},
    			                { label: '패스워드', name:'admin_password',   index:'admin_password',      align:'center', width:'10%' },
    			                { label: '연락처', name:'admin_tel',       index:'admin_tel',      align:'center', width:'10%' },
    			                { label: '이메일', name:'admin_email',     index:'admin_email',      align:'center', width:'10%' },
    			                { label: '패스워드잠김여부', name:'lock_yn', index:'lock_yn',      align:'center', width:'10%' },
    			                { label: '사용여부', name:'use_yn', index:'use_yn',     align:'center', width:'10%'},
    			                { label: '등록 일자', name:'reg_date', index:'reg_date', align:'center', width:'12%', 
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
							    		          			"searchKeyword" : $("#searchKeyword").val(),
							    		         			"searchCondition" : $("#searchCondition").val(),
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
    	                if (cm[index].name=='admin_name' || cm[index].name=='admin_id' ){
    	                	jqGridFunc.fn_empInfo("Edt", $(this).jqGrid('getCell', rowid, 'admin_id'));
            		    }
    	                
    	            }
    		    });
    	   },rowBtn: function (cellvalue, options, rowObject){
               if (rowObject.admin_id != "")
            	   return '<a href="javascript:jqGridFunc.delRow(&#34;'+rowObject.admin_id+'&#34;);">삭제</a>';
           }, refreshGrid : function(){
	        	$('#mainGrid').jqGrid().trigger("reloadGrid");
	       }, delRow : function (adminId){
        	    if(adminId != "") {
        		   var params = {'adminId':adminId };
        		   fn_uniDelAction("/backoffice/basicManage/managerDelete.do",params, "jqGridFunc.fn_search");
		        }
           }, fn_empInfo : function (mode, adminId){
        	    $("#btn_message").trigger("click");
			    $("#mode").val(mode);
		        $("#adminId").val(adminId);
		        $("#adminPassword").val("");
		        $("#adminPassword2").val("");
		        jqGridFunc.fn_empView("basic");
		        if (mode == "Ins"){  
				   $("#sp_unicheck").html("<a href='javascript:jqGridFunc.fn_uniCheck()'>중복체크</a>");
				   $("#sp_empcheck").html("<a href=\"javascript:jqGridFunc.fn_empView('search')\">사원검색</a>");
				   
				   $('input:text[name^=admin]').val("");
				   $('input:text[name^=dept]').val("");
		           $('select[name^=emp]').val("");
		           $('select[name^=admin]').val("");
		           toggleDefault("useYn");
		        }else {
				   $("#sp_uniCheck").html("");
				   $("#btnUpdate").text("수정");
				   var url = "/backoffice/basicManage/managerDetail.do";
	      		   var param = {"adminId" : adminId };
	      		   uniAjaxSerial(url, param, 
     		     			function(result) {
     						       if (result.status == "LOGIN FAIL"){
     								   location.href="/backoffice/login.do";
     		  					   }else if (result.status == "SUCCESS"){
     	                               //관련자 보여 주기 
     	                                var obj = result.regist;
     	                                $("#adminId").val(obj.admin_id).attr('readonly', true);
	     		  						$("#empNo").val(obj.emp_no);
	     		  						$("#adminName").val(obj.admin_name);
	     		  						$("#deptName").val(obj.dept_name);
	     		  						$("#deptId").val(obj.dept_id);
	     		  						
	     		  						$("#adminTel").val(obj.admin_tel);
	     		  						$("#adminEmail").val(obj.admin_email);
	     		  						$("#authorCode").val(obj.author_code);
	     		  						toggleClick("useYn", obj.use_yn);
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
        	   if ($("#mode").val() == "Ins"){
    			   if (any_empt_line_id("empNo", "사번을 검색 하지 않았습니다.") == false) return;
    			   if (any_empt_line_id("uniCheck", "아이디 중복을 하지 않았습니다.") == false) return;
    		   }
    		   if (any_empt_line_id("adminTel", "연락처를 입력 하지 않았습니다.") == false) return;	  
    		   if ($("#mode").val() == "Ins" ||  $("#adminPassword").val()  != ""){
    			   if (any_empt_line_id("adminPassword", "비밀번호를 입력해주세요.") == false) return;	  
    			   if (any_empt_line_id("adminPassword2", "비밀번호를 입력해주세요.") == false) return;	  
    			   if ( $.trim($('#adminPassword').val()) !=   $.trim($('#adminPassword2').val())  ){
    				   alert("비밀 번호가 일치 하지 않습니다.");
    				   return;
    			   }
    		   }
    		   if (any_empt_line_id("adminEmail", "이메일을 입력 하지 않았습니다.") == false) return;	 
    		   if (any_empt_line_id("authorCode", "관리자구분을 선택 하지 않았습니다.") == false) return;	 
    		   	   	
    		   if (confirm("등록 하시겠습니까?")== true){
    			   var param = {"mode" : $("#mode").val(), 
    					        "deptId" : $("#deptId").val(),  
    					        "empNo" : $("#empNo").val(),  
    					        "adminName" : $("#adminName").val(),  
    					        "deptName" : $("#deptName").val(),  
    					        "adminId" : $("#adminId").val(),  
    					        "adminTel" : $("#adminTel").val(), 
    					        //"adminPassword" : SHA256(SHA256($("#adminPassword").val())) , 
    					        "adminPassword" : $("#adminPassword").val() , 
    					        "adminEmail" : $("#adminEmail").val(), 
    					        "authorCode" : $("#authorCode").val(), 
    					        "useYn" : fn_emptyReplace($("#useYn").val(),"Y")	 
    			                };
    			      var url = "/backoffice/basicManage/managerUpdate.do";
    				  uniAjax(url, param, 
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
    					               need_close();
    							    },
    							    function(request){
    								    alert("Error:" +request.status );	       						
    							    }    		
    			      );
    		   }else{
    			   return;
    		   }
		  }, fn_search : function(){
			   $("#mainGrid").setGridParam({
    	    	 datatype	: "json",
    	    	 postData	: JSON.stringify(  {
          			"pageIndex": 1,
         			"searchKeyword" : $("#searchKeyword").val(),
         			"searchCondition" : $("#searchCondition").val(),
         			"pageUnit":$('.ui-pg-selbox option:selected').val()
         		 }),
    	    	 loadComplete	: function(data) {
    	    		 $("#sp_totcnt").text(data.paginationInfo.totalRecordCount);
    	    		 
    	    	 }
    	       }).trigger("reloadGrid");
		  },  fn_avayaUpdate : function(){
			    uniAjax("/backoffice/backoffice/avayaUpdate.do", null, 
			     			function(result) {
					               if (result.status == "LOGIN FAIL"){
							    	   alert(result.message);
			  						   location.href="/backoffice/login.do";
			  					   }else if (result.status == "SUCCESS"){
										alert("정상적으로 업데이트 되었습니다.");
								   }else if (result.status == "NO_UPDATE") {
										alert("업데이트 할 내요이 없습니다.");
								   }else {
										alert("업데이트 도중 문제가 발생 하였습니다.");
								   }	
							 },
							 function(request){
								    alert("Error:" +request.status );	       						
							 }    		
			     );
		  }, fn_uniCheck : function(){
			 //중복 체크 
			  var params = {"adminId" : $("#adminId").val()};
			  fn_uniCheck("/backoffice/basicManage/IdCheck.do", params, "uniCheck");
		  }, fn_empView : function (mode){
			  if (mode == "search"){
				  $("#emSearchKeyword").val("");
				  
				  $("#tb_empList > tbody").empty();
				  $("#tb_managerInfo").hide();
				  $("#dv_empInfo").show(); 
			  }else {
				  $("#tb_managerInfo").show();
				  $("#dv_empInfo").hide(); 
			  }
		  }, fn_empChoice : function (deptname, empname, empno, empid, empmail, deptcode, emptelphone){
			  $("#deptName").removeAttr();
			  $("#adminName").removeAttr();
			  $("#deptName").val(deptname);
			  $("#adminName").val(empname);
			  
			  $("#deptName").attr("readonly",true);
			  $("#adminName").attr("readonly",true);
			  $("#adminId").val(empid);
			  $("#empNo").val(empno);
			  $("#adminEmail").val(empmail);
			  $("#deptId").val(deptcode);
			  $("#adminTel").val(emptelphone); 
			  // 보여 주기 
			  $("#authorCode").val("ROLE_ADMIN");
			  toggleClick("useYn", "Y");
			  jqGridFunc.fn_empView("basic");
		  },fn_empSearch : function(){
			  //직원 조회
			  var params = {"searchCondition" : $("#emSearchCondition").val(), "searchKeyword" : $("#emSearchKeyword").val(), "mode" : "pop" };
			  uniAjax("/backoffice/orgManage/empListAjax.do", params, 
		     			function(result) {
				               if (result.status == "LOGIN FAIL"){
						    	   alert(result.message);
		  						   location.href="/backoffice/login.do";
		  					   }else if (result.status == "SUCCESS"){
								   $("#tb_searchform > tbody").empty();
								   var obj = result.resultlist;
								   var shtml = ""
								   for (var i in obj){
									   shtml= "<tr onclick=\"jqGridFunc.fn_empChoice('" + obj[i].deptname +"','"+obj[i].empname+"','" + obj[i].empno +"','"+obj[i].empno+"','"+obj[i].empmail+"','"+obj[i].deptcode+"','"+obj[i].emptelphone+"')\">"
										    + " <td>" + obj[i].deptname +"</td>"
										    + " <td>" + obj[i].empname +"</td>"
										    + " <td>" + obj[i].empno +"</td>"
									        + "</tr>";
									   $("#tb_searchform > tbody").append(shtml);
		  						       sHtml = "";  
								   }
							   }else {
									alert("업데이트 도중 문제가 발생 하였습니다.");
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
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/empList.do">	   	  
<c:import url="/backoffice/inc/top_inc.do" />	
 
<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="uniCheck" id="uniCheck">
<input type="hidden" name="mode" id="mode">

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>기초관리<span>></span><strong>관리자관리</strong>
                    </div>
                </div>
            </div>
            <div class="Swrap Asearch">
                <div class="Atitle"></div>
                <section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th style="width:140px">
		                		검색어
		                	</th>
		                	<td>
		                		<select name="searchCondition"  id="searchCondition">
											<option value="ALL">전체</option>
											<option value="ADMIN_ID">아이디</option>
											<option value="ADMIN_NM">이름</option>
								</select>
								<input class="nameB" type="text" name="searchKeyword" id="searchKeyword" />      
								 <a href="javascript:jqGridFunc.fn_search();"><span class="lightgrayBtn">조회</span></a>      
		                	</td>
		                	
						</tr>
                    </table>
                    <div class="text-right">
                          <a href="#" onclick="jqGridFunc.fn_empInfo('Ins','0')"><span class="blueBtn">등록</span></a>
                          <!-- <a href="#" onclick="jqGridFunc.fn_avayaUpdate()"><span class="lightgrayBtn">인사정보연동</span></a> -->
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
    
    
    <div id='employInfoPop' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>관리자 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <table class="pop_table thStyle" id="tb_managerInfo">
                <tbody>
                    <tr>
                        <th><span class="redText">*</span>아이디</th>
                        <td style="text-align:left">
                        <input type="text" name="adminId" size="30" maxlength="20" id="adminId"   style="width:200px;" />
                        <input type="hidden" size="30" id="empNo"   style="width:240px;" />
                        <span id="sp_unicheck" ></span>
                        </td>
                        <th><span class="redText">*</span>이름(사번)</th>
                        <td style="text-align:left">
	                        <input type="text"  name="adminName" size="30" maxlength="20" id="adminName"   style="width:200px;" />
				            <span id="sp_empcheck" ></span>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">*</span>부서(직급)</th>
                        <td style="text-align:left">
                        	<input type="text" name="deptName" id="deptName" size="30" maxlength="20" id="deptName"   style="width:340px;" disabled="disabled" value="${registInfo.deptName }" />
				       	</td>
                       	<th><span class="redText">*</span>연락처</th>
                        <td style="text-align:left">
                            <input type="text" name="adminTel" id="adminTel" size="30" maxlength="12"  style="width:340px;"   />
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">*</span>비밀번호</th>
                        <td style="text-align:left">
                            <input type="password" id="adminPassword" name="adminPassword"  title="비밀번호" size="30" maxlength="20" style="width:340px;"  onkeydown="if(event.ctrlKey && event.keyCode==86){return false;}"/>
                        </td>
                        <th><span class="redText">*</span>비밀번호확인</th>
                        <td style="text-align:left">
                            <input type="password" name="adminPassword2" id="adminPassword2" title="비밀번호확인"  size="30" maxlength="20" style="width:340px;"  onkeydown="if(event.ctrlKey && event.keyCode==86){return false;}"/>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">*</span>이메일</th>
                        <td style="text-align:left">
                        <input type="text" name="adminEmail" size="30" maxlength="20" id="adminEmail"  style="width:340px;" /></td>
                        <th><span class="redText">*</span>관리자구분</th>
                        <td style="text-align:left">
                            <select id="authorCode" name="authorCode" style="width:340px">
                                 <option value=""> 선택</option>
		                         <c:forEach items="${selectState}" var="auth">
		                            <option value="${auth.authorCode}">${auth.authorNm}</option>
		                         </c:forEach>
                            </select>	
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">사용여부</th>
                        <td style="text-align:left" colspan="3">
                        	<label class="switch">                                               
		                    	<input type="checkbox" id="useYn" onclick="toggleValue(this);" value="Y">
			                    <span class="slider round"></span> 
		                    </label>				
                        </td>
                    </tr>
                </tbody>
            </table>   
            <div class="pop_contents" style="padding-top:8px;" id="dv_empInfo">
	            <div id="dv_searchGubun">
		            <select name="emSearchCondition"  id="emSearchCondition" style="width:120px;">
						<option value="deptname">부서명</option>
						<option value="empname">이름</option>
					</select>
					&nbsp;&nbsp;	
		            <input type="text" name="emSearchKeyword" id="emSearchKeyword" size="10"  style="width:250px;"/>
					<a href="javascript:jqGridFunc.fn_empSearch();"><span class="blueBtn">조회</span></a>
		            <p class="searchP">이름을 선택해 주세요.</p>
	            </div>
				<table class="pop_table thStyle searchT" id="tb_searchform">
					<thead class="search">
						<tr>
							<th style="width:35%">부서명</th>
							<th style="width:20%">이름</th>
							<th style="width:20%">사번</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			
		   </div>
           
                
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  
    
    <button id="btn_message" style="display:none" data-needpopup-show='#employInfoPop'>확인1</button>
<c:import url="/backoffice/inc/bottom_inc.do" />    
</form:form>    
</div>	
</body>
<script src="/js/needpopup.js"></script> 
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
</html>