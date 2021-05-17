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
    <title><spring:message code="URL.TITLE" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <link href="/css/reset.css" rel="stylesheet" />
    <link href="/css/page.css" rel="stylesheet" />
    <link href="/css/calendar.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/new_calendar.js"></script>
    <script type="text/javascript" src="/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/jquery-ui.js"></script>
    <script src="/js/popup.js"></script>
    <script>
    	var pageStatus = $("#preview_value_page", opener.document).val();
    	// 파일 다운로드
    	function fileDown(downloadName){
    		if(downloadName == "preview_no_download"){
    			alert("*신규등록시 미리보기에서는 다운로드를 지원하지 않습니다.");
    		}else{
    			location.href="/backoffice/boardManage/fileDownload.do?fileName="+downloadName;	
    		}
    		
    	}
    	$(document).ready(function(){
    		// 제목
    		
    		
    		$(".preview_in_title").html(tagFilterCnvt(tagFilter($("#boardTitle", opener.document).val())));
    		
    		// 작성자
    		$(".preview_in_userNm").html($("#preview_value_userNm", opener.document).val());
    		
    		// 연락처
    		$(".preview_in_offiTelNo").html($("#preview_value_offiTelNo", opener.document).val());
    		
    		// 이메일
    		$(".preview_in_email").html($("#preview_value_email", opener.document).val());
    		
    		// 페이지 구분
    		if(pageStatus == "NOT"){
        		// 공지 기간
        		$(".preview_in_day").html($("#boardNoticeStartday", opener.document).val() +" ~ "+$("#boardNoticeEndday", opener.document).val());		
    		}
 
    		var fileName = $("#preview_value_fileNm", opener.document).val();
    		var fileDownloadInfo = "";

    		
   			// 첨부파일
       		if($("#preview_value_fileChange", opener.document).val() == "Y"){
       			// 서버에 업로드 된 파일 그대로
       			fileDownScript = "javascript:fileDown(&#39;preview_no_download&#39;);";
       		}else{
       			fileDownScript = "javascript:fileDown(&#39;"+fileName+"&#39;);";
       		}
       		$(".preview_in_file").html(fileName + '<a href='+fileDownScript+' class="reviseBtn addB">다운로드</a>');
   		
    		
    		// 목록상단 or 노출여부
    		$(".preview_in_useYn").html($("#preview_value_useYn", opener.document).val());
    		
    		// 콘텐츠 내용
    		$(".preview_in_contents").html($("#boardContent", opener.document).val());
    		//$(".preview_in_contents").html(tagFilterCnvt($("#boardContent", opener.document).val()));
    	});
    </script>
</head>
<body>
<div id="wrapper">	   	  
	<div class="pop_container">
        <!--//팝업 타이틀-->
        <div class="pop_header">
            <div class="pop_contents">
            <h2 style="margin-left:8px;">
            <script>
            	if(pageStatus == "NOT"){
            		document.write("공지사항&nbsp;미리보기");
            	}else{
            		document.write("FAQ&nbsp;미리보기");
            	}
            </script>
             </h2>
            </div>
        </div>
        <!--팝업타이틀//-->
        <!--//팝업 내용-->
        <div class="pop_contents">
	        <div class="Swrap tableArea viewArea" style="margin:16px">
                <div class="view_contents">
	                <table class="margin-top30 backTable mattersArea">
		                <tbody>
		                    <tr class="tableM">
		                        <th>제목</th>
		                        <td colspan="3" class="preview_in_title"></td>
		                    </tr>
		                    <tr>
		                    	<script>
			                    	if(pageStatus == "NOT"){
				                   			document.write("<th>작성자</th>");
				                   			document.write("<td style='text-align:left' class='preview_in_userNm'></td>")
				                   		}else{
				                   		}
		                    	</script>
			                   	<script>
			                   		if(pageStatus == "NOT"){
			                   			document.write("<th>목록상단에고정</th>");
			                   		}else{
			                   			document.write("<th>노출여부</th>");
			                   		}
			                   	</script>
		                   		<script>
			                   		if(pageStatus == "NOT"){
			                   			document.write("<td style='text-align:left' class='preview_in_useYn'></td>");
			                   		}else{
			                   			document.write("<td style='text-align:left' class='preview_in_useYn' colspan='3'></td>");
			                   		}
			                   	</script>
	                        </tr>
	                        <tr>
	                        	<script>
			                   		if(pageStatus == "NOT"){
			                   			document.write("<th>연락처</th>");
			                   			document.write("<td style='text-align:left' class='preview_in_offiTelNo'></td>");
			                   			document.write("<th>이메일</th>");
			                   			document.write("<td style='text-align:left' class='preview_in_email'></td>");
			                   		}else{
			                   		}
			                   	</script>
	                        </tr>
	                        <script>
	                        if(pageStatus == "NOT"){
	                        	document.write("<tr><th>공지기간</th><td style='text-align:left' colspan='3' class='preview_in_day'></td></tr>");
	                        }
	                        </script>
	                        <tr>
	                        	<th>첨부파일</th>
	                        	<td style='text-align:left' colspan='3' class='preview_in_file'></td>
	                        </tr>
				     		<tr>
				     			<th>내용</th>
				     			<td colspan="3" class="preview_in_contents"></td>
				     		</tr>	                    
		                </tbody>
		            </table>
            	</div>
        	</div>
       	</div>
        <!--팝업 내용//-->
        <!--//팝업 버튼-->
        <div class="footerBtn">
            <a href="javascript:self.close();" class="grayBtn" style="margin-bottom:16px;">닫기</a>
        </div>
        <!--팝업 버튼//-->
    </div>
</div>
</body>
</html>