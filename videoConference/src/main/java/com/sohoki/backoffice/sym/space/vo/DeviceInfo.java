package com.sohoki.backoffice.sym.space.vo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class DeviceInfo implements Serializable{

	
    private static final long serialVersionUID = 1L;
	
	private String deviceId = "";
	private String deviceNm = "";
	private String deviceIp = "";
	private String deviceMac = "";
	private String deviceUrl = "";
	private String deviceOs = "";
	private String deviceStartTime = "";
	private String deviceEndTime = "";
	private String deviceRemark = "";
	private String deviceEndConnTime = "";
	private String useYn = "";
	private String deviceStatus = "";
	private String regDate = "";
	private String regId = "";
	private String updateDate = "";
	private String updateId = "";
	private String mode = "";
	private String centerId = "";
	private String floorSeq = "";
	private String partSeq = "";
	private String meetingId = "";
	private String userId = "";
	private String deviceTop = "";
	private String deviceLeft = "";
	
	
}
