<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*,java.io.*,java.text.*, java.net.*" %>
<%@ page import="kr.co.danal.jsinbi.HttpClient" %> 
<%@ include file="inc/function.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("euc-kr");
	
	/********************************************************************************
	*
	* �ٳ� ��������
	*
	* - ���� ��û ������
	*	CP���� �� ��Ÿ ���� ����
	*
	* ���� �ý��� ������ ���� ���ǻ����� �����ø� ���񽺰��������� ���� �ֽʽÿ�.
	* DANAL Commerce Division Technique supporting Team
	* EMail : tech@danal.co.kr
	*
	********************************************************************************/
	
	/********************************************************************************
	 *
	 * XSS ����� ������ ���� 
	 * ��� ���������� �Ķ���� ���� ���� �����ϴ� ������ �߰��� ���� �ǰ� �帳�ϴ�.
	 * XSS ������� ������ ��� ���������� �����ϴ� �������� �������� �������� ��ũ��Ʈ�� ����� �� �ֽ��ϴ�.
	 * ���� ��å
	 *  - html tag�� ������� �ʾƾ� �մϴ�.(html �±� ���� white list�� �����Ͽ� �ش� �±׸� ���)
	 *  - <, >, &, " ���� ���ڸ� replace���� ���� ��ȯ�Լ��� ����Ͽ� ġȯ�ؾ� �մϴ�.
	 * 
	 ********************************************************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�ٳ� ��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<%
	/********************************************************************************
	 *
	 * [ ���� ��û ������ ] *********************************************************
	 *
	 ********************************************************************************/
	
	/***[ �ʼ� ������ ]************************************/
	Map TransR = new HashMap();
	
	/******************************************************
	 ** �Ʒ��� �����ʹ� �������Դϴ�.( �������� ������ )
	 * TXTYPE       : ITEMSEND
	 * SERVICE		: UAS
	 * AUTHTYPE		: 36
	 ******************************************************/
	TransR.put( "TXTYPE", "ITEMSEND" );
	TransR.put( "SERVICE", "UAS" );
	TransR.put( "AUTHTYPE", "36" );

	/******************************************************
	 * CPID 	 : �ٳ����� ������ �帰 ID( function ���� ���� )
	 * CPPWD	 : �ٳ����� ������ �帰 PWD( function ���� ���� )
	 * TARGETURL : ���� �Ϸ� �� �̵� �� �������� FULL URL
	 * CPTITLE   : �������� ��ǥ URL Ȥ�� APP �̸� 
	 ******************************************************/
	TransR.put( "CPID", ID );
	TransR.put( "CPPWD", PWD );
	TransR.put( "TARGETURL", "http://localhost:8080/web/CPCGI.do" );
	TransR.put( "CPTITLE", "www.danal.co.kr" );
	
	/***[ ���� ���� ]**************************************/
	/******************************************************
	 * USERID       : ����� ID
	 * ORDERID      : CP �ֹ���ȣ	 
	 * AGELIMIT		: ���� ��� ���� ���� ����( ������ �ʿ� �� ��� )
	 ******************************************************/
	TransR.put( "USERID", "USERID" );
	TransR.put( "ORDERID", ORDERID );	
	// TransR.put( "AGELIMIT", "019" );
	
	/********************************************************************************
	 *
	 * [ CPCGI�� HTTP POST�� ���޵Ǵ� ������ ] **************************************
	 *
	 ********************************************************************************/
	
	/***[ �ʼ� ������ ]************************************/
	Map ByPassValue = new HashMap();
	
	/******************************************************
	 * BgColor      : ���� ������ Background Color ����
	 * BackURL      : ���� �߻� �� ��� �� �̵� �� �������� FULL URL
	 * IsCharSet	: charset ����( EUC-KR:deault, UTF-8 )
	 ******************************************************/
	ByPassValue.put( "BgColor", "00" );
	ByPassValue.put( "BackURL", "http://localhost:8080/BackURL.do" );
	ByPassValue.put( "IsCharSet", CHARSET );
	
	
	/***[ ���� ���� ]**************************************/
	/******************************************************
	 ** CPCGI�� POST DATA�� ���� �˴ϴ�.
	 **
	 ******************************************************/
	ByPassValue.put( "ByBuffer", "This value bypass to CPCGI Page") ;
	ByPassValue.put( "ByAnyName", "AnyValue" );
	
	Map Res = CallTrans( TransR );
	
	/******************************************************
	 ** true�ϰ�� ���������� debugging �޽����� ����մϴ�.
	 ******************************************************/
	if( false )
	{
		out.print( "REQ[" + data2str(TransR) + "]<BR>" );
		out.print( "RES[" + data2str(Res) + "]<BR>" );
		return;
	}
	
	if( Res.get("RETURNCODE").equals("0000") ) {
%>
<body>
<form name="Ready" action="https://wauth.teledit.com/Danal/WebAuth/Web/Start.php" method="post">

	<%= MakeFormInput(Res,new String[]{"RETURNCODE","RETURNMSG"}) %>
	<%= MakeFormInput(ByPassValue, null) %>

</form>
<script Language="JavaScript">
	document.Ready.submit();
</script>
</body>
</html>
<%
	} else {
		/**************************************************************************
		 *
		 * ���� ���п� ���� �۾�
		 *
		 **************************************************************************/

		String RETURNCODE		= (String)Res.get("RETURNCODE");
		String RETURNMSG		= (String)Res.get("RETURNMSG");
		boolean AbleBack	= false;
		String BackURL		= (String)ByPassValue.get("BackURL");
		String BgColor		= (String)ByPassValue.get("BgColor");
%>
	<%@ include file ="./Error.jsp"%>
<%
	}
%>