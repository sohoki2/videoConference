package com.sohoki.backoffice.sts.msg.service.impl;

import com.sohoki.backoffice.sts.msg.vo.MessageInfo;
import com.sohoki.backoffice.sts.msg.vo.MessageInfoVO;
import com.sohoki.backoffice.sts.msg.service.MessageInfoManageService;

import java.util.List;
import java.util.Map;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sohoki.backoffice.sts.msg.mapper.MessageInfoManageMapper;

@Service
public class MessageInfoManageServiceImpl extends EgovAbstractServiceImpl implements MessageInfoManageService {

	
	private static final Logger LOGGER = LoggerFactory.getLogger(MessageInfoManageServiceImpl.class);
	
	@Autowired
	private MessageInfoManageMapper msgMapper;

	@Override
	public List<Map<String, Object>> selectMsgManageListByPagination(MessageInfoVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return msgMapper.selectMsgManageListByPagination(searchVO);
	}

	@Override
	public Map<String, Object> selectMsgManageDetail(String MsgSeq) throws Exception {
		// TODO Auto-generated method stub
		return msgMapper.selectMsgManageDetail(MsgSeq);
	}
	@Override
	public int updateMsgManage(MessageInfo vo) throws Exception {
		int ret = 0;
		try{
			if (vo.getMode().equals("Ins"))
				ret = msgMapper.insertMsgManage(vo);
			else 
				ret =msgMapper.updateMsgManage(vo);
		}catch(Exception e){
			LOGGER.error("updateMsgManage error:" + e.toString());
		}
		return ret;
	}

	@Override
	public int deleteMsgManage(String msgSeq) throws Exception {
		// TODO Auto-generated method stub
		return msgMapper.deleteMsgManage(msgSeq);
	}

	@Override
	public List<MessageInfo> selectMsgCombo(String msgGubun)
			throws Exception {
		// TODO Auto-generated method stub
		return msgMapper.selectMsgCombo(msgGubun);
	}
	
	
}
