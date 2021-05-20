package com.sohoki.backoffice.cus.org.service;

import com.sohoki.backoffice.cus.org.vo.SwcInfo;

public interface SwcInfoManageService {

	
	
	SwcInfo selectSwcInfoManageService ()throws Exception;
	
	int updateSwcInfoManageService(SwcInfo vo)throws Exception;
}
