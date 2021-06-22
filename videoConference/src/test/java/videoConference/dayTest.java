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
		
	}
	public static boolean isEmpty(Object obj) {
		if (obj instanceof String ) return obj == null || "".equals(obj.toString().trim());
		else if (obj instanceof List) return obj == null || ((List)obj).isEmpty();
		else if (obj instanceof Map) return obj == null || ((Map)obj).isEmpty();
		else if (obj instanceof Object[]) return obj == null || Array.getLength(obj) == 0;
		else return obj == null;
		
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
    //요소 확인 후 삭제 하기 
    public String checkItemList(List<String> _arrayList, String _nowVal, String _newVal) {
    	String itemList = "";
    	if (_arrayList.size()>0) {
    		
    		List list = _arrayList.stream().filter(e ->  !e.startsWith(_nowVal)).collect(Collectors.toList()); 
    		if (!_newVal.isBlank())
    	    	list.add(_newVal);
    		itemList = (String) list.stream().distinct().sorted().collect(Collectors.joining(","));
    	}
    	return itemList;
    }
}
