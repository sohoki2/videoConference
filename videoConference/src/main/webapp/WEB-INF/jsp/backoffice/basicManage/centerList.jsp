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
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/jscript" src="/js/SE/js/HuskyEZCreator.js" ></script>
    <script src="/js/popup.js"></script>
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
    <script type="text/javascript">
	$(document).ready(function() { 
		   jqGridFunc.setGrid("mainGrid");
	 });
    var jqGridFunc  = {
    		
    		setGrid : function(gridOption){
    			 var grid = $('#'+gridOption);
    		    //ajax 관련 내용 정리 하기 
    		   
                var postData = {"pageIndex": "1"};
    		    grid.jqGrid({
    		    	url : '/backoffice/basicManage/centerListAjax.do' ,
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
    		 	                { label: 'center_id', key: true, name:'center_id',       index:'msg_seq',      align:'center', hidden:true},
    			                { label: '지점',  name:'center_img',         index:'center_img',        align:'left',   width:'12%', formatter: jqGridFunc.imageFomatter },
    			                { label: '지점명', name:'center_nm',       index:'center_nm',      align:'center', width:'10%'},
    			                { label: '주소', name:'center_addr1',       index:'center_addr1',      align:'center', width:'20%', formatter:jqGridFunc.address },
    			                { label: '사용유무', name:'center_use_yn',       index:'center_use_yn',      align:'center', width:'10%'},
    			                { label: '작성자', name:'center_update_user_id',      index:'center_update_user_id',     align:'center', width:'14%'},
    			                { label: '최종 수정 일자', name:'center_update_date', index:'center_update_date', align:'center', width:'12%', 
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
    		            alert(error); 
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
    	                if (cm[index].name=='center_img'){
    	                	$("#centerId").val( $(this).jqGrid('getCell', rowid, 'center_id'));
    	                	$("form[name=regist]").attr("action", "/backoffice/basicManage/centerView.do").submit();
    	                	
            		    }
    	                if (cm[index].name=='center_nm'){
    	                	jqGridFunc.fn_CenterInfo("Edt", $(this).jqGrid('getCell', rowid, 'center_id'));
            		    }
    	            }
    		    });
    		}, imageFomatter: function(cellvalue, options, rowObject){
    		   //이미지 URL	
    		   var centerImg = (rowObject.center_img == "no_image.gif") ? "/img/no_image.gif": "/upload/"+ rowObject.center_img;
    		   return '<img src="' + centerImg + ' " style="width:120px">';
    		},address : function(cellvalue, options, rowObject){
    		   return rowObject.center_zipcode + "<br>"+ CommonJsUtil.NVL(rowObject.center_addr1) +"  "+ CommonJsUtil.NVL( rowObject.center_addr2)
    		},rowBtn: function (cellvalue, options, rowObject){
               if (rowObject.center_id != "")
            	  return '<a href="javascript:jqGridFunc.delRow(&#34;'+rowObject.center_id+'&#34;);">삭제</a>';
            },refreshGrid : function(){
	           $('#mainGrid').jqGrid().trigger("reloadGrid");
	        },fn_search: function(){
	    	   $("#mainGrid").setGridParam({
	    	    	 datatype	: "json",
	    	    	 postData	: JSON.stringify(  {
	    	    		"pageIndex": $("#pager .ui-pg-input").val(),
	         			"searchKeyword" : $("#searchKeyword").val(),
	         			"pageUnit":$('.ui-pg-selbox option:selected').val()
	         		}),
	    	    	loadComplete	: function(data) {$("#sp_totcnt").text(data.paginationInfo.totalRecordCount);}
	    	     }).trigger("reloadGrid");
 
	        }, delRow : function (center_id){
        	   if(trim(center_id) != "") {
        		   var params = {'centerId':trim(center_id) };
        		   $("#searchKeyword").val("")
        		   fn_uniDelAction("/backoffice/basicManage/centerDelete.do",params, "jqGridFunc.fn_search");
		        }
            },clearGrid : function() {
                $("#mainGrid").clearGridData();
            },fn_floorChange:function(floorinfo){
        	 //층수로 input 생성 
	        	 if ($("#startFloor").val() != "" && $("#endFloor").val() != ""){
	        		 if (fnIntervalCheck($("#startFloor").val().replace("CNETER_FLOOR_", ""),$("#endFloor").val().replace("CNETER_FLOOR_", ""), "시작 층수가 종료 층수 보다 큽니다.") == false) return;
	        		   fnCreatCheckbox("sp_floorInfo", $("#startFloor").val().replace("CNETER_FLOOR_", ""),  $("#endFloor").val().replace("CNETER_FLOOR_", ""), floorinfo, "floorInfos", "층") ;
	        	 }
            },fn_CenterInfo : function (mode, centerId){
        	    $("#btn_message").trigger("click");
        	    $("#mode").val(mode);
        	    if (mode == "Ins"){
        	    	$('input:text[name^=center]').val("");
      			    $("#centerId").attr('readonly', true);
      			    $("#startFloor").val("");
      			    $("#endFloor").val("");
      			    $("#centerAddr1").val("");
	            	$("#centerAddr2").val("");
	            	$("#centerTel").val("");
	            	$("#centerFax").val("");
      			    $(".popHead > h2").html("센터정보 등록");
                    $("#btnUpdate").text('등록');
                    $("#sp_floorInfo").empty();
                    toggleDefault("centerUseYn")
      		    }else {
      			  var url = "/backoffice/basicManage/centerDetail.do";
      			  var param = {"centerId" : centerId};
      			  uniAjax(url, param, 
      		     			function(result) {
      						       if (result.status == "LOGIN FAIL"){
      						    	   alert(result.meesage);
      		  						   location.href="/backoffice/login.do";
      		  					   }else if (result.status == "SUCCESS"){
      	                                $(".popHead > h2").html("센터정보 수정");
      			                        $("#btnUpdate").text('수정');
      		  						    var obj = result.regist;
      		  						    
      		  						    $("#centerId").val(obj.center_id).attr('readonly', true); 
      		 		            	    $("#centerNm").val(obj.center_nm);
      		 		            	    $("#centerAddr1").val(obj.center_addr1);
      		 		            	    $("#centerAddr2").val(obj.center_addr2);
      		 		            	    $("#centerTel").val(obj.center_tel);
      		 		            	    $("#centerFax").val(obj.center_fax);
      		 		            	    $("#startFloor").val(obj.start_floor);
      		 	      			        $("#endFloor").val(obj.end_floor);
      		 		            	    toggleClick("centerUseYn", obj.center_use_yn);
      		 		            	    $("#ir3").val(obj.center_info);
      		 		            	    fnCreatCheckbox("sp_floorInfo", $("#startFloor").val().replace("CNETER_FLOOR_", ""),  $("#endFloor").val().replace("CNETER_FLOOR_", ""), obj.floor_info, "floorInfos", "층") ;
      		  					   }
      						    },
      						    function(request){
      							    alert("Error:" +request.status );	       						
      						    }    		
      		       );
      		  }
           },fn_CheckForm  : function (){
        	  if (any_empt_line_id("centerNm", "사무소명을 입력해주세요.") == false) return;		  
     		  if (any_empt_line_id("centerAddr1", "주소를 입력해주세요.") == false) return;
     		  if (any_empt_line_id("centerTel", "사무소연락처를 입력해주세요.") == false) return;
     		  
     		  var commentTxt = ($("#mode").val() == "Ins") ? "등록 하시겠습니까?":"저장 하시겠습니까?";
     		
     		  if (confirm(commentTxt)== true){
     			  
     			  var floorInfo = ckeckboxValue("체크된 층수가 없습니다.", "floorInfos");
     			  var sHTML3 = oEditors.getById["ir3"].getIR();
     			  $("#centerInfo").val(sHTML3); 
     			  //체크 박스 체그 값 알아오기 
     			  var formData = new FormData();
     			  formData.append('centerImg', $('#centerImg')[0].files[0]);
     			  formData.append('centerSeatImg', $('#centerSeatImg')[0].files[0]);
     			  formData.append('centerId' , $("#centerId").val());
     			  formData.append('centerNm' , $("#centerNm").val());
     			  formData.append('centerAddr1' , $("#centerAddr1").val());
     			  formData.append('centerAddr2' , $("#centerAddr2").val());
     			  formData.append('centerTel' , $("#centerTel").val());
     			  formData.append('centerFax' , $("#centerFax").val());
     			  formData.append('mode' , $("#mode").val());
     			  formData.append('centerInfo' , $("#centerInfo").val());
     			  formData.append('startFloor' , $("#startFloor").val());
     			  formData.append('endFloor' , $("#endFloor").val());
     			  formData.append('floorInfo' , floorInfo);
     			  formData.append('centerUseYn' , fn_emptyReplace($("#centerUseYn").val(),"N"));
     		      uniAjaxMutipart("/backoffice/basicManage/centerUpdate.do", formData, 
     						function(result) {
     						       //결과값 추후 확인 하기 	
     		    	               if (result.status == "SUCCESS"){
     		    	                	
     		    	               }else if (result.status == "LOGIN FAIL"){
     									document.location.href="/backoffice/login.do";
     				               }
     		    	               need_close();
     		    	               jqGridFunc.fn_search();
     						    },
     						    function(request){
     							    alert("Error:" +request.status );	       						
     						    }    		
     			  );
     		    	
     		  } 
		  }   
    }
  </script>
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post"   action="/backoffice/basicManage/empList.do">
<c:import url="/backoffice/inc/top_inc.do" />

<input type="hidden" name="pageIndex" id="pageIndex">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="centerInfo" id="centerInfo" >
<input type="hidden" name="floorInfo" id="floorInfo" >
<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                        <spring:message code="menu.menu01" />
                        <span>></span>
                        <strong><spring:message code="menu.menu01_2" /></strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">총 지점 <span id="sp_totcnt" /></div>
                <section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th><spring:message code="search.chooseTxt" /></th>
		                	<td>
		                		<input class="nameB" type="text" name="searchKeyword" id="searchKeyword" >  
								<a href="javascript:jqGridFunc.fn_search();"><span class="searchTableB"><spring:message code="button.inquire" /></span></a>
		                	</td>
		                	<td class="text-right">
		                		  <a href="#" onclick="jqGridFunc.fn_CenterInfo('Ins','0')" data-needpopup-show="#centerPop"><span class="deepBtn"> <spring:message code="button.create" /></span></a>
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
    
   
   <div id='centerPop' class="needpopup">
        <div class="popHead" id="popTitle">
            <h2>센터 관리</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.center.Id" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="centerId" name="centerId" class="input_noti" size="10"/>     
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.center.name" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" id="centerNm" name="centerNm" class="input_noti" size="20"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.center.file01" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="file" id="centerImg" name="centerImg"> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.center.file02" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="file" id="centerSeatImg" name="centerSeatImg">
                </div>                
            </div>
            <div class="pop_box1000">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.center.address" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input title="주소1" id="centerAddr1" size="50" />-
                    <input title="주소2" id="centerAddr2" size="50" />
                </div>                
            </div>
            <!--팝업 필드박스 //-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.center.telInfo" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="text" title="연락처" id="centerTel" size="30" />
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.center.faxInfo" /> <span class="join_id_comment joinSubTxt"></span></p>
                      <input type="text" title="연락처" id="centerFax" size="30" />
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">층 선택 <span class="join_id_comment joinSubTxt"></span></p>
                     <select id="startFloor" onChange="jqGridFunc.fn_floorChange('')" style="width:120px">
                        <option value="">시작 층수</option>
                         <c:forEach items="${floorInfo}" var="floorList">
                            <option value="${floorList.code}">${floorList.codeNm}</option>
                         </c:forEach>
                    </select>
                    <select id="endFloor" onChange="jqGridFunc.fn_floorChange('')"  style="width:120px">
                        <option value="">종료 층수</option>
                        <c:forEach items="${floorInfo}" var="floorList">
                            <option value="${floorList.code}">${floorList.codeNm}</option>
                         </c:forEach>
                    </select> 
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">사용 층 <span class="join_id_comment joinSubTxt"></span></p>
                    <span id="sp_floorInfo"></span>  
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="common.UseYn.title" /> <span class="join_id_comment joinSubTxt"></span></p>
                       <label class="switch">                                               
                   	   <input type="checkbox" id="centerUseYn" onclick="toggleValue(this);" value="Y">
                       <span class="slider round"></span> 
                    </label> 
                </div>                
            </div>
            <div class="pop_box1000">
                <div class="padding15">
                    <p class="pop_tit"><spring:message code="page.center.info" /> <span class="join_id_comment joinSubTxt"></span></p>
                     <textarea name="ir3" id="ir3" style="width:700px; height:20px; display:none;">${regist.centerInfo }</textarea>
                </div>                
            </div>
            
                
                
                
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:jqGridFunc.fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div>  
    
<c:import url="/backoffice/inc/bottom_inc.do" /> 
<button id="btn_message" style="display:none" data-needpopup-show='#centerPop'>확인1</button>

<script src="/js/needpopup.js"></script> 
<script src="/js/jquery-ui.js"></script>


</form:form>
</div>
       
 <script type="text/javascript">
	 var oEditors = [];
	 nhn.husky.EZCreator.createInIFrame({
	     oAppRef: oEditors,
	     elPlaceHolder: "ir3",                        
	     sSkinURI: "/js/SE/SmartEditor2Skin.html",
	     htParams: { bUseToolbar: true,
	         fOnBeforeUnload: function () { },
	         //boolean 
	         fOnAppLoad: function () { }
	         //예제 코드
	     },
	     fCreator: "createSEditor2"
	 });
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