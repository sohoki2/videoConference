package com.sohoki.smartoffice.front.sts.brd.web;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.AdminLoginVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;

import com.sohoki.backoffice.sts.brd.service.BoardInfoManageService;
import com.sohoki.backoffice.sts.brd.vo.BoardInfo;
import com.sohoki.backoffice.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.uat.uia.service.AdminInfoManageService;
import com.sohoki.backoffice.util.SmartUtil;
import com.sohoki.backoffice.util.service.fileService;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.sohoki.backoffice.cus.org.vo.EmpInfo;
import com.sohoki.backoffice.cus.org.service.EmpInfoManageService;
import com.sohoki.backoffice.cus.org.vo.EmpInfoVO;

@RestController
@RequestMapping("/front")
public class FrontInfoManageController {

	    private static final Logger LOGGER = LoggerFactory.getLogger(FrontInfoManageController.class);
	
		//파일 업로드
	    @Autowired
	    private fileService uploadFile;
		
		
		@Autowired
	    protected EgovCcmCmmnDetailCodeManageService detailService;
		
		@Autowired
	    protected BoardInfoManageService boardInfoService;
		
		@Autowired
		protected EgovMessageSource egovMessageSource;
		
		@Autowired
	    protected EgovPropertyService propertiesService;
	
		@Autowired
		private EgovCcmCmmnDetailCodeManageService cmmnDetailService;
	
		@Autowired
		private EmpInfoManageService empInfo;
		
		@Autowired
		private SmartUtil util;
		
		//사용자 페이지 
		@RequestMapping(value="board/boardList.do")
		public ModelAndView  selectFrntBoardInfoManageListByPagination(@ModelAttribute("loginVO") LoginVO loginVO
				                                                 , @ModelAttribute("searchVO") Map<String, Object> searchVO
																 , HttpServletRequest request
																 , BindingResult bindingResult	) throws Exception {
			ModelAndView model = new ModelAndView("/front/board/boardList");
			try{
				EmpInfoVO user = new EmpInfoVO();
				user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
				if (user ==  null){
					LOGGER.debug("로그인 기록 없음");		    	
					model.setViewName("/front/noInfo");
					return model;
				}
				
				int pageUnit = searchVO.get("pageUnit") == null ?   propertiesService.getInt("pageUnit") : Integer.valueOf((String) searchVO.get("pageUnit"));
				  
			    searchVO.put("pageSize", propertiesService.getInt("pageSize"));
			    LOGGER.info("pageUnit:" + pageUnit);
			  
		              
		   	    PaginationInfo paginationInfo = new PaginationInfo();
			    paginationInfo.setCurrentPageNo( Integer.parseInt( util.NVL(searchVO.get("pageIndex"), "1") ) );
			    paginationInfo.setRecordCountPerPage(pageUnit);
			    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));
			    searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
			    searchVO.put("lastRecordIndex", paginationInfo.getLastRecordIndex());
			    searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
			    searchVO.put("boardGubun","NOT");
			  
			    //공지사항의 경우, 공지기한이 지난 게시물은 board_notice_useyn을 N으로 변경
			    boardInfoService.updateBoardNoticeUseYn();
			  
			    List<Map<String, Object>> list =  boardInfoService.selectBoardManageListByPagination(searchVO) ;
			    int totCnt = list.size() > 0 ?  Integer.valueOf( list.get(0).get("total_record_count").toString()) : 0;
				   
			    model.addObject(Globals.JSON_RETURN_RESULTLISR,   list );
			    model.addObject(Globals.STATUS_REGINFO, searchVO);
			    paginationInfo.setTotalRecordCount(totCnt);
			    model.addObject(Globals.JSON_PAGEINFO, paginationInfo);
			    model.addObject(Globals.PAGE_TOTALCNT, totCnt);
			}catch (Exception e){
				model.addObject("status", Globals.STATUS_FAIL);
				model.addObject("message", egovMessageSource.getMessage("fail.common.list"));
				LOGGER.info(e.toString());
			}			   
			return model;	
		}
		
		//게시판 수정
		@RequestMapping (value="board/boardDetail.do")
		public ModelAndView selectBoardInfoManageDetail(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO
                                                   , @ModelAttribute("vo")  BoardInfo vo
                                                   , HttpServletRequest request
                                    			   , BindingResult bindingResult) throws Exception{	
			
			ModelAndView model = new ModelAndView("/front/board/boardDetail");
			
			try{
				EmpInfoVO user = new EmpInfoVO();
				user = (EmpInfoVO) request.getSession().getAttribute("empInfoVO");
				if (user ==  null){
					LOGGER.debug("로그인 기록 없음");		    	
					model.setViewName("/front/noInfo");
					return model;
				}
			    
		    	vo.setBoardRegId(user.getEmpno());
		    	vo.setUserNm(user.getEmpno());
		    	vo.setDeptname(user.getDeptname());
		    	vo.setEmpemail(user.getEmpmail());
			    
				if (vo.getBoardGubun().equals("FAQ")){
					model.addObject("selectFaq", cmmnDetailService.selectCmmnDetailCombo("qna_gubun"));
				}				
				if (!vo.getMode().equals("Ins")){			
			     	model.addObject("regist", boardInfoService.selectBoardManageView(vo.getBoardSeq()));	     	
				}else {
					model.addObject("regist", vo);
				}
				
				
				
			}catch(Exception e){
				LOGGER.info("e:"+ e.toString());	
			}
			return model;
		}
		@RequestMapping (value="board/boardView.do")
		public String selectBoardViewInfoManageDetail(@ModelAttribute("loginVO") AdminLoginVO loginVO
												 	  , @ModelAttribute("vo")  BoardInfo vo
										              , HttpServletRequest request
										   			  , BindingResult bindingResult
												      , ModelMap model ) throws Exception{	
						
			try{
				LOGGER.debug("boardseq:"+vo.getBoardSeq());
				
				int hitCount = boardInfoService.updateBoardVisitedManage(vo.getBoardSeq());
				model.addAttribute("regist", vo);
			    model.addAttribute("regist", boardInfoService.selectBoardManageView(vo.getBoardSeq()));
					
			}catch(Exception e){
				LOGGER.info("e:"+ e.toString());	
			}
			return "/front/board/boardView";
		}
		
		@RequestMapping (value="board/boardDelete.do")		
		@ResponseBody
		public String deleteBoardInfoManage(@ModelAttribute("loginVO") AdminLoginVO loginVO
				                            , HttpServletRequest request)throws Exception{
			
			String boardSeq = request.getParameter("boardSeq") != null ? request.getParameter("boardSeq") : "";
			String returnMessage = "F";
			try{
			      int ret = 	boardInfoService.deleteBoardManage(boardSeq);		      
			      if (ret > 0 ) {		    	  
			    	  returnMessage = "T";
			      }else {
			    	  returnMessage = "F";		    	  
			      }
			}catch (Exception e){
				LOGGER.info(e.toString());
				returnMessage = "F";			
			}					
			return returnMessage;
		}		
		@RequestMapping (value="/front/board/boardUpdate.do")
		@SuppressWarnings("finally")
		public String updateboardInfoManage( HttpServletRequest request, MultipartRequest mRequest,
											@ModelAttribute("LoginVO") LoginVO loginVO,
											@ModelAttribute("BoardInfoVO") BoardInfo vo					
											, BindingResult result,
											ModelMap model) throws Exception{
			
			model.addAttribute("regist", vo);
			String meesage = "";
			String url = "/front/board/boardList";
			
			EgovStringUtil egovStringUtil = new EgovStringUtil();
			
			vo.setBoardTopSeq("0");	
	    	String realFolder = propertiesService.getString("Globals.fileStorePath") ;
	    	//LoginVO user = (LoginVO) request.getSession().getAttribute("LoginVO");
	    	EmpInfo user = (EmpInfo) request.getSession().getAttribute("empInfoVO");
	     	    			     	
	    	vo.setBoardFile01( uploadFile.uploadFileNm(mRequest.getFiles("boardFile01"), realFolder));
	    	vo.setBoardFile02( uploadFile.uploadFileNm(mRequest.getFiles("boardFile02"), realFolder));
			
			try{
				
			
				int ret  = 0;
				
				meesage = vo.getMode().equals("Ins") ?  "sucess.common.insert" :  "sucess.common.update";
				vo.setBoardTitle(egovStringUtil.checkHtmlView(vo.getBoardTitle()));
				vo.setUserId(user.getEmpno());
				url = "redirect:/front/board/boardList.do?boardGubun="+vo.getBoardGubun();
				ret = boardInfoService.updateBoardManage(vo);
				if (ret >0){
					model.addAttribute("status", Globals.STATUS_SUCCESS);
					model.addAttribute("message", egovMessageSource.getMessage(meesage));
				}else {
					throw new Exception();
				}
				
				
				if (ret >0){
					model.addAttribute("status", Globals.STATUS_SUCCESS);
					model.addAttribute("message", egovMessageSource.getMessage(meesage));
							
				}else {
					throw new Exception();
				}
				
			}catch (Exception e){
				model.addAttribute("status", Globals.STATUS_FAIL);
				model.addAttribute("message", egovMessageSource.getMessage("fail.common.insert"));			
				url = "redirect:/front/board/boardList.do?boardGubun="+vo.getBoardGubun();
			}
			return url;
			
		}
		
		@RequestMapping(value="board/helpPop.do")		
		public ModelAndView helpPop() throws Exception{
			ModelAndView mode  = new ModelAndView("/front/popup/helpPop");
			return mode;	
		}
		
		@RequestMapping(value="board/helpPop_inout.do")		
		public String helpPop_inout() throws Exception{
			
		  return "/front/popup/helpPop_inout";
		}
	
   	    // include 파일 정리 
		@RequestMapping(value="inc/fnt_top_inc.do")
		public ModelAndView nhisTop() throws Exception{	
			ModelAndView mode  = new ModelAndView("/front/inc/fnt_top_inc");
			return mode;
		}
		@RequestMapping(value="inc/fnt_bottom_inc.do")	
		public ModelAndView nhisBottom() throws Exception{		
			ModelAndView mode  = new ModelAndView("/front/inc/fnt_bottom_inc");
			return mode;		
		}
}
