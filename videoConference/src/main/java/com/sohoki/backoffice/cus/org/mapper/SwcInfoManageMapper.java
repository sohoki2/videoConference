package com.sohoki.backoffice.cus.org.mapper;

import com.sohoki.backoffice.cus.org.vo.SwcInfo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper
public interface SwcInfoManageMapper {

    public SwcInfo selectSwcInfoManageService ();
	
    public int updateSwcInfoManageService(SwcInfo vo);
}
