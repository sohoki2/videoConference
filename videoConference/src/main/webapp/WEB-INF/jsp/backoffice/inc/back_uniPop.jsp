<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <button type="button" id="btn_message" style="display:none" data-needpopup-show='#app_message'>버튼 확인</button>
   <script src="/js/needpopup.js"></script>  
   <script>    
	   function need_close(){
	   	needPopup.hide();
	   }
	   needPopup.config.custom = {
	       'removerPlace': 'outside',
	       'closeOnOutside': false,
	       onShow: function() {
			console.log('needPopup is shown');
	       },
	       onHide: function() {
	           console.log('needPopup is hidden');
	       }
	   };
	   needPopup.init();
   </script>