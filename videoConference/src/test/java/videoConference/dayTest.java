package videoConference;

import java.time.LocalDate;
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

		// 컨테이너에서 getBean()
		//List<String> floorInfo = dotToList("2,3,4");
		//String centerFloorInfo = checkItemList(floorInfo, "4", "6");
		//LocalDate.parse("20081004", DateTimeFormatter.BASIC_ISO_DATE);

		
		System.out.println(conferenceState("다목적홀:unuse,시민아카데미:unuse") );
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
