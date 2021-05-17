package egovframework.com.mapper;

import java.util.List;
import com.sohoki.backoffice.sym.ccm.ccc.service.CmmnClCode;
import com.sohoki.backoffice.sym.ccm.ccc.service.CmmnClCodeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("CmmnClCodeManageMapper")
public interface EgovCmmnClCodeManageMapper {

    public List<CmmnClCodeVO> selectCmmnClCodeListByPagination(CmmnClCodeVO vo);
	
	public List<CmmnClCode> selectCmmnClCodeList();
	
	public CmmnClCode selectCmmnClCodeDetail(String clCode);
	
	public int insertCmmnClCode(CmmnClCode vo);
	
	public int updateCmmnClCode(CmmnClCode vo);
	
	public int deleteCmmnClCode(String clCode);
	
	// 카운터 
	public int selectCmmnClCodeListTotCnt (CmmnClCodeVO searchVO);
}
