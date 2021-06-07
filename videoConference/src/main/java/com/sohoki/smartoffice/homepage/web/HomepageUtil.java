package com.sohoki.smartoffice.homepage.web;

public class HomepageUtil {

	public static String conferenceState(String conference) {
		String sHtml = "";
		try {
			String meetingLists[] = conference.split(",");
			sHtml = "<ul class=\"booking\">";
			             for (String meetingList : meetingLists) {
					    	 String classes[] = meetingList.split(":");
					    	 sHtml += "<li class='"+classes[1]+"'>"+classes[0]+"</li>";
					     }
				  sHtml  += "</ul>";
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		return sHtml;
	}
}
