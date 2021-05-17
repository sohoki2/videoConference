package com.sohoki.backoffice.sts.hly.mapper;

import java.util.List;

import com.sohoki.backoffice.sts.hly.vo.HolyworkInfo;
import com.sohoki.backoffice.sts.hly.vo.HolyworkInfoVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface HolyworkInfoManageMapper {

	
    public List<HolyworkInfoVO> selectHolyManageListByPagination(HolyworkInfoVO searchVO) throws Exception;
	
    public HolyworkInfoVO selectHolyManageDetail(String HolySeq) throws Exception;
	
    public HolyworkInfoVO selectHolyManageView(String HolySeq) throws Exception;
	
    public int selectHolyManageListTotCnt_S(HolyworkInfoVO searchVO) throws Exception;
	
    public int insertHolyManage(HolyworkInfo vo) throws Exception;
	
    public int updateHolyManage(HolyworkInfo vo) throws Exception;
	
    public int deleteHolyManage(String  HolySeq) throws Exception;

	public int smartBatch() throws Exception;
	
	public int timeBatch() throws Exception;
	
}
