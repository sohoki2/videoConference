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
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    
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
    <script type="text/javascript" src="/js/backoffice_common.js"></script>
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
   <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script> 
    
    
    
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
	                   		        <option value="0">전체</option>
									<option value="1">제목</option>
									<option value="2">내용</option>
							</select>	
							<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"  class="margin-left10">
							<a href="javascript:search_form();" ><span class="lightgrayBtn">조회</span></a>
						</td>
						<c:if test="${regist.boardGubun ne 'QNA'}" >
	                    <td class="text-right">
	                        <a href="javascript:view_Board('Ins','0')"><span class="blueBtn">등록</span></a>
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



<div id='app_message' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>회원사 관리</h2>
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
	                        <input type="text" name="boardTitle" id="boardTitle"  style="width:470px;" />
	                        </td>
	                    </tr>
	                    <tr id="tr_not1">
                      		<th>공지기간</th>
	                        <td style="text-align:left">
	                        <form:input  path="boardNoticeStartday" size="10" maxlength="8" id="boardNoticeStartday" class="date-picker-input-type-text" />
	                        ~ &nbsp;&nbsp;&nbsp;
	                        <form:input  path="boardNoticeEndday" size="10" maxlength="8" id="boardNoticeEndday" class="date-picker-input-type-text" />	                        
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
	                        <form:select path="boardFaqGubun" id="boardFaqGubun" title="소속">
								         <form:option value="" label="FAQ구분"/>
				                         <form:options items="${selectFaq}" itemValue="code" itemLabel="codeNm"/>
						    </form:select>
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
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div> 
    
    <!--  preview 설정값 -->
    <div id="preview_value_page"></div>
	<div id="preview_value_userNm"></div>
	<div id="preview_value_offiTelNo"></div>
	<div id="preview_value_email"></div>
	<div id="preview_value_useYn"></div>
	<div id="preview_value_fileNm"></div>
	<div id="preview_value_fileChange"></div>  
	<!--  preview 설정값 끝 부분-->
</div>
<script type="text/javascript">
     var postData = {"pageIndex": "1", "boardGubun" : $("#boardGubun").val()};
     $('#"boardGrid"').jqGrid({
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
		    	    	{ label: 'board_seq', key: true, name:'floor_seq',       index:'floor_seq',      align:'center', hidden:true},
		            	{ label: '제목', name:'board_title',       index:'board_title',      align:'center', width:'10%'},
			            { label: '작성자', name:'user_nm',      index:'user_nm',      align:'center', width:'10%'},
			            { label: '조회수', name:'board_visited',      index:'board_visited',      align:'center', width:'10%'},
		                { label: '최종 수정자', name:'user_updateid', index:'user_updateid',     align:'center', width:'10%'},
		                { label: '최종 수정 일자', name:'board_update_id', index:'board_update_id', align:'center', width:'12%', 
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
		    subGrid: true,
		    subGridRowExpanded: showChildGrid, 
		    subGridBeforeExpand : function (pID, id){
		    	alert("pID:" + pID + ":" + id);
		    },loadComplete : function (data){
		    	//$("#sp_totcnt").text(data.paginationInfo.totalRecordCount);
		    },loadError:function(xhr, status, error) {
		        alert("error:" + error); 
		    },onSelectRow: function(rowId){
		        if(rowId != null) { 
		           //멀트 체크 할떄 특정 값이면 다른 값에 대한 색 변경 	
		        }// 체크 할떄
		    },ondblClickRow : function(rowid, iRow, iCol, e){
		    	grid.jqGrid('editRow', rowid, {keys: true});
		    },onCellSelect : function (rowid, index, contents, action){
		    	var cm = $(this).jqGrid('getGridParam', 'colModel');
		        if (cm[index].name=='board_title' ){
		        	boardinfo.fn_floorInfo("Edt", $(this).jqGrid('getCell', rowid, 'board_seq'));
			    }
		        
		    }
		});
     
       var boardinfo = {
    		 fn_boardInfo : function(mode, boardSeq) {
    			    $("#btn_message").trigger("click");
				    $("#mode").val(mode);
			        $("#boardSeq").val(boardSeq);
			        if (mode == "Edt"){
			        	$("#btnUpdate").text("수정");
			        	
			     	   var params = {"boardSeq" : boardSeq};
			     	   var url = "/backoffice/boardManage/boardView.do";
			     	   uniAjaxSerial(url, params, 
			          			function(result) {
			     				       if (result.status == "LOGIN FAIL"){
			     				    	   location.href="/backoffice/login.do";
			       					   }else if (result.status == "SUCCESS"){
			       						   //총 게시물 정리 하기
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
								    		backoffice_common.fn_floorSearch(obj.floor_seq,'sp_floor', 'floorSeq');
								    		backoffice_common.fn_floorPlayState(obj.com_play_floor, "sp_floorCheck", "floorPlaySeq");
								    		toggleClick("tennUseyn", obj.tenn_useyn);
								       }
			     				    },
			     				    function(request){
			     					    alert("Error:" +request.status );	       						
			     				    }    		
			            );
			        }else {
			        	$("#btnUpdate").text("등록");
			        	$('input[name^=board]').val("");
			        	toggleDefault("boardNoticeUseyn");
			        	toggleDefault("boardViewYn");
			        	//층 및 예약 층 삭제 
			        }
    		 },fn_CheckForm  : function (){
				    if (any_empt_line_id("boardTitle", "제목을 입력해주세요.") == false) return;	
				    var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
		     		
		     		if (confirm(commentTxt)== true){
		     			  //체크 박스 체그 값 알아오기 
		     			  var formData = new FormData();
		     			  formData.append('boardFile01', $('#boardFile01')[0].files[0]);
		     			  formData.append('boardSeq' , $("#boardSeq").val());
		     			  formData.append('boardTitle' , $("#boardTitle").val());
		     			  formData.append('boardNoticeStartday' , $("#boardNoticeStartday").val());
		     			  formData.append('boardNoticeEndday' , $("#boardNoticeEndday").val());
		     			  formData.append('boardContent' , $("#boardContent").val());
		     			  formData.append('boardReturnContent' , $("#boardReturnContent").val());
		     			  formData.append('boardNoticeUseyn' , fn_emptyReplace($("#boardNoticeUseyn").val(),"N"));
		     			  formData.append('boardViewYn' , fn_emptyReplace($("#boardViewYn").val(),"N"));
		     			  uniAjaxMutipart("/backoffice/companyManage/companyUpdate.do", formData, 
		     						function(result) {
		     						       //결과값 추후 확인 하기 	
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
		 }, rowBtn : function (cellvalue, options, rowObject){
             if (rowObject.board_seq != "")
          	   return '<a href="javascript:boardinfo.delRow(&#34;'+rowObject.board_seq+'&#34;);">삭제</a>';
         }, delRow : function (board_seq){
        	 if(com_code != "") {
      		 var params = {'board_seq':coboard_seqm_code };
      		 fn_uniDelAction("/backoffice/boardManage/boardDelete.do",params, "boardinfo.fn_search");
		 } ,fn_search : function(){
			  $("#mainGrid").setGridParam({
	    	    	 datatype	: "json",
	    	    	 postData	: JSON.stringify(  {
	    	    		"pageIndex": $("#pager .ui-pg-input").val(),
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
	function search_form(){		  
		  $("form[name=regist]").attr("action", "/backoffice/boardManage/boardList.do").submit();		  
	}
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
	var previewWindow;
	function preview(){
		
		var popSpec = "";
		if(pageStatus == "NOT"){
			popSpec = "width=920,height=600,top=10,left=350,scrollbars=yes";
		} else {
			popSpec = "width=920,height=480,top=10,left=350,scrollbars=yes";
		}
		$("#preview_value_page").val(pageStatus);
		$("#boardContent").val(oEditors.getById["ir1"].getIR());
		$("#preview_value_userNm").val($(".preview_userNm").html());
		$("#preview_value_offiTelNo").val($(".preview_offiTelNo").html());
		$("#preview_value_email").val($(".preview_email").html());
		$("#preview_value_useYn").val($(":input:radio[name=boardNoticeUseyn]:checked").val());		
		if($("#preview_value_fileNm").val() == "N"){
			$("#preview_value_fileNm").val($(".preview_fileNm").html());
			
		}
		window.open("/backoffice/boardManage/boardPreview.do", "preview", popSpec);
	}
    </script>
</body>
</html>