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
    			                { label: '메세지구분',  name:'msg_gubuntxt',         index:'msg_gubunTxt',        align:'left',   width:'12%'},
    			                { label: '제목', name:'msg_title',       index:'msg_title',      align:'center', width:'50%'},
    			                { label: '사용유무', name:'useyn',       index:'UseYn',      align:'center', width:'10%'},
    			                { label: '작성자', name:'msg_update_id',      index:'msg_update_id',     align:'center', width:'14%'},
    			                { label: '최종 수정 일자', name:'msg_reg_date', index:'msg_reg_date', align:'center', width:'12%', 
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
    	                //console.log(cm);
    	                if (cm[index].name=='msg_title'){
    	                	jqGridFunc.fn_MessageInfo("Edt", $(this).jqGrid('getCell', rowid, 'msg_seq'));
            		    }
    	            }
    		    });
    		},rowBtn: function (cellvalue, options, rowObject){
            	 if (rowObject.msg_seq != "")
            	    	return '<a href="javascript:jqGridFunc.delRow('+rowObject.msg_seq+');">삭제</a>';
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
		           $("#btnUpdate").text("수정");
		           var params = {"msgSeq" : msgSeq};
		     	   var url = "/backoffice/basicManage/msgDetail.do";
		     	   uniAjaxSerial(url, params, 
		          			function(result) {
		     				       if (result.status == "LOGIN FAIL"){
		     				    	   alert(result.meesage);
		       						   location.href="/backoffice/login.do";
		       					   }else if (result.status == "SUCCESS"){
		       						   //총 게시물 정리 하기
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
			     if (any_empt_line_id("msgTitle", "메세지 제목을 입력해주세요.") == false) return;		
		    	 if (any_empt_line_id("msgGubun", "메세지 구분을 선택해주세요.") == false) return;		
		    	 //확인 
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
<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="msgSeq" id="msgSeq" >

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span> <spring:message code="menu.menu01" /><span>></span>
                        <strong>메시지 관리</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle"><spring:message code="page.common.pageCnt"  arguments="${totalCnt}"/></div>
                <section class="Bclear">
                   
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>
		                		검색어
		                	</th>
		                	<td>
		                		<select name="searchCondition"  id="searchCondition">
											<option value="0">전체</option>
											<option value="1" <c:if test="${searchVO.searchCondition == '1' }"> selected="selected" </c:if>>메시지 제목</option>
											<option value="2" <c:if test="${searchVO.searchCondition == '2' }"> selected="selected" </c:if>>발송시점</option>
								</select>
								<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}"> 
								 <a href="javascript:search_form();"><span class="searchTableB">조회</span></a>
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:jqGridFunc.fn_MessageInfo('Ins','0')" ><span class="deepBtn">등록</span></a>
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
            <h2>메세지 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.message.messageGubun" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <form:select path="msgGubun" id="msgGubun" title="소속" onChange="fn_messageView();">
										         <form:option value="" label="메세지 선택"/>
						                         <form:options items="${selectMsgGubun}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.message.messageNm" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <form:input path="msgTitle" id="msgTitle" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box1000">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.message.messageContent" /> <span class="join_id_comment joinSubTxt"></span></p>
                     <form:input path="msgContent" id="msgContent" class="input_noti" size="100"/>
                </div>                
            </div>
      
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="common.UseYn.title" /> <span class="join_id_comment joinSubTxt"></span></p>
                       <label class="switch">                                               
	                    	<input type="checkbox" id="useYn" name="useYn" onclick="toggleValue(this)" value="Y">
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

   <script src="/js/needpopup.js"></script> 
   <script src="/js/jquery-ui.js"></script>

</form:form>
    <button id="btn_message" style="display:none" data-needpopup-show='#app_message'>확인1</button>
    <button id="btn_needPopHide" style="display:none" >hide</button>
    
</div>

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