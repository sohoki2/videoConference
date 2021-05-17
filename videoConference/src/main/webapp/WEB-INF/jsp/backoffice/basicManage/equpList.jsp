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
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/reset.css"> 
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/popup.js"></script>
    
    <link rel="stylesheet" href="/css/needpopup.min.css" />
    <link rel="stylesheet" href="/css/needpopup.css">
    
</head>
<body>
<div id="wrapper">	
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/equpList.do">
<c:import url="/backoffice/inc/top_inc.do" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }">
<input type="hidden" name="mode" id="mode" >
<input type="hidden" name="equpCode" id="equpCode" >

<div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                                          기초관리
                        <span>></span>
                        <strong>비품 관리</strong>
                    </div>
                </div>
            </div>

            <div class="Swrap Asearch">
                <div class="Atitle">총 <span>${totalCnt}</span>건의 비품정보가 있습니다.</div>
                
                <section class="Bclear">
                	<table class="pop_table searchThStyle">
		                <tr class="tableM">
		                	<th style="width:140px">
		                		사무소별
		                	</th>
		                	<td>
		                		<form:select path="searchcenterId" id="searchcenterId" title="사무소">
							         <form:option value="" label="사무소구분"/>
			                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
							    </form:select>	
		                	</td>
		                	
		                	<th style="width:140px">
		                		검색어
		                	</th>
		                	<td>
		                		<select name="searchCondition"  id="searchCondition">
											<option  value="0">전체</option>
											<option value="1" <c:if test="${searchVO.searchCondition == '1' }"> selected="selected" </c:if>>회의실명</option>
											<option value="2" <c:if test="${searchVO.searchCondition == '2' }"> selected="selected" </c:if>>비품명</option>
											<option value="3" <c:if test="${searchVO.searchCondition == '3' }"> selected="selected" </c:if>>회사명</option>
								</select>
								<input class="nameB" type="text" name="searchKeyword" id="searchKeyword"  value="${regist.searchKeyword}">      
								 <a href="javascript:search_form();"><span class="lightgrayBtn">조회</span></a>  
		                	</td>
		                	<td class="text-right">
		                		<a href="#" onclick="view_equp('Ins','0')" data-needpopup-show="#equipPop" ><span class="deepBtn">등록</span></a>
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
                        	<th width="8%">번호</th>
                            <th width="10%">비품명</th>
                            <th width="8%">제조사</th>
                            <th width="8%">비치사무소</th>
                            <th width="8%">상태</th>
                            <th width="8%">대여일자</th>
                            <th width="8%">입고일자</th>
                            <th width="8%">사용유무</th>                            
                            <th width="10%">삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                     <c:forEach items="${resultList }" var="equpInfo" varStatus="status">
                        <tr>
                        	<td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
                            <td><a href="#" onclick="view_equp('Edt','${ equpInfo.equp_code }')" class="underline"  data-needpopup-show="#equipPop" >${ equpInfo.equipment_name }</a></td>
                            <td>${ equpInfo.company }</td>
                            <td>${ equpInfo.centernm }</td>
                            <td>${ equpInfo.equip_state_txt }</td>
                            <td>${ equpInfo.equp_indate }</td>
                            <td>${ equpInfo.equp_otdate }</td>            
                            <td>${ equpInfo.use_yn }</td>                             
                            <td><a href="javascript:del_check('${equpInfo.equp_code}');" class="grayBtn">삭제</a></td>
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
<c:import url="/backoffice/inc/bottom_inc.do" />



<div id='equipPop' class="needpopup">
        <div class="popHead">
            <h2>비품 등록</h2>
        </div>
        <!-- pop contents-->   
        <div class="popCon">
            <!--// 팝업 필드박스-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.equip.eqeuipNm" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <form:input path="equipmentName" id="equipmentName" class="input_noti" size="20"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.equip.eqeuipID" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <form:input path="equipmentId" id="equipmentId" class="input_noti" size="20"/>
                </div>                
            </div>
            <!--팝업 필드박스 //-->
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.equip.centerId" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <form:select path="centerId" id="centerId" class="popSel" title="소속" >
						     <option value=""><spring:message code="combobox.text" /></option>
	                         <form:options items="${selectCenter}" itemValue="centerId" itemLabel="centerNm"/>
				    </form:select>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.equip.company" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <form:input path="company" id="company" class="input_noti" size="20"/>
                </div>                
            </div>
            
            
            <div class="pop_box100">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="page.equip.remark" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <form:input  path="remark" size="100" maxlength="200" id="remark" class="input_noti"  />
                </div>                
            </div>
            
            <div class="pop_box50" id="divWH">
                <div class="padding15">
                    	<p class="pop_tit">*<spring:message code="page.equip.equipImg" /> <span class="join_id_comment joinSubTxt"></span></p>
				        <input name="equipImg" id="equipImg" type="file"  size="20"/>
                </div>                
            </div>
            <div class="pop_box50">
                <div class="padding15">
                    <p class="pop_tit">*<spring:message code="common.UseYn.title" /> <span class="join_id_comment joinSubTxt"></span></p>
                    <input type="radio" name="useYn" id="useYn_Y" value="Y" checked/>
                    <label for ="useYn_Y"><spring:message code="button.use" /></label>
					<input type="radio" name="useYn" id="useYn_N" value="N" />
					<label for="useYn_N"><spring:message code="button.nouse"/></label>
                </div>                
            </div>            
        </div>
        <div class="clear"></div>
         <div class="pop_footer">
            <span id="join_confirm_comment" class="join_pop_main_subTxt">내용을 모두 입력후 클릭해주세요.</span>
            <a href="javascript:fn_CheckForm();" class="redBtn" id="btnUpdate"><spring:message code="button.create" /></a>    
        </div>   
    </div> 
    
</form:form>
</div>
<script src="/js/needpopup.js"></script> 
<script src="/js/jquery-ui.js"></script>
<script type="text/javascript">
	function fn_CheckForm(){
	       if (any_empt_line_id("equipmentName", '<spring:message code="page.equip.alert01" />') == false) return;
		   if (any_empt_line_id("equipmentId", '<spring:message code="page.equip.alert02" />') == false) return;
		   if (any_empt_line_id("centerId", '<spring:message code="page.equip.alert03" />') == false) return;
		   //여기 부분에 ajax 로 할지 정리 하기 
		   var param = {
			      'equpCode' : $("#equpCode").val(),
			      'equipmentName' : $("#equipmentName").val(),
			      'equipmentId' : $("#equipmentId").val(),
			      'company' : $("#company").val(),
			      'centerId' :  $("#centerId").val(),
			      'useYn' :  fn_emptyReplace($('input[name="useYn"]:checked').val(),"Y"),
			      'remark' : $("#remark").val(),
			      'mode' : $("#mode").val()
	      };
		  uniAjax("/backoffice/basicManage/equpUpdate.do", param, 
				function(result) {
				    	alert(result.message);
						if (result.status == "SUCCESS"){
							document.location.reload();
						}else if (result.status == "LOGIN FAIL"){
							document.location.href="/backoffice/login.do";
		                }
				    },
				    function(request){
					    alert("Error:" +request.status );	       						
				    }    		
		 );
		   return;
	}
   function del_check(equpCode){
		fn_uniDel("/backoffice/basicManage/equpDelete.do"
				  , "equpCode="+ equpCode
		          , "/backoffice/basicManage/equpList.do");	
    }
    function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);				
		$("form[name=regist]").submit();
	}
	function view_equp(code, code1){
		  $('#mode').val(code);
		  $('#equpCode').val(code1);
		  if (code == "Edt"){
			  var url = "/backoffice/basicManage/equpDetail.do";
			  var param = {"equpCode" : $("#equpCode").val()};
			  
			  uniAjax(url, param, 
		     			function(result) {
						       if (result.status == "LOGIN FAIL"){
						    	   alert(result.meesage);
		  						   location.href="/backoffice/login.do";
		  					   }else if (result.status == "SUCCESS"){
	                                  $(".popHead > h2").html("비품정보 수정");
			                          $("#btnUpdate").text('수정');
		  						    //여기 부분 수정 어떻게 할지 추후 생각
		  						    var obj = result.regist;
		  						    $("#equipmentName").val(obj.equipmentName); 
		 		            	    $("#equipmentId").val(obj.equipmentId);
		 		            	    $("#centerId").val(obj.centerId);
		 		            	    $("#company").val(obj.company);
		 		            	    $("#remark").val(obj.remark);
		 		            	    $('input:radio[name=useYn]:radio[value=' + obj.useYn + ']').prop("checked", true);	 
		  					   }
						    },
						    function(request){
							    alert("Error:" +request.status );	       						
						    }    		
		          );
		  }else {
			  $("#equipmentName").val(""); 
       	      $("#equipmentId").val("");
       	      $("#centerId").val("");
       	      $("#company").val("");
       	      $("#remark").val("");
		  }
		  		  
	  }
	  function search_form(){		  
		  $("form[name=regist]").attr("action", "/backoffice/basicManage/equpList.do").submit();		  
	  }
	 
	</script>
</body>
</html>