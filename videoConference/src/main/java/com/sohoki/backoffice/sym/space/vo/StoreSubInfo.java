package com.sohoki.backoffice.sym.space.vo;

import java.util.Map;

import lombok.Data;

@Data
public class StoreSubInfo {

	private String id;
	private String name;
	private String nfc; //
	private String stationCode;
	private String selectLayout; //
	private Map<String, String> data; 
}
