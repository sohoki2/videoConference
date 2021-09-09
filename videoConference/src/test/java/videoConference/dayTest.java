package videoConference;

import java.lang.reflect.Array;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sohoki.backoffice.util.SmartUtil;

import static org.junit.Assert.*;



public class dayTest {

	

	@Test
	public void dbTest() {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", "SWC_TIME");
		
		
		meetingMsg("DAY");
	}
	public static boolean isEmpty(Object obj) {
		if (obj instanceof String ) return obj == null || "".equals(obj.toString().trim());
		else if (obj instanceof List) return obj == null || ((List)obj).isEmpty();
		else if (obj instanceof Map) return obj == null || ((Map)obj).isEmpty();
		else if (obj instanceof Object[]) return obj == null || Array.getLength(obj) == 0;
		else return obj == null;
		
	}
	
public void meetingMsg(String _dayGubun ) {
		
		Map<String, String> returnMsg = new HashMap<String, String>();
		String title = "";
		String resMessage = "";
		
		System.out.println("---------------------------------------------------");
		System.out.println("-------dayGubun"+ _dayGubun);
		System.out.println("---------------------------------------------------");
		switch (_dayGubun) {
		    case "RES":
		    	title = "[회의실 예약완료 알림]";
		    	System.out.println("[회의실 예약완료 알림");
		    case "DAY": 
		    	title = "[회의 D-1 알림]";
		    	System.out.println("[회의 D-1 알림");
		    case "STR": 
		    	title = "[회의 시작 알림]";
		    	System.out.println("[회의 시작 알림");
		    default :
		    	title = "[default]";
		    
		}
		returnMsg.put("title", title);
		
		System.out.println("title" + title);
		
	}
	public static boolean isEmpty(String s) {
		return !isEmpty(s);
	}
	
	public List<String> dotToList (String _dotlist) {
    	return !_dotlist.equals("") ?  Arrays.asList(_dotlist.split("\\s*,\\s*")) : null;
    }
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
