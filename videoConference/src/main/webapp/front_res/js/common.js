//facility icon effect
function toilet_men() {
  document.getElementById("toilet_men1").style.display = "block";
  document.getElementById("toilet_men2").style.display = "block";
  document.getElementById("toilet_girl").style.display = "none";
  document.getElementById("toilet_ele").style.display = "none";
  document.getElementById("toilet_locker1").style.display = "none";
  document.getElementById("toilet_locker2").style.display = "none";
  document.getElementById("toilet_cafe1").style.display = "none";
  document.getElementById("toilet_cafe2").style.display = "none";
  document.getElementById("toilet_meetinglounge1").style.display = "none";
  document.getElementById("toilet_meetinglounge2").style.display = "none";
  document.getElementById("toilet_meetinglounge3").style.display = "none";
}
//facility icon effect
function toilet_girl() {
  document.getElementById("toilet_girl").style.display = "block";

  document.getElementById("toilet_men1").style.display = "none";
  document.getElementById("toilet_men2").style.display = "none";
  document.getElementById("toilet_ele").style.display = "none";
  document.getElementById("toilet_locker1").style.display = "none";
  document.getElementById("toilet_locker2").style.display = "none";
  document.getElementById("toilet_cafe1").style.display = "none";
  document.getElementById("toilet_cafe2").style.display = "none";
  document.getElementById("toilet_meetinglounge1").style.display = "none";
  document.getElementById("toilet_meetinglounge2").style.display = "none";
  document.getElementById("toilet_meetinglounge3").style.display = "none";
}
//facility icon effect
function toilet_ele() {
  document.getElementById("toilet_ele").style.display = "block";

  document.getElementById("toilet_men1").style.display = "none";
  document.getElementById("toilet_men2").style.display = "none";
  document.getElementById("toilet_girl").style.display = "none";
  document.getElementById("toilet_locker1").style.display = "none";
  document.getElementById("toilet_locker2").style.display = "none";
  document.getElementById("toilet_cafe1").style.display = "none";
  document.getElementById("toilet_cafe2").style.display = "none";
  document.getElementById("toilet_meetinglounge1").style.display = "none";
  document.getElementById("toilet_meetinglounge2").style.display = "none";
  document.getElementById("toilet_meetinglounge3").style.display = "none";
}
//facility icon effect
function toilet_locker() {
  document.getElementById("toilet_locker1").style.display = "block";
  document.getElementById("toilet_locker2").style.display = "block";
  
  document.getElementById("toilet_men1").style.display = "none";
  document.getElementById("toilet_men2").style.display = "none";
  document.getElementById("toilet_girl").style.display = "none";
  document.getElementById("toilet_ele").style.display = "none";
  document.getElementById("toilet_cafe1").style.display = "none";
  document.getElementById("toilet_cafe2").style.display = "none";
  document.getElementById("toilet_meetinglounge1").style.display = "none";
  document.getElementById("toilet_meetinglounge2").style.display = "none";
  document.getElementById("toilet_meetinglounge3").style.display = "none";
}
//facility icon effect
function toilet_cafe() {
  document.getElementById("toilet_cafe1").style.display = "block";
  document.getElementById("toilet_cafe2").style.display = "block";

  document.getElementById("toilet_men1").style.display = "none";
  document.getElementById("toilet_men2").style.display = "none";
  document.getElementById("toilet_girl").style.display = "none";
  document.getElementById("toilet_ele").style.display = "none";
  document.getElementById("toilet_locker1").style.display = "none";
  document.getElementById("toilet_locker2").style.display = "none";
  document.getElementById("toilet_meetinglounge1").style.display = "none";
  document.getElementById("toilet_meetinglounge2").style.display = "none";
  document.getElementById("toilet_meetinglounge3").style.display = "none";
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
function dateDiff(_date1, _date2) {
    var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
    var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);
 
    diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
    diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());
 
    var diff = diffDate_2.getTime() - diffDate_1.getTime();
    diff = Math.ceil(diff / (1000 * 3600 * 24));
//    diff = (diff / (1000 * 3600 * 24));
 
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

function getDashboardTimeList(){
	var data = new Array();
	data.push("0800")
	data.push("0810");
	data.push("0820");
	data.push("0830");
	data.push("0840");
	data.push("0850");
	data.push("0900")
	data.push("0910");
	data.push("0920");
	data.push("0930");
	data.push("0940");
	data.push("0950");
	data.push("1000");
	data.push("1010");
	data.push("1020");
	data.push("1030");
	data.push("1040");
	data.push("1050");
	data.push("1100");
	data.push("1110");
	data.push("1120");
	data.push("1130");
	data.push("1140");
	data.push("1150");
	data.push("1200");
	data.push("1210");
	data.push("1220");
	data.push("1230");
	data.push("1240");
	data.push("1250");
	data.push("1300");
	data.push("1310");
	data.push("1320");
	data.push("1330");
	data.push("1340");
	data.push("1350");
	data.push("1400");
	data.push("1410");
	data.push("1420");
	data.push("1430");
	data.push("1440");
	data.push("1450");
	data.push("1500");
	data.push("1510");
	data.push("1520");
	data.push("1530");
	data.push("1540");
	data.push("1550");
	data.push("1600");
	data.push("1610");
	data.push("1620");
	data.push("1630");
	data.push("1640");
	data.push("1650");
	data.push("1700");
	data.push("1710");
	data.push("1720");
	data.push("1730");
	data.push("1740");
	data.push("1750");
	data.push("1800");
	data.push("1810");
	data.push("1820");
	data.push("1830");
	data.push("1840");
	data.push("1850");
	data.push("1900");
	data.push("1910");
	data.push("1920");
	data.push("1930");
	data.push("1940");
	data.push("1950");
	data.push("2000");
	data.push("2010");
	data.push("2020");
	data.push("2030");
	data.push("2040");
	data.push("2050");
	data.push("2100");
	return data;
}

function getDashboardTimeList2(){
	var data = new Array();
	data.push("0800")
	data.push("0830");
	data.push("0900")
	data.push("0930");
	data.push("1000");
	data.push("1030");
	data.push("1100");
	data.push("1130");
	data.push("1200");
	data.push("1230");
	data.push("1300");
	data.push("1330");
	data.push("1400");
	data.push("1430");
	data.push("1500");
	data.push("1530");
	data.push("1600");
	data.push("1630");
	data.push("1700");
	data.push("1730");
	data.push("1800");
	data.push("1830");
	data.push("1900");
	data.push("1930");
	data.push("2000");
	data.push("2030");
	data.push("2100");
	data.push("2130");
	return data;
}