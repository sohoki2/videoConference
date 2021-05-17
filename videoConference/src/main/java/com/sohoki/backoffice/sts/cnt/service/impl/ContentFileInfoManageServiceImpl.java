package com.sohoki.backoffice.sts.cnt.service.impl;


import java.util.List;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sts.cnt.mapper.ContentFileManagerMapper;
import com.sohoki.backoffice.sts.cnt.vo.ContentFileInfo;
import com.sohoki.backoffice.sts.cnt.vo.ContentFileInfoVO;
import com.sohoki.backoffice.sts.cnt.service.ContentFileInfoManageService;



@Service
public abstract class ContentFileInfoManageServiceImpl extends EgovAbstractServiceImpl implements ContentFileInfoManageService {

	@Autowired
	private ContentFileManagerMapper conFileManager;

	@Override
	public List<ContentFileInfoVO> selectFilePageListByPagination(ContentFileInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.selectFilePageListByPagination(searchVO);
	}

	@Override
	public int selectFilePageListByPaginationTotCnt_S(ContentFileInfoVO searchVO)
			throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.selectFilePageListByPaginationTotCnt_S(searchVO);
	}

	@Override
	public int selectFileListTotCnt_S(String conSeq) throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.selectFileListTotCnt_S(conSeq);
	}

	@Override
	public ContentFileInfoVO selectFileDetail(String atchFileId)
			throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.selectFileDetail(atchFileId);
	}

	@Override
	public int insertFileManage(ContentFileInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.insertFileManage(vo);
	}

	@Override
	public int updateFileManage(ContentFileInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.updateFileManage(vo);
	}

	@Override
	public int updateFileManageUseYn(ContentFileInfo vo) throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.updateFileManageUseYn(vo);
	}

	@Override
	public int deleteFileManage(String atchFileId) throws Exception {
		// TODO Auto-generated method stub
		return conFileManager.deleteFileManage(atchFileId);
	}

	
	
}
