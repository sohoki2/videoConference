<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*,java.io.*,java.text.*, java.net.*" %>
<%@ page import="kr.co.danal.jsinbi.HttpClient" %> 
<%@ include file="inc/function.jsp" %>
<%
	response.setHeader( "Pragma","No-cache" );

	/********************************************************************************
	*
	* �ٳ� ��������
	*
	* - ���� �Ϸ� ������
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
       
	String BgColor	= (String)request.getParameter("BgColor");
	String DI	= (String)request.getParameter("DI");
	String CI	= (String)request.getParameter("CI");
	String PHONE	= (String)request.getParameter("PHONE");
	String TID	= (String)request.getParameter("TID");
	String CARRIER	= (String)request.getParameter("CARRIER");
	String NAME	= (String)request.getParameter("NAME");

	/*
	 * Get BgColor
	 */
	BgColor = GetBgColor( BgColor );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>�ٳ� ��������</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="/uas/css/style.css" type="text/css" rel="stylesheet"  media="screen" />
<script src="/front_res/js/jquery-2.2.4.min.js"></script>
<script language="JavaScript" src="/uas/js/Common.js" type="text/javascript"></script>
<script>
  function fn_userInfo(){
	  $("#DI", opener.document).val($("#DI").val());
	  $("#CI", opener.document).val($("#CI").val());
	  $("#TID", opener.document).val($("#TID").val());
	  $("#userCellphone", opener.document).val($("#PHONE").val());
	  $("#userCellphone", opener.document).prop('readonly', true);
	  self.close();
  }
</script>
</head>
<body onload="changeFontSize();">
<input type="hidden" name="DI" id="DI" value="<%=DI%>">
<input type="hidden" name="CI" id="CI" value="<%=CI%>">
<input type="hidden" name="PHONE" id="PHONE" value="<%=PHONE%>">
<input type="hidden" name="TID" id="TID" value="<%=TID%>">
<input type="hidden" name="CARRIER" value="<%=CARRIER%>">
<input type="hidden" name="NAME" value="<%=NAME%>">
	<div class="Wrap">
    <!--HEADER START-->
        <div class="header01">
			<ul>
				<li><h1>�ٳ� ����Ȯ�� ����</h1></li>
				<li class="ci_danal">�ٳ��ΰ�</li>
			</ul>
        </div>
    <div class="step bg_<%=BgColor%>">
        <ul>
		<li><b>���� ����</b></li>
        </ul>
    </div>
    <div class="header02">
        <div class="wrap_txtsize">
            <button class="btn_minus" onClick="return false;">-</button>
            <p class="txtsize">�۾�ũ��</p>
            <button class="btn_plus" onClick="return false;">+</button>
        </div>
    </div>
    <!--//HEADER END-->
    <!--CONTENT START-->
    <div class="content">
        <div class="wrap_content"> <!--���̾��˾��� ���� ��� style="display: none;"-->
            <div class="box_style03">
				<p>���������� ���� ó���Ǿ����ϴ�.</p>
            </div>
            <ul class="notice">
                <li class="bullet">�ٳ� ������ : 1566-3355 (���� 9�� ~ 19�� ��ȭ���� / ��,��,������ �޹�)</li>
            </ul>
        </div>
        <div class="btnfucntion">
            <label for="okay" ><input id="okay" class="bg_<%=BgColor%>" onClick="fn_userInfo()" type="button" value="Ȯ��" /></label>
        </div>
        <ul class="certification">
            <li class="wau">�����ټ� ������ũ</li>
        </ul>
    </div>
    <!--//CONTENT END-->
    <!--BOARD START-->
    <div class="board">
	<ul>
		<li class="field">��������</li>
		<li class="value">�ٳ� ���������� �̿����ּż� �����մϴ�. (���� 1566-3355)</li>
	</ul>
    </div>
    <!--//BOARD END-->
</div>

</body>
</html>