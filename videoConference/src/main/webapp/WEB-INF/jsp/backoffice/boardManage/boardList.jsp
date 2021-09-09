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
                        <span>></span>커뮤니티관리<span>></span>
                        <strong>
                          <c:choose>
			                <c:when test="${searchVO.boardGubun eq 'NOT'}">
			                                   공지사항
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
            <div class="Atitle">총 <span id="sp_totcnt"></span>건의 
	            <c:choose>
					<c:when test="${searchVO.boardGubun eq 'NOT'}">			                
					공지사항이
					</c:when>
					<c:when test="${searchVO.boardGubun eq 'FAQ'}">			                
					FAQ가 
					</c:when>
					<c:otherwise>
					Q&A가 
					</c:otherwise>
				</c:choose>있습니다.
				</div>
                <section class="Bclear">
                <table class="pop_table searchThStyle">
                   
                   <tr>
	                   <th>검색어</th>
	                   <td>
	                   	<select name="searchCondition"  id="searchCondition">
	                   		        <option value="all">전체</option>
									<option value="boardTitle">제목</option>
									<option value="boardContent">내용</option>
							</select>	
							<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  class="margin-left10">
							<a href="javascript:boardinfo.fn_search();" ><span class="lightgrayBtn">조회</span></a>
						</td>
						<c:if test="${regist.boardGubun ne 'QNA'}" >
	                    <td class="text-right">
	                        <a href="javascript:boardinfo.fn_boardInfo('Ins','0')"><span class="blueBtn">등록</span></a>
	                    </td>
	                    </c:if>
                    </tr>
                     </section>
                 </table>
            </div>
            <div class="Swrap tableArea">
               <!--  리스트 보여 주기  -->
               <table id="boardGrid"></table>
               <div id="pager" class="scroll" style="text-align:center;"></div>     
               <br />
            </div>
        </div>
    </div>
<c:import url="/backoffice/inc/bottom_inc.do" />    
</form:form>





    <!--  preview 설정값 -->
    <div id="preview_value_page"></div>
	<div id="preview_value_userNm"></div>
	<div id="preview_value_offiTelNo"></div>
	<div id="preview_value_email"></div>
	<div id="preview_value_useYn"></div>
	<div id="preview_value_fileNm"></div>
	<div id="preview_value_fileChange"></div>  
	<!--  preview 설정값 끝 부분-->
	
<div id='app_message' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>
             <c:choose>
               <c:when test="${searchVO.boardGubun eq 'NOT'}">
                                  공지사항
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
            <!--// 팝업 필드박스-->
            <div class="pop_box100">
            
                 <table class="margin-top30 pop_table thStyle">
	                <tbody>
	                    <tr class="tableM">
	                        <th><span class="redText">*</span>제목</th>
	                        <td colspan="3">
	                        <input type="text" name="boardTitle" id="boardTitle" style="width:470px;" />
	                        </td>
	                    </tr>
	                    <tr id="tr_not1">
                      		<th>공지기간</th>
	                        <td style="text-align:left">
	                        <input type="text"  name="boardNoticeStartday" style="width:150px" maxlength="8" id="boardNoticeStartday" class="date-picker-input-type-text" />
	                        ~
	                        <input type="text"  name="boardNoticeEndday"  style="width:150px"  maxlength="8" id="boardNoticeEndday" class="date-picker-input-type-text" />	                        
	                        </td>
                            <th><span class="redText">*</span>목록상단에고정</th>
	                        <td style="text-align:left">
		                        <label class="switch">                                               
			                   	   <input type="checkbox" id="boardNoticeUseyn" onclick="toggleValue(this);" value="Y">
			                       <span class="slider round"></span> 
			                    </label> 
		                    </td>
	                    </tr>
	                    <tr id="tr_faq">
	                        <th>FAQ 구분</th>
	                        <td style="text-align:left">
		                        <select id="boardFaqGubun" name="boardFaqGubun">
		                             <option value="">FAQ 구분</option>
			                         <c:forEach items="${selectFaq}" var="selectFaq">
			                            <option value="${selectFaq.code}">${selectFaq.codeNm}</option>
			                         </c:forEach>
		                        </select>
	                        </td>
	                        <th><span class="redText">*</span>노출여부</th>
	                        <td style="text-align:left">
	                            <label class="switch">                                               
			                   	   <input type="checkbox" id="boardViewYn" onclick="toggleValue(this);" value="Y">
			                       <span class="slider round"></span> 
			                    </label> 
	                        </td>          
			            </tr>	
	                    <tr >
                            <th>첨부파일</th>
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
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:boardinfo.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div> 
</div>	

<button id="btn_message" style="display:none" data-needpopup-show='#app_message'>확인1</button>
<button id="btn_boardPriview" style="display:none" data-needpopup-show='#board_preView'>preview</button>


<div  id='board_preView' class="needpopup">
<div class="pop_container">
        <!--//팝업 타이틀-->
        <div class="pop_header">
            <div class="pop_contents">
            <h2 style="margin-left:8px;"><span id="sp_preview"></span>
             </h2>
            </div>
        </div>
        <!--팝업타이틀//-->
        <!--//팝업 내용-->
        <div class="pop_contents">
	        <div class="Swrap tableArea viewArea" style="margin:16px">
                <div class="view_contents">
	                <table class="margin-top30 backTable mattersArea">
		                <tbody>
		                    <tr class="tableM">
		                        <th>제목</th>
		                        <td colspan="3" class="preview_in_title"><span id="sp_boardTitle"></span></td>
		                    </tr>
		                    <!-- 
		                    <tr>
		                        <th>연락처</th>
		                        <td style='text-align:left' class='preview_in_offiTelNo'></td>
		                        <th>이메일</th>
		                        <td style='text-align:left' class='preview_in_email'></td>
		                    </tr>
		                     -->
	                        </tr>
	                           <tr><th>공지기간</th>
	                           <td style='text-align:left' colspan='3' class='preview_in_day'><span id="sp_interval"></span></td>
	                        </tr>
	                        <tr id="tr_boardFile">
	                        	<th>첨부파일</th>
	                        	<td style='text-align:left' colspan='3' class='preview_in_file'><span id="sp_boardFile"></span></td>
	                        </tr>
				     		<tr>
				     			<th>내용</th>
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
            <a href="javascript:need_close();" class="grayBtn" style="margin-bottom:16px;">닫기</a>
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
					            	{ label: '제목', name:'board_title',       index:'board_title',      align:'center', width:'20%'},
					            	{ label: '미리보기', name:'board_title',       index:'board_title',      align:'center', width:'10%'
					            	  , formatter:jqGridFunc.boardPreviewBtn	},
					            	{ label: '공지기간', name:'board_notice_startday', index:'board_notice_startday',   align:'center', width:'10%'
					            	  , formatter:jqGridFunc.boardNoticeDay	},
					            	{ label: '상위고정', name:'board_notice_useyn',    index:'board_notice_useyn',      align:'center', width:'10%'},
					            	{ label: '첨부파일', name:'board_file01', index:'board_file01', align:'center', width:'10%'},
					            	{ label: '작성자', name:'user_nm',      index:'user_nm',      align:'center', width:'10%'},
						            { label: '조회수', name:'board_visited',      index:'board_visited',      align:'center', width:'10%'},
					                { label: '최종 수정자', name:'user_nm', index:'user_nm',     align:'center', width:'10%'},
					                { label: '최종 수정 일자', name:'board_update_date', index:'board_update_date', align:'center', width:'12%', 
					                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
					                { label: '삭제', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : false, formatter:boardinfo.rowBtn}
					         ],  //상단면 
					    rowNum : 10,  //레코드 수
					    rowList : [10,20,30,40,50,100],  // 페이징 수
					    pager : pager,
					    refresh : true,
					    rownumbers : true, // 리스트 순번
					    viewrecord : true,    // 하단 레코드 수 표기 유무
					    //loadonce : true,     // true 데이터 한번만 받아옴 
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
					           //멀트 체크 할떄 특정 값이면 다른 값에 대한 색 변경 	
					        }// 체크 할떄
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
				 return "<a href='javascript:preview(\""+rowObject.board_seq+"\");'>미리보기</a>";
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
			        	$("#btnUpdate").text("수정");
			        	
			     	   var params = {"boardSeq" : boardSeq, "boardVisited": 0};
			     	   var url = "/backoffice/boardManage/boardView.do";
			     	   uniAjax(url, params, 
			          			function(result) {
			     				       if (result.status == "LOGIN FAIL"){
			     				    	   location.href="/backoffice/login.do";
			       					   }else if (result.status == "SUCCESS"){
			       						   //총 게시물 정리 하기
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
			        	$("#btnUpdate").text("등록");
			        	var boardGubun = $("#boardGubun").val();
			        	$('input[name^=board]').val("");
			        	$("#boardGubun").val(boardGubun);
			        	toggleDefault("boardNoticeUseyn");
			        	toggleDefault("boardViewYn");
			        }
    		 },fn_CheckForm  : function (){
				    if (any_empt_line_id("boardTitle", "제목을 입력해주세요.") == false) return;	
				    //시작일 종요일 체크 
				    if (dateIntervalCheck(fn_emptyReplace($("#boardNoticeStartday").val(),"0"), 
				    		              fn_emptyReplace($("#boardNoticeEndday").val(),"0") , "시작일이 종료일 보다 앞서 있습니다.") == false) return;
				    var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
		     		
		     		if (confirm(commentTxt)== true){
		     			  //체크 박스 체그 값 알아오기 
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
	     						       //결과값 추후 확인 하기 	
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
	            	   return '<a href="javascript:boardinfo.delRow(&#34;'+rowObject.board_seq+'&#34;);">삭제</a>';
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
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            weekHeader: 'Wk',
            dateFormat: 'yymmdd', //형식(20120303)
            autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
            changeMonth: true, //월변경가능
            changeYear: true, //년변경가능
            showMonthAfterYear: true, //년 뒤에 월 표시
            buttonImageOnly: true, //이미지표시
            buttonText: '달력선택', //버튼 텍스트 표시
            buttonImage: '/images/invisible_image.png', //이미지주소
            showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)
            yearRange: '1970:2030' //1990년부터 2020년까지
        };	      
        $("#boardNoticeStartday").datepicker(clareCalendar);
        $("#boardNoticeEndday").datepicker(clareCalendar);        
        $("img.ui-datepicker-trigger").attr("style", "margin-left:3px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
	    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
	});	
	function preview(boardSeq){
		var popSpec = "";
		if($("#boardGubun").val() == "NOT"){
			popSpec = "width=920,height=600,top=10,left=350,scrollbars=yes";
			$("#sp_preview").text("공지사항");
		} else {
			popSpec = "width=920,height=480,top=10,left=350,scrollbars=yes";
			$("#sp_preview").text("FAQ");
		}
		$("#board_preView").attr("style", popSpec);
		
		//관련 내용 넣기
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