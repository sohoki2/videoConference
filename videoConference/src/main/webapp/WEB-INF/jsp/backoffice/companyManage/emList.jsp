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
	<script type="text/javascript" src="/js/back_common.js"></script>
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
    		    	url : '/backoffice/orgManage/empListAjax.do' ,
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
    		 	                { label: 'empno', key: true, name:'empno',       index:'empno',      align:'center', hidden:true},
    			                { label: '?????????',  name:'empid',         index:'empid',        align:'left',   width:'10%'},
    			                { label: '??????',  name:'empno',         index:'empno',        align:'left',   width:'10%'},
							    { label: '??????',  name:'empname',         index:'empname',        align:'left',   width:'10%'},
    			                { label: '?????????',  name:'deptname',         index:'deptname',        align:'left',   width:'10%'},
    			                { label: '??????', name:'empgrad',       index:'empgrad',      align:'center', width:'15%'},
    			                { label: '??????', name:'empjikw',       index:'empjikw',      align:'center', width:'15%'},
    			                { label: '????????????', name:'emptelphone',       index:'emptelphone',      align:'center', width:'15%'},
    			                { label: '?????????', name:'empmail',       index:'empmail',      align:'center', width:'15%'},
    			                { label: '?????????', name:'emphandphone',       index:'emphandphone',      align:'center', width:'15%'},
    			                { label: '??????????????????', name:'pre_workinfo', index:'pre_workinfo',      align:'center', width:'10%' },
    			                { label: '??????????????????', name:'now_workinfo', index:'now_workinfo',      align:'center', width:'10%' },
    			                { label: '??????', name:'emp_state', index:'emp_state',      align:'center', width:'10%' },
    			                { label: '?????? ?????? ??????', name:'update_date', index:'update_date', align:'center', width:'12%', 
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
							    		          			"searchKeyword" : $("#searchKeyword").val(),
							    		           			"searchCondition" : $("#searchCondition").val(),
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
    	                if (cm[index].name=='empno' || cm[index].name=='deptname' || cm[index].name=='empid' || cm[index].name=='empname'){
    	                	jqGridFunc.fn_employInfo("Edt", $(this).jqGrid('getCell', rowid, 'empno'));
            		    }
    	            }
    		    });
    	   },rowBtn: function (cellvalue, options, rowObject){
            	 if (rowObject.empno != "")
            	    	return '<a href="javascript:jqGridFunc.delRow('+rowObject.empno+');">??????</a>';
           }, refreshGrid : function(){
	        	$('#mainGrid').jqGrid().trigger("reloadGrid");
	       }, delRow : function (empno){
        	    if(empno != "") {
        		   var params = {'empno':empno };
        		   fn_uniDelAction("/backoffice/orgManage/emDelete.do",params, "jqGridFunc.fn_search");
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
           }, fn_employInfo : function (mode, empno){
        	    $("#btn_message").trigger("click");
			    $("#mode").val(mode);
		        $("#empno").val(empno);
		        if (mode == "Edt"){
		        	$("#btnUpdate").text("??????");
		        	$("#sp_unicheck").html("");
		     	    var params = "empno="+$("#empno").val();
		     	    var url = "/backoffice/orgManage/empDetail.do";
		     	    uniAjaxSerial(url, params, 
		          			function(result) {
		     				       if (result.status == "LOGIN FAIL"){
		     				    	   alert(result.meesage);
		       						   location.href="/backoffice/login.do";
		       					   }else if (result.status == "SUCCESS"){
		       						  //??? ????????? ?????? ??????
		       						  var obj  = result.regist;
		       						  $("#empno").attr('readonly', true);
		       						  $("#empid").val(obj.empid);
		       						  $("#empname").val(obj.empname);
		       						  $("#deptname").val(obj.deptname);
		       						  $("#empgrad").val(obj.empgrad);
		       						  $("#emptelphone").val(obj.emptelphone);
		       						  $("#emphandphone").val(obj.emphandphone);
		       						  $("#empmail").val(obj.empmail);
		       						  $("#empState").val(obj.empState);
					    			  $("#preWorkinfo").val(obj.preWorkinfo);
					    			  $("#nowWorkinfo").val(obj.nowWorkinfo);
		       					   }
		     				    },
		     				    function(request){
		     					    alert("Error:" +request.status );	       						
		     				    }    		
		               );
		        }else{
		        	 $("#empno").val("");
					 $("#empid").val("");
					 $("#empname").val("");
					 $("#deptname").val("");
					 $("#empgrad").val("");
					 $("#emptelphone").val("");
					 $("#emphandphone").val("");
					 $("#empmail").val("");
					 $("#empState").val("");
	    			 $("#preWorkinfo").val("");
	    			 $("#nowWorkinfo").val("");
	    			
	    			 $("#sp_unicheck").html("<a href='javascript:jqGridFunc.fn_uniCheck()'>????????????</a>");
		        }
           },clearGrid : function() {
               $("#mainGrid").clearGridData();
           },fn_CheckForm  : function (){
			     if (any_empt_line_id("empno", "????????? ??????????????????.") == false) return;		
		    	 if (any_empt_line_id("empname", "????????? ??????????????????.") == false) return;	
		    	 if (any_empt_line_id("preWorkinfo", "?????? ?????? ????????? ??????????????????.") == false) return;	
		    	 if ($("#mode").val() == "Ins"){
	    			 if (any_empt_line_id("uniCheck", "????????? ????????? ?????? ???????????????.") == false) return;
	    		 }
		    	 //?????? 
		    	 var url = "/backoffice/orgManage/employUpdate.do";
		    	 var params = {  'empno' : $("#empno").val(),
				    			 'empid' : $("#empid").val(),
				    			 'empname' : $("#empname").val(),
				    			 'deptname' : $("#deptname").val(),
				    			 'empgrad' : $("#empgrad").val(),
				    			 'emptelphone' : $("#emptelphone").val(),
				    			 'emphandphone' : $("#emphandphone").val(),
				    			 'empmail' : $("#empmail").val(),
				    			 'empState' : $("#empState").val(),
				    			 'preWorkinfo' : $("#preWorkinfo").val(),
				    			 'nowWorkinfo' : $("#nowWorkinfo").val(),
				    			 'mode' : $("#mode").val()
				 }; 
		    	 uniAjax(url, params, 
		      			function(result) {
		 				       if (result.status == "LOGIN FAIL"){
		 				    	   alert(result.meesage);
		   						   location.href="/backoffice/login.do";
		   					   }else if (result.status == "SUCCESS"){
		   						   //??? ????????? ?????? ??????
		   						   need_close();
		   						   $('#mainGrid').jqGrid().trigger("reloadGrid");
		   					   }else {
                                   alert(result.meesage);
							   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }    		
		           );
		  },fn_uniCheck : function(){
			 //?????? ?????? 
			  var params = {"empno" : $("#empno").val()};
			  fn_uniCheck("/backoffice/orgManage/IdCheck.do", params, "uniCheck");
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
<input type="hidden" name="uniCheck" id="uniCheck">

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span> <spring:message code="menu.menu01" /><span>></span>
                        <strong>?????? ??????</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle"></div>
                <section class="Bclear">
                   <table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<td>
		                		<select name="searchCondition"  id="searchCondition">
									<option value="">??????</option>
									<option value="empid">?????????</option>
									<option value="empno">??????</option>
									<option value="empname">??????</option>
								</select>
								<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword" > 
								 <a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">??????</span></a>
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:jqGridFunc.fn_employInfo('Ins','0')" ><span class="deepBtn">??????</span></a>
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
            <h2>???????????? ??????</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// ?????? ????????????-->
            <table class="pop_table thStyle" id="tb_managerInfo">
                <tbody>
                    <tr>
                        <th><span class="redText">*</span>??????<br>?????????</th>
                        <td style="text-align:left">
                        <input type="text" name="empno" id="empno" size="30" style="width:100px;" /><span id="sp_unicheck" ></span><br/>
                        <input type="text" id="empid" name="empid" size="30" style="width:140px;" />
                        </td>
                        <th><span class="redText">*</span>??????</th>
                        <td style="text-align:left">
	                        <input type="text"  name="empname" size="30" id="empname" style="width:200px;" />
				            <span id="sp_empcheck" ></span>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">*</span>??????</th>
                        <td style="text-align:left">
                        	<input type="text" name="deptname" id="deptname"  size="30" style="width:200px;"/>
				       	</td>
                       	<th><span class="redText">*</span>??????</th>
                        <td style="text-align:left">
                            <input type="text" name="empgrad" id="empgrad" size="30" style="width:200px;"   />
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">*</span>????????????</th>
                        <td style="text-align:left">
                            <input type="text" id="emptelphone" name="emptelphone"  title="????????????" size="30" style="width:200px;" />
                        </td>
                        <th><span class="redText">*</span>?????????</th>
                        <td style="text-align:left">
                            <input type="text" name="emphandphone" id="emphandphone" title="?????????"  size="30" style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">*</span>?????????</th>
                        <td style="text-align:left">
                        <input type="text" name="empmail" id="empmail" style="width:200px;" /></td>
                        <th><span class="redText">*</span>??????</th>
                        <td style="text-align:left">
                            <select id="empState" name="empState" style="width:200px">
                                 <option value=""> ??????</option>
		                         <c:forEach items="${empstate}" var="state">
		                            <option value="${state.code}">${state.codeNm}</option>
		                         </c:forEach>
                            </select>	
                        </td>
                    </tr>
                    <tr>
                        <th><span class="redText">*</span>??? ????????????</th>
                        <td style="text-align:left">
                            <select id="preWorkinfo" name="preWorkinfo" style="width:200px">
                                 <option value=""> ??????</option>
		                         <c:forEach items="${preworkstate}" var="pre">
		                            <option value="${pre.code}">${pre.codeNm}</option>
		                         </c:forEach>
                            </select>	
                        </td>
                        <th><span class="redText">*</span>?????? ?????? ??????</th>
                        <td style="text-align:left">
                            <select id="nowWorkinfo" name="nowWorkinfo" style="width:200px">
                                 <option value=""> ??????</option>
		                         <c:forEach items="${nowworkstate}" var="now">
		                            <option value="${now.code}">${now.codeNm}</option>
		                         </c:forEach>
                            </select>	
                        </td>
                    </tr>
                </tbody>
            </table>  
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">????????? ?????? ????????? ??????????????????.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  

   <script src="/js/needpopup.js"></script> 
   <script src="/js/jquery-ui.js"></script>

</form:form>
    <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>??????1</button>
    <button id="btn_needPopHide" style="display:none" >hide</button>
    
</div>
 
</body>
</html>