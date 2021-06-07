<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <title><spring:message code="URL.TITLE" /></title>
    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    
    <script src="/js/popup.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/jscript" src="/SE/js/HuskyEZCreator.js" ></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
</head>
<body>
<form:form name="regist" commandName="regist" method="post" action="/backoffice/popup/reasonPop.do">
<div id="wrapper">	   	  
	<input type="hidden" name="resSeq" id="resSeq" value="${regist.resSeq }">
	<input type="hidden" name="reservProcessGubun" id="reservProcessGubun" value="${ regist.reservProcessGubun }">

	<div class="pop_container">
		<!--//팝업 타이틀-->
		<div class="pop_header">
			<div class="pop_contents">
	        		<h2>사유입력</h2>	
			</div>			
		</div>
		<!--팝업타이틀//-->
		<!--//팝업 내용-->
		<div class="pop_contents">
			<table class="pop_table thStyle">
				<tbody class="search">
					<tr>							         	
			        	<td style="text-align:left">
			        		<form:select path="cancelCode" id="cancelCode" title="신청사유">
                       			<form:option value="" label="신청사유"/>
	                         	<form:options items="${selectCancel}" itemValue="code" itemLabel="codeNm" />
		    				</form:select>
			        	</td>
		        	</tr>
		        	<tr>
			        	<td style="text-align:left">
				        	<textarea rows="10" id="cancelReason" name="cancelReason" >${regist.cancelReason }</textarea>
				        </td>
		        	</tr>
				</tbody>
			</table>
		</div>
		<!--팝업 내용//-->
        <!--//팝업 버튼-->
        <div class="footerBtn">
	        	<a href="javascript:void(0);" onclick="checkForm()" class="redBtn">저장</a>
	        	<a href="javascript:self.close();" class="deepBtn">닫기</a>
            
        </div>
        <!--팝업 버튼//-->
	</div>
	
</div>
</form:form>
    <script type="text/javascript">
    
    function checkForm(){	
    	
    	 if (confirm("저장 하시겠습니까?")== true){
    		 
    		 if (any_empt_line_id("cancelCode", '취소 유형을 입력해 주세요') == false) return;
    		 if (any_empt_line_id("cancelReason", '취소 이유를  입력해 주세요') == false) return;
    		 
    		 var params = {'resSeq': $("#resSeq").val(), 'cancelCode': $("#cancelCode").val(), 
    				       'reservProcessGubun' : $("#reservProcessGubun").val(), 'cancelReason' : $("#cancelReason").val()
    		              };
    	     uniAjax("/backoffice/resManage/reservationProcessChange.do", params, 
    	  			function(result) {
    					       if (result.status == "LOGIN FAIL"){
    					    	    alert(result.message);
    								location.href="/backoffice/login.do";
    						   }else if (result.status == "SUCCESS"){
    							    alert(result.message);
    							    parent.document.location.reload();
    							    self.close();
    						   }else {
    							   alert(result.message);
    						   }
    					    },
    					    function(request){
    						    alert("Error:" +request.status );	       						
    					    }    		
    	      );
 	    }else {
 	    	return;
 	    } 	  
		  
	}
    
    </script>
    <script  type="text/javascript">
        function popup_hide(id) {
            $('#' + id).hide();
        }
    </script>
</body>
</html>





