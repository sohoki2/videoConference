<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*,java.io.*,java.text.*, java.net.*" %>
<%@ page import="kr.co.danal.jsinbi.HttpClient" %> 
<%@ include file="inc/function.jsp" %>
<%
	response.setHeader( "Pragma","No-cache" );

	/********************************************************************************
	*
	* 다날 본인인증
	*
	* - 인증 완료 페이지
	*
	* 인증 시스템 연동에 대한 문의사항이 있으시면 서비스개발팀으로 연락 주십시오.
	* DANAL Commerce Division Technique supporting Team
	* EMail : tech@danal.co.kr
	*
	********************************************************************************/
	
	/********************************************************************************
	 *
	 * XSS 취약점 방지를 위해 
	 * 모든 페이지에서 파라미터 값에 대해 검증하는 로직을 추가할 것을 권고 드립니다.
	 * XSS 취약점이 존재할 경우 웹페이지를 열람하는 접속자의 권한으로 부적절한 스크립트가 수행될 수 있습니다.
	 * 보안 대책
	 *  - html tag를 허용하지 않아야 합니다.(html 태그 허용시 white list를 선정하여 해당 태그만 허용)
	 *  - <, >, &, " 등의 문자를 replace등의 문자 변환함수를 사용하여 치환해야 합니다.
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
<title>다날 본인인증</title>
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
				<li><h1>다날 본인확인 서비스</h1></li>
				<li class="ci_danal">다날로고</li>
			</ul>
        </div>
    <div class="step bg_<%=BgColor%>">
        <ul>
		<li><b>인증 성공</b></li>
        </ul>
    </div>
    <div class="header02">
        <div class="wrap_txtsize">
            <button class="btn_minus" onClick="return false;">-</button>
            <p class="txtsize">글씨크기</p>
            <button class="btn_plus" onClick="return false;">+</button>
        </div>
    </div>
    <!--//HEADER END-->
    <!--CONTENT START-->
    <div class="content">
        <div class="wrap_content"> <!--레이어팝업이 있을 경우 style="display: none;"-->
            <div class="box_style03">
				<p>본인인증이 정상 처리되었습니다.</p>
            </div>
            <ul class="notice">
                <li class="bullet">다날 고객센터 : 1566-3355 (평일 9시 ~ 19시 통화가능 / 토,일,공휴일 휴무)</li>
            </ul>
        </div>
        <div class="btnfucntion">
            <label for="okay" ><input id="okay" class="bg_<%=BgColor%>" onClick="fn_userInfo()" type="button" value="확인" /></label>
        </div>
        <ul class="certification">
            <li class="wau">웹접근성 인증마크</li>
        </ul>
    </div>
    <!--//CONTENT END-->
    <!--BOARD START-->
    <div class="board">
	<ul>
		<li class="field">공지사항</li>
		<li class="value">다날 본인인증을 이용해주셔서 감사합니다. (문의 1566-3355)</li>
	</ul>
    </div>
    <!--//BOARD END-->
</div>

</body>
</html>