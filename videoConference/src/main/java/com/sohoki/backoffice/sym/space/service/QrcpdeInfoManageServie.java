package com.sohoki.backoffice.sym.space.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sohoki.backoffice.sym.space.vo.QrcodeInfo;

public interface QrcpdeInfoManageServie {

    List<Map<String, Object>> selectQrCodeList(@Param("params") Map<String, Object> params) throws Exception;
	
    Map<String, Object> selectQrCodeDetail(@Param("params") Map<String, Object> params) throws Exception;
    
	public int updateQrcodeManage(QrcodeInfo vo) throws Exception;
}
