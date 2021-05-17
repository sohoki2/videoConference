package egovframework.com.cmm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sohoki.backoffice.sym.log.annotation.NoLogging;
import egovframework.com.cmm.service.EgovLogManageService;
import egovframework.com.cmm.service.LoginLog;
import egovframework.com.mapper.EgovLogManageMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class EgovLogManageServiceImpl extends EgovAbstractServiceImpl implements EgovLogManageService {

	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLogManageServiceImpl.class);
	
	@Autowired
	private EgovLogManageMapper loginMapper;
	
    @Resource(name = "egovLoginLogIdGnrService")
    private EgovIdGnrService idgenService;
	
	@Override
	public int logInsertLoginLog(LoginLog vo) throws Exception {
		vo.setLogId(idgenService.getNextStringId());
		return loginMapper.logInsertLoginLog(vo);
	}

	/*@Override
	public List selectLoginLogInfo( LoginLog searchVO) throws Exception {
		// TODO Auto-generated method stub		 
		//페이징 입력 후 처리 하기
		
		return loginMapper.selectLoginLogInfo(searchVO);
	}*/
    @NoLogging
	@Override
	public ModelAndView selectLoginLogInfo( LoginLog searchVO) throws Exception {
		// TODO Auto-generated method stub
		ModelAndView mav = new ModelAndView();
		try{
			//페이징 처리 다시 한번 생각하기 
			PaginationInfo paginationInfo = new PaginationInfo();
		   	paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());
			 
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			
			List<Map<String, Object>> list = loginMapper.selectLoginLogInfo(searchVO);
			
			
			 int totCnt = list.size() > 0 ? Integer.parseInt( list.get(0).get("total_record_count").toString() ): 0;
	    	 mav.addObject("resultList",  list );
	    	 mav.addObject("paginationInfo", paginationInfo);
	    	 mav.addObject("totalCnt", totCnt);
			 
		}catch (Exception e){
			LOGGER.debug("selectLoginLogInfo ERROR:" + e.toString());
			throw e;
		}
		return mav;
	}
}
