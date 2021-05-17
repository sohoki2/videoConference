function fn_resView(resSeq){
        	//예약 정보 보기 
	       var params = {'resSeq': resSeq};
        	uniAjax("/front/resInfo/resInfo.do", params, 
         			function(result) {
        			       if (result.status == "LOGIN FAIL"){
        			    	    alert(result.message);
        							location.href="/front/resInfo/noInfo.do";
        					   }else if (result.status == "SUCCESS"){
        						    //예약 정보 넣기 
        						    var obj = result.resInfo;
        						    $("#sp_res_swcName").html(obj.meeting_name);
									if (obj.res_password == "Y"){
									   $("#sp_resTitle").html(obj.res_title);
									}else {
                                       $("#sp_resTitle").html("비공개 회의");
									}
        						    
        						    var passCheck = (obj.res_password == "Y") ? "공개" : "비공개";
          						    $("#sp_resPassword").html(passCheck);
          						    $("#sp_ResStartDay").html(obj.resstartday);
          						    $("#sp_ResStartTime").html(obj.resstarttime+"~"+obj.resendtime);
          						    //var proxyYnTxt = (obj.proxy_yn == "S") ? "승인" : "관리자요청";
          						    $("#sp_proxyYn").html(obj.reservprocessgubuntxt);
          						    $("#sp_regGubun").html(obj.resgubuntxt);
	          						if (obj.res_gubun == "SWC_GUBUN_2"){
										if (result.resRoomInfo != undefined){
											var meetingInfoTxt = "동시 진행할 영상회의실: ";
											if (result.resRoomInfo.length > 0){
												for (var i =0; i < result.resRoomInfo.length; i++){
													var meetinginfo = result.resRoomInfo[i];
													meetingInfoTxt += "<span style='padding-left: 10px;'>※"+meetinginfo.seatName+"</span>";
												}
												$("#div_meetingResRoomInfo").show();
												$("#sp_meegintRoomInfo").html(meetingInfoTxt);
											}
										}
	          							
	          						}
	          						var userYnMessage = (obj.use_yn == "Y") ? "사용" : "사용안함";
	          						$("#sp_useYn").html(userYnMessage);
	          						if (result.resUserList.length > 0){
	          							var userInfoTxt = "예약자: "+ obj.empname+"("+obj.deptname+ ") 참석자: ";
										//var userInfoTxt = " 참석자: ";
	          							if (obj.resPassword == "Y"){
	          								for (var i=0; i < result.resUserList.length; i++){
	        							  		var userInfos = result.resUserList[i];
	        							  	    userInfoTxt += "<span style='padding-left: 10px;'>"+userInfos.empname+"("+userInfos.deptname+")</span>";
	        							  	}	
	          							}else {
	          								userInfoTxt += "*****************";
	          							}
	          							$("#sp_ResMeetingAttendList").html(userInfoTxt);
	          						}
									//장비 사용 여부 확인 
									$("#sp_EquipList").show();
									$("#sp_EquipList").html("");
										
        					   }
        			    },
        			    function(request){
        				    alert("Error:" +request.status );	       						
        			    }    		
             );
        	$("#btn_res").trigger("click");
        }