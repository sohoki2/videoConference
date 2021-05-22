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
    
    
    
    
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/boardManage/boardList.do">	   	  
<c:import url="/backoffice/inc/top_inc.do" />	
<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="boardGubun" id="boardGubun"  value="${regist.boardGubun }">
<input type="hidden" name="boardSeq" id="boardSeq">
<input type="hidden" name="mode" id="mode">
 
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
               <table id="mainGrid"></table>
               <div id="pager" class="scroll" style="text-align:center;"></div>     
               <br />
                
                
               
            </div>
            
        </div>
    </div>
<c:import url="/backoffice/inc/bottom_inc.do" />    
</form:form>    
</div>
<script type="text/javascript">
	grid.jqGrid({
		url : '/backoffice/basicManage/centerViewAjax.do' ,
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
		        	{ label: 'floor_seq', key: true, name:'floor_seq',       index:'floor_seq',      align:'center', hidden:true},
	            	{ label: '도면이미지', name:'floor_map',       index:'floor_map',      align:'center', width:'10%', 
		        	  formatter: jqGridFunc.imageFomatter},
		                { label: '층수', name:'floor_info_txt',   index:'floor_info_txt',      align:'center', width:'10%'},
		                { label: '층이름', name:'floor_name',      index:'floor_name',      align:'center', width:'10%'},
		                { label: '좌석 현황', name:'seat_cnt',      index:'seat_cnt',      align:'center', width:'10%'},
	                { label: '회의실 현황', name:'meet_cnt',      index:'meet_cnt',      align:'center', width:'10%' },
	                { label: '사용 유무', name:'floor_useyn',    index:'floor_useyn',      align:'center', width:'10%' },
	                { label: 'floor_part', name:'floor_part',       index:'floor_part',      align:'center', hidden:true},
	                { label: '구역사용', name:'floor_part',      index:'floor_part',      align:'center', width:'10%', 
	                  formatter: jqGridFunc.partInfo	},
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
	    },
	    isHasSubGrid : function (rowId) {
	        
	    	var cell = grid.jqGrid('getCell', rowId, "floor_part");
			console.log(cell);
			if( cell === "FLOOR_PART_2") {
				return false;
			}
			return true;
		},subGridOptions : {
			plusicon: "ui-icon-triangle-1-e",
			minusicon: "ui-icon-triangle-1-s",
			openicon: "ui-icon-arrowreturn-1-e"
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
	        if (cm[index].name=='floor_map' || cm[index].name=='floor_info_txt' || cm[index].name=='floor_name'){
	        	floorService.fn_floorInfo("Edt", $(this).jqGrid('getCell', rowid, 'floor_seq'));
		    }
	        
	    }
	});

</script>
<script type="text/javascript">

	function search_form(){		  
		  $("form[name=regist]").attr("action", "/backoffice/boardManage/boardList.do").submit();		  
	}
	function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);		
		$("form[name=regist]").submit();
	}
	function view_Board(code, code1){
		  $("#mode").val(code);
		  $("#boardSeq").val(code1);  
		  if (code == "Ins"){
			  $("form[name=regist]").attr("action", "/backoffice/boardManage/boardDetail.do").submit();
		  }else {
			  $("form[name=regist]").attr("action", "/backoffice/boardManage/boardView.do").submit();  			  			  
		  }		  
	}
	function del_check(code){
		 if (confirm("삭제 하시겠습니까?")== true){
		    	apiExecute(
						"POST", 
						"/backoffice/boardManage/boardDelete.do",
						{
							boardSeq : code
						},
						null,				
						function(result) {		
							if (result != null) {
								if (result == "O"){
									alert("정상적으로 삭제되었습니다.");
								}else {
									alert("삭제시 문제가 생겼습니다");
								}					
							}else {
							        alert("삭제시 문제가 생겼습니다");							  
							}
							$("form[name=regist]").attr("action", "/backoffice/boardManage/boardList.do").submit();
						},
						null,
						null
					);	
		    }else {
		    	return;
		    }
	}  
    </script>
</body>
</html>