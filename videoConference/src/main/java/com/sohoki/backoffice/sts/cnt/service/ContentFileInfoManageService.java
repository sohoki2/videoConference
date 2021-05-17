package com.sohoki.backoffice.sts.cnt.service;

import java.util.List;

import com.sohoki.backoffice.sts.cnt.vo.ContentFileInfo;
import com.sohoki.backoffice.sts.cnt.vo.ContentFileInfoVO;

public interface ContentFileInfoManageService  {
	
	
    List<ContentFileInfoVO> selectFilePageListByPagination(ContentFileInfoVO searchVO) throws Exception;
		
	int selectFilePageListByPaginationTotCnt_S (ContentFileInfoVO contentFileInfoVO)throws Exception;
	
	int  selectFileListTotCnt_S (String conSeq) throws Exception;
	
	ContentFileInfoVO selectFileDetail   (String atchFileId) throws Exception;

	int insertFileManage (ContentFileInfo vo) throws Exception;
	
	int updateFileManage (ContentFileInfo vo) throws Exception;
	
	int updateFileManageUseYn(ContentFileInfo vo) throws Exception;
	
	int deleteFileManage (String atchFileId) throws Exception;



}
