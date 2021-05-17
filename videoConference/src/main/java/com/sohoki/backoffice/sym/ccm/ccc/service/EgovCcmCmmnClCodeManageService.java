package com.sohoki.backoffice.sym.ccm.ccc.service;

import java.util.List;


public interface EgovCcmCmmnClCodeManageService {

	/**
	 * 공통분류코드를 삭제한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	int deleteCmmnClCode(CmmnClCode cmmnClCode) throws Exception;

	/**
	 * 공통분류코드를 등록한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	int insertCmmnClCode(CmmnClCode cmmnClCode) throws Exception;

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 * @param cmmnClCode
	 * @return CmmnClCode(공통분류코드)
	 * @throws Exception
	 */
	 CmmnClCode selectCmmnClCodeDetail(CmmnClCode cmmnClCode) throws Exception;

	/**
	 * 공통분류코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통분류코드 목록)
	 * @throws Exception
	 */
	List<?> selectCmmnClCodeList(CmmnClCodeVO searchVO) throws Exception;

    /**
	 * 공통분류코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통분류코드 총 갯수)
     */
    int selectCmmnClCodeListTotCnt(CmmnClCodeVO searchVO) throws Exception;

	/**
	 * 공통분류코드를 수정한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
    int updateCmmnClCode(CmmnClCode cmmnClCode) throws Exception;
}
