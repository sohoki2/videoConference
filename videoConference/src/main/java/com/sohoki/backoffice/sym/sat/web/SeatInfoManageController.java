package com.sohoki.backoffice.sym.sat.web;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.service.OrgInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;
import com.sohoki.backoffice.sts.msg.service.MessageInfoManageService;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.sat.vo.SeatInfo;
import com.sohoki.backoffice.sym.sat.service.SeatInfoManageService;
import com.sohoki.backoffice.sym.sat.vo.SeatInfoVO;
import com.sohoki.backoffice.util.service.fileService;

import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;




@RestController
@RequestMapping("/backoffice/basicManage")
public class SeatInfoManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SeatInfoManageController.class);
	
	 @Autowired
	private SeatInfoManageService seatService;
	
	@Autowired
	private OrgInfoManageService orgService;
	
	@Autowired
	private CenterInfoManageService centerService;
	
	@Autowired
	private EmpInfoManageService empService;
	
	@Autowired
	private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	 
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;

	@Autowired
	private MessageInfoManageService msgService;
	
	//파일 업로드
	@Autowired
	private fileService uploadFile;
	
	//xss 변조 설정 
	EgovStringUtil util = new EgovStringUtil();
	
	@RequestMapping(value="seatCombo.do")
	public ModelAndView selectSeatCombo(@ModelAttribute("loginVO") AdminLoginVO loginVO
										, @RequestBody SeatInfoVO searchVO
										, HttpServletRequest request
										, BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
	    	    model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
	    	    model.addObject(Globals.STATUS,  Globals.STATUS_LOGINFAIL);
	    		return model;
		    }
		    model.addObject("seatInfo",seatService.selectSeatEmptyManageList(searchVO) );
		    //센터 리스트 보여주기 
		    model.addObject(Globals.STATUS,  Globals.STATUS_SUCCESS);
		}catch(Exception e){
			LOGGER.debug("selectSeatCombo error:" + e.toString());
			model.addObject(Globals.STATUS,  Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}
		return model;
	}
	
	@RequestMapping(value="seatSync.do")	
	public ModelAndView seatSyncState 	(@ModelAttribute("loginVO") AdminLoginVO loginVO
														, HttpServletRequest request
														, BindingResult bindingResult	) throws Exception {
		     ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		     try{
		    	   //넘어 오는지 확인 
		    	   Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			 	   if(!isAuthenticated) {
			 	    		model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			 	    		model.setViewName("/backoffice/login");
			 	    		return model;
			 	   }
			 	   int ret = seatService.updateSeatSycn();
			 	   model.addObject(Globals.STATUS,   Globals.STATUS_SUCCESS);
		     }catch(Exception e){
		    	   LOGGER.error("seatSyncState ERROR:" + e.toString());
				   model.addObject(Globals.STATUS,  Globals.STATUS_FAIL);
				   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		     }
		     return model;
		
	}
	
	
	@RequestMapping(value="seatList.do")
	public ModelAndView  selectSeatInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
														, @ModelAttribute("searchVO") SeatInfoVO searchVO
														, HttpServletRequest request
														, BindingResult bindingResult	) throws Exception {
		
		ModelAndView model = new ModelAndView("/backoffice/basicManage/seatList");
		try{
			
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
	    	    model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
	    	    model.setViewName("/backoffice/login");
	    		return model;
		    }
		    
			model.addObject("selectCenter", centerService.selectCenterInfoManageCombo());
			model.addObject("selectSeat", cmmnDetailService.selectCmmnDetailCombo("SWC_GUBUN"));
			model.addObject("selectCodeDM", cmmnDetailService.selectCmmnDetailCombo("CENTER_PARTGUBUN"));
		
			if( searchVO.getPageUnit() > 0  ){    	   
		    	   searchVO.setPageUnit(searchVO.getPageUnit());
			}else {
					   searchVO.setPageUnit(propertiesService.getInt("pageUnit"));   
			}
			searchVO.setPageSize(propertiesService.getInt("pageSize"));
		       
		       
		       /** pageing */       
		    PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());
	
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			//수정
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	        List<SeatInfoVO> list = seatService.selectSeatManageListByPagination(searchVO);
	        
		    model.addObject("resultList",  list);
		    model.addObject("regist", searchVO);
		    int totCnt = list.size() > 0 ? list.get(0).getTotalRecordCount() : 0;       
			paginationInfo.setTotalRecordCount(totCnt);
		    model.addObject("paginationInfo", paginationInfo);
		    model.addObject("totalCnt", totCnt);
		    
		    
		
		}catch (Exception e){
		   LOGGER.error("selectSeatInfoManageListByPagination error:" + e.toString());
		   model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.select"));
		   model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
			
		return model;	
	}
	@RequestMapping (value="seatDetail.do")
	public ModelAndView selecSeatInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
		                                            , @ModelAttribute("SeatInfoVO")  SeatInfoVO vo
		                                            , HttpServletRequest request
		                            				, BindingResult bindingResult) throws Exception{	
		
		ModelAndView model = new ModelAndView("/backoffice/basicManage/seatDetail");
		
		try{
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		    if(!isAuthenticated) {
	    	    model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
	    	    model.setViewName("/backoffice/login");
	    		return model;
		    }
		    
			
			//센터 
			model.addObject("selectCenter", centerService.selectCenterInfoManageCombo());
			//기초코드 
			model.addObject("selectPartGubun", cmmnDetailService.selectCmmnDetailCombo("CENTER_PARTGUBUN"));
			model.addObject("selectSwcGubun", cmmnDetailService.selectCmmnDetailCombo("SWC_GUBUN"));
			
			
			model.addObject("selectMail", msgService.selectMsgCombo("MSG_TYPE_1"));
			model.addObject("selectSms", msgService.selectMsgCombo("MSG_TYPE_2"));
			
			if (!vo.getMode().equals("Ins")){		
				SeatInfo info = seatService.selectSeatManageView(vo.getSwcSeq());
				model.addObject("registinfo", info);	   
		     	vo.setCenterId(info.getCenterId());
		     	vo.setRoomType(info.getRoomType());
		     	vo.setResMessageMail(info.getResMessageMail());
		     	vo.setResMessageSms(info.getResMessageSms());
		     	vo.setCanMessageMail(info.getCanMessageMail());
		     	vo.setCanMessageSms(info.getCanMessageSms());
			}
			model.addObject("regist", vo);
		}catch(Exception e){
			LOGGER.error("selectSeatInfoManageListByPagination error:" + e.toString());
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.select"));
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
		return model;
		
	}
	@RequestMapping (value="seatInfo.do")
	public ModelAndView selelctSeatInfo(@ModelAttribute("loginVO") AdminLoginVO loginVO
									            , @ModelAttribute("SeatInfoVO")  SeatInfoVO vo
									            , HttpServletRequest request
									  		     , BindingResult bindingResult) throws Exception{	
	
	    ModelAndView model = new ModelAndView(Globals.JSONVIEW);
	
		try{
		    LOGGER.debug("swcSeq:" + vo.getSwcSeq());
		
			model.addObject("regist", vo);
			model.addObject("regist", seatService.selectSeatManageView(vo.getSwcSeq()));
		}catch(Exception e){
			LOGGER.error("selectSeatInfoManageListByPagination error:" + e.toString());
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.select"));
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
	    return model;
	}
	
	//여기 부분 수정 하기 
	@RequestMapping (value="seatAdminUpdate.do")	
	public ModelAndView updateSeatAdminManage(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                                            , @RequestBody SeatInfoVO vo
																        , HttpServletRequest request
																  	    , BindingResult bindingResult) throws Exception{		
	
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try{
			int ret = seatService.updateSeatAdminManage(vo);
			if (ret >0){
				  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	  
			}else {
				 model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			}
		}catch(Exception e){
			LOGGER.error("deleteSeatInfoManage error:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
		return model;		
	}
	@RequestMapping (value="seatUpdate.do")
	@SuppressWarnings("finally")
	public ModelAndView updateSeatInfoManage(HttpServletRequest request, MultipartRequest mRequest
						                                , @ModelAttribute("loginVO") AdminLoginVO loginVO
													    , @ModelAttribute("seatInfoVO")  SeatInfoVO seatInfoVO                     				 
													    , BindingResult result) throws Exception{
		
		
		
		
		ModelAndView model = new ModelAndView();
		String url = "redirect:/backoffice/basicManage/seatList.do?pageIndex="+seatInfoVO.getPageIndex()+"&searchCenterId="+seatInfoVO.getSearchCenterId()+"&searchCondition="+seatInfoVO.getSearchCondition()+"&searchKeyword="+seatInfoVO.getSearchKeyword();
		String meesage = "";
		
		model.addObject(Globals.STATUS_REGINFO, seatInfoVO);
		try{
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.setViewName("/backoffice/login");
		    		return model;
		    }else {
		    	 HttpSession httpSession = request.getSession(true);
		    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
		    	 seatInfoVO.setUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
		    }
			String maxCnt = seatInfoVO.getMaxCnt().equals("") ? "0" : seatInfoVO.getMaxCnt();
			seatInfoVO.setMaxCnt(maxCnt);
			meesage =  seatInfoVO.getMode().equals("Ins") ?  "sucess.common.insert" : "sucess.common.update";
			//이미지 업로드 
			seatInfoVO.setSeatImg1( uploadFile.uploadFileNm(mRequest.getFiles("seatImg1"), propertiesService.getString("Globals.filePath")));
			seatInfoVO.setSeatImg2( uploadFile.uploadFileNm(mRequest.getFiles("seatImg2"), propertiesService.getString("Globals.filePath")));
			
			int ret = seatService.updateSeatManage(seatInfoVO);
			if (ret >0){
				model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
			}else {
				throw new Exception();
			}
		}catch (Exception e){
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE , egovMessageSource.getMessage("fail.common.update"));	
		}
		model.setViewName(url);
		return model;	
	}
	@RequestMapping (value="seatView.do")
	public ModelAndView selecSeatInfoManageView(@ModelAttribute("loginVO") AdminLoginVO loginVO
	                                      , @ModelAttribute("SeatInfoVO")  SeatInfoVO vo
	                                      , HttpServletRequest request
	                            		  , BindingResult bindingResult) throws Exception{	
		
		ModelAndView model = new ModelAndView("/backoffice/basicManage/seatView");
		
		try{
			  model.addObject("regist", vo);
			  vo = seatService.selectSeatManageView(vo.getSwcSeq());
		      model.addObject("registinfo", vo);
		      
		      if (!vo.getSeatAdminid().equals("")){
					List<String> empNoList =  Arrays.asList(vo.getSeatAdminid().split("\\s*,\\s*"));
					model.addObject("resUserList", empService.selectMeetinngUserList(empNoList));
			  }
		}catch(Exception e){
			LOGGER.error("selectSeatInfoManageListByPagination error:" + e.toString());
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.select"));
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}
					
		
		return model;
	}
	@RequestMapping (value="seatDelete.do", method = {RequestMethod.POST})
	public ModelAndView deleteSeatInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
																   @RequestParam Map<String, String> params,
																   HttpServletRequest request) throws Exception {

        ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		String swcSeq = params.get("swcSeq");
		
		try{
		      int ret = 	seatService.deleteSeatManage(swcSeq);		      
		      if (ret > 0 ) {		    	  
		    	  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);	  
		      }else {
		    	  throw new Exception();		    	  
		      }
		}catch (Exception e){
			LOGGER.error("deleteSeatInfoManage error:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
		}		
		return model;
	}
	
	
	
	@RequestMapping (value="selectCode.do")
	public ModelAndView selectRoomInfoCode (HttpServletRequest request) throws Exception {
		String roomType = request.getParameter("roomType") != null ? request.getParameter("roomType") : "";
		String centerId = request.getParameter("centerId") != null ? request.getParameter("centerId") : "";
		SeatInfoVO searchVo = new SeatInfoVO();
		
		searchVo.setRoomType(roomType);
		searchVo.setCenterId(centerId);
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
        return model.addObject("roomList", seatService.selectRoomId(searchVo));
	}
	
	@RequestMapping (value="selectSeatCode.do")
	public ModelAndView selectSeatInfoCode (HttpServletRequest request) throws Exception {
		SeatInfoVO searchVo = new SeatInfoVO();
		
		searchVo.setCenterId(request.getParameter("centerId") != null ? request.getParameter("centerId") : "");
		searchVo.setRoomType(request.getParameter("roomType") != null ? request.getParameter("roomType") : "");
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
        return model.addObject("areaList", seatService.selectRoomSeat(searchVo));
	}
	
	
}
