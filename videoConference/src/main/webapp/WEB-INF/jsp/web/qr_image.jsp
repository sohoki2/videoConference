<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title><spring:message code="URL.TITLE" /></title>

    <!--css-->
    <link href="/front_res/css/reset.css" rel="stylesheet" />
    <link href="/front_res/css/jquery-ui.css" rel="stylesheet" />
    <link href="/front_res/css/needpopup.min.css" rel="stylesheet" type="text/css" >
    <link href="/front_res/css/style.css" rel="stylesheet" />
    <link href="/front_res/css/paragraph.css" rel="stylesheet" />
    <link href="/front_res/css/widescreen.css" rel="stylesheet" media="only screen and (min-width : 1080px)">
    <link href="/front_res/css/mobile.css" rel="stylesheet" media="only screen and (max-width:1079px)">
    <!--js-->
    <script src="/front_res/js/jquery-2.2.4.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/jquery-ui.min.js"></script>
    <script src="/front_res/js/common.js"></script>
    <script src="/front_res/js/pinch-zoom.umd.js"></script>
    <script src="/front_res/js/qrcode.js"></script>

</head>
</head>
<body>
<div class="qr_wrap">
	<form:form name="regist" commandName="regist" method="post" >
	   <input type="hidden" name="qrInfo" id="qrInfo" value="${regist.visited_qrcode }" />
	   <div class="qr_header">
			<p>출입을 위한 QR코드</p>
			<span>방문지에서 전달 받은<br>QR코드를 통해 체크인하세요.</span>
		</div>
	   <div class="led_group" align="center">	   		
			<div class="qr_pin">
				<div id="qrImage" />
			</div>
	   </div>
	</form:form>
</div>
    <script type="text/javascript">
        var qrcode = new QRCode(document.getElementById("qrImage"), {
          width: 150,
          height: 150
        });
        $( function() {
	    	qrcode.makeCode($("#qrInfo").val());
	    });
    </script>
</body>
</html>