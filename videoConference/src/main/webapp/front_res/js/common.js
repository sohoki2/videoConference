//facility icon effect
function any_empt_line_id(frm_nm, alert_message){
     if ($('#'+frm_nm).val() == "" || $('#'+frm_nm).val() == null ){
		  alert(alert_message);
		  $('#'+frm_nm).focus();
		  return false;
	 }else{
         return true;
	 }
}
//패스워드 설정 
function chkPwd(str){
	 var reg_pwd = /^.*(?=.{10,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	 if(!reg_pwd.test(str)){
	    $("#sp_message").text("비밀번호를 확인하세요.<br/>(영문,숫자를 혼합하여 10~20자 이내) ");
	    $("#btn_result").trigger("click");
	    return false;
	 }
	 return true;
}
function fn_Check (_UniCheckFormNm, _btn_message){
	if ($("#"+_UniCheckFormNm).is(":checked") == true){
		return true;
	}else {
	    $("#sp_message").text(_btn_message);
	    $("#btn_result").trigger("click");
		return false;
	}
}
//핸드폰 번호
//var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
//4. 일반 전화번호 정규식
//var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;


function any_empt_line_span(frm_nm, alert_message){
     //if ($('#'+frm_nm).val() == "" || $('#'+frm_nm).val() == null ){
     if ($('#'+frm_nm).val() == "" ){
         $("#sp_message").html(alert_message);
		 $("#btn_result").trigger("click");
		 $('#'+frm_nm).focus();
		 return false;
	 }else{
         return true;
	 }
}
function fn_index(){
    location.href="/web/Login.do";
}
function fn_uniCheck(url, params, _field){
    uniAjax(url, params, 
			  function(result) {
			       var alert_message = ""; 
			       if (result.status == "SUCCESS"){
	                   //관련자 보여 주기 
	                   alert_message = "사용 가능한 아이디 입니다.";
					   $("#"+_field).val("Y");
				   }else {
				      alert_message = "사용할 수 없는 아이디 입니다.";
					  $("#"+_field).val("N");
				   }
				   $("#sp_message").html(alert_message);
		           $("#btn_result").trigger("click");
			  },
			  function(request){
				    alert("Error:" +request.status );	       						
			  }    		
	);
}
function verifyEmail(_field){
    var emailVal = $("#"+_field).val(); 
	var reg_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if (!reg_email.test(emailVal)) { 
		$("#sp_message").html("입력한 이메일이 형식에 맞지 않습니다.");
		$("#btn_result").trigger("click");
		return false; 
	} else { 
		return true; 
	}

}
function fn_trInnerTxt(td_id, td_message){
  if (td_message == ""){
     $("#"+td_id).parent().hide();
  }else {
     $("#"+td_id).parent().show();
     $("#"+td_id)[0].innerText = td_message;
  }

}
//return 값 받아 오기 
function uniAjaxReturn(url, param){
    var returnVal = "";
	$.ajax({
		        type : 'POST',
		        url : url,
		        async: false,
		        beforeSend:function(jxFax, settings){
	        	   jxFax.setRequestHeader('AJAX', true);
	        	   //$('.loadingDiv').show();
	            }, 
		        complete : function(jqXHR, textStatus) {
		        },
		        contentType : "application/json; charset=utf-8",
		        data : JSON.stringify(param)
		    }).done(function(result){
		           if (result.status == "LOGIN FAIL"){
		               alert(result.meesage);
					   location.href="/web/Login.do";
				   }else if (result.status == "SUCCESS"){
				       returnVal = result;
				   }else {
				       alert(result.meesage); 
				   }
		       }
		    ).fail(function(request){
		          alert("Error:" +request.status );
		           }
	);
	return returnVal;
}
//return 값 받아 오기 
function uniAjaxReturnSerial(url, param){
    var returnVal = "";
	var jxFax =  $.ajax({
		        type : 'GET',
		        url : url,
		        async: false,
		        beforeSend : function(jqXHR, settings) {
			       jqXHR.setRequestHeader('AJAX', true);
			       //$('.loadingDiv').show();
		        }, 
		        complete : function(jqXHR, textStatus) {
		        },
		        contentType : "application/json; charset=utf-8",
		        data : param,
		    }).done(function(result){
		           if (result.status == "LOGIN FAIL"){
			    	   alert("로그 아웃 상태 입니다.");
					   location.href="/web/Login.do";
				   }else if (result.status == "SUCCESS"){
				       returnVal = result;
				   }else {
				       alert("ERROR" +result.meesage); 
				   }
		       }
		    ).fail(function(request){
		          alert("Error:" +request.status );
		       }
	);
    return returnVal;
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
function uniAjax(url, param, done_callback, fail_callback){
	var jxFax =  $.ajax({
		        type : 'POST',
		        url : url,
		        async: false,
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
function today_get(){
	var now = new Date();
    var today_day = fnLPAD(String(now.getDate()), "0", 2); //일자를 구함
    var today_month = fnLPAD(String((now.getMonth() + 1)), "0", 2); // 월(month)을 구함    
    var today_year = String(now.getFullYear()); //년(year)을 구함
    var today = today_year + today_month + today_day;
    
    return today;
}
//지난 일자는 등록 하지 못하게 하기 
function yesterDayConfirm(res_day, alert_message){
	var day = new Date();
    var dateNow = fnLPAD(String(day.getDate()), "0", 2); //일자를 구함
    var monthNow = fnLPAD(String((day.getMonth() + 1)), "0", 2); // 월(month)을 구함    
    var yearNow = String(day.getFullYear()); //년(year)을 구함
    var today = yearNow + monthNow + dateNow;
    
    if (parseInt(res_day) < today){
    	$("#sp_message").html(alert_message);	 
	    $("#btn_result").trigger("click");
    	return false;
    }else {
    	return true;
    }
}
function dayConvert(day){
    
    
	if(day.length == 8){
	    
		day = day.substring(0,4)+"-"+day.substring(4,6)+"-"+day.substring(6,8);
	}
	return day 
}
//요청일로 부터 비교 하기 
function dateAdd(reqDay){
	var now = new Date();
	now.setDate(now.getDate()+ parseInt(reqDay));
    var req_day = fnLPAD(String(now.getDate()), "0", 2); //일자를 구함
    var req_month = fnLPAD(String((now.getMonth() + 1)), "0", 2); // 월(month)을 구함    
    var req_year = String(now.getFullYear()); //년(year)을 구함
    var reqDay = req_year + req_month + req_day;
    return reqDay;
}
function dateCheck (_date, _addDay, alert_message){
   if (parseInt(_date) < dateAdd(_addDay)){
    	$("#sp_message").html(alert_message);	 
	    $("#btn_result").trigger("click");
    	return false;
   }else {
    	return true;
   }
}
function dateDiffCheck (_date, _addDay, alert_message){
   if (parseInt(_date) > parseInt(_addDay)){
    	$("#sp_message").html(alert_message);	 
	    $("#btn_result").trigger("click");
    	return false;
    }else {
    	return true;
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
function fn_domNullReplace(checkField, nullVal){
	return ( (checkField == "" || checkField == undefined) ? nullVal : checkField);		
}
function need_close(){
     	needPopup.hide();
}
function NVL(reqValue){
			return (reqValue == undefined || reqValue == "") ? "" : reqValue;
}
//체크 박스 체크 여부
function checkbox_val(message, checkboxNm){
		 var checkboxvalue = "";
		 var check_length = $("input:checkbox[name="+checkboxNm+"]:checked").length;
		 if (check_length <1){
		    $("#sp_message").html(message);
	        $("#btn_result").trigger("click");
			return false;
		 }else {
			$("input:checkbox[name="+checkboxNm+"]:checked").each(function(){
				checkboxvalue = checkboxvalue+","+ $(this).val();
			});	
		 }
		 return checkboxvalue.substring(1);
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
//특정 문자 앞에 값 넣기 
function timeComma(str, gubun){
   if (gubun == "S"){
     str = str.substring(0,2)+":"+str.substring(2,4)
   }else {
     if (str.substring(2,4) == "30"){
        str = parseInt(parseInt(str.substring(0,2)) +1) + ":00";
     }else{
        str = str.substring(0,2)+":30";
     }
   }
   return str;
}
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

//List to Day 변경 
function fn_ViewChange(_viewGubun){
            	var url = (_viewGubun == "List") ? "/web/meetingList.do" : "/web/meetingDay.do" ;
            	$("form[name=regist]").attr("action",url).submit();
}
function ajaxPaging(currentPageNo, firstPageNo, recordCountPerPage, firstPageNoOnPageList, lastPageNoOnPageList, totalPageCount, pageSize, pageScript){
    var pageHtml = "";
    pageHtml += "<ul class='page_num'>";
	 if (currentPageNo == firstPageNo ){
      pageHtml += "<li><a href='#' >&laquo;</a></li>";
	 }else {
      pageHtml += "<li><a href='#' onclick='"+pageScript+"("+ firstPageNo +")';return false; '>&laquo;</a></li>";
	 }
	 if (parseInt(currentPageNo) > parseInt(firstPageNo)){
      pageHtml += "<li><a href='#' onclick='"+pageScript+"("+ parseInt(parseInt(currentPageNo) -1)+");return false;'>&lt;</a></li>"
	 }else {
      pageHtml += "<li><a href='#' >&lt;</a></li>"
	 }
    for(var  i = firstPageNoOnPageList; i<= lastPageNoOnPageList; i++){
		 if (i == currentPageNo){
            pageHtml += "<li class=active>"+i+"</li>";
		 }else {
            pageHtml += "<li><a href='#' onclick='"+pageScript+"("+i+");return false; '>"+i+"</a></li>";
		 }
    }

	 if (parseInt(totalPageCount) > parseInt(pageSize) ){
        pageHtml += "<li><a href='#' onclick='"+pageScript+"("+ parseInt(parseInt(currentPageNo) + 1)+");return false;'>&gt;</a></li>"
	 }else {
        pageHtml += "<li><a href='#' onclick='"+pageScript+"("+ parseInt(parseInt(currentPageNo) + 1)+");return false;'>&gt;</a></li>"
	 }
    if (parseInt(totalPageCount) > parseInt(pageSize)  ){
      pageHtml += "<li><a href='#' onclick='"+pageScript+"("+ totalPageCount +");return false;'>&raquo;</a></li>";
	 }else{
      pageHtml += "<li><a href='#' >&raquo;</a>";
	 }	
    return pageHtml;
}
//top 메뉴 
function fn_floorSearch(floorSeq , _action_url){
        
		$("#dv_floor").find("[name=btn_floor]").attr('class', '');
		$("#btn_"+floorSeq).attr('class', 'active');
		$("#floorSeq").val(floorSeq);
		var call_script = eval("window."+_action_url+"();"); 		
}
//his 화면 정리 
function fn_hisInfo(){
    need_close();
    if ($("#hid_history").val() != "")
       var call_script = eval("window."+$("#hid_history").val()+"();"); 
}
//공백 제거
function trim(str){
	return str.replace(/ /gi, "");
} 
 
 
//facility icon effect
function toilet_meetinglounge() {
  document.getElementById("toilet_meetinglounge1").style.display = "block";
  document.getElementById("toilet_meetinglounge2").style.display = "block";
  document.getElementById("toilet_meetinglounge3").style.display = "block";

  document.getElementById("toilet_men1").style.display = "none";
  document.getElementById("toilet_men2").style.display = "none";
  document.getElementById("toilet_girl").style.display = "none";
  document.getElementById("toilet_ele").style.display = "none";
  document.getElementById("toilet_locker1").style.display = "none";
  document.getElementById("toilet_locker2").style.display = "none";
  document.getElementById("toilet_cafe1").style.display = "none";
  document.getElementById("toilet_cafe2").style.display = "none";
}

//leftMenu _ gnb
function openNav() {
  document.getElementById("mySidenav").style.display = "block";
  document.getElementById("mySidenav").style.width = "100%";
  document.getElementById("mySidenav1").style.width = "280px";
  document.getElementById("userBox").style.width = "220px";
}
function closeNav() {
	document.getElementById("mySidenav").style.display = "none";
  document.getElementById("mySidenav").style.width = "0";
  document.getElementById("mySidenav1").style.width = "0";
  document.getElementById("userBox").style.width = "0";
}

//leftMenu _ gnb
function openTime() {
  document.getElementById("mySidetime").style.display = "block";
  document.getElementById("mySidetime").style.width = "100%";
  document.getElementById("userBox").style.width = "220px";
}
function closeTime() {
  document.getElementById("mySidetime").style.display = "none";
  document.getElementById("mySidetime").style.width = "0";
  document.getElementById("userBox").style.width = "0";
}

//rightMenu _ floor
function openRight() {
  document.getElementById("rightMenu").style.width = "100%";
  document.getElementById("rightMenu1").style.width = "280px";
}
function closeRight() {
//  document.getElementById("rightMenu").style.width = "0";
//  document.getElementById("rightMenu1").style.width = "0";
}
//my reserve
function reserve() {
  document.getElementById("reserve").style.display = "block";
  document.getElementById("reserve_back").style.width = "100%";
  document.getElementById("mySidenav").style.width = "0";
  document.getElementById("mySidenav1").style.width = "0";
}
function closeReserve() {
  document.getElementById("reserve").style.display = "none";
  document.getElementById("reserve_back").style.width = "0";
}
//notice
function notice() {
  document.getElementById("notice").style.display = "block";
  document.getElementById("notice_back").style.width = "100%";
  document.getElementById("mySidenav").style.width = "0";
  document.getElementById("mySidenav1").style.width = "0";
}
  function closeNotice() {
  document.getElementById("notice").style.display = "none";
  document.getElementById("notice_back").style.width = "0";
}
//pass
  function pass() {
	  document.getElementById("pass").style.display = "block";
	  document.getElementById("pass_back").style.width = "100%";
	  document.getElementById("mySidenav").style.width = "0";
	  document.getElementById("mySidenav1").style.width = "0";
  }
  function closePass() {
	  document.getElementById("pass").style.display = "none";
	  document.getElementById("pass_back").style.width = "0";
  }
//meetingroom search
function meetingView() {
  document.getElementById("meetingView").style.display = "block";
  document.getElementById("meetingView_back").style.width = "100%";
}
function closeMeeting() {
  document.getElementById("meetingView").style.display = "none";
  document.getElementById("meetingView_back").style.width = "0";
}
//reser01_seat timebar
function seatBtn() {
  document.getElementById("seatBtn").style.height = "auto";
}
function closeSeat(obj) {
	$('#'+obj).css('display', 'none');
	var currentDate = new Date();  
	$("#reserve_date").datepicker().datepicker("setDate", currentDate );
	$("#area_Map li").siblings().removeClass("select");
}
//reser01_seat reserve info
function seatBtn2() {
  document.getElementById("seatBtn2").style.height = "auto";
}
function closeSeat2() {
  document.getElementById("seatBtn2").style.height = "0";
}



//date
/*
$(document).ready(function () {
	
    // gnb
    $(".nav_box").on('mouseenter focusin', function () {
        $(".twoDBg").slideDown(300);
        $(".nav_box li .twoD").slideDown(300);
    })
    $(".nav_box").on('mouseleave', function () {
        $(".twoDBg").stop().slideUp(300);
        $(".nav_box li .twoD").stop().slideUp(300);
    })

    // 모바일메뉴
    $('.mobile_gnb_open_btn').click(function () {
        if ($(this).is('.is-active')) {
            $(this).removeClass('is-active');
            $(".mobile_gnb_list").removeClass('on');
            $(".family_link_m").removeClass('on');
            $(".header_wrap .header h1").removeClass('on');
            $("html, body").css({
                "height": "auto",
                "overflow-y": "auto"
            });
            $(".mobile_gnb_list .gnb_area .oneD.depth").eq(mOneDNum).removeClass("on");
            $(".mobile_gnb_list .gnb_area .twoD").eq(mOneDNum).hide();
            mOneDNum = -1;
        } else {
            $(this).addClass('is-active');
            $(".mobile_gnb_list").addClass('on');
            $(".family_link_m").addClass('on');
            $(".header_wrap .header h1").addClass('on');
            $("html, body").css({
                "height": $(window).height(),
                "overflow-y": "hidden"
            });
        };
    });

    var mOneDNum = -1;
    $(".mobile_gnb_list .gnb_area .oneD.depth").each(function (i) {
        $(this).click(function () {
            if (mOneDNum != i) {
                $(".mobile_gnb_list .gnb_area .oneD.depth").eq(mOneDNum).removeClass("on");
                $(".mobile_gnb_list .gnb_area .twoD").eq(mOneDNum).slideUp(300);
                mOneDNum = i;
                $(".mobile_gnb_list .gnb_area .oneD.depth").eq(mOneDNum).addClass("on");
                $(".mobile_gnb_list .gnb_area .twoD").eq(mOneDNum).slideDown(300);
            } else {
                $(".mobile_gnb_list .gnb_area .oneD.depth").eq(mOneDNum).removeClass("on");
                $(".mobile_gnb_list .gnb_area .twoD").eq(mOneDNum).slideUp(300);
                mOneDNum = -1;
            }
        });
    });
    
    
    history.pushState(null, null, location.href);
    window.onpopstate = function(event) {
    	history.go(-1);
    	location.document.reload();
    };
    
    $("#resultList").on("click", "tr", function() {
		$(this).siblings().removeClass("select");
		$(this).addClass("select");
    });
    
});
*/
//$(window).ajaxStart(function () {
//	$('.wrap-loading').show();	// 로딩바
//});
//
//$(window).ajaxComplete(function () {
//	$('.wrap-loading').hide();	// 로딩바
//});

// 모바일 메뉴 css변경
jQuery(document).ready(function() {
    var bodyOffset = jQuery('body').offset();
    jQuery(window).scroll(function() {
        if (jQuery(document).scrollTop() > bodyOffset.top) {
            jQuery('header').addClass('scroll');
        } else {
            jQuery('header').removeClass('scroll');
        }
    });
});


function getStr(str){
	if(str == null || str == 'null'){
		return '';
	}else{
		return str;
	}
}

function getDateTimeForm(param){
	if(param == null){
		return '';
	}else{
		return param.substring(0,4)+'-'+param.substring(4,6)+'-'+param.substring(6,8) + ' ' + param.substring(8,10) + ':'+param.substring(10,12);
	}
}
function getDateForm(param){
	if(param == null){
		return '';
	}else{
		return param.substring(0,4)+'-'+param.substring(4,6)+'-'+param.substring(6,8);
	}
}

function getPhone(str) {
	var number = '';
	var phone = "";
	if(str != null){
		number = str.replace(/[^0-9]/g, "");
	}else{
		return '';
	}
	
    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    str = phone;
    return phone;
}

function getTel(str) {
	var number = '';
	var phone = "";
	if(str != null){
		number = str.replace(/[^0-9]/g, "");
	}else{
		return '';
	}
	var tel = '';
	if(number.substring(0, 2).indexOf('02') == 0) {
		if(number.length < 3) {
            return number;
        } else if(number.length < 6) {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2);
        } else if(number.length < 10) {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2, 3);
            tel += "-";
            tel += number.substr(5);
        } else {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2, 4);
            tel += "-";
            tel += number.substr(6);
        }
    
    // 서울 지역번호(02)가 아닌경우
    } else {
        if(number.length < 4) {
            return number;
        } else if(number.length < 7) {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3);
        } else if(number.length < 11) {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3, 3);
            tel += "-";
            tel += number.substr(6);
        } else {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3, 4);
            tel += "-";
            tel += number.substr(7);
        }
    }


	return tel;
}

function getComma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function getParameter(param) {
	var returnValue;
	var url = location.href;
	var parameters = (url.slice(url.indexOf('?') + 1,
			url.length)).split('&');
	for (var i = 0; i < parameters.length; i++) {
		var varName = parameters[i].split('=')[0];
		if (varName.toUpperCase() == param.toUpperCase()) {
			returnValue = parameters[i].split('=')[1];
			return decodeURIComponent(returnValue);
		}
	}
}


function getRole(str) {
	if(str == null){
		str = '';
	}
	if(str == '01'){
		str = '일반사용자';
	}else if(str == '02'){
		str = '관리자';
	}else if(str == '03'){
		str = '슈퍼 관리자';
	}else{
		str = '일반사용자';
	}
    return str;
}

function getFormatDate(date){
    var year = date.getFullYear();              // yyyy
    var month = (1 + date.getMonth());          // M
    month = month >= 10 ? month : '0' + month;  // month 두자리로 저장
    var day = date.getDate();                   // d
    day = day >= 10 ? day : '0' + day;          // day 두자리로 저장
    return  year + '-' + month + '-' + day;
}

String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

function getIP(str){
	if(str == null){
		str = '';
	}
	
	str = str.split('.');
	return str; 
	
}

function getTimeForm(str){
	if(str == null){
		str = '';
	}
	return str.substring(0,2) + ':' + str.substring(2,4) 
}

function getTimeList(id){
	var str = '<select id="'+id+'" name="'+id+'">';
	str += '<option value="0000">00:00</option>';
	str += '<option value="0030">00:30</option>';
	str += '<option value="0100">01:00</option>';
	str += '<option value="0130">01:30</option>';
	str += '<option value="0200">02:00</option>';
	str += '<option value="0230">02:30</option>';
	str += '<option value="0300">03:00</option>';
	str += '<option value="0330">03:30</option>';
	str += '<option value="0400">04:00</option>';
	str += '<option value="0430">04:30</option>';
	str += '<option value="0500">05:00</option>';
	str += '<option value="0530">05:30</option>';
	str += '<option value="0600">06:00</option>';
	str += '<option value="0630">06:30</option>';
	str += '<option value="0700">07:00</option>';
	str += '<option value="0730">07:30</option>';
	str += '<option value="0800">08:00</option>';
	str += '<option value="0830">08:30</option>';
	str += '<option value="0900">09:00</option>';
	str += '<option value="0930">09:30</option>';
	str += '<option value="1000">10:00</option>';
	str += '<option value="1030">10:30</option>';
	str += '<option value="1100">11:00</option>';
	str += '<option value="1130">11:30</option>';
	str += '<option value="1200">12:00</option>';
	str += '<option value="1230">12:30</option>';
	str += '<option value="1300">13:00</option>';
	str += '<option value="1330">13:30</option>';
	str += '<option value="1400">14:00</option>';
	str += '<option value="1430">14:30</option>';
	str += '<option value="1500">15:00</option>';
	str += '<option value="1530">15:30</option>';
	str += '<option value="1600">16:00</option>';
	str += '<option value="1630">16:30</option>';
	str += '<option value="1700">17:00</option>';
	str += '<option value="1730">17:30</option>';
	str += '<option value="1800">18:00</option>';
	str += '<option value="1830">18:30</option>';
	str += '<option value="1900">19:00</option>';
	str += '<option value="1930">19:30</option>';
	str += '<option value="2000">20:00</option>';
	str += '<option value="2030">20:30</option>';
	str += '<option value="2100">21:00</option>';
	str += '<option value="2130">21:30</option>';
	str += '<option value="2200">22:00</option>';
	str += '<option value="2230">22:30</option>';
	str += '<option value="2300">23:00</option>';
	str += '<option value="2330">23:30</option>';
	str += '<option value="2400">24:00</option>';
	str +='</select>';
	return str;
}

function useTimeList(arr){
	var str = '';
	for ( var i in arr) {
		str += '<option value="'+ arr[i].start_time +'">' + getTimeForm(arr[i].start_time) + '</option>';
	}
	return str;
}

function get_reserve_status(val){
	var str = '';
//	if(val == '1'){
//		str += '<option value="1" selected="selected">임시예약</option>';
//	}else{
//		str += '<option value="1">임시예약</option>';
//	}
	
	if(val == '2'){
		str += '<option value="2" selected="selected">예약</option>';
	}else{
		str += '<option value="2">예약</option>';
	}
	
	if(val == '3'){
		str += '<option value="3" selected="selected">승인</option>';
	}else{
		str += '<option value="3">승인</option>';
	}
	if(val =='5'){
		str += '<option value="5" selected="selected">반려</option>';
	}else{
		str += '<option value="5">반려</option>';
	}
	
	if(val == '4'){
		str = '<option value="4" selected="selected">사용자 취소</option>';
	}
	
	return str;
}
var ip_filter = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;

/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}


//날짜 비교
function dateDiff(_date1, _date2) {
    var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
    var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);
 
    diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
    diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());
 
    var diff = diffDate_2.getTime() - diffDate_1.getTime();
    diff = Math.ceil(diff / (1000 * 3600 * 24));
    return diff;
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}


function checkFileName(obj){
	var str = $(obj).val();
	str = str.split('\\').pop().toLowerCase();;
	//1. 확장자명 체크
	var ext =  str.split('.').pop().toLowerCase();
	if($.inArray(ext, ['bmp' , 'hwp', 'jpg', 'pdf', 'png', 'xls', 'zip', 'pptx', 'xlsx', 'jpeg', 'doc', 'gif', 'hwp', 'ppt', 'docx', 'txt']) == -1) {
		alert(ext+'파일은 업로드 하실 수 없습니다.');
		$(obj).val('');
		return false;
// 		alert(ext);
	}
	//2. 파일명에 특수문자 체크
	var pattern =   /[\{\}\/?,;:|*~`!^\+<>@\#$%&\\\=\'\"]/gi;
	if(pattern.test(str) ){
		//alert("파일명에 허용된 특수문자는 '-', '_', '(', ')', '[', ']', '.' 입니다.");
		alert('파일명에 특수문자를 제거해주세요.');
		$(obj).val('');
		return false;
	}
}

function notice_file_down(notice_id){
	document.location.href = '/Common/getNoticeFileDownload.do?notice_id='+notice_id;
}

String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
Number.prototype.zf = function (len) { return this.toString().zf(len); };

Date.prototype.format = function (f) {

    if (!this.valueOf()) return " ";

    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];

    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];

    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    var d = this;

 

    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {

        switch ($1) {

            case "yyyy": return String(d.getFullYear()).replace(' ',''); // 년 (4자리)

            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)

            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)

            case "dd": return d.getDate().zf(2); // 일 (2자리)

            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)

            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)

            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)

            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)

            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)

            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)

            case "mm": return d.getMinutes().zf(2); // 분 (2자리)

            case "ss": return d.getSeconds().zf(2); // 초 (2자리)

            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분

            default: return $1;

        }
    });
};
