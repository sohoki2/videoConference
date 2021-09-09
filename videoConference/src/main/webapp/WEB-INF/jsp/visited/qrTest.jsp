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
<script type="text/javascript">
    function fn_Qrsend(){
    	 var params = {'visitedQrcode': $("#visitedQrcode").val()};
	     uniAjax("/visited/visitQrProcess.do", params, 
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
    function fn_QrImage(){
    	var params = {'visitedCode': 'V20210825001'};
    	 uniAjaxSerial("/visited/visitQrImage.do", params, 
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
    	 uniAjax("/visited/visitUpdaterProcess.do", params, 
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
    	 uniAjax("/visited/visitUpdaterProcess.do", params, 
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
    <input type="text" id="visitedQrcode" name="visitedQrcode" onChnage="fn_Qrsend()"/>
    <button type="button" id="btn_Submit" onClick="fn_Qrsend()">조회</button>
    <span id="sp_qrimage"></span>
    <button type="button" id="btn_Submit" onClick="fn_QrImage()">이미지 요청</button>
    <button type="button" id="btn_Submit" onClick="fn_apprival()">승인</button>
    <button type="button" id="btn_Submit" onClick="fn_cancel()">취소</button>
    <br />
    
 
</body>
</html>