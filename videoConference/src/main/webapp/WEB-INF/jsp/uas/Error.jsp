<%@ page contentType="text/html; charset=euc-kr" %>
<%
	/*
	 * Get BgColor
	 */
	 BgColor = GetBgColor( BgColor );
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>�ٳ� ��������</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="/uas/css/style.css" type="text/css" rel="stylesheet"  media="screen" />
<script src="/front_res/js/jquery-2.2.4.min.js"></script>
<script language="JavaScript" src="/uas/js/Common.js" type="text/javascript"></script>
</head>
<body onload="changeFontSize();">
	
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
		<li><b>�������񽺿���</b></li>
        </ul>
    </div>
    <div class="header02">
        <div class="wrap_txtsize">
            <button class="btn_minus"  onClick="return false;">-</button>
            <p class="txtsize">�۾�ũ��</p>
            <button class="btn_plus"  onClick="return false;">+</button>
        </div>
    </div>
    <!--//HEADER END-->
    <!--CONTENT START-->
    <div class="content">
        <div class="wrap_content"> <!--���̾��˾��� ���� ��� style="display: none;"-->
            <div class="box_style03">
				<p><strong>���� ����(<%=RETURNCODE%>)</strong></p>
				<p><%=RETURNMSG%></p>
            </div>
            <ul class="notice">
                <li class="bullet">�ٳ� ������ : 1566-3355 (���� 9�� ~ 18�� ��ȭ���� / ��,��,������ �޹�)</li>
            </ul>
        </div>
        <div class="btnfucntion">
            <label for="okay" ><input id="okay" class="bg_<%=BgColor%>" type="button" value="Ȯ��" /></label>
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
