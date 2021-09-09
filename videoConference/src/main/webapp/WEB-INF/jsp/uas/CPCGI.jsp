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
	* - ���� Ȯ�� ������
	*	���� Ȯ�� �� ��Ÿ ���� ����
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
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="./css/style.css" type="text/css" rel="stylesheet" media="all"/>
<title>�ٳ� ��������</title>
</head>
<%
	boolean BillErr = false;

	Map TransR = new HashMap();
	Map Res = null;
	
	String TID = (String)request.getParameter("TID");
	/*
	 * - CONFIRMOPTION
	 *		0 : NONE( default )
	 *		1 : CPID �� ORDERID üũ
	 * - IDENOPTION
	 * 0 : �������(6�ڸ�) �� ���� IDEN �ʵ�� Return (ex : 1401011)
	 * 1 : �������(8�ڸ�) �� ���� ���� �ʵ�� Return (���� �Ŵ��� ����. ex : DOB=20140101&SEX=1)
	 */
	int nConfirmOption = 0;
	int nIdenOption = 0;
	TransR.put( "TXTYPE", "CONFIRM" );
	TransR.put( "TID", TID );
	TransR.put( "CONFIRMOPTION", nConfirmOption );
	TransR.put( "IDENOPTION", nIdenOption );

	/*
	 * nConfirmOption�� 1�̸� CPID, ORDERID �ʼ� ����
	 */
	if( nConfirmOption == 1 )
	{
		TransR.put( "CPID", ID );
		TransR.put( "ORDERID", ORDERID );
	}

	Res = CallTrans( TransR );

	/******************************************************
	 ** true�ϰ�� ���������� debugging �޽����� ����մϴ�.
	 ******************************************************/
	if( false )
	{
		out.print( "REQ[" + data2str(TransR) + "]<BR>" );
		out.print( "RES[" + data2str(Res) + "]<BR>" );
	}

	if( Res.get("RETURNCODE").equals("0000") )
	{
		/**************************************************************************
		 *
		 * ���������� ���� �۾�
		 *
		 **************************************************************************/
%>
<body>
<form name="CPCGI" action="/web/Success.do" method="post">

	<%= MakeFormInputHTTP(request.getParameterMap(),"TID") %>
	<%= MakeFormInput(Res,new String[]{"RETURNCODE","RETURNMSG"}) %>
</form>
<script>
	document.CPCGI.submit();
</script>
</body>
</html>
<%
	} else{
		/**************************************************************************
		 *
		 * �������п� ���� �۾�
		 *
		 **************************************************************************/

		String RETURNCODE	  	= (String)Res.get("RETURNCODE");
		String RETURNMSG	  	= (String)Res.get("RETURNMSG");
		boolean AbleBack	= false;
		String BackURL	  	= (String)request.getParameter("BackURL");
		String BgColor	  	= (String)request.getParameter("BgColor");
%>
	<%@ include file ="./Error.jsp"%>
<%
	}
%>


