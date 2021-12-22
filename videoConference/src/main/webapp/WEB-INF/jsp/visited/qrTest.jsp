<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QrTest</title>
    <script src="/visited/js/jquery-3.5.1.min.js"></script>
    <script src="/visited/js/jquery-ui.js"></script>
    <script src="/visited/js/common.js"></script>
    <script src="/front_res/js/common.js"></script>
	<!--css-->
    <link href="/visited/css/reset.css" rel="stylesheet" />
    <link href="/visited/css/paragraph.css" rel="stylesheet" />

<script type="text/javascript">
	$(function(){
	    $("#visitedQrcode").focus();
	});
    function fn_Qrsend(){
    	 if ($("#visitedQrcode").val() != ""){
    		 var params = {'visitedQrcode': $("#visitedQrcode").val()};
    	     uniAjax("/visit/VisitQrProcess.do", params, 
    	  			 function(result) {
    					       if (result.status == "SUCCESS"){
    							    alert(result.message);
    						   }else {
    							   alert(result.message);
    						   }
    					  },function(request){
    						    alert("Error:" +request.status );	       						
    					  }    		
    	     );
             $("#visitedQrcode").val("");
    	 }
    }
    function fn_QrImage(){
    	var params = {'visitedCode': 'V20210825001'};
    	 uniAjaxSerial("/visit/VisitQrImage.do", params, 
	  			 function(result) {
					       if (result.status == "SUCCESS"){
					    	   $("#sp_qrimage").html("<img src=/qrcode/"+ result.result.visited_code+".png />")
						   }else {
							   alert(result.message);
						   }
					  },function(request){
						    alert("Error:" +request.status );	       						
					  }    		
	     );
    }
    function fn_apprival(){
    	 var params = {'visitedCode': 'V20210909004', 'mode' : 'Edt', 'visitedStatus' : 'VISITED_STATE_2', 'visitedGubun' : 'VISITED_GUBUN_1' };
    	 uniAjax("/visit/VisitUpdaterProcess.do", params, 
	  			 function(result) {
					       if (result.status == "SUCCESS"){
					    	   alert(result.message);
						   }else {
							   alert(result.message);
						   }
					  },function(request){
						    alert("Error:" +request.status );	       						
					  }    		
	     );
    }
    function fn_cancel(){
    	var params = {'visitedCode': 'V20210909004', 'mode' : 'Edt', 'visitedStatus' : 'VISITED_STATE_4', 'visitedGubun' : 'VISITED_GUBUN_1','cancelReason' : '취소 사유' };
    	 uniAjax("/visit/VisitUpdaterProcess.do", params, 
	  			 function(result) {
					       if (result.status == "SUCCESS"){
					    	   alert(result.message);
						   }else {
							   alert(result.message);
						   }
					  },function(request){
						    alert("Error:" +request.status );	       						
					  }    		
	     );
    }
</script>
</head>
<body>
	<div class="qr_wrap">
		<div class="qr_con">
			<input type="text" id="visitedQrcode" name="visitedQrcode" onChange="fn_Qrsend()"/>
			<button type="button" id="btn_Submit" onClick="fn_Qrsend()" class="qr_btn">조회</button>
		</div>			
	</div>		
    <!-- 
    <span id="sp_qrimage"></span>
    <button type="button" id="btn_Submit" onClick="fn_QrImage()">이미지 요청</button>
    <button type="button" id="btn_Submit" onClick="fn_apprival()">승인</button>
    <button type="button" id="btn_Submit" onClick="fn_cancel()">취소</button>
    <br />
     -->
 
</body>
</html>