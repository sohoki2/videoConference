package com.sohoki.backoffice.sym.cnt.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.service.Globals;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfo;
import com.sohoki.backoffice.sym.cnt.vo.CenterInfoVO;
import com.sohoki.backoffice.sym.cnt.vo.FloorInfo;
import com.sohoki.backoffice.sym.cnt.vo.FloorPartInfo;
import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import com.sohoki.backoffice.sym.cnt.service.CenterInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorInfoManageService;
import com.sohoki.backoffice.sym.cnt.service.FloorPartInfoManageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.UniSelectInfoManageService;
import com.sohoki.backoffice.util.service.fileService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



@RestController
@RequestMapping("/backoffice/basicManage")
public class CenterInfoManageController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CenterInfoManageController.class);
	
	//파일 업로드
    @Autowired
	private fileService uploadFile;
    
	
	@Autowired
	private CenterInfoManageService centerInfoManageService;
	
	@Autowired
	protected EgovMessageSource egovMessageSource;
	
	@Autowired
    protected EgovPropertyService propertiesService;

	@Autowired
	private SmartUtil util;
	
	@Autowired
	private UniSelectInfoManageService  uniService;
	
	@Autowired
	private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	
	@Autowired
	private FloorInfoManageService floorService;
	
	@Autowired
	private FloorPartInfoManageService partService;

	
	@RequestMapping(value="centerList.do")
	public ModelAndView  selectCenterInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @ModelAttribute("searchVO") CenterInfoVO searchVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		
		
		
		ModelAndView model = new ModelAndView(); 
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			model.setViewName("/backoffice/login");
			return model;	
		}else {
	       HttpSession httpSession = request.getSession(true);
	       loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
		}
		model.addObject(Globals.STATUS_REGINFO , searchVO);
		model.addObject("floorInfo", cmmnDetailService.selectCmmnDetailCombo("CNETER_FLOOR"));
	    model.setViewName("/backoffice/basicManage/centerList");
		return model;	
	}
	@RequestMapping(value="centerListAjax.do")
	public ModelAndView  selectCenterAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @RequestBody Map<String,Object>  searchVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		try {
			
			  int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
			  
			  searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			  
			  LOGGER.info("pageUnit:" + pageUnit);
			  
		       /** pageing */       
		   	  PaginationInfo paginationInfo = new PaginationInfo();
			  paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex").toString(), "1") ) );
			  paginationInfo.setRecordCountPerPage(pageUnit);
			  paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

			  searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
			  searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
			  searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			  
			  
			  
			  List<Map<String, Object>> list = centerInfoManageService.selectCenterInfoManageListByPagination(searchVO);
		      model.addObject(Globals.JSON_RETURN_RESULTLISR,  list );
		      model.addObject(Globals.STATUS_REGINFO, searchVO);
		      int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) :0;
		      
		      paginationInfo.setTotalRecordCount(totCnt);
		      model.addObject("paginationInfo", paginationInfo);
		      model.addObject("totalCnt", totCnt);
		      
	
			  
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));	
		}
		return model;
	}
	//센터 정보 상세
	@RequestMapping (value="centerDetail.do")
	public ModelAndView selectCenterInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
							                                               , @RequestBody  CenterInfo vo
							                                               , HttpServletRequest request
							                                			   , BindingResult bindingResult) throws Exception{	
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
				return model;	
	    }	
		model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		model.addObject(Globals.STATUS_REGINFO, centerInfoManageService.selectCenterInfoManageDetail(vo.getCenterId()));	     	
		return model;
	}
	@RequestMapping (value="centerView.do")
	public ModelAndView selectCenterViewInfo  (@ModelAttribute("loginVO") AdminLoginVO loginVO
									           , @ModelAttribute("searchVO") CenterInfo searchVO
									           , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView("/backoffice/basicManage/centerView");
		try {
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					return model;	
		    }	
			// 센터 값이 안들오 오면 에러 보내기
			Map<String, Object> search = new HashMap<String,Object>();
			search.put("centerId", searchVO.getCenterId());
			search.put("firstIndex", "0");
			search.put("recordCountPerPage", "100");
			List<Map<String, Object>> floorList = floorService.selectFloorInfoManageListByPagination(search);
			int totCnt = floorList.size() > 0 ?  Integer.valueOf( floorList.get(0).get("total_record_count").toString()) :0;
			
			model.addObject(Globals.JSON_RETURN_RESULTLISR, floorList);
			model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			Map<String, Object> centerInfo = centerInfoManageService.selectCenterInfoManageDetail(searchVO.getCenterId());
			model.addObject(Globals.STATUS_REGINFO, centerInfo);
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("code", "CNETER_FLOOR");
			params.put("startCode", centerInfo.get("start_floor"));
			params.put("endCode", centerInfo.get("end_floor"));
			model.addObject("floorlistInfo", cmmnDetailService.selectCmmnDetailComboEtc(params));
			model.addObject("floorPart", cmmnDetailService.selectCmmnDetailCombo("FLOOR_PART"));
			model.addObject("floorListSeq", floorService.selectFloorInfoManageCombo(searchVO.getCenterId()));
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			//층수 리스트 
			
		}catch(Exception e) {
			LOGGER.error("selectCenterViewInfo:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg")); 
		}
		return model;
	}
	@NoLogging
	@RequestMapping (value="centerUpdate.do")
	public ModelAndView updateCenterInfoManage(HttpServletRequest request
			                                   , MultipartRequest mRequest
											   , @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
											   , @ModelAttribute("CenterInfo") CenterInfo vo
											   , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
		}else {
	    	 HttpSession httpSession = request.getSession(true);
	    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
	    	 vo.setCenterUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
	    }
		
		try{
			
			model.addObject(Globals.STATUS_REGINFO , vo);
			String meesage = "";
			vo.setCenterZipCode("");     	  
			
	    	vo.setCenterImg( uploadFile.uploadFileNm(mRequest.getFiles("centerImg"), propertiesService.getString("Globals.filePath")));
			vo.setCenterSeatImg( uploadFile.uploadFileNm(mRequest.getFiles("centerSeatImg"), propertiesService.getString("Globals.filePath")));
			meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update" ;
			int ret = centerInfoManageService.updateCenterInfoManage(vo);
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
						
			}else {
				throw new Exception();
			}
			
		}catch (Exception e){
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
	}
	@RequestMapping (value="centerDelete.do")
	public ModelAndView deleteCenterInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
			                                   @RequestParam("centerId") String centerId)throws Exception{
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }	
		try{
			  // 이미지 삭제 먼저 하기 
			
		      int ret = 	uniService.deleteUniStatement("CENTER_IMG,CENTER_SEAT_IMG", "tb_centerinfo", "CENTER_ID=["+centerId+"[");		      
		      if (ret > 0 ) {		
		    	  //층 삭제
		    	  uniService.deleteUniStatement("FLOOR_MAP, FLOOR_MAP1", "tb_floorinfo", "CENTER_ID=["+centerId+"[");
		    	  //구역 삭제 
		    	  uniService.deleteUniStatement("PART_MAP1, PART_MAP2", "tb_floorpart", "CENTER_ID=["+centerId+"[");
		    	  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    	  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.delete") );		    	 
		      }else {
		    	  throw new Exception();		    	  
		      }
		}catch (Exception e){
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));			
		}		
		return model;
	}
	/*
	 *  지점 층수 리스트 
	 * 
	 */
	@RequestMapping (value="floorListAjax.do")
	public ModelAndView selectFloorListAjaxInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
			                                          , @RequestBody Map<String,Object>  searchVO
			                                          , HttpServletRequest request
			                                          , BindingResult result) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		try {
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			if(!isAuthenticated) {
					model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
					model.addObject(Globals.STATUS, Globals.STATUS_LOGINFAIL);
					return model;	
		    }	
			// 센터 값이 안들오 오면 에러 보내기
			searchVO.put("firstIndex", "0");
			searchVO.put("recordCountPerPage", "100");
			List<Map<String, Object>> floorList = floorService.selectFloorInfoManageListByPagination(searchVO);
			int totCnt = floorList.size() > 0 ?  Integer.valueOf( floorList.get(0).get("total_record_count").toString()) :0;
			model.addObject(Globals.JSON_RETURN_RESULTLISR, floorList);
			model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			LOGGER.debug("---------------------------------------------------" + totCnt);
		}catch(Exception e) {
			LOGGER.error("selectCenterViewInfo:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg")); 
		}
		return model;
	}

		   
	@RequestMapping (value="floorDetail.do")
	public ModelAndView selectFloorInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
									           , @RequestParam("floorSeq") String floorSeq	) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }
	    try {
	    	model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
			model.addObject(Globals.STATUS_REGINFO, floorService.selectFloorInfoManageDetail(floorSeq));
	    }catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
	    }
	    return model;
	}
	@NoLogging
	@RequestMapping (value="floorUpdate.do")
	public ModelAndView updateFloorInfoManage(HttpServletRequest request
			                                   , MultipartRequest mRequest
											   , @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
											   , @ModelAttribute("FloorInfo") FloorInfo vo
											   , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
		}else {
	    	 HttpSession httpSession = request.getSession(true);
	    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
	    	 vo.setUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
	    }
		
		try{
			
			model.addObject(Globals.STATUS_REGINFO , vo);
			String meesage = "";
			
	    	vo.setFloorMap( uploadFile.uploadFileNm(mRequest.getFiles("floorMap"), propertiesService.getString("Globals.filePath")));
			vo.setFloorMap1( uploadFile.uploadFileNm(mRequest.getFiles("floorMap1"), propertiesService.getString("Globals.filePath")));
			meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update" ;
			
			int ckCnt =  uniService.selectIdDoubleCheck("FLOOR_INFO", "tb_floorinfo", "CENTER_ID = ["+vo.getCenterId() +"[ and FLOOR_INFO = ["+vo.getFloorInfo() +"[");
			//중복 층수 체크 
			if (ckCnt>0  && !vo.getNowVal().equals(vo.getNewVal()) ) {
				model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.floor.unicheck"));
				return model;
			}
				  
					
			int ret = floorService.updateFloorInfoManage(vo);
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
			}else {
				throw new Exception();
			}
			
		}catch (Exception e){
			LOGGER.error("floorUpdate error:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
	}
	@RequestMapping (value="floorDelete.do")
	public ModelAndView deleteFloorInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO
			                                  , @RequestParam("floorSeq") String floorSeq)throws Exception{
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }	
		try{
			// 층수 먼저 정리 하기  
			Map<String, Object> vo = floorService.selectFloorInfoManageDetail(floorSeq);
			centerInfoManageService.updateCenterFloorInfoManage(util.checkItemList(util.dotToList(vo.get("floor_info_cnt").toString()), vo.get("code_dc").toString() , "")  , vo.get("center_id").toString());
			// 이미지 삭제
			int ret = 	uniService.deleteUniStatement("FLOOR_MAP, FLOOR_MAP1", "tb_floorinfo", "FLOOR_SEQ="+floorSeq+"");		      
		    if (ret > 0 ) {		
		    	  //구역 삭제 
		    	  uniService.deleteUniStatement("PART_MAP1, PART_MAP2", "tb_floorpart", "FLOOR_SEQ="+floorSeq+"");
		    	  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    	  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.delete") );		    	 
		    }else {
		      throw new Exception();		    	  
		    }
		}catch (Exception e){
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));			
		}		
		return model;
	}
	@RequestMapping (value="partDetail.do")
	public ModelAndView selectPartDetailInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
	                                               , @RequestParam("partSeq") String partSeq) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
			model.setViewName("/backoffice/login");
			return model;	
		}
		try {
			model.addObject(Globals.STATUS_REGINFO, partService.selectFloorPartInfoManageDetail(partSeq));
			//Detail 값 가지고 오기 
			model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));
		}
		return model;
	}
	//구역 리스트 보여 주기 
	@RequestMapping(value="partListAjax.do")
	public ModelAndView  selectPartAjaxInfoManageListByPagination(@ModelAttribute("loginVO") AdminLoginVO loginVO
															, @RequestBody Map<String,Object>  searchVO
															, HttpServletRequest request
															, BindingResult bindingResult	) throws Exception {
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
		try {
			
			
			searchVO.put("firstIndex", "0");
			searchVO.put("recordCountPerPage", "100");
			List<Map<String, Object>> partList = partService.selectFloorPartInfoManageListByPagination(searchVO);
			int totCnt = partList.size() > 0 ?  Integer.valueOf( partList.get(0).get("total_record_count").toString()) :0;
			model.addObject(Globals.JSON_RETURN_RESULTLISR, partList);
		    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
		    model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		}catch(Exception e) {
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));	
		}
		return model;
	}
	@NoLogging
	@RequestMapping (value="partUpdate.do")
	public ModelAndView updatePartInfoManage(HttpServletRequest request
			                                   , MultipartRequest mRequest
											   , @ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
											   , @ModelAttribute("FloorPartInfo") FloorPartInfo vo
											   , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
		}else {
	    	 HttpSession httpSession = request.getSession(true);
	    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
	    	 vo.setUserId(EgovUserDetailsHelper.getAuthenticatedUser().toString());
	    }
		
		try{
			
			model.addObject(Globals.STATUS_REGINFO , vo);
			String meesage = "";
			
	    	vo.setPartMap1(uploadFile.uploadFileNm(mRequest.getFiles("partMap1"), propertiesService.getString("Globals.filePath")));
			vo.setPartMap2( uploadFile.uploadFileNm(mRequest.getFiles("partMap2"), propertiesService.getString("Globals.filePath")));
			meesage = vo.getMode().equals("Ins") ? "sucess.common.insert" : "sucess.common.update" ;
					
			int ret = partService.updateFloorPartInfoManage(vo);
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage(meesage));
			}else {
				throw new Exception();
			}
			
		}catch (Exception e){
			LOGGER.error("floorUpdate error:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
	}
	
	@RequestMapping (value="partDelete.do")
	public ModelAndView deletePartInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO,
			                                   @RequestParam("partSeq") String partSeq)throws Exception{
		
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW); 
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	    if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
				return model;	
	    }	
		try{
			// 이미지 삭제
			int ret = 	uniService.deleteUniStatement("PART_MAP1, PART_MAP2", "tb_floorpart", "PART_SEQ="+partSeq+"");		      
		    if (ret > 0 ) {		
		    	  //구역 삭제 
		    	  model.addObject(Globals.STATUS, Globals.STATUS_SUCCESS);
		    	  model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("success.common.delete") );		    	 
		    }else {
		      throw new Exception();		    	  
		    }
		}catch (Exception e){
			LOGGER.info(e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.delete"));			
		}		
		return model;
	}
	//좌석 일괄 등록
	@NoLogging
	@RequestMapping (value="floorSeatUpdate.do")
	public ModelAndView updateFloorSeatUpdateInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
													   , @RequestBody Map<String,Object>  params
													   , HttpServletRequest request
													   , BindingResult result) throws Exception{
		
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.login"));
				model.setViewName("/backoffice/login");
		}else {
	    	 HttpSession httpSession = request.getSession(true);
	    	 loginVO = (AdminLoginVO)httpSession.getAttribute("AdminLoginVO");
	    	 params.put("userId", EgovUserDetailsHelper.getAuthenticatedUser().toString());
	    }
		try{
			LOGGER.debug("params:" + params.toString());
			int ret = floorService.insertFloorSeatUpdate(params);
			if (ret >0){
				model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
				model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("sucess.common.insert"));
			}else {
				throw new Exception();
			}
			
		}catch (Exception e){
			LOGGER.error("floorUpdate error:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.insert"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
	}
	@RequestMapping (value="seatCount.do")
	public ModelAndView selectSeatCountInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
													   , @RequestBody Map<String,Object>  params
													   , HttpServletRequest request
													   , BindingResult result) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
		try{
			String is_condition = params.get("partSeq") != "" ? "FLOOR_SEQ = " + params.get("floorSeq") + " AND PART_SEQ = " + params.get("partSeq") + "" : "FLOOR_SEQ = " + params.get("floorSeq")+ "";
			String is_Field = "";
			String is_Table = "";
			LOGGER.debug("type:" + params.get("type").toString());
			switch (params.get("type").toString()) {
				case "S":
					is_Field = "SEAT_ID";
					is_Table = "tb_seatinfo";
					break;
				case "M" :
					is_Field = "MEETING_ID";
					is_Table = "tb_meeting_room"; 
					break;
				case "D":
					is_Field = "MEETING_ID";
					is_Table = "tb_meeting_room"; 
					break;
				default :
					is_Field = "SEAT_ID";
					is_Table = "tb_seatinfo";
			}
			LOGGER.debug("type:" + is_Field + ":" + is_Table);
			
			
			int ret = uniService.selectIdDoubleCheck(is_Field, is_Table, is_condition);
			
			model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULT, ret);
			
		}catch (Exception e){
			LOGGER.error("floorUpdate error:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
		
	}
	/*
	 *  지점 층 조회
	 *  
	 */
	@RequestMapping (value="floorComboInfo.do")
	public ModelAndView selectFloorComboInfoManage(@ModelAttribute("AdminLoginVO") AdminLoginVO loginVO
												   , @RequestParam("centerId") String centerId
												   , HttpServletRequest request
												   , BindingResult result) throws Exception{
		ModelAndView model = new ModelAndView(Globals.JSONVIEW);
		
		try{
			model.addObject(Globals.STATUS  , Globals.STATUS_SUCCESS);
			model.addObject(Globals.JSON_RETURN_RESULTLISR, floorService.selectFloorInfoManageCombo(centerId));
		}catch (Exception e){
			LOGGER.error("floorUpdate error:" + e.toString());
			model.addObject(Globals.STATUS, Globals.STATUS_FAIL);
			model.addObject(Globals.STATUS_MESSAGE, egovMessageSource.getMessage("fail.common.msg"));	
		}	
		LOGGER.debug("model:" + model.toString());
		return model;
		
	}
	
}
