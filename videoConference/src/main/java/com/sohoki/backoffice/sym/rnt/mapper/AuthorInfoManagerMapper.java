package com.sohoki.backoffice.sym.rnt.mapper;

import java.util.List;
import com.sohoki.backoffice.sym.rnt.vo.AuthorInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper
public interface AuthorInfoManagerMapper {
	public List<AuthorInfo> selectAuthorIInfoManageCombo();
}
