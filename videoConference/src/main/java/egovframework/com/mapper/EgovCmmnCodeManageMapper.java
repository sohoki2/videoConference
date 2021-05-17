package egovframework.com.mapper;

import java.util.List;

import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCode;
import com.sohoki.backoffice.sym.ccm.cca.service.CmmnCodeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("CmmnCodeManageMapper")
public interface EgovCmmnCodeManageMapper {

    public List<CmmnCodeVO> selectCmmnCodeListByPagination(CmmnCodeVO vo);
	
	public List<CmmnCode> selectCmmnCodeList(String clCode);
	
	public CmmnCode selectCmmnCodeDetail(String codeId);
	
	public int insertCmmnCode(CmmnCode vo);
	
	public int updateCmmnCode(CmmnCode vo);
	
	public int deleteCmmnCode(String codeId);
	
	public int selectCmmnCodeListTotCnt(CmmnCodeVO  vo);	
	//아이디 체크 
	public int selectIDCheck (String codeId);
}
