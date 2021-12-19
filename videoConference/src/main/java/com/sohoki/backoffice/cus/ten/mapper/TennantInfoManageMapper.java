package com.sohoki.backoffice.cus.ten.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.sohoki.backoffice.cus.ten.vo.TennantInfo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;



@Mapper
public interface TennantInfoManageMapper {
	
	    public List<Map<String, Object>> selectTennantInfoManageListByPagination(@Param("params") Map<String, Object> params);
	    //history 설정 
	    public List<Map<String, Object>> selectTennantSubInfoManageListByPagination(@Param("params") Map<String, Object> params);
		
		public List<Map<String, Object>> selectTennantInfoManageCombo (@Param("comCode") String comCode);
		
		public Map<String, Object> selectTennantInfoManageDetail(String tennSeq);
		//history 상세
		public Map<String, Object> selectTennantHistorylInfoManageDetail(String tennSeq);
		
		public int insertTennantInfoManage(TennantInfo vo);
		//한달에 한번 크레딧 배포
		public int insertTennantMonthManage();
		
		public int insertTennantReset(String comCode);
		
		public int insertTennantInfoManages(List<TennantInfo> list);
		
		public int updateTennantInfoManage(TennantInfo vo);
		//테넌트 사용 
		public void updatePlayTennantInfoManage(@Param("tenn") Map<String, Object> tenn);
		//테넌트 취소 
		public int cancelPlayTennantInfoManage(@Param("tenn") Map<String, Object> tenn);
		//테넌트 회수
		public int updateRetireTennantInfoManage(@Param("tenn") Map<String, Object> tenn);
		
		
		
		
}
