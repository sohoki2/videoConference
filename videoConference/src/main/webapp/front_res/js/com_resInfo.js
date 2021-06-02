function fn_ResGubunCombo(resSelectId, resGubun, resGubunVal){
	
    var radio_value = "";
	$("#"+resSelectId+" option").remove();
	$("#"+resSelectId).append("<option value=''>회의실 선택</option>");
	if (resGubun == "SWC_GUBUN_2"){
		$("#"+resSelectId).append("<option value='SWC_GUBUN_2'>영상 회의실</option>");
		$("#"+resSelectId).append("<option value='SWC_GUBUN_1'>일반 회의실</option>");
        radio_value = "N";
		
		$("#resPassword_1").show();
		$("#resPassword_2").show();
		$("#sp_01").show();
		$("#sp_02").show();
	}else{
		$("#"+resSelectId).append("<option value='SWC_GUBUN_1'>일반 회의실</option>");
		radio_value = "Y";
		$("#resPassword_1").show();
		$("#resPassword_2").hide();
		$("#sp_01").show();
		$("#sp_02").hide();
	}

    

	$(":radio[name=resPassword][value='"+radio_value+"']").prop("checked", true);
	console.log("check_value="+ $(":radio[name='resPassword']:checked").val());
	$("#"+resSelectId).val(resGubunVal);
}
function fn_resReset(){	
	$("#btn_meeting").trigger("click");
}
function fn_resMeetingReset(){
	$("#resGubun").val("");
	$("#meetingSeq").val("");
	$("#meegintRoomInfo").html("");
	$("#btn_meeting").trigger("click");	
}
function fn_cancel(){
	$("#hid_attendList").val("");
	$("#div_attendList").hide();
}
//장비 시작 부분
function fn_equipList(){
	var params = {"itemId": $("#itemId").val(), 'searchEquipState' : 'EQUIP_STATE_1'};
	uniAjax("/backoffice/basicManage/equpListinfo.do", params, 
 			function(result) {
		          
			       if (result.status == "LOGIN FAIL"){
			    	        alert(result.message);
							location.href="/web/Login.do";
					   }else if (result.status == "SUCCESS"){
						    //테이블 정리 하기
						   if (result.totCnt > 0){
								$("#sp_equipLst").html("");
								var shtml = "<div class='pop_con'>";
								var divCnt = 0;
								for (var i =0; i < result.equipList.length; i ++){
									var obj = result.equipList[i];
									if( parseInt(divCnt) > 2){
										shtml += "</div><div class='pop_con'>";
										divCnt = 0;
									}
									//예약자 체크 선택 EQUIPMENT_NAME
									shtml += "<div class='box_2'><div class='left_box'><input type='checkbox' name='appEquipCode' value='"+obj.equp_code+"' onClick='fn_EquipInsert(&#39;"+obj.equp_code+"&#39;,&#39;"+obj.equipment_name+"&#39;)' /></div>";
									shtml += "<div class='left_box margin_left20'>";
									shtml += "<p class='equip_team'>"+obj.equipment_name+"</p>";
									shtml += "</div>";
									shtml += "<div class='clearfix'></div></div>";
									divCnt = parseInt(divCnt) + 1;      
								}
							    shtml += "</div>";
							  $("#sp_equipLst").html(shtml);
						   }
					   }else {
						    alert(result.message);
					   }
			    },
			    function(request){
				    alert("Error:" +request.status );	       						
			    }    		
     );	
	
}
function fn_EquipInsert(equipCode, equipName){
	 if ( $("input:checkbox[name='appEquipCode']").is(":checked") == true){
		    if  ($("#hid_equipList").val().indexOf(",") > 0){
		    	var attendInfo = $("#hid_equipList").val().split(",");
		    	for (var i in attendInfo){
		    		
		    	  if (attendInfo[i] == equipCode)	{
		    		  return;
		    		  break;
		    	  }
		    	}	
		    }
	    	var userAttendList = $("#hid_equipList").val()+","+equipCode;
	    	$("#hid_equipList").val(userAttendList);
	    	var span_info = $("#sp_popEquipLst").html() + "<span id='sp_"+equipCode+"'>"+equipName+" <a href='#' onclick='fn_equipDel(&#39;"+equipCode+"&#39;)'>[X]</a></span>";
	    	$("#sp_popEquipLst").html(span_info);
	    }else {
	    	fn_equipDel(equipCode);
	    }
}
function fn_equipDel(equipCode){
	var replaceTxt = ","+equipCode;
	var attendList = $("#hid_equipList").val().replace(replaceTxt,"");
	$("#hid_equipList").val(attendList);
	$("#sp_"+equipCode).remove();
}
function fn_equipInfo(){
	$("#sp_equipRoomInfo").html($("#sp_popEquipLst").html());
	$("#sp_popEquipLst").html("");
	$("#btn_meeting").trigger("click");	
}
function fn_resEquipReset(){	
	$("#btn_meeting").trigger("click");
}
// 장비 끝 부분
function fn_userPop(gubun){
	if (gubun == "P"){
		$("#popTopTxt").html("참석자 선택");
		$("#div_attend").show();
	}else{
		$("#popTopTxt").html("승인자 선택");
		$("#div_attend").hide();
	}
	$("#sp_popUsrLst").html("");
	$("#sp_popMeetingLst").html("");
	$("#userMode").val(gubun);
	$("#btn_view").trigger("click");
	
	var params = {};
	uniAjax("/front/resInfo/resjobPst.do", params, 
 			function(result) {
			       if (result.status == "LOGIN FAIL"){
			    	    alert(result.message);
							location.href="/front/resInfo/noInfo.do";
					   }else if (result.status == "SUCCESS"){
						    //테이블 정리 하기
							//검색봐 리스트 보여주기
							$("#searchJobpst option").remove();
						    $("#searchJobpst").append("<option value=''>부서선택</option>");
							for (var i = 0; i <= result.jobPst.length; i ++){
								try{
									$("#searchJobpst").append("<option value='"+result.jobPst[i].deptcode +"'>"+result.jobPst[i].deptname+"</option>");
								}catch(err){
									console.log(err);
								}
							}
					   }else {
						    alert(result.message);
					   }
			    },
			    function(request){
				    alert("Error:" +request.status );	       						
			    }    		
     );	
	
	
}
function fn_arrow(code){
	var size = parseInt($("#searchCenterId option").size()) -1;
	var indexNo = document.getElementById("searchCenterId").selectedIndex;
	if (code=="N"){
		var next 
		if (indexNo == size){
			$("#searchCenterId option:eq(1)").prop("selected", "selected");
		}else {
		    $("#searchCenterId option:eq("+ parseInt(parseInt(indexNo)+1)  +")").prop("selected", "selected");
		}
	}else {
		if (indexNo == "1"){
		
			$("#searchCenterId option:eq("+ parseInt(parseInt(size))  +")").prop("selected", "selected");
		}else {
			$("#searchCenterId option:eq("+ parseInt(parseInt(indexNo)-1)  +")").prop("selected", "selected");
		}
	}
	fn_search();
}
function fn_EmChoice(empno, empname){
	$("#proxyUserId").val(empno);
	$("#sp_proxyUserId").html(empname);
	$("#btn_meeting").trigger("click");
}

function fn_meetingRoom(){
	var reportSeq = ckeckboxValue('선택한 값이 없습니다.',"meetingSeq");
	if (reportSeq == false){
		return;
	}
	var meetingRoomTxt = "";
	if (reportSeq == "on"){
		$("#meegintRoomInfo").html( "PC영상회의");
		$("#meetingSeq").val(reportSeq);
	}else {
		$("input:checkbox[name=meetingSeq]:checked").each(function(){
			meetingRoomTxt = meetingRoomTxt + "," + $("#seat_"+$(this).val()).text() + "   ";
		});	
		$("#meegintRoomInfo").html(meetingRoomTxt.substring(1));
		$("#meetingSeq").val(reportSeq);
	}	
	$("#btn_meeting").trigger("click");
	//회의실명 및 
}


function fn_userCheckboxSearch(gubun){
	if ($("#searchJobpst").val() == ""){
		if (any_empt_line_id("searchCondition", '검색할 방법을 선택해 주세요.') == false) return;
		if (any_empt_line_id("searchKeyword", '검색할 내용을 입력해 주세요.') == false) return;	
	}
	var params = {'searchCondition': $("#searchCondition").val(), 'searchKeyword': $("#searchKeyword").val(), 'searchJobpst': $("#searchJobpst").val()};
	
	uniAjax("/front/resInfo/emSearchList.do", params, 
 			function(result) {
			       if (result.status == "LOGIN FAIL"){
			    	    alert(result.message);
							location.href="/front/resInfo/noInfo.do";
					   }else if (result.status == "SUCCESS"){
						    //테이블 정리 하기
							if (result.totCnt > 0){
								$("#sp_popUsrLst").html("");
								var shtml = "<div class='pop_con'>";
								var divCnt = 0;
								for (var i  in result.emList){
									var obj = result.emList[i];
									if( parseInt(divCnt) > 2){
										shtml += "</div><div class='pop_con'>";
										divCnt = 0;
									}
									//예약자 체크 선택 
									if (gubun == "Y"){
										shtml += "<div class='box_2'><div class='left_box'><input type='checkbox' name='appEmNo' value='"+obj.empno+"' checked onClick='fn_EmInsert(&#39;"+obj.empno+"&#39;,&#39;"+obj.empname+"&#39;)' /></div>";
										//사용자 추가 
										fn_EmInt(obj.empno,obj.empname);
										
									}else {
										shtml += "<div class='box_2'><div class='left_box'><input type='checkbox' name='appEmNo' value='"+obj.empno+"' onClick='fn_EmInsert(&#39;"+obj.empno+"&#39;,&#39;"+obj.empname+"&#39;)' /></div>";
										fn_userDel(obj.empno);
									}
									
									
									shtml += "<div class='left_box margin_left20'>";
									shtml += "<p class='user_nam'>"+obj.deptname+"/"+obj.empjikw+"</p><p class='user_team'>"+obj.empname+"</p>";
									shtml += "</div>";
									shtml += "<div class='clearfix'></div></div>";
									divCnt = parseInt(divCnt) + 1;      
								}
							    shtml += "</div>";
							  $("#sp_popUsrLst").html(shtml);
							}else {
								alert("검색 조건에 맞는 내용이 없습니다.");
							}
					   }else {
						    alert(result.message);
					   }
			    },
			    function(request){
				    alert("Error:" +request.status );	       						
			    }    		
     );	
}
function fn_userSearch(){
	if ($("#searchJobpst").val() == ""){
		if (any_empt_line_id("searchCondition", '검색할 방법을 선택해 주세요.') == false) return;
		if (any_empt_line_id("searchKeyword", '검색할 내용을 입력해 주세요.') == false) return;	
	}
	//
	var params = {'searchCondition': $("#searchCondition").val(), 'searchKeyword': $("#searchKeyword").val(), 'searchJobpst': $("#searchJobpst").val()};
	uniAjax("/front/resInfo/emSearchList.do", params, 
 			function(result) {
			       if (result.status == "LOGIN FAIL"){
			    	    alert(result.message);
							location.href="/front/resInfo/noInfo.do";
					   }else if (result.status == "SUCCESS"){
						    //테이블 정리 하기
							if (result.totalCnt > 0){
								$("#sp_popUsrLst").html("");
								var shtml = "<div class='pop_con'>";
								var divCnt = 0;
								for (var i in  result.emList){
									var obj = result.emList[i];
									if( parseInt(divCnt) > 2){
										shtml += "</div><div class='pop_con'>";
										divCnt = 0;
									}
									if ($("#userMode").val() == "A"){
										shtml += "<div class='box_2'><div class='left_box'><input type='radio' name='appEmNo' id='appEmNo_"+obj.empno+"' value='"+obj.empno+"' onClick='fn_EmChoice(&#39;"+obj.empno+"&#39;,&#39;"+obj.empname+"&#39;)' /></div>";
									}else {
										shtml += "<div class='box_2'><div class='left_box'><input type='checkbox' name='appEmNo'  id='appEmNo_"+obj.empno+"' value='"+obj.empno+"' onClick='fn_EmInsert(&#39;"+obj.empno+"&#39;,&#39;"+obj.empname+"&#39;)' /></div>";
									}
									shtml += "<div class='left_box margin_left20'>";
									shtml += "<p class='user_nam'>"+obj.deptname+"/"+obj.empjikw+"</p><p class='user_team'>"+obj.empname+"</p>";
									shtml += "</div>";
									shtml += "<div class='clearfix'></div></div>";
									divCnt = parseInt(divCnt) + 1;      
								}
								if (divCnt == 2){
									 console.log("divCnt:"+ divCnt);
                                     shtml += "<div class='box_2'><div class='left_box'></div><div class='left_box margin_left20'><p class='user_nam'></p><p class='user_team'></p></div><div class='clearfix'></div></div>";
								}
							    shtml += "</div>";
							  $("#sp_popUsrLst").html(shtml);
							}else {
								alert("검색 조건에 맞는 내용이 없습니다.");
							}
					   }else {
						    alert(result.message);
					   }
			    },
			    function(request){
				    alert("Error:" +request.status );	       						
			    }    		
     );	
}
//체크 박스 선택 
function fn_EmInt(empno, empname){
	
	var attendInfo = $("#hid_attendList").val().split(",");
	for (var i in attendInfo){
		
	  if (attendInfo[i] == empno)	{
		  return;
		  break;
	  }
	}
	var userAttendList = $("#hid_attendList").val()+","+empno;
	$("#hid_attendList").val(userAttendList);
	var span_info = $("#sp_popAttendLst").html() + "<span id='sp_"+empno+"'>"+empname+" <a href='#' onclick='fn_userDel("+empno+")'>[X]</a></span>";
	$("#sp_popAttendLst").html(span_info);
    
}
//체크 박스 관련 내용 정리 하기 
function fn_EmInsert(empno, empname){
    if ( $("input:checkbox[name='appEmNo']").is(":checked") == true){
    	var attendInfo = $("#hid_attendList").val().split(",");
    	for (var i in attendInfo){
    	  if (attendInfo[i] == empno)	{
    		  return;
    		  break;
    	  }
    	}
    	var userAttendList = $("#hid_attendList").val()+","+empno;
    	$("#hid_attendList").val(userAttendList);
    	var span_info = $("#sp_popAttendLst").html() + "<span id='sp_"+empno+"'>"+empname+" <a href='#' onclick='fn_userDel("+empno+")'>[X]</a></span>";
    	$("#sp_popAttendLst").html(span_info);
    }else {
    	fn_userDel(empno);
    }
}
function fn_attendList(){
	$("#sp_meetingAttendList").html($("#sp_popAttendLst").html());
	$("#sp_popAttendLst").html("");
	$("#div_attendList").show();
	$("#btn_meeting").trigger("click");	
}
//사용자 삭제
function fn_userDel(empno){
	var replaceTxt = ","+empno;
	var attendList = $("#hid_attendList").val().replace(replaceTxt,"");
	$("#hid_attendList").val(attendList);
	$("#sp_"+empno).remove();
	//체크 박스가 있는지 혹인 후 체크 되어 있으면 삭제


	if ( document.getElementById("appEmNo_"+empno) ){
         if($("#appEmNo_"+empno).is(":checked") == true){
            $("#appEmNo_"+empno).prop("checked", false);
		 }
	}else {
		 if($("#appEmNo_"+empno).is(":checked") == true){
            $("#appEmNo_"+empno).prop("checked", false);
		 }
	}
}
//회의실 전체 선택/해제
function fn_meetingCheck(gubun){
	
	var params = {'searchRoomType': $("#resGubun").val(), 'notSearchSeq' : $("#itemId").val(), 'searchSwcUseyn' :'Y'};
	uniAjax("/front/resInfo/meetingSeatList.do", params, 
 			function(result) {
			       if (result.status == "LOGIN FAIL"){
			    	    alert(result.message);
							location.href="/front/resInfo/noInfo.do";
					   }else if (result.status == "SUCCESS"){
						    //테이블 정리 하기
						   
						 if (result.totalCnt > 0){
							$("#sp_popMeetingLst").html("");
							var shtml = "<div class='pop_con'>";
							var divCnt = 0;
							for (var i  in  result.resultList){
								var obj = result.resultList[i];
								if( parseInt(divCnt) > 2){
									shtml += "</div><div class='pop_con'>";
									divCnt = 0;
								}
								shtml += "<div class='box_2'><div class='left_box'>"
								if (gubun == "Y"){
									shtml += "<input type='checkbox' name='meetingSeq' checked id='meetingSeq' value='"+obj.meeting_id+"'/>";
									
								}else {
									shtml += "<input type='checkbox' name='meetingSeq' id='meetingSeq' value='"+obj.meeting_id+"'/>";
								}
								
								shtml += "</div>";
								shtml += "<div class='left_box margin_left20'>";
								shtml += "<p class='user_nam'>"+obj.center_nm+" "+obj.floor_name+"</p>";
								shtml += "<p class='user_team' id='seat_"+obj.meeting_id+"'>"+obj.meeting_name+"</p>";
								shtml += "</div>";
								shtml += "<div class='clearfix'></div></div>";
								divCnt = parseInt(divCnt) + 1;      
							}
							if (divCnt == 2){
									 console.log("divCnt:"+ divCnt);
                                     shtml += "<div class='box_2'><div class='left_box'></div><div class='left_box margin_left20'><p class='user_nam'></p><p class='user_team'></p></div><div class='clearfix'></div></div>";
							}
						    shtml += "</div>";
						  $("#sp_popMeetingLst").html(shtml);
						 }
					   }
			    },
			    function(request){
				    alert("Error:" +request.status );	       						
			    }    		
     );
	
}

function fn_MeetingCheck(){
	if ($("#resGubun").val() == "SWC_GUBUN_2"){
		

		
		$("#div_meeting1").show();
		$("#div_meeting2").show();
		
		
		$("#btn_meetingRoom").trigger("click");
		$("#div_meetingRoomInfo").show();
		var params = {'searchRoomType': $("#resGubun").val(), 'notSearchSeq' : $("#itemId").val(), 'searchSwcUseyn' :'Y', 'searchRoomView':'Y'};
    	uniAjax("/front/resInfo/meetingSeatList.do", params, 
     			function(result) {
				       if (result.status == "LOGIN FAIL"){
				    	    alert(result.message);
  							location.href="/front/resInfo/noInfo.do";
  					   }else if (result.status == "SUCCESS"){
  						    //테이블 정리 하기
  						 if (result.totalCnt > 0){
								$("#sp_popMeetingLst").html("");
								var shtml = "<div class='pop_con'>";
								var divCnt = 0;
								
								for (var i in result.resultlist){
									var obj = result.resultlist[i];
									/*   PC 영 영상회이는 자기 겂만 확인  */
									if (i == 0){
										    shtml += "<div class='box_2'><div class='left_box'>"
											shtml += "<input type='checkbox' name='meetingSeq' id='meetingSeq' onClick='fn_meetingRoom()' />";
											shtml += "</div>";
											shtml += "<div class='left_box margin_left20'>";
											shtml += "<p class='user_nam'>PC 영상호출</p>";
											shtml += "<p class='user_team' id='seat_0'>PC 영상호출</p>";
											shtml += "</div>";
											shtml += "<div class='clearfix'></div></div>";
											divCnt = parseInt(divCnt) + 1; 
									}
									
									if( parseInt(divCnt) > 2){
										shtml += "</div><div class='pop_con'>";
										divCnt = 0;
									}
									shtml += "<div class='box_2'><div class='left_box'>"
									shtml += "<input type='checkbox' name='meetingSeq' id='meetingSeq' value='"+obj.meeting_id+"'/>";
									shtml += "</div>";
									shtml += "<div class='left_box margin_left20'>";
									shtml += "<p class='user_nam'>"+obj.center_nm+" "+obj.floor_name+"</p>";
									shtml += "<p class='user_team' id='seat_"+obj.meeting_id+"'>"+obj.meeting_name+"</p>";
									shtml += "</div>";
									shtml += "<div class='clearfix'></div></div>";
									divCnt = parseInt(divCnt) + 1;      
									//여기
								}
								if (divCnt == 2){
									 console.log("divCnt:"+ divCnt);
                                     shtml += "<div class='box_2'><div class='left_box'></div><div class='left_box margin_left20'><p class='user_nam'></p><p class='user_team'></p></div><div class='clearfix'></div></div>";
								}
							    shtml += "</div>";
							  $("#sp_popMeetingLst").html(shtml);
  						 }
  					   }
				    },
				    function(request){
					    alert("Error:" +request.status );	       						
				    }    		
         );
	}else {
		$("#div_meeting1").hide();
		$("#div_meeting2").hide();		
		$("#div_meetingRoomInfo").hide();
		$("#meetingSeq").val("");
	}
}
//장비 대여 관련 뷰 보여주기 
function fn_EquipCheck(){
	var equipCheck = "";
	if ($("#resEqupcheck").val() == "RES_EQUPCHECK_2"){
		equipCheck = "<table border=0><tr><td>"
		                  + "빔프로젝트:<input type='radio' id='equip_type01' name='equip_type01' value='Y' checked>사용"
		                  + "<input type='radio' id='equip_type01' name='equip_type01' value='N'>미사용"
		                  +"</td><td><td style='width:50px;'></td>"
		                  + "마이크:<input type='radio' id='equip_type02' name='equip_type02' value='Y' checked>사용"
		                  + "<input type='radio' id='equip_type02' name='equip_type02' value='N'>미사용"
		                  +"</td><tr>"
		                  + "</table>";
	}else {
       equipCheck = "";
	}
	$("#sp_equipRoomInfo").html(equipCheck);
}


function day_convert(date ){
	return (date.length> 7) ?  date.substring(0,4)+"년"+date.substring(4,6)+"월"+date.substring(6,8)+"일" : date ;
	
}
function fn_swcTime(swcTime, resSeq, itemId){
	var params = {'resStarttime': swcTime, 'resSeq': resSeq, 'itemId' : itemId};
	uniAjax("/front/resInfo/resInfo.do", params, 
 			function(result) {
			       if (result.status == "LOGIN FAIL"){
			    	    alert(result.message);
							location.href="/front/resInfo/noInfo.do";
					   }else if (result.status == "SUCCESS"){
						    //테이블 정리 하기
							var objS = result.resStartTime;
							
							if (objS.length > 0 ){
								$("#resStarttime option").remove();
								for (var i in objS){
								    console.log(objS[i].codeNm);
									try{
										$("#resStarttime").append("<option value='"+objS[i].codeNm.replace(":","") +"'>"+objS[i].codeNm+"</option>");
									}catch(err){
										console.log(err);
									}
  						    }
							}
							var objE = result.resEndTime;
							if (objE.length > 0 ){
								$("#resEndtime option").remove();
  							for (var i in  objE){
  								try{
  									$("#resEndtime").append("<option value="+objE[i].codeNm.replace(":","")+">"+objE[i].codeDc+"</option>");
  								}catch(err){
  									console.log(err);
  								}
  						    }
							}
							//회의실 구분
							
							fn_ResGubunCombo("resGubun", result.seatInfo.room_type, null);
							
							if (result.seatInfo.room_type != "SWC_GUBUN_2"){
								$("#resGubun").val("SWC_GUBUN_1");
							}
							
							$("#resStarttime").val(swcTime);
						    if (resSeq != "0"){
						    	$("#resEndtime").val();
						    }else {
						    	$("#resStarttime option:eq(0)").prop("selected", true);
						    	$("#resEndtime option:eq(0)").prop("selected", true);
						    }
						    	
					   }
			    },
			    function(request){
				    alert("Error:" +request.status );	       						
			    }    		
     );
}
function fn_indexInfo(itemId, timeSeq, swcTime, swcName, resSeq, centerId, seatConfirmgubun ,seatEqupgubun){
	$("#mode").val("Ins");
	$("#res_swcName").text(swcName);
	var resDay = ($("#searchResStartday").val() == "") ? today_get() : $("#searchResStartday").val();
	$("#resStartday").val(resDay);
	
	$("#sp_ResDay").text(day_convert(resDay) + "");
	$("#resStartday").val(resDay);
	$("#itemId").val(itemId);
	$("#useYn").val("Y");
    $("#sp_meetingAttendList").html("");
    $("#hid_attendList").val("");
    $("#searchCenterId").val(centerId);
    $("#seatConfirmgubun").val(seatConfirmgubun);
    $("#hid_equipList").val("");
	$("#sp_equipRoomInfo").html("");

    $("#div_meeting1").hide();
	$("#div_meeting2").hide();
	


    if (seatEqupgubun == "Y"){
    	$("#div_equipRoomInfo").show();
    }else {
    	$("#div_equipRoomInfo").hide();
    }
    
    fn_swcTime(swcTime, resSeq, itemId);
}
//팝업
function fn_resInfo(itemId, timeSeq, swcTime, swcName, resSeq, seatConfirmgubun, seatEqupgubun){
	if (resSeq == "0"){
		$("#mode").val("Ins");
		$("#res_swcName").text(swcName);
		$("#resTitle").val();
		var resDay = ($("#searchResStartday").val() == "") ? today_get() : $("#searchResStartday").val();
		$("#sp_ResDay").text(day_convert(resDay));
		$("#resStartday").val(resDay);
		$("#itemId").val(itemId);
		$("#useYn").val("Y");
        $("#sp_meetingAttendList").html("");
        $("#hid_attendList").val("");
        $("#meetingSeq").val("");
        $("#meegintRoomInfo").html("");
        $("#seatConfirmgubun").val(seatConfirmgubun);
        $("#hid_equipList").val("");
   	    $("#sp_equipRoomInfo").html("");
   	    $("#resEqupcheck").val("");

		$("#div_meeting1").hide();
	    $("#div_meeting2").hide();
	
        if (seatEqupgubun == "Y"){
        	$("#div_equipRoomInfo").show();
           // $("#resEqupcheck").html("");
         
        }else {
        	$("#div_equipRoomInfo").hide();
        }
	}else {
		$("#mode").val("Edt");
	}
	fn_swcTime(swcTime, resSeq, itemId);
}
function fn_resCancel(){	
	 $("#itemId").val("");
	 $("#resTitle").val("");
	 $("#mode").val("");
	 $("#resPassword").val("");
	 $("#resStartday").val("");
	 $("#resStarttime").val("");
	 $("#resEndtime").val("");
	 $("#proxyUserId").val("");
	 $("#resGubun").val("");
	 $("#meetingSeq").val("");
	 $("#hid_attendList").val("");
	 $("#conPin").val("");
	 $("#conAllowstream").val("N");
	 $("#conBlackdial").val("N");
	 $("#conSendnoti").val("N");
	 $("#searchKeyword").val("");
	 $("#hid_equipList").val("");
	 $("#resEqupcheck").val("");
	 $("#sp_equipRoomInfo").html("");
	
}
function fn_TimeCheck(_strTime, _endTime, alertMessage){
	$("#sp_errorMessage").html("");
	if (parseInt($("#"+_strTime).val() ) > parseInt($("#"+_endTime).val())      ){
		  $("#sp_errorMessage").html(alertMessage);
		  $("#sp_errorMessage").attr("style", "color:red");
		  $("#"+ frm_nm).attr("style", "border-color:red"); 
		  return false;
	}else{
         return true;
	}
}
function fn_resView(resSeq){
        	//예약 정보 보기 
	        var params = {'resSeq': resSeq};
        	uniAjax("/web/resInfo.do", params, 
         			function(result) {
        			       if (result.status == "LOGIN FAIL"){
        			    	    alert(result.message);
        							location.href="/web/Login.do";
        					   }else if (result.status == "SUCCESS"){
        						    //예약 정보 넣기 
        						    var obj = result.resInfo;
        						    var shtml = ""
        						              + "<span class=\"popuptext\" >"
                                              + "  <p class=\"m_room\">"+obj.meeting_name+"</p>"
                                              + "  <p class=\"m_day\">"+obj.resstartday+" "+obj.resstarttime+"~"+obj.resendtime+"</p>"
                                              + "  <p class=\"m_title\">"+obj.res_title+"</p>"
                                              + "</span>";
                                    $("#sp_message").html(shtml);
										
        					   }
        			    },
        			    function(request){
        				    alert("Error:" +request.status );	       						
        			    }    		
             );
        	$("#btn_result").trigger("click");
}
function fn_ResSave(){
	 
	 var resEqupcheck = "";
	 // 회의실 일떄 -> ITEM_GUBUN_1 로 정의 추후 변경 예정 
	 
	 if (any_empt_line_span("resTitle", '회의 제목을 입력해 주세요.',"sp_errorMessage") == false) return;
	 if (any_empt_line_span("resStarttime", '회의 시작 시간을 선택해 주세요.', "sp_errorMessage") == false) return;
	 if (any_empt_line_span("resEndtime", '회의 종료 시간을 선택해 주세요.', "sp_errorMessage") == false) return;
	 
	 if (fn_TimeCheck ( "resStarttime",  "resEndtime", "시작 시간이 종료 시간보다 빠릅니다" , "sp_errorMessage" ) == false) return;
	 if (any_empt_line_span("resGubun", '회의 구분을 선택해 주세요.', "sp_errorMessage") == false) return;
	 
	 if ($("#div_equipRoomInfo").is(":visible") == true){
           if (any_empt_line_span("resEqupcheck", '장비사용 여부를 선택해 주세요.', "sp_errorMessage") == false) return;
	 }

	 if ($("#resGubun").val() == "SWC_GUBUN_2"  && $("#meetingSeq").val() == ""){
		 $("#sp_errorMessage").html("영상회의를 진행할 회의실을 선택해 주세요.");	 
		 return;
	 }
	
	 if ($("#resEqupcheck").val() == "장비 사용여부"){
         resEqupcheck = "RES_EQUPCHECK_1";
	 }else {
		 //여기 부분에 값 넣기 
		 resEqupcheck = $("#resEqupcheck").val();
	 }
	 if ($("#meetingSeq").val() == "on"){
          $("#meetingSeq").val("");
		  
	 }
	
	 var params = {'mode': $("#mode").val(), 'itemId': $("#itemId").val(), 'itemGubun':'ITEM_GUBUN_1', 'resTitle' : $("#resTitle").val(),
	               'resPassword' : fn_domNullReplace( $(":radio[name='resPassword']:checked").val() ,'Y'), 'resStartday' : $("#resStartday").val(),
			       'resStarttime' : $("#resStarttime").val(), 'resEndtime' : $("#resEndtime").val(),
			       'proxyUserId' : $("#proxyUserId").val(), 'resGubun' : $("#resGubun").val(),
			       'useYn' : "Y", 'centerId': $("#searchCenterId").val(),
			       'proxyYn' :  $("#proxyYn").val(),  'meetingSeq' : $("#meetingSeq").val(), 
			       'seatConfirmgubun': $("#seatConfirmgubun").val(),
			       'resAttendlist' : $("#hid_attendList").val().substring(1),
			       'conNumber' : "", 'conPin' : $("#conPin").val(),
			       'conVirtualPin' :$("#conVirtualPin").val(), 'conAllowstream' : fn_domNullReplace($("#conAllowstream").val(), "N") ,
			       'conBlackdial' : fn_domNullReplace($("#conBlackdial").val(), "N") , 'conSendnoti' :  fn_domNullReplace($("#conSendnoti").val(), "N"),
			       'resEqupcheck' : fn_domNullReplace( $("#resEqupcheck").val(), "RES_EQUPCHECK_1"), 
			       'sendMessage' : fn_domNullReplace( $(":checkbox[name='sendMessage']:checked").val() ,'Y'),
			       'floorSeq' : $("#floorSeq").val()
	              };
	
	 //값 수정 
	 uniAjax("/web/resReservertionUpdate.do", params, 
  			function(result) {
				       if (result.status == "LOGIN FAIL"){
						    alert(result.message);
							location.href="/web/Login.do";
					   }else  {
					        
					   	    need_close()
						    $("#sp_message").text(result.message);
						    $("#btn_result").trigger("click");
						    fn_resCancel();
						    res.fn_floorInfo();			   
					   }
					  
			},
		    function(request){
			     alert("Error:" +request.status );	       						
		    }    		
      );
}

function fn_paramReset(){
		 $("#itemId").val("");
		 $("#resTitle").val("");
		 $("#mode").val("");
		 $("#resPassword").val("");
		 $("#resStartday").val("");
		 $("#resStarttime").val("");
		 $("#resEndtime").val("");
		 $("#proxyUserId").val("");
		 $("#resGubun").val("");
		 $("#meetingSeq").val("");
		 $("#hid_attendList").val("");
		 $("#conPin").val("");
		 $("#conAllowstream").val("N");
		 $("#conBlackdial").val("N");
		 $("#conSendnoti").val("N");
		      
		 
}
