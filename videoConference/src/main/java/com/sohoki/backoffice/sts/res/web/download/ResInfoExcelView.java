package com.sohoki.backoffice.sts.res.web.download;

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
import com.sohoki.backoffice.sts.res.vo.ResInfoVO;

public class ResInfoExcelView extends AbstractExcelView{

	private static final Logger LOGGER = LoggerFactory.getLogger(ResInfoExcelView.class);
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
										HSSFWorkbook workbook, 
										HttpServletRequest request,
										HttpServletResponse response) throws Exception {
		
		try{
			response.setHeader("Content-Disposition", "attachment; filename=\"" + getClass().getSimpleName() + ".xls\"");
	
			HSSFCell cell = null;
	
			HSSFSheet sheet = workbook.createSheet("예약현황");
			sheet.setDefaultColumnWidth(9);
			
			// put text in first cell
			cell = getCell(sheet, 0, 0);
			setText(cell, "회의실 예약관리");
			setText(getCell(sheet, 2, 0), "No.");
			setText(getCell(sheet, 2, 1), "부서");
			setText(getCell(sheet, 2, 2), "이름");
			setText(getCell(sheet, 2, 3), "사번");
			setText(getCell(sheet, 2, 4), "연락처");
			setText(getCell(sheet, 2, 5), "예약센터");
			setText(getCell(sheet, 2, 6), "회의실명");
			setText(getCell(sheet, 2, 7), "예약구분");
			setText(getCell(sheet, 2, 8), "회의제목");
			setText(getCell(sheet, 2, 9), "공개여부");
			
			setText(getCell(sheet, 2, 10), "참여인원");
			setText(getCell(sheet, 2, 11), "신청일");
			setText(getCell(sheet, 2, 12), "예약일자");
			setText(getCell(sheet, 2, 13), "시작~종료시간");
			setText(getCell(sheet, 2, 14), "결제상태");
			setText(getCell(sheet, 2, 15), "승인자");
			
			setText(getCell(sheet, 2, 16), "최종승인일자");
			setText(getCell(sheet, 2, 17), "반려사유유형");
			setText(getCell(sheet, 2, 18), "반려사유");
			setText(getCell(sheet, 2, 19), "회의록");
			
			
			List<ResInfoVO> goods = (List<ResInfoVO>) model.get("resReport");
			for (int i = 0; i < goods.size(); i++) {
				ResInfoVO resVO = goods.get(i);
	
				cell = getCell(sheet, 3 + i, 0);
				setText(cell, Integer.toString(i + 1));
				cell = getCell(sheet, 3 + i, 1);
				setText(cell, resVO.getDeptname());
				cell = getCell(sheet, 3 + i, 2);
				setText(cell, resVO.getEmpname());
				cell = getCell(sheet, 3 + i, 3);
				setText(cell, resVO.getUserId());
				cell = getCell(sheet, 3 + i, 4);
				setText(cell, resVO.getEmpmail());
				cell = getCell(sheet, 3 + i, 5);
				setText(cell, resVO.getCenterNm());
				cell = getCell(sheet, 3 + i, 6);				
				setText(cell, resVO.getSeatName());
				cell = getCell(sheet, 3 + i, 7);				
				setText(cell, resVO.getResGubunTxt());
				cell = getCell(sheet, 3 + i, 8);
				setText(cell, resVO.getAttendListTxt());
				
				cell = getCell(sheet, 3 + i, 9);
				setText(cell, resVO.getResTitle());
				cell = getCell(sheet, 3 + i, 10);
				setText(cell, resVO.getResPassTxt());
				
				
				cell = getCell(sheet, 3 + i, 11);
				setText(cell, resVO.getRegDate().substring(0,10) );
				cell = getCell(sheet, 3 + i, 12);
				setText(cell, resVO.getResStartday());
				cell = getCell(sheet, 3 + i, 13);
				setText(cell, resVO.getResStarttime() +"~"+ resVO.getResEndtime());	
				cell = getCell(sheet, 3 + i, 14);
				setText(cell, resVO.getReservProcessGubunTxt()  );
				cell = getCell(sheet, 3 + i, 15);
				setText(cell, resVO.getUserId());
				
				cell = getCell(sheet, 3 + i, 16);
				setText(cell, resVO.getAdminReplayDate()  );
				
				cell = getCell(sheet, 3 + i, 17);
				setText(cell, resVO.getCancelCodeTxt()  );
				
				cell = getCell(sheet, 3 + i, 18);
				setText(cell, resVO.getReservationReason()  );
				
				cell = getCell(sheet, 3 + i, 19);
				setText(cell, resVO.getMeetinglog());
				
				
			}
		}catch(Exception e){
			LOGGER.info("error:" + e.toString());
		}
	}
}

