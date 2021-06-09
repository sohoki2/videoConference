var backoffice_common = {
     //유료 무료 구분 확인 
     fn_payClassGubun : function(payGubun, payCost, sp_id){
	    	 //유료 무료 구분 PAY_CLASSIFICATION_1 -> 유료 
	    	  var payHtml = "";
	    	  if ( $("#payClassification").val() == "PAY_CLASSIFICATION_1"){
	        	 var _url = "/backoffice/basicManage/CmmnDetailAjax.do"
		    	 var _params = {"codeId" : "PAY_GUBUN"}
	        	 fn_comboList("sp_PayInfo", "payGubun",_url, _params, "", "120px", payGubun);
	        	 payHtml = $("#sp_PayInfo").html() + "<input type='number' id='payCost' name='payCost' value='"+payCost+"' onkeypress='only_num();' style='width:120px;'>";
	         }else { payHtml = "";}	 
             $("#"+sp_id).html(payHtml);
     }, fn_floorSearch : function (floorSeq, span_id, comboboxId){
             var _url = "/backoffice/basicManage/floorListAjax.do";
			 var _params = {"centerId" : $("#searchCenter").val(), "floorUseyn": "Y"};
		     fn_comboListPost(span_id, comboboxId,_url, _params, "", "120px", floorSeq);  
	 }, uniAjax : function(_url, _data, _sendGubun){
	        var returnData = "";
	        $.ajax({
			        type : _sendGubun,
			        url : url,
			        async: false,
			        beforeSend:function(jxFax, settings){
		        	   jxFax.setRequestHeader('AJAX', true);
		            }, 
			        contentType : "application/json; charset=utf-8",
			        data : JSON.stringify(_data),
			        success :function (data, textStatus, jqXHR){
						 if (data.status == "SUCCESS"){
				    		 returnData = data;
						 }else if (data.status == "LOGIN FAIL"){
							 location.href="/backoffice/login.do";
						 }else {
							 alert(data.status);
							 alert(data.message);
						 }
					},
					error: function (jqXHR, textStatus, errorThrown){
						alert(textStatus + ":" + errorThrown);
					}
		    });
	        return returnData;
	        
	 }, fn_floorPlayState : function (floorPlaySeq, span_id, checkboxField){
		  var _url = "/backoffice/basicManage/floorListAjax.do";
	      var _params = {"centerId" : $("#centerId").val(), "floorUseyn": "Y"};
	      fn_checkListPost(span_id, checkboxField,_url, _params, floorPlaySeq, "");
	 }, fn_floorInfo : function (floorSeq, span_id, comboboxId){
			  var _url = "/backoffice/basicManage/floorListAjax.do";
			  var _params = {"centerId" : $("#centerId").val(), "floorUseyn": "Y"};
		      fn_comboListPost(span_id, comboboxId,_url, _params, "", "120px", floorSeq);  
	 }        
}

