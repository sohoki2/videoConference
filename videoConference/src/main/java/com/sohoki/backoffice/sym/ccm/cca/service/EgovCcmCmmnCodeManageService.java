package com.sohoki.backoffice.sym.ccm.cca.service;

import java.util.List;


public interface EgovCcmCmmnCodeManageService {

	
	List<CmmnCodeVO> selectCmmnCodeListByPagination(CmmnCodeVO vo) throws Exception;
	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	int deleteCmmnCode(String codeId) throws Exception;
	     
	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCode
	 * @return CmmnCode(공통코드)
	 * @throws Exception
	 */
	CmmnCode selectCmmnCodeDetail(String codeId) throws Exception;

	/**
	 * 공통코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통코드 목록)
	 * @throws Exception
	 */
	List<?> selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception;

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	int updateCmmnCode(CmmnCode cmmnCode) throws Exception;

}
