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
    
    
    <!-- bpopup 사용 -->
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
                <div class="Atitle">총 입주사 <span id="sp_totcnt" /></div>
                <section class="Bclear">
                   <table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th>검색어</th>
		                	<td>
		                	    <select path="searchCenter" id="searchCenter" title="지점구분" onChange="backoffice_common.fn_floorSearch('','sp_floorCombo', 'searchFloorSeq')">
								         <option value="">지점 선택</option>
				                         <c:forEach items="${searchCenter}" var="centerList">
				                            <option value="${centerList.centerId}">${centerList.centerNm}</option>
				                         </c:forEach>
						    	</select> 
						    	<span id="sp_floorCombo"></span>
		                		<input class="nameB"  type="text" name="searchKeyword" id="searchKeyword"> 
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB">조회</span></a>
		                	</td>
		                	<td class="text-right">
		                		<a href="javascript:jqGridFunc.fn_ComInfo('Ins','0')" ><span class="deepBtn">등록</span></a>
		                		<a href="javascript:jqGridFunc.fn_tennPop();" class="deepBtn">크레딧 등록</a>
		                		<a href="javascript:userFunc.fn_ExcelUpload()" ><span class="deepBtn">Excel Upload</span></a>
		                		
		                		<a data-popup-open="dv_seatSetting" style="display:none"  class="rightGBtn" id="btn_bpop" >좌석 세팅</a>
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
            <h2>회원사 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
           
            
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*회사명 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comName" name="comName" class="input_noti" size="10"/>
                </div>                
            </div>
             <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">* 거래처 구분<span class="join_id_comment joinSubTxt"></span></p>
                    <form:select path="comGubun" id="comGubun" title="거래처구분" onChange="jqGridFunc.fn_comNumber();">
				         <form:option value="" label="구분선택"/>
                         <form:options items="${comGubun}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*사업자등록번호 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comNumber" name="comNumber" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">대표자명 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comCeoName" name="comCeoName"> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">회사 로고 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="file" id="comLogo" name="comLogo"> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">* 거래처 상태<span class="join_id_comment joinSubTxt"></span></p>
                    <form:select path="comState" id="comState" title="거래처구분">
				         <form:option value="" label="구분선택"/>
                         <form:options items="${comState}" itemValue="code" itemLabel="codeNm"/>
					</form:select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">업태<span class="join_id_comment joinSubTxt"></span></p>
                     <input type="text" id="comItem" name="comItem" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">업종 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="comBuscondition" name="comBuscondition" class="input_noti" size="10"/>
                </div>                
            </div>
             <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">전화번호<span class="join_id_comment joinSubTxt"></span></p>
                     <input type="text" id="comTel" name="comTel" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">팩스번호<span class="join_id_comment joinSubTxt"></span></p>
                     <input type="text" id="comFax" name="comFax" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">지점<span class="join_id_comment joinSubTxt"></span></p>
                    <select path="centerId" id="centerId" title="지점구분" onChange="backoffice_common.fn_floorInfo('', 'sp_floor', 'floorSeq');backoffice_common.fn_floorPlayState('', 'sp_floorCheck', 'floorPlaySeq');">
				         <option value="">지점 선택</option>
                         <c:forEach items="${searchCenter}" var="centerList">
                            <option value="${centerList.centerId}">${centerList.centerNm}</option>
                         </c:forEach>
					</select> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">근무층/예약 가능 층<span class="join_id_comment joinSubTxt"></span></p>
                    <span id="sp_floor" />
                   
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">예약 가능 층<span class="join_id_comment joinSubTxt"></span></p>
                    <span id="sp_floorCheck" />
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">크레딧 사용여부<span class="join_id_comment joinSubTxt"></span></p>
                    <label class="switch">                                               
                   	   <input type="checkbox" id="tennUseyn" onclick="toggleValue(this);" value="Y">
                       <span class="slider round"></span> 
                    </label> 
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
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div> 
    
    
    <div id='dv_userInfo' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>회원사 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*사번 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userNo" name="userNo" class="input_noti" size="10"/>
                    <span id="sp_uniCheck"></span>
                    <input type="hidden" id="uniCheck">
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*이름 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userName" name="userName" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">직책 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userRank" name="userRank" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">직급 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userPosition" name="userPosition" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*연락처 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userCellphone" name="userCellphone" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*이메일 <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="userEmail" name="userEmail" class="input_noti" size="10"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*상태<span class="join_id_comment joinSubTxt"></span></p>
                    <select id="userState"   style="width:120px">
                        <option value="">사용자상태</option>
                        <c:forEach items="${userState}" var="state">
                            <option value="${state.code}">${state.codeNm}</option>
                         </c:forEach>
                    </select>
                </div>                
            </div>
            
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:userFunc.fn_userUpdate();" class="redBtn" id="btnUserUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>   
    
   <!-- 테넌트  설정  -->
   <div data-popup="dv_seatSetting" class="popup focusPop">
        <div class="popup_con">
            <span class="button b-close">&times;</span>
            <div class="top"  id="dv_Title">크레딧 등록</div>
            <div class="con">
               <input type="number" name="tennRecCount" size="40" maxlength="80" id="tennRecCount"  onkeypress="only_num();" style="width:250px;"/> 
            </div>
            <a href="#" onClick="jqGridFunc.fn_tennUpdate()" class="greenBtn">확인</a>
        </div>
   </div>
   
   <script src="/js/needpopup.js"></script> 
   <script src="/js/jquery-ui.js"></script>
   <script type="text/javascript">
		 $(document).ready(function() { 
			   jqGridFunc.setGrid("mainGrid");
		 });
		 //bpop 확인 하기 
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
	    		    //ajax 관련 내용 정리 하기 
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
	    		 	                { label: '로고',  name:'com_logo',         index:'com_logo',        align:'left',   width:'12%', formatter: jqGridFunc.imageFomatter },
	    			                { label: '회사명', name:'com_name',       index:'com_name',      align:'center', width:'10%'},
	    			                { label: '구분', name:'com_gubun_txt',     index:'com_gubun_txt',      align:'center', width:'10%'},
	    			                { label: '거래상태', name:'code_nm',     index:'com_gubun_txt',      align:'center', width:'10%'},
	    			                { label: '지점', name:'center_nm',       index:'center_nm',      align:'center', width:'10%'},
	    			                { label: '사용층수', name:'floor_name',       index:'floor_name',      align:'center', width:'10%'},
	    			                { label: '예약가능층수', name:'floor_nm',       index:'floor_nm',      align:'center', width:'10%'},
	    			                { label: '대표자명', name:'com_ceo_name',       index:'com_ceo_name',      align:'center', width:'10%'},
	    			                { label: '주소', name:'com_addr',       index:'com_addr',      align:'center', width:'20%', formatter:jqGridFunc.address },
	    			                { label: '크레딧 여부', name:'tenn_info',       index:'tenn_info',      align:'center', width:'15%'},
	    			                { label: '최종 수정자', name:'com_updateid',      index:'com_updateid',     align:'center', width:'14%'},
	    			                { label: '최종 수정 일자', name:'com_update', index:'com_update', align:'center', width:'12%', 
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
	    		        multiselect:false, 
	    		        subGrid: true,
	    		        //여기 부분 수정 하기 
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
	    		 	                { label: '상태', name:'code_nm',       index:'code_nm',      align:'center', width:'10%'},
	    		 	                { label: '회사명', name:'com_name',     index:'com_name',      align:'center', width:'10%'},
	    		 	                { label: '사용자 상태', name:'code_nm',     index:'com_name',      align:'center', width:'10%'},
	    		 	                { label: '사번', name:'user_no',       index:'user_no',      align:'center', width:'10%'},
	    		 	                { label: '이름', name:'user_name',       index:'user_name',      align:'center', width:'10%'},
	    			                { label: '직급', name:'user_position',   index:'user_position',      align:'center', width:'10%' },
	    			                { label: '직책', name:'user_rank',       index:'user_rank',      align:'center', width:'10%' },
	    			                { label: '이메일', name:'user_email',     index:'user_email',      align:'center', width:'10%' },
	    			                { label: '연락처', name:'user_cellphone', index:'user_cellphone',      align:'center', width:'10%' },
	    			                { label: '최종 수정자', name:'user_updateid', index:'user_updateid',     align:'center', width:'10%'},
	    			                { label: '최종 수정 일자', name:'user_update', index:'com_update', align:'center', width:'12%', 
	    			                  sortable: 'date' ,formatter: "date", formatoptions: { newformat: "Y-m-d"}},
	    			                { label: '등록', name: 'btn',  index:'btn',      align:'center',  width: 50, fixed:true, sortable : false, formatter:userFunc.rowBtn}
	    			            ],  //상단면 
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
		    		          	  postData : JSON.stringify({
							    		          			"pageIndex": gridPage,
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
	            	   return '<a href="javascript:jqGridFunc.delRow(&#34;'+rowObject.com_code+'&#34;);">삭제</a>';
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
			        	$("#btnUpdate").text("수정");
			        	
			     	   var params = {"comCode" : comCode};
			     	   var url = "/backoffice/companyManage/companyDetail.do";
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
								    		backoffice_common.fn_floorInfo(obj.floor_seq,'sp_floor', 'floorSeq');
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
			        	$('input:text[name^=com]').val("");
			        	$('select[name^=com]').val("");
			        	$("#centerId").val("");
			        	toggleDefault("tennUseyn");
			        	//층 및 예약 층 삭제 
			        	$("#sp_floor").html("");
			        	$("#sp_floorCheck").html("");
			        	
			        }
	           },clearGrid : function() {
	                $("#mainGrid").clearGridData();
	           },fn_CheckForm  : function (){
				    if (any_empt_line_id("comName", "회사명을 입력해주세요.") == false) return;	
				    if (any_empt_line_id("centerId", "지점을 선택해 주세요.") == false) return;
				    if (any_empt_line_id("floorSeq", "층을 선택해 주세요.") == false) return;
				    if (any_empt_line_id("comState", "거레 상태를 선택해 주세요.") == false) return;
				    if (fn_CheckBoxMsg("사용할 층수를 선택 하지 않았습니다.", "floorPlaySeq") == false) return;	
		     		var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
		     		
		     		if (confirm(commentTxt)== true){
		     			  
		     			  //체크 박스 체그 값 알아오기 
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
		     			  formData.append('comPlayFloor' , ckeckboxValue("사용할 층수를 선택 하지 않았습니다.", "floorPlaySeq"));
		     			  formData.append('tennUseyn' , fn_emptyReplace($("#tennUseyn").val(),"N"));
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
			  }, fn_comNumber: function (){
				 //사업자 등록 번호
			  }, fn_search : function(){
				  $("#mainGrid").setGridParam({
	    	    	 datatype	: "json",
	    	    	 postData	: JSON.stringify(  {
	    	    		"pageIndex": $("#pager .ui-pg-input").val(),
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
				 //배열 값 정리 하기 
				 if (confirm('저장 하시겠습니까?')){
					 var tennArray = new Array();
					 for (var i in tenn_array){
						 
						  var TennantInfo = new Object();
						  TennantInfo.comCode = tenn_array[i];
						  TennantInfo.tennRecCount = $("#tennRecCount").val();
						  tennArray.push(TennantInfo);
					 }
					 var param =  new Object();
			         param.data = tennArray;
			         var url = "/backoffice/companyManage/tennUpdate.do";
				     uniAjax(url, param, 
		   		       	     function(result) {
	   						       if (result.status == "LOGIN FAIL"){
	   						    	   alert(result.meesage);
	   		  						   location.href="/backoffice/login.do";
	   		  					   }else if (result.status == "SUCCESS"){
		   		  					   alert('정상적으로 등록 되었습니다.');
		   		  					   $('[data-popup="dv_seatSetting"]').fadeOut(1000).bPopup().close();
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
					  alert("체크된 값이 없습니다.");
					  return;
				  }
			     
			  }  
	    }
       
	   var userFunc  = {
			    fn_userInfo : function (mode, userNo, comCode){
				   $("#btn_user").trigger("click");
				   $("#mode").val(mode);
				   $("#comCode").val(comCode);
				   if (mode == "Ins"){
					   $("#userNo").attr("style", "width:200px;");
					   $("#sp_uniCheck").html("<a href='javascript:userFunc.fn_uniCheck()'>중복체크</a>");
					   $('input:text[name^=user]').val("");
			           $('select[name^=user]').val("");
			           $("#userNo").attr('readonly', false);
			           $('#userState').val("USER_STATE_1");
			           $("#btnUserUpdate").text("등록");
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
	            	   return '<a href="javascript:userFunc.delRow(&#34;'+rowObject.user_no+'&#34;,&#34;'+rowObject.com_code+'&#34;);">삭제</a>';
	           },delRow : function (user_no, comCode){
	        	   if(user_no != "") {
	        		   var params = {'userNo':user_no };
	        		   fn_uniDelAction("/backoffice/companyManage/userDelete.do",params, "");
	        		   userFunc.fn_search(comCode);
	        	   }
		       }, fn_userUpdate : function (){
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
				   //중복 확인 
				   var params = {"userNo" : $("#userNo").val()};
				   fn_uniCheck("/backoffice/companyManage/userUniCheck.do", params, "uniCheck");
			   }, fn_ExcelUpload : function(){
				   //엑셀 업로드 
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