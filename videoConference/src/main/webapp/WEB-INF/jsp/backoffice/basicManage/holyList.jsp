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
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/holyList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="holySeq" id="holySeq" >

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                        ????????????
                        <span>></span>
                        <strong>??????????????????</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">??? <span>${totalCnt}</span>?????? ???????????? ???????????? ????????????.</div>
                
                <section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>
		                		?????????
		                	</th>
		                	<td>
		                		<select name="searchCondition"  id="searchCondition">
									<option value="0">??????</option>
									<option value="1" <c:if test="${searchVO.searchCondition == '1' }"> selected="selected" </c:if>>??????</option>
									<option value="2" <c:if test="${searchVO.searchCondition == '2' }"> selected="selected" </c:if>>??????</option>
								</select>	
								<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}">     
								<a href="javascript:search_form();"><span class="searchTableB">??????</span></a>       
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:view_holy('Ins','0')" ><span class="deepBtn">??????</span></a>
		                	</td>		                	
						</tr>
                    </table>                
                <br/>
               
                </section>
            </div>

            <div class="Swrap tableArea">
                <table class="backTable">
                    <thead>
                        <tr>
                            <th>??????</th>
                            <th>?????????</th>
                            <th>????????????</th>
                            <th>????????????</th>
                            <th>??????</th>
                            <th>??????</th>
                            <th>??????</th>
                            <th>??????</th>
                        </tr>
                    </thead>
                    <tbody>
                     <c:forEach items="${resultList }" var="holyInfo" varStatus="status">
                        <tr>
                            <td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
                            <td><a href="javascript:view_holy('Edt','${ holyInfo.holySeq }')" class="underline" >${ holyInfo.holyDate }</a></td>
                            <td><a href="javascript:view_holy('Edt','${ holyInfo.holySeq }')" class="underline" >${ holyInfo.holyNm }</a></td>
                            <td>${ holyInfo.orgName }</td>
                            <td>${holyInfo.posGrdNm }</td>
                            <td>${ holyInfo.empNm }</td>
                            <td>${ holyInfo.empNo }</td>
                            <td><a href="javascript:del_check('${ holyInfo.holySeq }');" class="grayBtn">??????</a></td>
                        </tr>
                      </c:forEach>                        
                    </tbody>
                </table>
            </div>
            <div class="pagenum">
                <div class="pager">
                	<ol>
		                		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />
		                   </ol>
                </div>
            </div>
        </div>
    </div>
</form:form>

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
    		    	url : '/backoffice/basicManage/msgListAjax.do' ,
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
    		 	                { label: 'msg_seq', key: true, name:'msg_seq',       index:'msg_seq',      align:'center', hidden:true},
    			                { label: '???????????????',  name:'msg_gubuntxt',         index:'msg_gubunTxt',        align:'left',   width:'12%'},
    			                { label: '??????', name:'msg_title',       index:'msg_title',      align:'center', width:'50%'},
    			                { label: '????????????', name:'useyn',       index:'UseYn',      align:'center', width:'10%'},
    			                { label: '?????????', name:'msg_update_id',      index:'msg_update_id',     align:'center', width:'14%'},
    			                { label: '?????? ?????? ??????', name:'msg_reg_date', index:'msg_reg_date', align:'center', width:'12%', 
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
    	                if(rowId != null) {  }// ?????? ??????
    	            },ondblClickRow : function(rowid, iRow, iCol, e){
    	            	grid.jqGrid('editRow', rowid, {keys: true});
    	            },onCellSelect : function (rowid, index, contents, action){
    	            	var cm = $(this).jqGrid('getGridParam', 'colModel');
    	                //console.log(cm);
    	                if (cm[index].name=='msg_title'){
    	                	jqGridFunc.fn_MessageInfo("Edt", $(this).jqGrid('getCell', rowid, 'msg_seq'));
            		    }
    	            }
    		    });
    		},rowBtn: function (cellvalue, options, rowObject){
            	 if (rowObject.msg_seq != "")
            	    	return '<a href="javascript:jqGridFunc.delRow('+rowObject.msg_seq+');">??????</a>';
           },refreshGrid : function(){
	        	$('#mainGrid').jqGrid().trigger("reloadGrid");
	       }, delRow : function (msg_seq){
        	    if(msg_seq != "") {
        		   var params = {'msgSeq':msg_seq };
        		   fn_uniDelAction("/backoffice/basicManage/msgDelete.do",params, "jqGridFunc.fn_search");
		        }
           },fn_MessageInfo : function (mode, msgSeq){
        	    $("#btn_message").trigger("click");
			    $("#mode").val(mode);
		        $("#msgSeq").val(msgSeq);
		        if (mode == "Edt"){
		           $("#btnUpdate").text("??????");
		           var params = {"msgSeq" : msgSeq};
		     	   var url = "/backoffice/basicManage/msgDetail.do";
		     	   uniAjaxSerial(url, params, 
		          			function(result) {
		     				       if (result.status == "LOGIN FAIL"){
		     				    	   alert(result.meesage);
		       						   location.href="/backoffice/login.do";
		       					   }else if (result.status == "SUCCESS"){
		       						   //??? ????????? ?????? ??????
		       						    var obj  = result.regist;
		       						      $("#msgTitle").val(obj.msg_title);
							    		   $("#msgGubun").val( obj.msg_gubun  );
							    		   $("#msgContent").val(obj.msg_content);
							    		   toggleClick("useYn", obj.useyn);
							    		   jqGridFunc.fn_contentView();
		       					   }
		     				    },
		     				    function(request){
		     					    alert("Error:" +request.status );	       						
		     				    }    		
		               );
		        }else{
		        	$('input[name^=msg]').val("");
		        	toggleDefault("useYn");
		        }
           },clearGrid : function() {
               $("#mainGrid").clearGridData();
           },fn_contentView : function (){
			  if ($("#msgGubun").val() == "MSG_TYPE_1")
				  $("#dv_message").show();
			  else 
				  $("#dv_message").hide();
		  },fn_CheckForm  : function (){
			     if (any_empt_line_id("msgTitle", "????????? ????????? ??????????????????.") == false) return;		
		    	 if (any_empt_line_id("msgGubun", "????????? ????????? ??????????????????.") == false) return;		
		    	 //?????? 
		    	 var url = "/backoffice/basicManage/msgUpdate.do";
		    	 var params = { 'msgSeq' : $("#msgSeq").val(),
				    			'msgTitle' : $("#msgTitle").val(),
				    		    'msgGubun' : $("#msgGubun").val(),
				    			'msgContent' : $("#msgContent").val(),
				    			'useYn' :  fn_emptyReplace($('#useYn').val(),"Y"),
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
		   						   jqGridFunc.fn_search();
		   					   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }    		
		           );
		  },fn_search: function(){
			  //?????? 
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
  
  
</div>
</body>
</html>