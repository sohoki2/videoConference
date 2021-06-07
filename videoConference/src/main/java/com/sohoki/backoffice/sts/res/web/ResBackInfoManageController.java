package com.sohoki.backoffice.sts.res.web;


import java.util.Arrays;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.sts.res.service.ResInfoManageService;
import com.sohoki.backoffice.sts.res.service.TimeInfoManageService;
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;
import com.sohoki.backoffice.sym.ccm.cde.vo.CmmnDetailCodeVO;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorPartInfoManageService;
import com.sohoki.backoffice.sym.equ.mapper.EquipmentManageMapper;
import com.sohoki.backoffice.sym.equ.vo.EquipmentVO;
import com.sohoki.backoffice.sym.space.service.MeetingRoomInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;

@RestController
@RequestMapping("/backoffice/resManage")
public class ResBackInfoManageController {

	
	    private static final Logger LOGGER = LoggerFactory.getLogger(ResBackInfoManageController.class);
	 
	    //좌석 관련 
	    @Autowired
		private MeetingRoomInfoManageService meetingService;
		
		
		@Autowired
		protected EgovMessageSource egovMessageSource;
		
		@Autowired
	    protected EgovPropertyService propertiesService;

		
		@Autowired
		private ResInfoManageService resService;
		
		@Autowired
		private EmpInfoManageService empInfo;
		
		@Autowired
		private CenterInfoManageService centerService;
		
		@Autowired
		private OrgInfoManageService orgService;
		
		@Autowired
		private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
		
		@Autowired
		private EquipmentManageMapper equipMapper;
		
		//시간 관련 
		@Autowired
		private TimeInfoManageService timeService;
		
		@Autowired
		private SmartUtil util;
		
		@Autowired
		private FloorInfoManageService floorService;
		
		@Autowired
		private FloorPartInfoManageService partService;
		
		
		@RequestMapping("resEquipChange.do")
		public ModelAndView updateEquipChange(@ModelAttribute("loginVO") AdminLoginVO loginVO
													                , @RequestBody ResInfoVO searchVO
													            	, HttpServletRequest request
																	, BindingResult bindingResult) throws Exception{
				 ModelAndView model = new ModelAndView(Globals.JSONVIEW);
                 try{
                	   List<String> equpList =  Arrays.asList(searchVO.getResEqupinfo().split("\\s*,\\s*"));
                	   EquipmentVO equip = new EquipmentVO();
                	   equip.setEqupList(equpList);
                	   model.addObject("resList", equipMapper.selectResEquipList(equip)) ;  
                	   model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS) ;
                	   
                 }catch(Exception e){
                	 LOGGER.error("resPreCheckString error:"+ e.toString());
   	  			      model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
   	  			      model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
                 }
                 return model;
                
        }
        @RequestMapping("reservationProcessChange.do")
        public ModelAndView updateResProcessChange(@ModelAttribute("loginVO") AdminLoginVO loginVO
									                , @RequestBody ResInfoVO searchVO
													, HttpServletRequest request
													, BindingResult bindingResult) throws Exception{
        	ModelAndView model = new ModelAndView(Globals.JSONVIEW);
        	try{
    			  
        		
        		  //테넌트 값 가지고 오기 
        		   
      			  int ret = resService.updateResManageChange(searchVO);
      			  //테넌트 처리 
      			  
      			  
      			  if (ret>0){
	      				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
	    				model.addObject(Globals.STATUS_MESSAGE, "정상적으로 처리 되었습니다.");
      			  }else{
      				throw new Exception();
      			  }
        	}catch(Exception e){
	  			  LOGGER.error("resPreCheckString error:"+ e.toString());
	  			  model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
	  			  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
        	}
        	return model;
        }
        @RequestMapping(value="reasonPop.do")		
		public ModelAndView resPopResCancelInfo(@ModelAttribute("loginVO") AdminLoginVO loginVO
				                                , @ModelAttribute("searchVO") ResInfoVO searchVO
												, HttpServletRequest request
												, BindingResult bindingResult) throws Exception{
			
		   String resSeq = request.getParameter("resSeq") != null ? request.getParameter("resSeq") : "";
		   searchVO.setResSeq(resSeq);
		   searchVO.setReservProcessGubun("PROCESS_GUBUN_5");
		   ModelAndView model = new ModelAndView("/backoffice/popup/reasonPop");
		   try{
			   model.addObject("selectCancel", cmmnDetailService.selectCmmnDetailCombo("CANCEL_CODE") );
			   model.addObject(Globals.STATUS,  Globals.STATUS_SUCCESS);
			   model.addObject(Globals.STATUS_REGINFO, searchVO);
		   }catch(Exception e){
	  		   model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
	  		   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		   }
		   return model;
		   
        }
        
        @RequestMapping(value="resSendMessage.do")
        public ModelAndView resSendMessage(@ModelAttribute("loginVO") AdminLoginVO loginVO
												                , @ModelAttribute("searchVO") ResInfoVO searchVO
																, HttpServletRequest request
																, BindingResult bindingResult) throws Exception{
        	
        	
        	ModelAndView model = new ModelAndView(Globals.JSONVIEW);
        	try{
        		
        		List<ResInfoVO> resInfo	 = resService.selectMessagentList();	
     		    for (int i =0; i < resInfo.size(); i ++){
     		       //해당 관련 메일 보내기
     		      /* // AtMessengerCommunicator amc = new AtMessengerCommunicator(propertiesService.getString("mgMessageIP"), propertiesService.getInt("mgMessagePort"));
     				
     				String fromUid = resInfo.get(i).getUserId();
     				String strMessage = "[회의 초대] " + resInfo.get(i).getResTitle() + " 회의 방번호:" + resInfo.get(i).getMeetingTel() +" 예약 일자:" + resInfo.get(i).getResStartday() + " 회의 시간:" + resInfo.get(i).getResStarttime() + "~" + resInfo.get(i).getResEndtime();
     				String[] messangetoUrlList = resInfo.get(i).getResAttendlist().split(",");
     				
     				for (int a = 0; a < messangetoUrlList.length; a++){
     					//메세지 보내기
     					amc.addMessage(fromUid, messangetoUrlList[a].toString(), strMessage, "", strMessage);
     				}
     				amc.send();     */		    	
     		    }
     		    
        		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
        	}catch(Exception e){
        		model.addObject(Globals.STATUS,  Globals.STATUS_FAIL);
 	  		    model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
        	}
        	
        	return model;
        }
		
		@RequestMapping(value="resInfo.do")		
		public ModelAndView resResInfoPop(@ModelAttribute("loginVO") AdminLoginVO loginVO
				                                , @ModelAttribute("searchVO") ResInfoVO searchVO
												, HttpServletRequest request
												, BindingResult bindingResult) throws Exception{
			
		   String resSeq = request.getParameter("resSeq") != null ? request.getParameter("resSeq") : "";
			
		   ModelAndView model = new ModelAndView("/backoffice/popup/resInfo");
		   
		   try{
			    searchVO.setResSeq(resSeq);
			    
			    Map<String, Object> resInfo = resService.selectResManageView(searchVO.getResSeq());
				model.addObject("resInfo", resInfo);
				//참석자
				
				
				LOGGER.debug("resInfo.getResAttendlist():" + resInfo.get("res_attendlist"));
				if (! util.NVL(resInfo.get("res_attendlist"), "").equals("")){
					List<String> empNoList =  util.dotToList(resInfo.get("res_attendlist").toString());
					LOGGER.debug("empNoList:" + empNoList.size());
					model.addObject("resUserList", empInfo.selectMeetinngUserList(empNoList));
				}
				//영상회의 이면 
				if (resInfo.get("RES_GUBUN").toString().equals("SWC_GUBUN_2") && !util.NVL(resInfo.get("meeting_seq"), "").equals("")){
					LOGGER.debug("resInfo.getMeetingSeq():" + resInfo.get("meeting_seq"));
					List<String> swSeqList =   util.dotToList(resInfo.get("meeting_seq").toString() );
					model.addObject("resRoomInfo", meetingService.selectConferenceList(swSeqList));
				}
		   }catch(Exception e){
			   LOGGER.error("resResInfoPop error:" + e.toString());
			   
		   }
		   return model;
          
		}
		@RequestMapping(value="resInfoAjax.do")		
		public ModelAndView resResInfoAjax(@ModelAttribute("loginVO") AdminLoginVO loginVO
							                                , @RequestParam("resSeq") String resSeq
															, HttpServletRequest request
															, BindingResult bindingResult) throws Exception{
			
		   
		   ModelAndView model = new ModelAndView(Globals.JSONVIEW );
		   
		   try{
			    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
				if(!isAuthenticated) {
				    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				    		model.addObject(Globals.STATUS,  Globals.STATUS_LOGINFAIL);
				    		return model;
				}
				
				LOGGER.debug("resSeq:" + resSeq + "=====================================================");
			    Map<String, Object> resInfo = resService.selectResManageView(resSeq);
				model.addObject("resInfo", resInfo);
				//참석자
				LOGGER.debug("resInfo.getResAttendlist():" + resInfo.get("res_attendlist"));
				if (! util.NVL(resInfo.get("res_attendlist"), "").equals("")){
					List<String> empNoList =  Arrays.asList(resInfo.get("res_attendlist").toString().split("\\s*,\\s*"));
					LOGGER.debug("empNoList:" + empNoList.size());
					model.addObject("resUserList", empInfo.selectMeetinngUserList(empNoList));
					
				}
				//영상회의 이면 
				if (resInfo.get("RES_GUBUN").toString().equals("SWC_GUBUN_2") && !util.NVL(resInfo.get("meeting_seq"), "").equals("")){
					LOGGER.debug("resInfo.getMeetingSeq():" + resInfo.get("meeting_seq"));
					List<String> swSeqList =   util.dotToList(resInfo.get("meeting_seq").toString() );
					model.addObject("resRoomInfo", meetingService.selectConferenceList(swSeqList));
				}
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		   }catch(Exception e){
			   LOGGER.error("resResInfoPop error:" + e.toString());
			   model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		   }
		   return model;
          
		}
		@RequestMapping(value="resEquChange.do")
		public ModelAndView resEquipChange(@ModelAttribute("loginVO") AdminLoginVO loginVO
															 , @RequestBody ResInfoVO searchVO
															 , HttpServletRequest request
															 , BindingResult bindingResult) throws Exception{
			
			   ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			   try{
				   int ret = resService.resEquipStateChange(searchVO);
				   
				   model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			   }catch (Exception e){
				   model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
			   }
		       return model;
		}
		
		//좌셕 현황 리스트
		@RequestMapping(value="seatStateInfo.do")		
		public ModelAndView resSeatStateInfo(@RequestBody Map<String, Object> params
												 , HttpServletRequest request
												 , BindingResult bindingResult) throws Exception{
		
		  ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		  
		  try{
			  //지도 이미지
			  //System.out.println("floorSeq" + params.get("floorSeq"));
			  
			  if (params.get("resStarttime") == null ) {
				  params.put("resStarttime", "0800");
			  }
			  if (params.get("resEndtime") == null ) {
				  params.put("resEndtime", "1730");
			  }
			  
			  if (params.get("floorSeq") != null ) {
				     //System.out.println("partSeq" + params.get("partSeq"));
			    	 Map<String, Object> mapInfo = params.get("partSeq") == null ? floorService.selectFloorInfoManageDetail(params.get("floorSeq").toString()) : partService.selectFloorPartInfoManageDetail(params.get("partSeq").toString());
			    	 model.addObject("seatMapInfo", mapInfo);
			  }
	  		  model.addObject(Globals.JSON_RETURN_RESULTLISR, timeService.selectSeatStateInfo(params));
	  		  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		  }catch(Exception e){
			  LOGGER.error("resSeatStateInfo error:"+ e.toString());
			  model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		  }
		  return model;
		}
		@RequestMapping(value="resList.do")		
		public ModelAndView resList(@ModelAttribute("loginVO") AdminLoginVO loginVO
											 , @ModelAttribute("searchVO") ResInfoVO searchVO
											 , HttpServletRequest request
											 , BindingResult bindingResult) throws Exception{
		
		  ModelAndView model = new ModelAndView("/backoffice/resManage/resList");
		  
		  try{
			  
			  Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			  
			  
			 
			  if(!isAuthenticated) {
				    HttpSession httpSession = request.getSession(true);
			    	loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
				   
				    //로그인 시 이상하게 풀룸 신규로 잡아 놓음 나중에 다시 수정 해야함 
				    if (!loginVO.getAuthorCode().equals("")) {
				    	Authentication authentication = new UsernamePasswordAuthenticationToken(loginVO.getAdminId(), "USER_PASSWORD");   
		            	SecurityContext securityContext = SecurityContextHolder.getContext();
		                securityContext.setAuthentication(authentication);
				    }else {
				    	model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			    		model.setViewName("/backoffice/login");
			    		return model;
				    }
			  }else{
			    	 HttpSession httpSession = request.getSession(true);
			    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
				     searchVO.setAuthorCode(loginVO.getAuthorCode());
			  }
			  model.addObject("searchCenterId", centerService.selectCenterInfoManageCombo());    
	  		  model.addObject("selectOrg", orgService.selectOrgInfoCombo());
	  		  model.addObject("selectResType", cmmnDetailService.selectCmmnDetailCombo("swc_gubun"));
	  		  
	  		  //신규 추가 
	  		  CmmnDetailCodeVO detailvo = new CmmnDetailCodeVO();
	  		  detailvo.setCodeId("PROCESS_GUBUN");
	  		  model.addObject("selectProcessType", cmmnDetailService.selectCmmnDetailResTypeCombo(detailvo));
	  		  detailvo.setSearchCodedc("3");
	  		  model.addObject("selectProcessTypeAdmin", cmmnDetailService.selectCmmnDetailResTypeCombo(detailvo));
	  		  model.addObject(Globals.STATUS_REGINFO, searchVO);
	  		  
		  }catch(Exception e){
			  LOGGER.error("resPreCheckString error:"+ e.toString());
			  model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		  }
		  return model;
		}
		@RequestMapping(value="resListAjax.do")
		public ModelAndView resListAjax (@ModelAttribute("loginVO") AdminLoginVO loginVO
				                        , @RequestBody Map<String, Object> searchVO
	                                    , HttpServletRequest request
	                                    , BindingResult bindingResult) throws Exception {
			
			ModelAndView model = new ModelAndView(Globals.JSONVIEW);
			
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			
			try{
				if(!isAuthenticated) {
			    	 model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			    	 model.setViewName("/backoffice/login");
			    	 return model;
				}else{
					 HttpSession httpSession = request.getSession(true);
				     loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
				     searchVO.put("authorCode", loginVO.getAuthorCode());
				     
				     PaginationInfo paginationInfo = new PaginationInfo();
					 paginationInfo.setCurrentPageNo( Integer.valueOf( util.NVL(searchVO.get("pageIndx"), "1")));
					 paginationInfo.setRecordCountPerPage(Integer.valueOf( util.NVL(searchVO.get("pageUnit"), propertiesService.getInt("pageUnit"))));
					 paginationInfo.setPageSize(Integer.valueOf( util.NVL(searchVO.get("pageSize"), propertiesService.getInt("pageSize"))));
					 
					 searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
					 searchVO.put("lastIndex", paginationInfo.getLastRecordIndex());
					 searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
					
					 
			         String date1 = util.NVL(searchVO.get("searchStartDay"),  com.sohoki.backoffice.util.SmartUtil.reqDay(-7)) ;
			         String date2 =  util.NVL(searchVO.get("searchEndDay"),  com.sohoki.backoffice.util.SmartUtil.reqDay(0)) ;
			         searchVO.put("searchStartDay", date1);
			         searchVO.put("searchEndDay", date2);
			         searchVO.put("SearchEmpno", loginVO.getAdminId());
			          
			  		 List<Map<String, Object>> reslist = resService.selectResManageListByPagination(searchVO);
			  		 int totCnt = reslist.size() > 0 ?  Integer.valueOf(reslist.get(0).get("total_record_count").toString()) : 0;
				     model.addObject(Globals.JSON_RETURN_RESULTLISR,  reslist );
				     model.addObject(Globals.STATUS_REGINFO, searchVO);
				     
				     
				     paginationInfo.setTotalRecordCount(totCnt);
				     model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
				     model.addObject(Globals.PAGE_TOTALCNT, totCnt);
				     model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				     
				}
			}catch(Exception e){
				 StackTraceElement[] ste = e.getStackTrace();
			      
		         int lineNumber = ste[0].getLineNumber();
				 LOGGER.error("resPreCheckString error:"+ e.toString() + ":" + lineNumber);
				 
				 model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				 model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
			}
			return model;
		}
		
}
