package com.sohoki.backoffice.sts.brd.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sts.brd.vo.BoardInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface BoardInfoManageMapper {

	
    public List<Map<String, Object>> selectBoardManageListByPagination(@Param("params") Map<String, Object> params ) throws Exception;
	
    public List<Map<String, Object>> selectBoardMainManageListByPagination() throws Exception;
    
    public List<Map<String, Object>> selectIndexBoardTitle()throws Exception;
    
    public List<Map<String, Object>> selectBoardMainManageListByPagination1() throws Exception;
    
    public List<Map<String, Object>> selectBoardMainManageListByPagination2() throws Exception;
    
    public List<Map<String, Object>> selectBoardMainManageListByPagination3() throws Exception;
  
    public Map<String, Object> selectBoardManageView(String boardSeq) throws Exception;
	
    public int insertBoardManage(BoardInfo vo) throws Exception;
	
    public int updateBoardManage(BoardInfo vo) throws Exception;
    
    public int updateBoardVisitedManage(String  boardSeq) throws Exception;
	
    public int deleteBoardManage(String  boardSeq) throws Exception;

	public int updateBoardNoticeUseYn() throws Exception;

	public int updateBoardTopSeq() throws Exception;

	public String selectBoardUploadFileName(String boardSeq) throws Exception;

	public String selectBoardoriginalFileName(String boardSeq) throws Exception;
}
