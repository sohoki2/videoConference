package com.sohoki.backoffice.uat.uia.service.impl;

import java.util.List;
import java.util.Map;

import com.sohoki.backoffice.uat.uia.vo.AdminInfo;
import com.sohoki.backoffice.util.mapper.UniSelectInfoManageMapper;
import com.sohoki.backoffice.uat.uia.service.AdminInfoManageService;
import com.sohoki.backoffice.uat.uia.mapper.AdminInfoManagerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class AdminInfoManageServiceImpl extends EgovAbstractServiceImpl implements  AdminInfoManageService {

	
	@Autowired
	private AdminInfoManagerMapper adminMapper;
	
	@Autowired
	private UniSelectInfoManageMapper uniMapper;
	
	@Override
	public List<Map<String, Object>> selectAdminUserManageListByPagination(Map<String, Object> searchVO)throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminUserManageListByPagination(searchVO);
	}
	
	@Override
	public Map<String, Object> selectAdminUserManageDetail(String adminId) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminUserManageDetail(adminId);
	}
	
	@Override
	public int deleteAdminUserManage(String mberId) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.deleteAdminUserManage(mberId);
	}
	
	@Override
	public int updateAdminUserManage(AdminInfo vo) throws Exception {
		// TODO Auto-generated method stub
		int ret = 0;
		if (vo.getMode().equals("Ins")){
			//사번 체크 하기 
			ret = (uniMapper.selectIdDoubleCheck("ADMIN_ID", "tb_admin", "ADMIN_ID = ["+ vo.getEmpNo() + "[" ) > 0) ? -1 :  adminMapper.insertAdminUserManage(vo);
		}else {
			ret = adminMapper.updateAdminUserManage(vo);
		}
		return ret;
	}

	@Override
	public int updateAdminUserLockManage(String adminId) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.updateAdminUserLockManage(adminId);
	}
	
}
