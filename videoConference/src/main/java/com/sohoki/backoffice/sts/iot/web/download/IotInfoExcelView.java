package com.sohoki.backoffice.sts.iot.web.download;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.sohoki.backoffice.sts.hly.web.HolyworkInfoManageController;
import com.sohoki.backoffice.sts.iot.vo.InoutManageInfoVO;


public class IotInfoExcelView extends AbstractExcelView {

	private static final Logger LOGGER = LoggerFactory.getLogger(IotInfoExcelView.class);
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		try{
			response.setHeader("Content-Disposition", "attachment; filename=\"" + getClass().getSimpleName() + ".xls\"");
	
			HSSFCell cell = null;
	
			HSSFSheet sheet = workbook.createSheet("입퇴실 내역 현황");
			sheet.setDefaultColumnWidth(13);
	
			// put text in first cell
			cell = getCell(sheet, 0, 0);
			setText(cell, "입퇴실  리스트");
	
			// set header information
			setText(getCell(sheet, 2, 0), "No.");
			setText(getCell(sheet, 2, 1), "예약센터");
			setText(getCell(sheet, 2, 2), "좌석번호");
			setText(getCell(sheet, 2, 3), "부서");
			setText(getCell(sheet, 2, 4), "직급");
			setText(getCell(sheet, 2, 5), "이름");
			setText(getCell(sheet, 2, 6), "사번");
			setText(getCell(sheet, 2, 7), "외부인구분");
			setText(getCell(sheet, 2, 8), "실근무자");
			setText(getCell(sheet, 2, 9), "신청일");			
			setText(getCell(sheet, 2, 10), "예약일");
			setText(getCell(sheet, 2, 11), "예약시간");
			setText(getCell(sheet, 2, 12), "입실시간");
			setText(getCell(sheet, 2, 13), "퇴실시간");
			setText(getCell(sheet, 2, 14), "상태");
			setText(getCell(sheet, 2, 15), "로그인");
			setText(getCell(sheet, 2, 16), "로그아웃");
			setText(getCell(sheet, 2, 17), "비밀번호");
			
	
			List<InoutManageInfoVO> goods = (List<InoutManageInfoVO>) model.get("resReport");
	
			for (int i = 0; i < goods.size(); i++) {
				InoutManageInfoVO resVO = goods.get(i);
	
				cell = getCell(sheet, 3 + i, 0);
				setText(cell, Integer.toString(i + 1));
				
				cell = getCell(sheet, 3 + i, 1);				
					setText(cell, resVO.getCenterNm());	
					
				cell = getCell(sheet, 3 + i, 2);
				setText(cell, resVO.getSeatName());
				
				cell = getCell(sheet, 3 + i, 3);
				setText(cell, resVO.getOrgName());
				
				cell = getCell(sheet, 3 + i, 4);
				setText(cell, resVO.getPosGrdNm());
				
				cell = getCell(sheet, 3 + i, 5);
				setText(cell, resVO.getEmpNm());
				
				cell = getCell(sheet, 3 + i, 6);
				setText(cell, resVO.getUserId());
	
				cell = getCell(sheet, 3 + i, 7);				
				if (!resVO.getCoworkerYn().equals("1")){
					setText(cell, "외부인");
				}
				
				cell = getCell(sheet, 3 + i, 8);
				if( resVO.getProxyYn().equals("P") ){
					setText(cell, resVO.getProxyUserNm() );
				}else if( resVO.getCoworkerYn().equals("0") ){
					setText(cell, resVO.getOutUserNm() );
				}else{
					setText(cell, "본인");
				}
				
				cell = getCell(sheet, 3 + i, 9);
				setText(cell, resVO.getRegDate()  );
				
				cell = getCell(sheet, 3 + i, 10);				
				setText(cell, resVO.getResDay());
				
				cell = getCell(sheet, 3 + i, 11);				
				setText(cell, resVO.getResStarttime() +"~"+ resVO.getResEndtime());
				
				cell = getCell(sheet, 3 + i, 12);
				setText(cell, resVO.getRoomIntime()  );
				
				cell = getCell(sheet, 3 + i, 13);
				setText(cell, resVO.getRoomOttime()  );
				
				cell = getCell(sheet, 3 + i, 14);
				if ( resVO.getRoomIntime()==null && resVO.getRoomOttime() ==null){
					setText(cell, "미확인"  );
				}else{
					setText(cell, "확인"  );
				}
				cell = getCell(sheet, 3 + i, 15);
				setText(cell, resVO.getLogin()  );
				cell = getCell(sheet, 3 + i, 16);
				setText(cell, resVO.getLogout()  );
				cell = getCell(sheet, 3 + i, 17);
				setText(cell, resVO.getPcPassword()  );
			}
		}catch(Exception e){
			LOGGER.info("error:" + e.toString());
		}
	}
}
