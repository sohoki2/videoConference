//우편번호 
function zipCode(){
	 window.open("/common/zipcode.jsp", "zip_code", "width=500, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=auto" );	
}
//페이지 이동 
function view_Page(code, code1, code_value, action_page, frm_nm){
	document.getElementById("mode").value = code;	
	code.value =code_value;	
	frm_nm.action = action_page;
	frm_nm.submit();	
}
function fn_emptyReplace(ckValue, replaceValue){
	return  (ckValue == "" || ckValue == undefined ) ? replaceValue : ckValue;
}
//패스워드 설정 
function chkPwd(str){
	 var reg_pwd = /^.*(?=.{10,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	 if(!reg_pwd.test(str)){
	  return false;
	 }
	 return true;
}
//jqGrid 체크 박스 체크된 값 알아오기 
function getEquipArray(id, array){
    var ids = $("#"+id).jqGrid('getDataIDs');
    for(var i=0; i<ids.length; i++){
        if($("input:checkbox[id='jqg_"+ids[i]+"']").is(":checked")){
            var rowObject = $("#"+id).getRowData(ids[i]);
            //console.log(ids[i]);
            //var value = rowObject.equipId;
            array.push(ids[i]);
        }
    }
}
//페이지로 가기 
function listPage(code, code1){	
	$("form[name="+code+"").attr("action", code1).submit();
	return;
}
function apiExecute(type, url, data, beforeSend, done_callback, fail_callback, always_callback) {
	return _apiExecute(type, url, data, beforeSend, done_callback, fail_callback, always_callback);
}
//이미지 아이콘 변경 하기 
function resCheck(code, maxIcon){			
	for (var i = 1; i < parseInt(maxIcon); i++){
		$("#iconRes0"+i).attr("src", "/images/box_off.png");			  
	}
	if (code != ""){
		$("#iconRes0"+code).attr("src", "/images/box_on.png");			  
	}			
}
//특정 길이 대체 문자
function stringLength (str, strlength, replaceTxt){
	if (str.length < parseInt(strlength)){
		for (var i =0; i < (parseInt(strlength) - str.length); i++ ){
			str = replaceTxt + str;
		}
	}else {
		str = str;
	}
	return str;
}
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
function dayConvert(day){
	if(day.length == 8){
		day = day.substring(0,4)+"-"+day.substring(4,6)+"-"+day.substring(6,8);
	}
	return day 
}
//숫자만 입력 
function only_num() {
    if (((event.keyCode < 48) || (event.keyCode > 57)) && (event.keyCode != 190)) event.returnValue = false;
}
function _apiExecute(type, url, data, beforeSend, done_callback, fail_callback, always_callback) {
	var contentType = "application/x-www-form-urlencoded; charset=UTF-8";
	var jqXHR = $.ajax({
		type : type,
		contentType : contentType,
		url : url,
		data : data,
		beforeSend : beforeSend
	}).done(done_callback).fail(fail_callback).always(always_callback);

	return jqXHR;
}
//지난 일자는 등록 하지 못하게 하기 
function yesterDayConfirm(res_day, alert_message){
	var day = new Date();
    var dateNow = fnLPAD(String(day.getDate()), "0", 2); //일자를 구함
    var monthNow = fnLPAD(String((day.getMonth() + 1)), "0", 2); // 월(month)을 구함    
    var yearNow = String(day.getFullYear()); //년(year)을 구함
    var today = yearNow + monthNow + dateNow;
    
    if (parseInt(res_day) < today){
    	alert(alert_message);
    	return false;
    }else {
    	return true;
    }
}
// 값 비교 후 경고 문구 보내기
function fnIntervalCheck(stratVal, endVal, alertMessge){
	if (stratVal > endVal){
		alert(alertMessge);
		return false;
	}
	return true;
}

function fnCreatCheckbox(_returnObject, _startVal, _endVal, _checkVal, _checkboxNm, _checkTxt){
	var checked = "";
	$("#"+_returnObject).empty();
	for (var i = _startVal; i <= _endVal; i ++ ){
		checked = _checkVal.includes(i) ? "checked" : "";
		$("#"+_returnObject).append("&nbsp;<input type='checkbox' name='"+_checkboxNm+"'  value='"+i+"' "+checked+">" + i+ _checkTxt);
	}
}
function fnLPAD(val, set, cnt) {
    if (!set || !cnt || val.length >= cnt) {
        return val;
    }
    var max = (cnt - val.length) / set.length;
    for (var i = 0; i < max; i++) {
        val = set + val;
    }
    return val;
}
function any_empt_line_id(frm_nm, alert_message){
	 var form_nm = eval("document.getElementById('"+frm_nm+"')");
	 if (form_nm.value.length < 1)
	 {
		  alert(alert_message);
		  form_nm.focus();
		  return false;
	 }else{
         return true;
	 }
}
function any_empt_line_span(frm_nm, alert_message, spanTxt){
	 var form_nm = eval("document.getElementById('"+frm_nm+"')");
	 $("#sp_errorMessage").html("");
	 if (form_nm.value.length < 1){
		  $("#sp_errorMessage").html(alert_message);
		  $("#sp_errorMessage").attr("style", "color:red");
		  $("#"+ frm_nm).attr("style", "border-color:red"); 
		  return false;
	 }else{
        return true;
	 }
}
function search_form(){
	$(":hidden[name=pageIndex]").val(1);	
	$("form[name=regist]").submit();
	
}
function del_Check(url){
	if (confirm("삭제 하시겠습니까?")== true){
		locaion.href=url;
	}
}
function fn_uniCheck(url, params, _field){
    uniAjaxSerial(url, params, 
				  function(result) {
					       if (result.status == "LOGIN FAIL"){
							   location.href="/backoffice/login.do";
						   }else if (result.status == "SUCCESS"){
			                   //관련자 보여 주기 
			                    alert("중복된 내역이 없습니다.");
							   $("#"+_field).val("Y");
						   }else {
						      alert("중복된 내역이 있습니다.");
							  $("#"+_field).val("N");
						   }
				  },
				  function(request){
					    alert("Error:" +request.status );	       						
				  }    		
	);
}
//갑 조회 할때 쓰기 
function fn_returnVal(url, params, _action_url){
    var returnVal = "";
    uniAjax(url, params, 
				  function(result) {
					       if (result.status == "LOGIN FAIL"){
							   location.href="/backoffice/login.do";
						   }else if (result.status == "SUCCESS"){
			                   //관련자 보여 주기 
			                   var call_script = eval("window."+_action_url+"(result.result);");
			                   
						   }else {
						      alert("장애가 발생 하였습니다.");
							  returnVal = "";
						   }
				  },
				  function(request){
					    alert("Error:" +request.status );	       						
				  }    		
	);
	return returnVal;
}

function today_get(){
	var now = new Date();
    var today_day = fnLPAD(String(now.getDate()), "0", 2); //일자를 구함
    var today_month = fnLPAD(String((now.getMonth() + 1)), "0", 2); // 월(month)을 구함    
    var today_year = String(now.getFullYear()); //년(year)을 구함
    var today = today_year + today_month + today_day;
    
    return today;
}

function tomorrow_get(){
	var now = new Date();
	now.setDate(now.getDate()+1);
    var tomorrow_day = fnLPAD(String(now.getDate()), "0", 2); //일자를 구함
    var tomorrow_month = fnLPAD(String((now.getMonth() + 1)), "0", 2); // 월(month)을 구함    
    var tomorrow_year = String(now.getFullYear()); //년(year)을 구함
    var tomorrow = tomorrow_year + tomorrow_month + tomorrow_day;
    
    return tomorrow;
}
//공백 제거
function trim(str){
	return str.replaceAll(/^\s\s*/, '').replaceAll(/\s\s$/,'');
}
function fn_uniDel(_url, _data, _action_url){
	if (confirm("삭제 하시겠습니까?")== true){
		$.ajax({
			url: _url,
			type : "POST",
			beforeSend:function(jxFax, settings){
	        	jxFax.setRequestHeader('AJAX', true);
	        },
			data : _data,
			success :function (data, textStatus, jqXHR){
				 if (data.status == "SUCCESS"){
		    		 $("form[name=regist]").attr("action", _action_url).submit();
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
	}
	else {
	    return;
	}
}
function fn_uniDelAction(_url, _data, _action_url){
	if (confirm("삭제 하시겠습니까?")== true){
	    $.ajax({
			url: _url,
			type : "POST",
			beforeSend:function(jxFax, settings){
	        	jxFax.setRequestHeader('AJAX', true);
	        },
			data : _data,
			success :function (data, textStatus, jqXHR){
				 if (data.status == "SUCCESS"){
					 // 추후 다른 framework 으로 변경 예정
					 if (_action_url != ""){
					    var call_script = eval("window."+_action_url+"();"); 
					 }
					 
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
	}
	else {
	    return;
	}
}
function fn_uniDelAction(_url, _data, _action_url, _param){
	if (confirm("삭제 하시겠습니까?")== true){
	    $.ajax({
			url: _url,
			type : "POST",
			beforeSend:function(jxFax, settings){
	        	jxFax.setRequestHeader('AJAX', true);
	        },
			data : _data,
			success :function (data, textStatus, jqXHR){
				 if (data.status == "SUCCESS"){
					 // 추후 다른 framework 으로 변경 예정
					 if (_action_url != ""){
					    //var call_script = eval("window."+_action_url+"();"); 
					    console.log("_action_url:" + _action_url  + ":" + _param);
					    
					    var call_script = eval("window."+_action_url+"(_param);");
					 }
					 
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
	}
	else {
	    return;
	}
}

function fn_uniDelParam(_url, _data, _action_funcion, _params){
	if (confirm("삭제 하시겠습니까?")== true){
	
		$.ajax({
			url: _url,
			type : "POST",
			beforeSend:function(jxFax, settings){
	        	jxFax.setRequestHeader('AJAX', true);
	        },
			data : _data,
			success :function (data, textStatus, jqXHR){
				 if (data.status == "SUCCESS"){
					     var args = new Array();
					     if (_params != null && _params.indexOf(",") > 0){
					    	  var arguments_params = _params.split(',');
							  for (var i = 1; i < arguments_params.length; i++)
							         args.push(arguments[i]);
						 }
					     console.log("_action_funcion:" + _action_funcion);
					     window[_action_funcion].apply(this, args);
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
	}
	else {
	    return;
	}
}


var CommonJsUtil = {
		isNumeric : function(val){
			if(/[^0-9]/.test(val)){
				return false;
			}else{
				return true;
			}
		},form_empty_check : function (frm_nm, alert_message){
			 if ($("#"+frm_nm).val().length < 1)
			 {
				  alert(alert_message);
				  $("#"+frm_nm).focus();
				  return false;
			 }else{
		         return true;
			 }
		},form_empty_check_span: function (frm_nm, alert_message, spanTxt){
			 var form_nm = eval("document.getElementById('"+frm_nm+"')");
			 $("#sp_errorMessage").html("");
			 if (form_nm.value.length < 1)
			 {
				  
				  $("#sp_errorMessage").html(alert_message);
				  $("#sp_errorMessage").attr("style", "color:red");
				  $("#"+ frm_nm).attr("style", "border-color:red"); 
				  return false;
			 }else{
		       return true;
			 }
		},checkbox_allCheck: function (checkbox_nm){
			if ($("#"+checkbox_nm).prop("checked")){	
			    //체크 선택
				fn_userCheckboxSearch("Y");
			}else {
			   //체크 선택 안함
				fn_userCheckboxSearch("D");
			}
		},checkbox_val: function (message, checkboxNm){
			var checkboxvalue = "";
			var check_length = $("input:checkbox[name="+checkboxNm+"]:checked").length;
			if (check_length <1){
				alert(message);
				return false;
			}else {
				$("input:checkbox[name="+checkboxNm+"]:checked").each(function(){
					checkboxvalue = checkboxvalue+","+ $(this).val();
				});	
			}
			return checkboxvalue.substring(1);
			
			CommonJsUtil
		},tagFilter : function(reqValue){
			reqValue = reqValue.replace(/</gi,"&lt;");
			reqValue = reqValue.replace(/>/gi,"&gt;");
			reqValue = reqValue.replace(/&/gi,"&amp;");
			reqValue = reqValue.replace(/"/gi,"&quot;");
			reqValue = reqValue.replace(/\//gi,"&#47;");
			return reqValue;
		},tagFilterCnvt: function (reqValue){
			reqValue = reqValue.replace(/&lt;/gi,'<');
			reqValue = reqValue.replace(/&gt;/gi,'>');
			reqValue = reqValue.replace(/&amp;/gi,'&');
			reqValue = reqValue.replace(/&quot;/gi,'"');
			reqValue = reqValue.replace(/&#47;/gi,'\/');
			return reqValue;
		}, NVL : function (reqValue){
			return (reqValue == undefined || reqValue == "") ? "" : reqValue;
		}
}


//ajax 전송 공용폼 
var CommonAjax = {
		uniAjax : function 	(url, param, done_callback, fail_callback, sendType){
		var _data = (sendType == "JSON") ? JSON.stringify(param) : param;
		var jxFax =  $.ajax({
			        type : 'POST',
			        url : url,
			        beforeSend : function(jqXHR, settings) {
			        	//$('.loadingDiv').show();
			        },  
			        complete : function(jqXHR, textStatus) {
			        	//$('.loadingDiv').show();
			        },
			        contentType : "application/json; charset=utf-8",
			        data : _data
			    }).done(done_callback).fail(fail_callback);
    return jxFax;
	}
}

function fn_UniCheckAlert(_UniCheckFormNm, _focusNm){
	if ($("#"+_UniCheckFormNm).val() == "Y"){
		return true;
	}else {
	    alert("중복 검사를 하지 않았습니다");
		$("#"+_focusNm).focus();
		return false;
		
	}
}

//페이징 스크립트;
function ajaxPaging(currentPageNo, firstPageNo, recordCountPerPage, firstPageNoOnPageList, lastPageNoOnPageList, totalPageCount, pageSize, pageScript){
    var pageHtml = "";
    pageHtml += "<div class=pagination>";
	 if (currentPageNo == firstPageNo ){
      pageHtml += "<a href='#' >&laquo;</a>";
	 }else {
      pageHtml += "<a href='#' onclick='"+pageScript+"("+ firstPageNo +")';return false; '>&laquo;</a>";
	 }
	 if (parseInt(currentPageNo) > parseInt(firstPageNo)){
      pageHtml += "<a href='#' onclick='"+pageScript+"("+ parseInt(parseInt(currentPageNo) -1)+");return false;'>&lt;</a>"
	 }else {
      pageHtml += "<a href='#' >&lt;</a>"
	 }
    for(var  i = firstPageNoOnPageList; i<= lastPageNoOnPageList; i++){
		 if (i == currentPageNo){
            pageHtml += "<a class=active>"+i+"</a>";
		 }else {
            pageHtml += "<a href='#' onclick='"+pageScript+"("+i+");return false; '>"+i+"</a>";
		 }
    }

	 if (parseInt(totalPageCount) > parseInt(pageSize) ){
        pageHtml += "<a href='#' onclick='"+pageScript+"("+ parseInt(parseInt(currentPageNo) + 1)+");return false;'>&gt;</a>"
	 }else {
        pageHtml += "<a href='#' onclick='"+pageScript+"("+ parseInt(parseInt(currentPageNo) + 1)+");return false;'>&gt;</a>"
	 }
    if (parseInt(totalPageCount) > parseInt(pageSize)  ){
      pageHtml += "<a href='#' onclick='"+pageScript+"("+ totalPageCount +");return false;'>&raquo;</a>";
	 }else{
      pageHtml += "<a href='#' >&raquo;</a>";
	 }	
    return pageHtml;
}
//체크 박스 빈값 관련 내용 처리 
function fn_CheckBoxMsg(message, checkboxNm){
	var check_length = $("input:checkbox[name="+checkboxNm+"]:checked").length;
	if (check_length <1){
		alert(message);
		return false;
	}else {
		return true;
	}
}
//combo list
// 콤보 박스 리스트
function fn_comboList(_spField, _Field, _url, _params, _onChangeAction, _width, _checkVal){
		    // params로 보내기 
		    if ($("#"+_spField) != undefined){
		        var onChangeTxt =  _onChangeAction != "" ? "onChange='" + _onChangeAction+ "'" :  "";
		    	$("#"+_spField).html("<select id='"+ _Field + "' name='"+ _Field + "'" + onChangeTxt+" style='width:" + _width + "'></select>");
		        uniAjaxSerial(_url, _params, 
		  			    function(result) {
					       if (result.status == "LOGIN FAIL"){
					    	   location.href="/backoffice/login.do";
						   }else if (result.status == "SUCCESS"){
							   //총 게시물 정리 하기
							    if (result.resultlist.length > 0){
							        var obj  = result.resultlist;
								    $("#"+_Field).empty();
								    $("#"+_Field).append("<option value=''>선택</option>");
								    for (var i in obj) {
								        var array = Object.values(obj[i])
								        var ckString = (array[0] === _checkVal) ? "selected" : "";
								        $("#"+_Field).append("<option value='"+ array[0]+"' "+ckString+">"+array[1]+"</option>");
								    }
							    }else {
							      //값이 없을때 처리 
							      $("#"+_Field).remove();
							      return "0";
							    }
							    
						   }
					    },
					    function(request){
						    alert("Error:" +request.status );	       						
					    }    		
			     ); 
		    }   
}
function fn_comboListPost(_spField, _Field, _url, _params, _onChangeAction, _width, _checkVal){
		    //requestBody 로 보내기
		    if ($("#"+_spField) != undefined){
		        var onChangeTxt =  _onChangeAction != "" ? "onChange='" + _onChangeAction+ "'" :  "";
		    	$("#"+_spField).html("<select id='"+ _Field + "' name='"+ _Field + "'" + onChangeTxt+" style='width:" + _width + "'></select>");
		        uniAjax(_url, _params, 
		  			    function(result) {
					       if (result.status == "LOGIN FAIL"){
					    	   location.href="/backoffice/login.do";
						   }else if (result.status == "SUCCESS"){
							   //총 게시물 정리 하기
							    if (result.resultlist.length > 0){
							        var obj  = result.resultlist;
								    $("#"+_Field).empty();
								    $("#"+_Field).append("<option value=''>선택</option>");
								    for (var i in obj) {
								        var array = Object.values(obj[i])
								        var ckString = (array[0] === _checkVal) ? "selected" : "";
								        $("#"+_Field).append("<option value='"+ array[0]+"' "+ckString+">"+array[1]+"</option>");
								    }
								}else {
							      //값이 없을때 처리 
							      $("#"+_Field).remove();
							      return "0";
							    }
							    
						   }
					    },
					    function(request){
						    alert("Error:" +request.status );	       						
					    }    		
			     ); 
		    }   
}
function fn_checkListPost(_spField, _Field, _url, _params, _checkVal, _checkTxt){
		    //requestBody 로 보내기
		    if ($("#"+_spField) != undefined){
		        uniAjax(_url, _params, 
		  			    function(result) {
					       if (result.status == "LOGIN FAIL"){
					    	   location.href="/backoffice/login.do";
						   }else if (result.status == "SUCCESS"){
							   //총 게시물 정리 하기
							    $("#"+_spField).empty();
							    if (result.resultlist.length > 0){
							        var obj  = result.resultlist;
							        var checked = "";
							        for (var i in obj) {
								        var array = Object.values(obj[i])
								        checked = CommonJsUtil.NVL(_checkVal).toString().includes(array[0]) ? "checked" : "";
								        console.log("checked:" +checked);
								        $("#"+_spField).append("&nbsp;<input type='checkbox' name='"+_Field+"'  value='"+array[0]+"' "+checked+">" + array[1]+ _checkTxt);
								        
								     }
								}else {
							      $("#"+_spField).remove();
							      return "0";
							    }
							    
						   }
					    },
					    function(request){
						    alert("Error:" +request.status );	       						
					    }    		
			    ); 
		    }   
}

function uniAjax(url, param, done_callback, fail_callback){
	var jxFax =  $.ajax({
		        type : 'POST',
		        url : url,
		        beforeSend:function(jxFax, settings){
	        	   jxFax.setRequestHeader('AJAX', true);
	        	   //$('.loadingDiv').show();
	            }, 
		        complete : function(jqXHR, textStatus) {
		        },
		        contentType : "application/json; charset=utf-8",
		        data : JSON.stringify(param)
		    }).done(done_callback).fail(fail_callback);
	return jxFax;
}

function uniAjaxSerial(url, param, done_callback, fail_callback){
	var jxFax =  $.ajax({
		        type : 'GET',
		        url : url,
		        beforeSend : function(jqXHR, settings) {
			       jqXHR.setRequestHeader('AJAX', true);
			       //$('.loadingDiv').show();
		        }, 
		        complete : function(jqXHR, textStatus) {
		        },
		        contentType : "application/json; charset=utf-8",
		        data : param,
		    }).done(done_callback).fail(fail_callback);
	
    return jxFax;
}
//토글 버튼 스크립트
function toggleValue(obj){
	 $(obj).is(":checked") ? $(obj).val("Y") : $(obj).val("N");
}
function toggleClick(obj, val){
     $("#"+obj).val(val);
     console.log(obj + ":" + val);
     
     if (val == "Y" && !$("#"+obj).is(":checked"))
		 $("#"+obj).trigger("click");
}
//토글 디폴트 
function toggleDefault(obj){
     if ($("#"+obj).is(":checked"))
		 $("#"+obj).trigger("click");
}
//jqgrid 체크 박스 선택 
function jqGridCheckValue(){
   
}
//사용자 검색 
function fn_userSearch(){
    var url = ($("#searchUserGubun").val() === "G") ? "/backoffice/orgManage/empListAjax.do" : "/backoffice/companyManage/userListAjax.do";
    if (any_empt_line_id("searchUserKeyword", "검색어를 입력해 주세요.") == false) return;
    var params = {"searchCondition" : "empname", "searchKeyword" : $("#searchUserKeyword").val()};
    uniAjax(url, params, 
		      			function(result) {
		 				       if (result.status == "LOGIN FAIL"){
		 				    	   alert(result.meesage);
		   						   location.href="/backoffice/login.do";
		   					   }else if (result.status == "SUCCESS"){
		   						   //사용자 리스트 보여 주기 
		   						   $("#tb_userInfo > tbody").empty();
		   						   var obj = result.resultlist;
		   						   if (obj.length > 0){
		   						      var html = "";
		   						      for (var i in obj){
		   						          if ($("#searchUserGubun").val() === "G"){
		   						             html  = "<tr onClick='fn_useChoice(\"G\", \""+ obj[i].empno +"\", \""+ obj[i].empname +"\")'>"
		   						                   + "   <td>" + obj[i].com_name + "</td>"
		   						                   + "   <td>" + obj[i].empno + "</td>"
		   						                   + "   <td>" + obj[i].empname + "</td>"
		   						                   + "   <td>" + obj[i].emptelphone + "</td>"
		   						                   + " </tr>";
		   						          }else {
		   						             html  = "<tr onClick='fn_useChoice(\"C\", \""+ obj[i].user_no +"\", \""+ obj[i].user_name +"\")'>"
		   						                   + "  <td>" + obj[i].com_name + "</td>"
		   						                   + "  <td>" + obj[i].user_no + "</td>"
		   						                   + "  <td>" + obj[i].user_name + "</td>"
		   						                   + "  <td>" + obj[i].user_cellphone + "</td>"
		   						                   + "</tr>";
		   						          }
		   						          $("#tb_userInfo > tbody").append(html);
		   						          html = "";
		   						      }
		   						   }else{
		   						     alert("검색한 내용이 없습니다");
		   						   }
		   						  
		   					   }
		 				    },
		 				    function(request){
		 					    alert("Error:" +request.status );	   
		 					    $("#btn_needPopHide").trigger("click");
		 				    }    		
	);

}
// 담당자 값 넣어주기 

function fn_useChoice(SearchGubun, empno, empnm){
    $("#seatFixGubun").val(SearchGubun);
    $("#seatFixUserId").val(empno);
    $("#sp_fixUser").html(empnm);
    jqGridFunc.fn_seatChoic("V");
}

//업로드
function uniAjaxMutipart(url, formData, done_callback, fail_callback){
	var jxFax =  $.ajax({
				        type : 'POST',
				        url : url,
	                    beforeSend : function(jqXHR, settings) {
		                  //이미지 업로드 보여주기
			            },
				        processData: false,
				        contentType : false,
			            cache: false,
			            timeout: 600000,
	                    data : formData,
	                    type: 'POST',
	                    complete : function(jqXHR, textStatus) {
		                       
			            },
			    }).done(done_callback).fail(fail_callback);
    return jxFax;
}
// 업로드 공용
function fnUniUploadFile(fileInfo){
	    
    	var formData = new FormData();
    	
    	if (  fileInfo.indexOf(",") > 0){
    		
    	}else
    		formData.append('uploadFile', $('#photo_upload')[0].files[i]);
    	
        for(var i=0; i<$('#photo_upload')[0].files.length; i++){
	        formData.append('uploadFile', $('#photo_upload')[0].files[i]);
	    }
        $.ajax({
            url: '/upload',
            data: formData,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {
                alert("이미지 업로드 성공");
            }
        });	    
}

jQuery.fn.serializeObject = function() {
    var obj = null;
    try {
        //if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function() {
                    obj[this.name] = this.value;
                });
            }//if ( arr ) {
        //}
    } catch (e) {
        alert(e.message);
    } finally {
    }
 
    return obj;
};
function ckeckboxValue(message, checkboxNm){
	var checkboxvalue = "";
	var check_length = $("input:checkbox[name="+checkboxNm+"]:checked").length;
	if (check_length <1){
		alert(message);
		return false;
	}else {
		$("input:checkbox[name="+checkboxNm+"]:checked").each(function(){
			checkboxvalue = checkboxvalue+","+ $(this).val();
		});	
	}
	return checkboxvalue.substring(1);
}
function fn_domNullReplace(checkField, nullVal){
	
	return (checkField == "" ? nullVal : checkField);
		
}
//사용자 전체 선택/해제
function fn_userAllCheck(){
	
	if ($("#userAllCheck").prop("checked")){	
	    //체크 선택
		fn_userCheckboxSearch("Y");
	}else {
	   //체크 선택 안함
		fn_userCheckboxSearch("D");
	}
}
//회의실 전체 선택
function fn_conAllCheck(){
	if ($("#comferenceAllCheck").prop("checked")){	
		fn_meetingCheck("Y");
	}else {
		fn_meetingCheck("D");
	}	
}


//대상 selectbox
function empSel(acd_group, rule_cd, obj, _url, _params){
	$.ajax({
		type : Post,
		url : _url,
		data : _params, 
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		cache : false,
		success : function(data) {
			try {
				$("#" + obj + " option").remove();
				$("#" + obj).append("<option value=''>선택하세요</option>");
				$.each(data.rows,function(i,val){
					var option = $("<option value='"+val.EMP_NO+"'></option>").html(val.EMP_NM);
					$("#" + obj).append(option);
				})
			} catch(e) {
				alert(e);
			}
		},
		error: function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});	
}


function fullScreenOpen(url, id){
		 var isNav = (navigator.appName == "Netscape")?1:0;
		 var isIE = (navigator.appName.indexOf("Microsoft") != -1)?1:0;
		 var isMac=(navigator.platform.indexOf("Mac")>-1)?1:0; 
		 var isWin=(navigator.platform.indexOf("Win")>-1)?1:0;
		 var opts = "toolbar=no,titlebar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,copyhistory=no,menubar=no,fullscreen=yes";
		 if (isNav) { 
		  //크롬 사파리 파폭도 여기 잡힌다. 파폭은 잘된다 아이폰도 여기 잡힌다. 아이폰은 잘된다.
		  opts = opts+",width="+screen.availWidth+",height="+screen.availHeight+",outerWidth="+screen.availWidth+",outerHeight="+screen.availHeight+",­screenX=0,screenY=0";
		 } else if (isIE) { 
		  opts = opts+",left=0,top=0"; 
		  if (isMac) {  
		   opts = opts+",width="+(screen.availWidth - 13)+",height="+(screen.availHeight - 32); 
		  } else if (isWin) {  
		   opts = opts+",width="+(screen.availWidth - 12)+",height="+(screen.availHeight - 25); 
		  } else {
		   opts = opts+",width="+screen.availWidth+",height="+screen.availHeight; 
		  }
		 } else {
		  //오페라 때문에... 
		  opts = "fullscreen=yes";
		  //opts = opts+",left=0,top=0,width="+(screen.availWidth - 13)+",height="+(screen.availHeight - 32)+"outerWidth="+screen.availWidth+",outerHeight="+screen.availHeight; 
		 } 
		// alert("opts : "+opts);
		 var newWin = window.open(url,'hamie',opts);
		 if (window.focus){newWin.focus();} 
		 if (parseInt(navigator.appVersion) >= 4) { 
		  newWin.moveTo(0,0); 
		 }
}
//글자 지정 길이로 자르기
function cutStr(str,limit) {
	var tmpStr = str;
	var byte_count = 0;
	var len = str.length;
	var dot = "";


	for(var i=0; i<len; i++){
		byte_count += chr_byte(str.charAt(i));
		if(byte_count == limit-1){
			if(chr_byte(str.charAt(i+1)) == 2){
				tmpStr = str.substring(0,i+1);
				dot = "...";
			} else {
				if(i+2 != len) dot = "...";
				tmpStr = str.substring(0,i+2);
			}
			break;
		} else if(byte_count == limit){
			if(i+1 != len) dot = "...";
			tmpStr = str.substring(0,i+1);
			break;
		}
	}
	//document.writeln(tmpStr+dot);
	return tmpStr+dot;
}
//키워드로 글자 지정 길이로 자르기
function cutKeywordStr(str,limit,keywords,tag){
	//keywords 에서 중복값 제거
	var newkeywords = [];
	$.each(keywords, function(i, el){
	    if($.inArray(trim(el), newkeywords) === -1) newkeywords.push(trim(el));
	});
	
	var tmpStr = str;
	var byte_count = 0;
	var len = str.length;	//전체 문서 길이
	var dot = "";
	var keylen = 0;
	var replaceKeywords = "";
	newkeywords.sort();

	//전체 글길이가 표기할 글 길이보다 커야 한다.
	if(len > limit){
		for(var k=0; k<newkeywords.length; k++){
			keylen = tmpStr.indexOf(newkeywords[k]);	//키워드의 본문 위치 찾기
			//console.log(newkeywords[k] + " : " + keylen);
			if(keylen >= 0){
				break;
			}
		}
		if(keylen < 0){
			for(var k=0; k<newkeywords.length; k++){
				var nkeywords = replaceAll(newkeywords[k]," ","");
				if(nkeywords.length > 2){
					for(var kk=0; kk< (nkeywords.length - 1); kk++){
						keylen = tmpStr.indexOf(nkeywords.substring(kk,(kk+2)) );	//키워드의 본문 위치 찾기
						if(keylen >= 0){
							replaceKeywords = nkeywords.substring(kk,(kk+2));
							break;
						}
					}
				}
				//alert(replaceKeywords + " : " + keylen);
				if(keylen >= 0){
					break;
				}
			}
		}
		//키워드가 있는 위치가 limit(표기할 문자길이)의 2분에 1값 보다 크다면
		//키워드가 있는 위치가 40이고 표기할 글자 길이가 50이라면 (50/2)보다 40이 크기 때문에 앞부분 글을 자르기 해야 한다.
		//가능하면 키워드를 중앙에 표기 하기 위한 조치
		if(keylen > Math.floor(limit / 2)){
			//전체 글의 길이가 150이고 키워드 위치가 40이면 (150 - 40)이 표기할 글 길이인 50에서 반값인 (50/2) 보다 크다면
			//키워드를 중심으로 앞뒤로 (50/2) 식 글자를 자르기 해야 한다.
			if((len - keylen) > Math.floor(limit / 2)){
				//(40 - 25) = 15
				keylen = keylen - Math.floor(limit / 2);
			}else{
				//전체 글의 길이가 100이고 키워드 위치가 90이면 뒷쪽 남은 글길이 10이고 표기할 글 길이인 50에서 반값인 (50/2)보다 작다면
				if(len <= keylen + (Math.floor(limit / 2))){
					keylen = len - Math.floor(limit / 2);
				}else{
					keylen = keylen - (Math.floor(limit / 2) + ((len - keylen) - Math.floor(limit / 2)) );
				}
				if(keylen < 0){
					keylen = 0;
				}
			}
		}else{
			//글의 첫부분 부터 표기 하여도 키워드가 보이는 경우
			keylen = 0;
		}
	}
	var tmpStrSet = false;
	for(var i=keylen; i<len; i++){
		byte_count += chr_byte(str.charAt(i));
		
		if(byte_count == limit-1){
			if(chr_byte(str.charAt(i+1)) == 2){
				tmpStr = str.substring(keylen,i+1);
				dot = "...";
			} else {
				if(i+2 != len) dot = "...";
				tmpStr = str.substring(keylen,i+2);
			}
			tmpStrSet = true;
			break;
		} else if(byte_count >= limit){
			if(i+1 != len) dot = "...";
			tmpStr = str.substring(keylen,i+1);
			tmpStrSet = true;
			break;
		}
	}
	if(tmpStrSet == false){
		tmpStr = str.substring(keylen,len);
	}
	if(replaceKeywords !=""){
		var tmpTag = replaceAll(tag, "{KEYWORD}", replaceKeywords);
		tmpStr = replaceAll(tmpStr, replaceKeywords, tmpTag);
	}
	//document.writeln(tmpStr+dot);
	for(var k=0; k<newkeywords.length; k++){
		var tmpTag = replaceAll(tag, "{KEYWORD}", newkeywords[k]);
		tmpStr = replaceAll(tmpStr, newkeywords[k], tmpTag);
	}
	if(keylen > 0){
		tmpStr = "..."+tmpStr;
	}
	return tmpStr+dot;
}

function fn_uniDelJSON(_url, _data, _action_url){
	if (confirm("삭제 하시겠습니까?")== true){
		$.ajax({
			url: _url,
			type : "POST",
			contentType : "application/json; charset=utf-8",
	        data : JSON.stringify(_data),
			success :function (data, textStatus, jqXHR){
			     alert(data.message);
		    	 if (data.status == "SUCCESS"){
		    		 $("form[name=regist]").attr("action", _action_url).submit();
				 }else if (result.status == "LOGIN FAIL"){
					location.href="/backoffice/login.do";
				 }
			},
			error: function (jqXHR, textStatus, errorThrown){
				alert(textStatus + ":" + errorThrown);
			}
		});
	}
	else {
	    return;
	}
}
//마우스 이벤트로 이미지 변경
function mouseOutOver(id,e){
	var e = e || window.event; // 브라우저별 설정
	 if(e.type == "mouseover"){
		 $(id).attr("src", $(id).attr("over_img"));
	 }else{
		 $(id).attr("src", $(id).attr("out_img"));
	 }
}
//마우스 이벤트로 class 변경
function menuOutOver(id,e){
	var e = e || window.event; // 브라우저별 설정
	 if(e.type == "mouseover"){
		 $(id).attr("class", "on");
	 }else{
		 if($(id).attr("page_url")!="true"){
			 $(id).attr("class", "");
		 }
	 }
}
//지점 층수 함수
function fn_floorSearchState(){
      var _url = "/backoffice/basicManage/floorListAjax.do";
	  var _params = {"centerId" : $("#searchCenter").val(), "floorUseyn": "Y"};
      fn_comboListPost("sp_floorCombo", "searchFloorSeq",_url, _params, "", "120px", ""); 
}
 

function mouseoverAction(name, type)
{
//keyword Trend onmouseover onmouseout
	var arr = $("*[name='"+name+"']");
	for(var i=0; i<arr.length; i++){
		if(type == true){
			arr[i].className='trend';
		}else{
			arr[i].className='';
		}
	}
}

//초를 시간으로 환산
function getTimeToHour(time)
{
	hour = parseInt(time/3600); 
	if(hour < 10){
		hour = "0"+hour;
	}
	min = parseInt((time%3600)/60);
	if(min < 10){
		min = "0"+min;
	}
	sec = time%60; 	//초값.....
	if(sec < 10){
		sec = "0"+sec;
	}
	return hour+":"+min+":"+sec; 
}


function wrapWindowByMask(maskId, showId, left, top){
	if($(maskId).css("display") == "none"){
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();  
		var maskWidth = $(window).width();  
	
		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$(maskId).css({'width':maskWidth,'height':maskHeight});  
	
		//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 100% 불투명도로 간다.
		$(maskId).fadeIn(1000);      
		$(maskId).fadeTo("slow",1);
	
		$(showId).css("left", left);
		$(showId).css("top", top);
		
		//윈도우 같은 거 띄운다.
		$(showId).show();
	}
}


function extendDateFormat(input, format)
 {
// dateFormat Check
var regex = /^(\d{2,4}[-\/:]\d{2}.\d{2}|\d{8}|\d{6})/g;
// regex true than variable capture
var regex2 = /^(?:(\d{4})(\d{2})(\d{2}))|^(?:(\d{2})(\d{2})(\d{2}))/g;
  input = input.replace(/\D/g, '');
  var formatLength = $.isEmptyObject(format) ? 0 : format.replace(/[^yMd]/g, '').length;
  if (regex.test(input))
  {
   var transfer = '';
   // Delete all Character
   switch (format)
   {
    case "yyyy-MM-dd":
     transfer = "$1-$2-$3";
     break;
    case "yyyy/MM/dd":
     transfer = "$1/$2/$3";
     break;
    case "yyyy:MM:dd":
     transfer = "$1:$2:$3";
     break;
    case "yyyyMMdd":
     transfer = "$1$2$3";
     break;
    case "yyyy-MM":
     transfer = "$1-$2";
     break;
    case "yyyy/MM":
     transfer = "$1/$2";
     break;
    case "yyyy:MM":
     transfer = "$1:$2";
     break;
    case "yyyyMM":
     transfer = "$1$2";
     break;
    case "yy-MM-dd":
     input = input.substr(input.length - formatLength);
     transfer = "$4-$5-$6";
     break;
    case "yy/MM/dd":
     input = input.substr(input.length - formatLength);
     transfer = "$4/$5/$6";
     break;
    case "yy:MM:dd":
     input = input.substr(input.length - formatLength);
     transfer = "$4:$5:$6";
     break;
    case "yyMMdd":
     input = input.substr(input.length - formatLength);
     transfer = "$4$5$6";
     break;
    default:
     transfer = "$1-$2-$3";
     break;
   }
   temp = input.replace(regex2, transfer);
   //alert(temp);
   return temp;
  }
  else
  {
   alert("값이 형식에 맞지 않습니다.");
   return false;
  }
 }

function resetForm(f){
	$el = $(f);
	$('input:text', $el).val('');
	$('input:hidden', $el).val('');
	$('textarea', $el).val('');
	$('select', $el).each(function(){
		if($(this).find('option.default').size() > 0){
			$(this).find('option.default').attr('selected','true');			
		}else{
			$(this).find('option:first').attr('selected','true');
		}
	});
	$('input:checkbox', $el).attr("checked", false);
}

//SHA256 ENCODE

function SHA256(s){

    

    var chrsz   = 8;

    var hexcase = 0;

  

    function safe_add (x, y) {

        var lsw = (x & 0xFFFF) + (y & 0xFFFF);

        var msw = (x >> 16) + (y >> 16) + (lsw >> 16);

        return (msw << 16) | (lsw & 0xFFFF);

    }

  

    function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }

    function R (X, n) { return ( X >>> n ); }

    function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }

    function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }

    function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }

    function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }

    function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }

    function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }

  

    function core_sha256 (m, l) {

         

        var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1,

            0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,

            0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786,

            0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,

            0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147,

            0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,

            0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B,

            0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,

            0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A,

            0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,

            0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);

 

        var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 

                   0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);

 

        var W = new Array(64);

        var a, b, c, d, e, f, g, h, i, j;

        var T1, T2;

  

        m[l >> 5] |= 0x80 << (24 - l % 32);

        m[((l + 64 >> 9) << 4) + 15] = l;

  

        for ( var i = 0; i<m.length; i+=16 ) {

            a = HASH[0];

            b = HASH[1];

            c = HASH[2];

            d = HASH[3];

            e = HASH[4];

            f = HASH[5];

            g = HASH[6];

            h = HASH[7];

  

            for ( var j = 0; j<64; j++) {

                if (j < 16) W[j] = m[j + i];

                else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);

  

                T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);

                T2 = safe_add(Sigma0256(a), Maj(a, b, c));

  

                h = g;

                g = f;

                f = e;

                e = safe_add(d, T1);

                d = c;

                c = b;

                b = a;

                a = safe_add(T1, T2);

            }

  

            HASH[0] = safe_add(a, HASH[0]);

            HASH[1] = safe_add(b, HASH[1]);

            HASH[2] = safe_add(c, HASH[2]);

            HASH[3] = safe_add(d, HASH[3]);

            HASH[4] = safe_add(e, HASH[4]);

            HASH[5] = safe_add(f, HASH[5]);

            HASH[6] = safe_add(g, HASH[6]);

            HASH[7] = safe_add(h, HASH[7]);

        }

        return HASH;

    }

  

    function str2binb (str) {

        var bin = Array();

        var mask = (1 << chrsz) - 1;

        for(var i = 0; i < str.length * chrsz; i += chrsz) {

            bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);

        }

        return bin;

    }

  

    function Utf8Encode(string) {

        string = string.replace(/\r\n/g,"\n");

        var utftext = "";

  

        for (var n = 0; n < string.length; n++) {

  

            var c = string.charCodeAt(n);

  

            if (c < 128) {

                utftext += String.fromCharCode(c);

            }

            else if((c > 127) && (c < 2048)) {

                utftext += String.fromCharCode((c >> 6) | 192);

                utftext += String.fromCharCode((c & 63) | 128);

            }

            else {

                utftext += String.fromCharCode((c >> 12) | 224);

                utftext += String.fromCharCode(((c >> 6) & 63) | 128);

                utftext += String.fromCharCode((c & 63) | 128);

            }

  

        }

  

        return utftext;

    }

  

    function binb2hex (binarray) {

        var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";

        var str = "";

        for(var i = 0; i < binarray.length * 4; i++) {

            str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +

            hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);

        }

        return str;

    }

  

    s = Utf8Encode(s);

    return binb2hex(core_sha256(str2binb(s), s.length * chrsz));

}
