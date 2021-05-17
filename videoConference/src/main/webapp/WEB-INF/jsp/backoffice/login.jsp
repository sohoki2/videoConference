<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title><spring:message code="URL.TITLE" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/global.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <style>
    html, body {overflow:hidden}
    </style>
</head>
<body>
	<!--//header-->
	<form name="regist" method="post" action="/backoffice/SecurityLogin.do" autocomplete="off">
    <header class="Mwrap">
        <section>
            <div class="subwidth">
                <h1><img src="/img/logo.png" alt="logo" /></h1>
            </div>
        </section>
    </header>
	<!--header//-->
	<!--//contents-->	
	<div id="container">
		<div class="loginBox">
			<div class="login_title">
				<p><spring:message code='button.login' /></p>
			</div>
			<div class="login_con">
				<div>
					<p><spring:message code='page.login.id' /> </p>
					<input type="text" name="adminId" id="adminId" placeholder="<spring:message code='page.login.id' />" >	
				</div>
				<div>
					<p><spring:message code='page.login.password' /></p>
					<input type="password" name="adminPassword" id="adminPassword" placeholder="<spring:message code='page.login.password' />"    autocomplete="off"/>	
				</div>
				<a href="javascript:form_check();" class="loginBtn"><spring:message code='button.login' /></a>
			</div>
		</div>
	</div>
	
	<!--contents//-->
    <div id="footer">
        <div class="contents">
            <span style="text-align:left">
                <spring:message code="BOTTOM.COPYRIGHT" />
		    </span>
            <div class="clear"></div>
        </div>
    </div>
    </form>
    <script type="text/javascript">
    function form_check(){
       if (any_empt_line_id("adminId", "<spring:message code='page.common.alert01' />") == false) return;
 	   if (any_empt_line_id("adminPassword", "<spring:message code='page.common.alert02' />") == false) return; 
 	   //$("#adminPassword").val(SHA256(SHA256($("#adminPassword").val())));
 	   //
 	   $("form[name=regist]").attr("action", "/backoffice/SecurityLogin.do").submit(); 	   
    }       
    $(document).ready(function() {
	    	if ("${message}" != "") {
	    		  if ("${message}" == "login_ok"){
	    			  alert("2")
	    			  location.href="/backoffice/resManage/resList.do?searchRoomType=swc_gubun_1";  
	    		  }else {
	    			  alert("<spring:message code='page.common.alert03' />");
		    		  $("#admin_id").focus() ;	    			  
	    		  }				
	    	}    	           	    	
    });  
    </script>
</body>
</html>