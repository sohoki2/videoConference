<%@ page contentType="text/html; charset=euc-kr" %>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>�ٳ� ��������</title>
</head>
<body>
<%
	String nextURL = "";

	/* Ư�� URL ���� */
	//nextURL = "http://www.danal.co.kr";
 
	/* â �ݱ� Script */
	nextURL = "Javascript:self.close();";
%>
<form name="BackURL" action="<%=nextURL%>" method="post">
</form>
<script Language="Javascript">
	document.BackURL.submit();
</script>
</body>
</html>
