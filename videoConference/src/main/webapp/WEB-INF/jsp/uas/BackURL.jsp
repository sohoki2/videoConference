<%@ page contentType="text/html; charset=euc-kr" %>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>다날 본인인증</title>
</head>
<body>
<%
	String nextURL = "";

	/* 특정 URL 지정 */
	//nextURL = "http://www.danal.co.kr";
 
	/* 창 닫기 Script */
	nextURL = "Javascript:self.close();";
%>
<form name="BackURL" action="<%=nextURL%>" method="post">
</form>
<script Language="Javascript">
	document.BackURL.submit();
</script>
</body>
</html>
