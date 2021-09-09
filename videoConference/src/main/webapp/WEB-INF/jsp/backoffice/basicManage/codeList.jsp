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
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <script src="/js/jquery.min.js"></script>
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script> 
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<div id="wrapper">
<form:form name="regist" commandName="regist" method="post" action="/backoffice/basicManage/codeList.do">	   
   <input type="hidden"  name="idCheck" id="idCheck">	    
   <input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }">
   <input type="hidden" name="mode" id="mode" > 
   <input type="hidden" name="code_d" id="code_d" > 
   <input type="hidden" name="right_V" id="right_V" > 
   
   <c:import url="/backoffice/inc/top_inc.do" />     
   
   
   <div class="Aconbox">
        <div class="rightT">
            <div class="Smain">
                <div class="Swrap Stitle">
                    <div class="infomenuA">
                        <img src="/images/home.png" alt="homeicon" />
                        <span>></span>
                        <spring:message code="menu.menu01" />
                        <span>></span>
                        <strong><spring:message code="menu.menu01" /></strong>
                    </div>
                    </div>
                </div>
                <div class="Swrap Asearch">
                 <div class="Atitle">총 <span>${totalCnt}</span>건의 기초 코드가 있습니다.</div>
                    </div>
            </div>

            
            <div class="Swrap tableArea">
                <div class="code_width">
                    <div class="code_text margin-top10">
                        <span>
                            <input type="text" size="14" name="searchKeyword" id="searchKeyword" value="${searchVO.searchKeyword}" class="nameB" placeholder="">
                            <a href="javascript:search_form()" class="lightgrayBtn"><spring:message code="button.inquire" /></a>
                        </span>
                        <span>
                            <form:input path="codeId" id="codeId" title="코드" size="14" class="nameB"/>
                            <a href="javascript:fn_idCheck('Basic');" class="lightgrayBtn" id="btn_idCheck">
                            <spring:message code="page.common.btn.UniCheck" />
                            </a>
                        </span>
                        <span>
                            <form:input path="codeIdNm" id="codeIdNm" class="nameB" title="코드명" size="14" />
                            <a href="javascript:codeUpdate('Ins','0');" id="btn_update" class="blueBtn"><spring:message code="button.create" /></a>
                        </span>
                    </div>
                    <table class="margin-top30 backTable">
                        <thead>
                            <tr>
                                <th><spring:message code="page.code.codeId" /></th>
                                <th><spring:message code="page.code.codeNm" /></th>
                                <th><spring:message code="button.update" /> | <spring:message code="button.delete" /></th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${resultlist }" var="codeinfo" varStatus="status">
                            <tr>
                                <td><a href="javascript:fn_viewSubCodeLit('${codeinfo.codeId}')">${codeinfo.codeId }</a></td>
                                <td><a href="javascript:fn_viewSubCodeLit('${codeinfo.codeId}')">${codeinfo.codeIdNm }</a></td>
                                <td>
                                    <a href="javascript:codeUpdate('EdtD','${codeinfo.codeId}');" class="reviseBtn">
                                    <spring:message code="button.update" />
                                    </a>
                                    <a href="javascript:codeUpdate('Del','${codeinfo.codeId}');" class="grayBtn">
                                    <spring:message code="button.delete" />
                                    </a>
                                </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                    </table> 
                    <div class="pagenum margin-top30">
                        <div class="pager">
                          <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"  />  
                        </div>
                    </div>   
                </div>                            
                <div class="code_width rightListBox">                
                    <span id="detailTable" ></span>
                </div> 
                <div class="clear"></div> 
            </div>
        </div>   
 <c:import url="/backoffice/inc/bottom_inc.do" />    
 </form:form>     
  <script type="text/javascript">
    function linkPage(pageNo) {
		$(":hidden[name=pageIndex]").val(pageNo);				
		$("form[name=regist]").submit();
	   }    
    $(document).ready(function() {        
    	    if ($("#mode").val()== ""){ $("#mode").val("Ins"); }
    	   if ("${status}" != "") {
	    		if ("${status}" == "SUCCESS") {
	    			alert('<spring:message code="success.request.msg" />');    		
	    			$("#CodeId").val('') ;
					$("#codeDNm").val('');
					 location.href = "/backoffice/basicManage/codeList.do";
	    		}else{
	    			alert('<spring:message code="fail.request.msg" />');
	    			$("#CodeId").val('') ;
					$("#codeDNm").val('');
					 location.href = "/backoffice/basicManage/codeList.do";
	    		}
	    	}    
        });
    </script>
    <script type="text/javascript">
        function codeDetail_insert(mode, codeId){
        	
        	 if (any_empt_line_id("codeDNm", '<spring:message code="page.code.code.alert" />') == false) return;
        	 mode = $("#subBtnTxt").text() == "수정" ? "Edt" : "Ins";
       		 var param = { codeId : $("#codeId").val(), code : codeId, codeNm: $("#codeDNm").val(), 
       				       codeDc :  $("#codeDc").val(), mode :  mode
       				      };
       		 if (mode == "Edt") 
       			param.code = $("#code").val();
       		    uniAjax("/backoffice/basicManage/CodeDetailUpdate.do", param, 
           			function(result) {
   					    fn_RightView(result);
   				    },
   				    function(request){
   					    alert("Error:" +request.status );	       						
   				    }    		
           	 );
        }
        //상세
        function codeUpdate(code, code1){
        	$("#mode").val(code);        	
        	if (code== "Ins"){
        		if (any_empt_line_id("codeId", '<spring:message code="page.code.code.alert01" />') == false) return;
        		if (fn_UniCheckAlert("idCheck", "codeId") == false) return;
        		$("form[name=regist]").attr("action", "/backoffice/basicManage/codeUpdate.do").submit();
        	}else if (code=="EdtD") {
        		$("#mode").val('Edt');
        		$("#codeId").val(code1) ;
        		var url = "/backoffice/basicManage/codeDetail.do";
        		var param =  {"codeId" : $("#codeId").val()}
        		uniAjaxSerial(url, param, 
   		     			function(result) {
   						       if (result.status == "LOGIN FAIL"){
   								   location.href="/backoffice/login.do";
   		  					   }else if (result.status == "SUCCESS"){
   	                               //관련자 보여 주기 
   	                                var obj = result.regist;
   	                                $("#codeIdNm").val(obj.codeIdNm);
   	                                $("#btn_idCheck").hide();
	       						    $("#btn_update").prop("href", "javascript:codeUpdate('Edt','" + $("#codeId").val() + "')").text("코드 수정")
	       					   }else{
   		  						  alert(result.message); 
   		  					   }
   						    },
						    function(request){
							    alert("Error:" +request.status );	       						
						    }    		
   		        );
             }else if (code == "Del") {            	 
            	 $("#codeId").val(code1) ;
            	 $("form[name=regist]").attr("action", "/backoffice/basicManage/codeDelete.do").submit();
             }else {
            	 $("#codeId").val(code1) ;
            	 $("form[name=regist]").attr("action", "/backoffice/basicManage/codeUpdate.do").submit();
             }
        	
        }
        //right info
        function fn_viewSubCodeLit(code){
        	if ( $("#right_V").val() == ""){
        		$("#right_V").val("Y");
        		$("#detailTable").html('');  
            	$("#codeId").val(code);  
            	var param = { codeId : code };
            	uniAjax("/backoffice/basicManage/CmmnDetailCodeList.do", param, 
            			function(result) {
    					    fn_RightView(result);
    				    },
    				    function(request){
    					    alert("Error:" +request.status );	       						
    				    }    		
            	);
        	}else {
        		$("#right_V").val("");
        		$("#detailTable").html('');  
            	$("#codeId").val("");  
        		
        	}
        	
        }
        function fn_idCheck(gubun){
        	var input_id; 
        	var idCheck_Nm;
        	if (gubun == "Basic"){
        		input_id = "codeId";
        		idCheck_Nm = "idCheck";
        	}
        	url = "/backoffice/basicManage/codeIDCheck.do"
        	var param =  {"codeId" : $("#"+input_id).val()};
        	if ($("#"+input_id).val() != ""){
        		uniAjaxSerial(url, param, 
	        			    function(result) {	
        			           if (result != null) {	       	
        			        	   if (result.status == "SUCCESS"){
        			        		    if (result.result == "OK"){
											alert('<spring:message code="common.codeOk.msg" />');
											$("#"+idCheck_Nm).val("Y");	
										}else {
											alert('<spring:message code="common.codeFail.msg" />');
											$("#"+idCheck_Nm).val("N");
										}						
									}else {
										alert('<spring:message code="common.codeFail.msg" />');
										$("#"+idCheck_Nm).val("N");
									}
								}
							},
						    function(request){
							    alert("Error:" +request.status );	       						
						    }    		
		        ); 
        	}else {
        		 alert ('<spring:message code="common.alertcode.msg" />');
   		    	 $("#"+input_id).focus();
   		    	 return;	
	        }
        }
         
        function del_code(code, code1, mode){
        	
        	
        	var param = { code: code, codeId : code1 };
        	var url = (mode == "Edt") ? "CmmnDetailView.do" : "codeDetailCodeDelete.do"
        	uniAjax("/backoffice/basicManage/"+ url, param, 
        			function(result) {
        		        if (mode == "Del"){
        		        	$("#detailTable").html('');
        		        	var didDetailHtm = "";
        		        	fn_RightView(result);
        		        }else {
        		        	if (result.status == "SUCCESS"){
        		        		$("#codeDNm").val(result.detaulCode.codeNm);
        		        		$("#codeDc").val(result.detaulCode.codeDc);
        		        		$("#code").val(result.detaulCode.code);
        		        		$("#subBtnTxt").text("수정");
        		        	}else {
        		        		alert("Error:" +result.message );	  
        		        	}
        		        }
				    },
				    function(request){
					    alert("Error:" +request.status );	       						
				    }    		
        	);
        }
        //우측 화면 보기
        function fn_RightView(result){
        	var didDetailHtm = "";
        	$("#mode").val("Ins");
        	
        	didDetailHtm = "<table class='backTable'><thead><tr><th>분류명</th><th>기타</th><th>수정 | 삭제</th></tr></thead><tbody>";
			if (result != null) {
				
				if (result.cmDetailLst != null) {
					for (var i=0; i<result.cmDetailLst.length; i++) {
						var obj = result.cmDetailLst[i];
						didDetailHtm += "<tr><td>"+ obj.codeNm  +"</td>"
						                      +   "<td>&nbsp;"+ obj.codeDc  +"</td>"
						                      +   "<td>&nbsp;<a href='javascript:del_code(&#39;"+ obj.code  +"&#39;,&#39;"+ $("#codeId").val()  +"&#39;, &#39;Edt&#39;)' class='reviseBtn'>수정</a>"
						                      +   " | <a href='javascript:del_code(&#39;"+ obj.code  +"&#39;,&#39;"+ $("#codeId").val()  +"&#39;, &#39;Del&#39;)' class='grayBtn'>삭제</a></td>"
						                      +  "</tr>";	     									
					}	  
				}    
				didDetailHtm += "</tbody></table>";
				didDetailHtm += "<div class='code_text margin-top10'>";
				didDetailHtm += "<input  type='hidden' name='code' id='code'  />";		 
				didDetailHtm += "<input  type='text' name='codeDNm' id='codeDNm' title='분류명' size='15' />";		   
				didDetailHtm += "<input  type='text' name='codeDc' id='codeDc' title='기타' size='15' />";
				didDetailHtm += "<span><a href='javascript:codeDetail_insert(&#39;Ins&#39;,&#39;0&#39;);' class='blueBtn' id='subBtnTxt'>등록</a></span>";
				didDetailHtm += "</div>";	 
			
			$("#detailTable").html(didDetailHtm);
			}
        }
        function search_form(){
        	$("form[name=regist]").attr("action", "/backoffice/basicManage/codeList.do").submit();        	
        }
        
    </script>  
</body>
</html>