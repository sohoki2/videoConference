package com.sohoki.backoffice.uat.uia.service.impl;


import java.sql.ResultSet;
import java.sql.SQLException;
import egovframework.com.cmm.AdminLoginVO;

import egovframework.rte.fdl.security.userdetails.EgovUserDetails;
import egovframework.rte.fdl.security.userdetails.jdbc.EgovUsersByUsernameMapping;
import javax.sql.DataSource;


public class EgovSessionMapping extends EgovUsersByUsernameMapping  {
	
	
	/**
	 * 사용자정보를 테이블에서 조회하여 EgovUsersByUsernameMapping 에 매핑한다.
	 * @param ds DataSource
	 * @param usersByUsernameQuery String
	 */
	public EgovSessionMapping(DataSource ds, String usersByUsernameQuery) {
        super(ds, usersByUsernameQuery);
    }

	/**
	 * mapRow Override
	 * @param rs ResultSet 결과
	 * @param rownum row num
	 * @return Object EgovUserDetails
	 * @exception SQLException
	 */
	@Override
	protected EgovUserDetails mapRow(ResultSet rs, int rownum) throws SQLException {
    	//logger.debug("## EgovUsersByUsernameMapping mapRow ##");
    	//권한 설정 변경 
        String strUserId    = rs.getString("ADMIN_ID");        
        String strPassWord  = rs.getString("ADMIN_PASSWORD");        
        boolean strEnabled  = true;
        String strUserNm    = rs.getString("ADMIN_NAME");        
        String strUserTel    = rs.getString("ADMIN_TEL");        
        String strUserEmail = rs.getString("ADMIN_EMAIL");        
        String strAuthorCode = rs.getString("AUTHOR_CODE");     
        
        String strLockYn = rs.getString("LOCK_YN");        
        String strUseYn = rs.getString("USE_YN");
        String strEmpNo = rs.getString("EMP_NO");
        
        
        // 세션 항목 설정
        AdminLoginVO adminloginVO = new AdminLoginVO();
        adminloginVO.setAdminId(strUserId);
        adminloginVO.setAdminPassword(strPassWord);
        adminloginVO.setAdminName(strUserNm);
        adminloginVO.setAdminTel(strUserTel);
        adminloginVO.setAdminEmail(strUserEmail);
        adminloginVO.setAuthorCode(strAuthorCode);
        
        adminloginVO.setLockYn(strLockYn);
        adminloginVO.setUseYn(strUseYn);
        adminloginVO.setEmpNo(strEmpNo);
        

        return new EgovUserDetails(strUserId, strPassWord, strEnabled, adminloginVO);
    }

}
