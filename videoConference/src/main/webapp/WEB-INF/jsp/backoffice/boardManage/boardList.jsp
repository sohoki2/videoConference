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
    <link rel="stylesheet" href="/css/new/reset.css"> 
    
    <link rel="stylesheet" href="/css/needpopup.min.css" />
    <link rel="stylesheet" href="/css/needpopup.css">
    
    
    <script type="text/javascript" src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script>
    
    
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
    
    
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/boardManage/boardList.do">	   	  
<c:import url="/backoffice/inc/top_inc.do" />	
<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="boardGubun" id="boardGubun"  value="${regist.boardGubun }">
<input type="hidden" name="boardSeq" id="boardSeq">
<input type="hidden" name="mode" id="mode">

<input type="hidden" name="boardContent" id="boardContent" >
<input type="hidden" name="boardReturnContent" id="boardReturnContent" >
 
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>??????????????????<span>></span>
                        <strong>
                          <c:choose>
			                <c:when test="${searchVO.boardGubun eq 'NOT'}">
			                                   ????????????
                            </c:when>
                            <c:when test="${searchVO.boardGubun eq 'FAQ'}">			                
                            FAQ
                            </c:when>
                            <c:otherwise>
                            Q&A
                            </c:otherwise>
                          </c:choose>
                         </strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
            <div class="Atitle">??? <span id="sp_totcnt"></span>?????? 
	            <c:choose>
					<c:when test="${searchVO.boardGubun eq 'NOT'}">			                
					???????????????
					</c:when>
					<c:when test="${searchVO.boardGubun eq 'FAQ'}">			                
					FAQ??? 
					</c:when>
					<c:otherwise>
					Q&A??? 
					</c:otherwise>
				</c:choose>????????????.
				</div>
                <section class="Bclear">
                <table class="pop_table searchThStyle">
                   
                   <tr>
	                   <th>?????????</th>
	                   <td>
	                   	<select name="searchCondition"  id="searchCondition">
	                   		        <option value="all">??????</option>
									<option value="boardTitle">??????</option>
									<option value="boardContent">??????</option>
							</select>	
							<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  class="margin-left10">
							<a href="javascript:boardinfo.fn_search();" ><span class="lightgrayBtn">??????</span></a>
						</td>
						<c:if test="${regist.boardGubun ne 'QNA'}" >
	                    <td class="text-right">
	                        <a href="javascript:boardinfo.fn_boardInfo('Ins','0')"><span class="blueBtn">??????</span></a>
	                    </td>
	                    </c:if>
                    </tr>
                     </section>
                 </table>
            </div>
            <div class="Swrap tableArea">
               <!--  ????????? ?????? ??????  -->
               <table id="boardGrid"></table>
               <div id="pager" class="scroll" style="text-align:center;"></div>     
               <br />
            </div>
        </div>
    </div>
<c:import url="/backoffice/inc/bottom_inc.do" />    
</form:form>





    <!--  preview ????????? -->
    <div id="preview_value_page"></div>
	<div id="preview_value_userNm"></div>
	<div id="preview_value_offiTelNo"></div>
	<div id="preview_value_email"></div>
	<div id="preview_value_useYn"></div>
	<div id="preview_value_fileNm"></div>
	<div id="preview_value_fileChange"></div>  
	<!--  preview ????????? ??? ??????-->
	
<div id='app_message' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>
             <c:choose>
               <c:when test="${searchVO.boardGubun eq 'NOT'}">
                                  ????????????
               </c:when>
               <c:when test="${searchVO.boardGubun eq 'FAQ'}">			                
                FAQ
               </c:when>
               <c:otherwise>
                Q&A
               </c:otherwise>
             </c:choose>
            </h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// ?????? ????????????-->
            <div class="pop_box100">
            
                 <table class="margin-top30 pop_table thStyle">
	                <tbody>
	                    <tr class="tableM">
	                        <th><span class="redText">*</span>??????</th>
	                        <td colspan="3">
	                        <input type="text" name="boardTitle" id="boardTitle" style="width:470px;" />
	                        </td>
	                    </tr>
	                    <tr id="tr_not1">
                      		<th>????????????</th>
	                        <td style="text-align:left">
	                        <input type="text"  name="boardNoticeStartday" style="width:150px" maxlength="8" id="boardNoticeStartday" class="date-picker-input-type-text" />
	                        ~
	                        <input type="text"  name="boardNoticeEndday"  style="width:150px"  maxlength="8" id="boardNoticeEndday" class="date-picker-input-type-text" />	                        
	                        </td>
                            <th><span class="redText">*</span>?????????????????????</th>
	                        <td style="text-align:left">
		                        <label class="switch">                                               
			                   	   <input type="checkbox" id="boardNoticeUseyn" onclick="toggleValue(this);" value="Y">
			                       <span class="slider round"></span> 
			                    </label> 
		                    </td>
	                    </tr>
	                    <tr id="tr_faq">
	                        <th>FAQ ??????</th>
	                        <td style="text-align:left">
		                        <select id="boardFaqGubun" name="boardFaqGubun">
		                             <option value="">FAQ ??????</option>
			                         <c:forEach items="${selectFaq}" var="selectFaq">
			                            <option value="${selectFaq.code}">${selectFaq.codeNm}</option>
			                         </c:forEach>
		                        </select>
	                        </td>
	                        <th><span class="redText">*</span>????????????</th>
	                        <td style="text-align:left">
	                            <label class="switch">                                               
			                   	   <input type="checkbox" id="boardViewYn" onclick="toggleValue(this);" value="Y">
			                       <span class="slider round"></span> 
			                    </label> 
	                        </td>          
			            </tr>	
	                    <tr >
                            <th>????????????</th>
                           	<td colspan="3"><a class="preview_fileNm"></a><input name="boardFile01" id="boardFile01" type="file" size="20"/></td>
                        </tr>
	                    <tr>
	                        <th><span class="redText" id="sp_returntxt">*</span></th>
	                        <td colspan="3" style="text-align:left">
	                            <textarea name="ir1" id="ir1" style="width:700px; height:100px; display:none;"></textarea>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>                     
            </div>
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">????????? ?????? ????????? ??????????????????.</span>
            <a href="javascript:boardinfo.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div> 
</div>	

<button id="btn_message" style="display:none" data-needpopup-show='#app_message'>??????1</button>
<button id="btn_boardPriview" style="display:none" data-needpopup-show='#board_preView'>preview</button>


<div  id='board_preView' class="needpopup">
<div class="pop_container">
        <!--//?????? ?????????-->
        <div class="pop_header">
            <div class="pop_contents">
            <h2 style="margin-left:8px;"><span id="sp_preview"></span>
             </h2>
            </div>
        </div>
        <!--???????????????//-->
        <!--//?????? ??????-->
        <div class="pop_contents">
	        <div class="Swrap tableArea viewArea" style="margin:16px">
                <div class="view_contents">
	                <table class="margin-top30 backTable mattersArea">
		                <tbody>
		                    <tr class="tableM">
		                        <th>??????</th>
		                        <td colspan="3" class="preview_in_title"><span id="sp_boardTitle"></span></td>
		                    </tr>
		                    <!-- 
		                    <tr>
		                        <th>?????????</th>
		                        <td style='text-align:left' class='preview_in_offiTelNo'></td>
		                        <th>?????????</th>
		                        <td style='text-align:left' class='preview_in_email'></td>
		                    </tr>
		                     -->
	                        </tr>
	                           <tr><th>????????????</th>
	                           <td style='text-align:left' colspan='3' class='preview_in_day'><span id="sp_interval"></span></td>
	                        </tr>
	                        <tr id="tr_boardFile">
	                        	<th>????????????</th>
	                        	<td style='text-align:left' colspan='3' class='preview_in_file'><span id="sp_boardFile"></span></td>
	                        </tr>
				     		<tr>
				     			<th>??????</th>
				     			<td colspan="3" class="preview_in_contents">
				     			<span id="sp_boardContent"></span>
				     			</td>
				     		</tr>	                    
		                </tbody>
		            </table>
            	</div>
        	</div>
       	</div>
        <div class="footerBtn">
            <a href="javascript:need_close();" class="grayBtn" style="margin-bottom:16px;">??????</a>
        </div>
    </div>

</div>	
<c:import url="/backoffice/inc/uni_pop.do" />

<script type="text/javascript">
	 $(document).ready(function() { 
		   jqGridFunc.setGrid("boardGrid");
	 });
	 var jqGridFunc  = {
			 setGrid : function(gridOption){
				 var postData = {"pageIndex": "1", "boardGubun" : $("#boardGubun").val(), "searchKeyword" : $("#searchKeyword").val()};
			     
			     $('#'+gridOption).jqGrid({
						url : '/backoffice/boardManage/boardListAjax.do' ,
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
					    	    	{ label: 'board_seq', key: true, name:'board_seq',       index:'board_seq',      align:'center', hidden:true},
					            	{ label: '??????', name:'board_title',       index:'board_title',      align:'center', width:'20%'},
					            	{ label: '????????????', name:'board_title',       index:'board_title',      align:'center', width:'10%'
					            	  , formatter:jqGridFunc.boardPreviewBtn	},
					            	{ label: '????????????', name:'board_notice_startday', index:'board_notice_startday',   align:'center', width:'10%'
					            	  , formatter:jqGridFunc.boardNoticeDay	},
					            	{ label: '????????????', name:'board_notice_useyn',    index:'board_notice_useyn',      align:'center', width:'10%'},
					            	{ label: '????????????', name:'board_file01', index:'board_file01', align:'center', width:'10%'},
					            	{ label: '?????????', name:'user_nm',      index:'user_nm',      align:'center', width:'10%'},
						            { label: '?????????', name:'board_visited',      index:'board_visited',      align:'center', width:'10%'},
					                { label: '?????? ?????????', name:'user_nm', index:'user_nm',     align:'center', width:'10%'},
					                { label: '?????? ?????? ??????', name:'board_update_date', index:'board_update_date', align:'center', width:'12%', 
					                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
					                { label: '??????', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : false, formatter:boardinfo.rowBtn}
					         ],  //????????? 
					    rowNum : 10,  //????????? ???
					    rowList : [10,20,30,40,50,100],  // ????????? ???
					    pager : pager,
					    refresh : true,
					    rownumbers : true, // ????????? ??????
					    viewrecord : true,    // ?????? ????????? ??? ?????? ??????
					    //loadonce : true,     // true ????????? ????????? ????????? 
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
	    		        	  var gridPage = $('#'+gridOption).getGridParam('page'); //get current  page
	    		        	  var lastPage = $('#'+gridOption).getGridParam("lastpage"); //get last page 
	    		        	  var totalPage = $('#'+gridOption).getGridParam("total");
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
	    		              $('#'+gridOption).setGridParam({
			    		          	  page : gridPage,
			    		          	  rowNum : $('.ui-pg-selbox option:selected').val(),
			    		          	  postData : JSON.stringify(  {
								    		          			"pageIndex": gridPage,
								    		          			"boardGubun" : $("#boardGubun").val(),
								    		    	    		"searchCondition" : $("#searchCondition").val(),
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
					        if (cm[index].name=='board_title' ){
					        	boardinfo.fn_boardInfo("Edt", $(this).jqGrid('getCell', rowid, 'board_seq'));
						    }
					        
					    }
				 });
			 }, boardPreviewBtn : function (cellvalue, options, rowObject){
				 return "<a href='javascript:preview(\""+rowObject.board_seq+"\");'>????????????</a>";
			 }, boardNoticeDay :function (cellvalue, options, rowObject){
				 if (rowObject.board_notice_startday!= "")
				 return rowObject.board_notice_startday+"~"+rowObject.board_notice_endday;
			 }
	     
	 }
     var boardinfo = {
    		 fn_boardInfo : function(mode, boardSeq) {
    			    $("#btn_message").trigger("click");
				    $("#mode").val(mode);
			        $("#boardSeq").val(boardSeq);
			        boardinfo.fn_boardFormCk();
			        if (mode == "Edt"){
			        	$("#btnUpdate").text("??????");
			        	
			     	   var params = {"boardSeq" : boardSeq, "boardVisited": 0};
			     	   var url = "/backoffice/boardManage/boardView.do";
			     	   uniAjax(url, params, 
			          			function(result) {
			     				       if (result.status == "LOGIN FAIL"){
			     				    	   location.href="/backoffice/login.do";
			       					   }else if (result.status == "SUCCESS"){
			       						   //??? ????????? ?????? ??????
			       						    var obj  = result.regist;
			       						    $("#boardTitle").val(obj.board_title);
			       						    $("#boardGubun").val(obj.board_gubun);
				       						$("#ir1").val(obj.board_content);
				       						$("#boardNoticeStartday").val(obj.board_notice_startday);
				       						$("#boardNoticeEndday").val(obj.board_notice_endday);
				       						toggleClick("boardViewYn", obj.board_view_yn);
								    		toggleClick("boardNoticeUseyn", obj.board_notice_useyn);
								       }
			     				    },
			     				    function(request){
			     					    alert("Error:" +request.status );	       						
			     				    }    		
			            );
			        }else {
			        	$("#btnUpdate").text("??????");
			        	var boardGubun = $("#boardGubun").val();
			        	$('input[name^=board]').val("");
			        	$("#boardGubun").val(boardGubun);
			        	toggleDefault("boardNoticeUseyn");
			        	toggleDefault("boardViewYn");
			        }
    		 },fn_CheckForm  : function (){
				    if (any_empt_line_id("boardTitle", "????????? ??????????????????.") == false) return;	
				    //????????? ????????? ?????? 
				    if (dateIntervalCheck(fn_emptyReplace($("#boardNoticeStartday").val(),"0"), 
				    		              fn_emptyReplace($("#boardNoticeEndday").val(),"0") , "???????????? ????????? ?????? ?????? ????????????.") == false) return;
				    var commentTxt = ($("#mode").val() == "Ins") ? "?????? ???????????????????":"?????? ???????????????????";
		     		
		     		if (confirm(commentTxt)== true){
		     			  //?????? ?????? ?????? ??? ???????????? 
		     			  var sHTML = oEditors.getById["ir1"].getIR();
     			          $("#boardContent").val(sHTML); 
     			          
		     			  var formData = new FormData();
		     			  formData.append('mode' , $("#mode").val());
		     			  formData.append('boardFile01', $('#boardFile01')[0].files[0]);
		     			  formData.append('boardSeq' , $("#boardSeq").val());
		     			  formData.append('boardTitle' , $("#boardTitle").val());
		     			  formData.append('boardNoticeStartday' , $("#boardNoticeStartday").val());
		     			  formData.append('boardNoticeEndday' , $("#boardNoticeEndday").val());
		     			  formData.append('boardContent' , $("#boardContent").val());
		     			  formData.append('boardGubun' , $("#boardGubun").val());
		     			  formData.append('boardReturnContent' , $("#boardReturnContent").val());
		     			  formData.append('boardNoticeUseyn' , fn_emptyReplace($("#boardNoticeUseyn").val(),"N"));
		     			  formData.append('boardViewYn' , fn_emptyReplace($("#boardViewYn").val(),"N"));
		     			  uniAjaxMutipart("/backoffice/boardManage/boardUpdate.do", formData, 
	     						function(result) {
		     				           //alert("result:" + result);
	     						       //????????? ?????? ?????? ?????? 	
	     		    	               if (result.status == "SUCCESS"){
	     		    	            	  boardinfo.fn_search();
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
		     },rowBtn : function (cellvalue, options, rowObject){
	             if (rowObject.board_seq != "")
	            	   return '<a href="javascript:boardinfo.delRow(&#34;'+rowObject.board_seq+'&#34;);">??????</a>';
	         }, delRow : function (board_seq){
	        	 if(board_seq != "") {
	          		 var params = {'boardSeq':board_seq };
	          		 fn_uniDelAction("/backoffice/boardManage/boardDelete.do",params, "boardinfo.fn_search");
	        	 }
	    	 }, fn_boardFormCk : function (){
	    		 if ($("#boardGubun").val() == "NOT"){
	    			 $("#tr_faq").hide();
	    			 $("#tr_not1").show();
	    		 }else {
	    			 $("#tr_faq").show();
	    			 $("#tr_not1").hide();
	    		 }
	    		 
	    	 },fn_search : function(){
				  $("#boardGrid").setGridParam({
		    	    	 datatype	: "json",
		    	    	 postData	: JSON.stringify(  {
		    	    		"pageIndex": $("#pager .ui-pg-input").val(),
		    	    		"boardGubun" : $("#boardGubun").val(),
		    	    		"searchCondition" : $("#searchCondition").val(),
		    	    		"searchKeyword" : $("#searchKeyword").val(),
		         			"pageUnit":$('.ui-pg-selbox option:selected').val()
		         		 }),
		    	    	 loadComplete	: function(data) {
		    	    		 $("#sp_totcnt").text(data.paginationInfo.totalRecordCount);
		    	    	 }
		    	   }).trigger("reloadGrid");
			 }
     }  
</script>
<script type="text/javascript">
   
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	     oAppRef: oEditors,
	     elPlaceHolder: "ir1",                        
	     sSkinURI: "/js/SE/SmartEditor2Skin.html",
	     htParams: { bUseToolbar: true,
	         fOnBeforeUnload: function () {},
	         //boolean 
	     }, fOnAppLoad: function () {
	    	 
			 oEditors.getById["ir1"].exec("PASTE_HTML", ['${regist.boardContent}']);
		 },
	     fCreator: "createSEditor2"
	});
	$(function () {
        var clareCalendar = {
            monthNamesShort: ['1???', '2???', '3???', '4???', '5???', '6???', '7???', '8???', '9???', '10???', '11???', '12???'],
            dayNamesMin: ['???', '???', '???', '???', '???', '???', '???'],
            weekHeader: 'Wk',
            dateFormat: 'yymmdd', //??????(20120303)
            autoSize: false, //??????????????????(body??? ??????????????? ????????? ?????????)
            changeMonth: true, //???????????????
            changeYear: true, //???????????????
            showMonthAfterYear: true, //??? ?????? ??? ??????
            buttonImageOnly: true, //???????????????
            buttonText: '????????????', //?????? ????????? ??????
            buttonImage: '/images/invisible_image.png', //???????????????
            showOn: "both", //??????????????? ????????? ?????? ??????(both,button)
            yearRange: '1970:2030' //1990????????? 2020?????????
        };	      
        $("#boardNoticeStartday").datepicker(clareCalendar);
        $("#boardNoticeEndday").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //??????????????? style??????
	    $("#ui-datepicker-div").hide(); //???????????? ???????????? div?????? ??????
	});	
	function preview(boardSeq){
		var popSpec = "";
		if($("#boardGubun").val() == "NOT"){
			popSpec = "width=920,height=600,top=10,left=350,scrollbars=yes";
			$("#sp_preview").text("????????????");
		} else {
			popSpec = "width=920,height=480,top=10,left=350,scrollbars=yes";
			$("#sp_preview").text("FAQ");
		}
		$("#board_preView").attr("style", popSpec);
		
		//?????? ?????? ??????
		var url = "/backoffice/boardManage/boardView.do";
		var params = {'boardSeq': boardSeq};
		var result = fn_returnInfoReg(url, params);
		var obj = result.regist;
		
		$("#sp_boardTitle").text(obj.board_title);
		$("#sp_interval").text(obj.board_notice_startday + "~" + obj.board_notice_endday);
		if(obj.board_file01 != "") {
			$("#tr_boardFile").show();
			$("#sp_boardFile").text(obj.board_file01);
		}else {
			$("#tr_boardFile").hide();
			$("#sp_boardFile").text("");
		}
		$("#sp_boardContent").html(obj.board_content);
		$("#btn_boardPriview").trigger("click");
	}
    </script>
</body>
</html>