package com.sohoki.backoffice.sym.space.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.sohoki.backoffice.sym.space.vo.QrcodeInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface QrcodeInfoManageMapper {

	
	public List<Map<String, Object>> selectQrCodeList(@Param("params") Map<String, Object> params);
	
	public Map<String, Object> selectQrCodeDetail(@Param("params") Map<String, Object> params);
	
	public int insertQrcodeManage(QrcodeInfo vo);
	
	public int updateQrcodeManage(QrcodeInfo vo);
}
