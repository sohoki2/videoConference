package com.sohoki.backoffice.sts.res.vo;

import java.io.Serializable;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TimeInfo implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String timeSeq = "";
	private String swcTime = "";
	private String resSeq = "";
	private String apprival = "";
	private String useYn = "";
	private String meetingId = "";
	private String swcResday = "";
	private String centerId = "";
	private List meetingSeq;
	
	

	
	
}
