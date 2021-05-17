var front_common = {
    fn_floorState : function (floorSeq){
         var _url = "/backoffice/basicManage/floorListAjax.do";
	     var _params = {"centerId" : $("#centerId").val(), "floorUseyn": "Y"};
	     fn_comboListPost("sp_floor", "floorSeq",_url, _params, "jqGridFunc.fn_partState()", "120px", floorSeq); 
    } 

}

 