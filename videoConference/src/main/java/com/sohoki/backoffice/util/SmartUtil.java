package com.sohoki.backoffice.util;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TimeZone;
import java.util.stream.Collectors;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.lang.reflect.Array;

import javax.imageio.ImageIO;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NameList;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.sohoki.backoffice.cus.org.vo.EmpInfo;

import egovframework.rte.fdl.property.EgovPropertyService;

import java.math.BigDecimal;


@Service
public class SmartUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(SmartUtil.class);
	
			
	@Autowired
	protected EgovPropertyService propertiesService;
	

	public String sendAvayaMessage(String _txtLocal){
		 
		 String RequestBody = "";
		 String sendMsg = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
		                 " <MCU_XML_API> " +
		                 "   <Request>"+
		                 "     "+   RequestBody  +"  "+
                        "   </Request>"+
		                 " </MCU_XML_API> "; 
		return sendMsg;
	}
	public void XMLParse(String xmlData) throws ParserConfigurationException, SAXException, IOException{
		
		InputSource is = new InputSource(new StringReader(xmlData));
		
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		Document doc = documentBuilder.parse(is);
		Element root = doc.getDocumentElement();
		NodeList chideren = root.getChildNodes();
		
		for (int i = 0; i < chideren.getLength(); i ++){
			Node node = chideren.item(i);
			if (node.getNodeType() == Node.ELEMENT_NODE){
				Element ele = (Element)node;
				String nodeName = ele.getNodeName();
				if ( nodeName.equals("")){
					
				}else{
					
				}
				
			}
			
		}		
	}
	/*
	 *  ????????? ??????
	 * 
	 */
	public static String reqDay( int _number  ){
		
		LocalDate now = LocalDate.now();
		String dayFormat = _number == 0  ? now.format(DateTimeFormatter.ofPattern("yyyyMMdd")) :  now.plusDays(_number).format((DateTimeFormatter.ofPattern("yyyyMMdd")));
		return  dayFormat;
	}
	/*
	 *  ?????? ??? ????????? ??????  ??? ????????? 
	 *  ?????? ??? ??????, ?????? ??? ?????? ?????? 
	*/
    public static String reqEndDay(String _day){
		
    	//String day = LocalDate.parse("20181211", DateTimeFormatter.BASIC_ISO_DATE).with(TemporalAdjusters.firstDayOfMonth()).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String dayFormat = LocalDate.parse(_day, DateTimeFormatter.BASIC_ISO_DATE).with(TemporalAdjusters.lastDayOfMonth()).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		
		return  dayFormat;
	}
    /*
     *  qr ?????? 
     *  path ????????? ?????? ?????? 
     */
    public static String getQrCode(String path, String data, int width, int height, String file_nm){
		
		LOGGER.debug("path : " + path);
		LOGGER.debug("data : " + data);
		LOGGER.debug("visit_id : " + file_nm);
		
		try {
            File file = null;
            // ?????????????????? ????????? ???????????? ??????
            file = new File(path);
            if(!file.exists()) {
                file.mkdirs();
            }
            //qr???????????????
            
            // ??????????????? ????????? ?????? (url??? ?????? ?????? )
            String codeurl = new String(data.getBytes("UTF-8"), "ISO-8859-1");
            // ???????????? ????????? ?????????
          
            int qrcodeColor =   0xff000000;
//            #000000
            // ???????????? ???????????????
            int backgroundColor = 0xFFFFFFFF;
             
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            // 3,4?????? parameter??? : width/height??? ??????
            BitMatrix bitMatrix = qrCodeWriter.encode(codeurl, BarcodeFormat.QR_CODE, width, height);
            //
            MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrcodeColor,backgroundColor);
            BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
            // ImageIO??? ????????? ????????? ????????????
            ImageIO.write(bufferedImage, "png", new File(path + "/" + file_nm + ".png" ));
             
        } catch (Exception e) {
        	data = "FAIL";
        	LOGGER.error("getQrCode ERROR" + e.toString());
            e.printStackTrace();
        }  
		
		return data;
	}
	public static String timeView(String _time)
	{
		return _time.length() ==4 ? _time.substring(0,2)+":"+_time.substring(2,4) : "";
	}
	//?????? ?????? ????????? ????????? 	
	public static String calView (int _year, int _month, int day, String _gubun){
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(_year, _month-1, day);
		
		if (_gubun.equals("pre")){
			cal.add(Calendar.MONTH, -1);
		}else if (_gubun.equals("nxt")){
			cal.add(Calendar.MONTH, 1);
		}
		
		String now_Month = String.valueOf(cal.get(Calendar.MONTH)+1);
		
        /*String fYMD =  String.valueOf(cal.getMinimum(Calendar.DAY_OF_MONTH));
        int w = cal.get(Calendar.WEEK_OF_MONTH);
        String lYMD = String.valueOf(cal.getMaximum(Calendar.DAY_OF_MONTH));*/
        
        //?????? ?????? 
        cal.set(Calendar.DATE, 1);
        int w = cal.get(Calendar.DAY_OF_WEEK);        
        String lYMD = String.valueOf(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        // ?????? ?????? ???       

        
        StringBuilder sb = new StringBuilder();
        sb.append("<table class='data_cal'>");
        sb.append(" <caption>??????</caption>");
        sb.append(" <thead>");
        sb.append("   <tr>");
        sb.append("   <td><a href='javascript:cal_change(&#34;pre&#34;)'><</a></td>");
        sb.append("   <td colspan='5'>"+now_Month+"???</td>");
        sb.append("   <td><a href='javascript:cal_change(&#34;nxt&#34;)'>></a></td>");
        sb.append("   </tr>");        
        sb.append("   <tr>");
        sb.append("     <th>???</th> ");
        sb.append("     <th>???</th> ");
        sb.append("     <th>???</th> ");
        sb.append("     <th>???</th> ");
        sb.append("     <th>???</th> ");
        sb.append("     <th>???</th> ");
        sb.append("     <th>???</th> ");
        sb.append("   </tr>");
        sb.append(" </thead>");
        sb.append(" <tbody>");

        sb.append("<tr>");

        for (int i = 1; i < w; i++)
        { // 6?????? 1?????? ??????????????? w=7 ????????? ?????? 6?????? ?????????.
            sb.append("<td></td>");
        }

        String fc;


        String _res_remark = null;
        String _res_day_ck = null;
        //?????? ?????? ?????? 
        _year = cal.get(Calendar.YEAR);
		//?????? ?????? ?????? ??? ?????? 
        int meeting_count = 0;
        for (int i = 1; i <= Integer.parseInt(lYMD); i++)
        {
            fc = w % 7 == 1 ? "red" : (w % 7 == 0 ? "blue" : "black");
            if (i == day)
            {
                sb.append("<td id='cal_"+ String.valueOf(_year) + day_format(now_Month) + day_format(String.valueOf(i))+"' style='color:" + fc + ";' class='today' onclick='javascript:day_change(&#39;" + String.valueOf(_year) + day_format(now_Month) + day_format(String.valueOf(i)) + "&#39;)'>");
            } 
            else
            {
                sb.append("<td id='cal_"+String.valueOf(_year) + day_format(now_Month) + day_format(String.valueOf(i))+"' style='color:" + fc + ";' onclick='javascript:day_change(&#39;" + String.valueOf(_year) + day_format(now_Month) + day_format(String.valueOf(i)) + "&#39;)'>");
            }
            
            sb.append("<span>"+i+"</span></td>");
            _res_remark = "";
            meeting_count = 0;
            w++;

            if (w % 7 == 1 && i != Integer.parseInt(lYMD))
            {
                sb.append("</tr>");
                sb.append("<tr>");
            }
        }
        if (w % 7 != 1)
        {
            if (w % 7 == 0)
            {
                sb.append("<td></td>");
            }
            else
            {
                for (int i = w % 7; i <= 7; i++)
                    sb.append("<td></td>");
            }
        }
        sb.append(" </tbody>");
        sb.append("</table>");
        return sb.toString();
	}
    private static String day_format(String _date)
    {
        return (_date.length() == 1) ? "0" + _date : _date;
    }
    //null or empty ??????
    public String NVL(String _val, String _replace) {
    	return _val.isEmpty() ? _replace : _val;
    }
    public String NVL(Object _val, String _replace) {
    	return _val == null ? _replace : _val.toString();
    }
    public int NVL(Object _val, int _replace) {
    	return _val == null ? _replace : Integer.valueOf( _val.toString());
    }
	public List<String> dotToList (String _dotlist) {
    	return !_dotlist.equals("") ?  Arrays.asList(_dotlist.split("\\s*,\\s*")) : null;
    }
    //?????? ?????? ??? ?????? ?????? 
    public String checkItemList(List<String> _arrayList, String _nowVal, String _newVal) {
    	String itemList = "";
    	if (_arrayList.size()>0) {
    		
    		List list = _arrayList.stream().filter(e ->  !e.startsWith(_nowVal)).collect(Collectors.toList()); 
    		if (!_newVal.isEmpty())
    	    	list.add(_newVal);
    		itemList = (String) list.stream().distinct().sorted().collect(Collectors.joining(","));
    	}
    	return itemList;
    	
    }
    /**
     *<pre>
     * ????????? ?????? String??? null??? ?????? &quot;&quot;??? ????????????.
     * &#064;param src null?????? ???????????? ?????? String ???.
     * &#064;return ?????? String??? null ?????? ?????? &quot;&quot;??? ?????? String ???.
     *</pre>
     */
    public static String nullConvert(Object src) {
		//if (src != null && src.getClass().getName().equals("java.math.BigDecimal")) {
		if (src != null && src instanceof java.math.BigDecimal) {
		    return ((BigDecimal)src).toString();
		}
	
		if (src == null || src.equals("null")) {
		    return "";
		} else {
		    return ((String)src).trim();
		}
    }
    public static String checkHtmlView(String strString) {
		String strNew = "";

		StringBuffer strTxt = new StringBuffer("");

		char chrBuff;
		int len = strString.length();

		for (int i = 0; i < len; i++) {
			chrBuff = (char) strString.charAt(i);

			switch (chrBuff) {
				case '<':
					strTxt.append("&lt;");
					break;
				case '>':
					strTxt.append("&gt;");
					break;
				case '"':
					strTxt.append("&quot;");
					break;
				case 10:
					strTxt.append("<br>");
					break;
				case ' ':
					strTxt.append("&nbsp;");
					break;
				case '&' :
					strTxt.append("&amp;");
				break;
				default:
					strTxt.append(chrBuff);
			}
		}

		strNew = strTxt.toString();

		return strNew;
	}
    /*
	 *  ?????? ?????? 
	 *  strTitle ,  strMessage, sendEmail, sendName, recMail
	 * 
	 */
	public boolean sendMail ( String  strTitle, String strMessage, String sendEmail , String sendName,  String recMail )throws Exception {
		
		boolean sendMailResult = false;
		
	    Properties props = System.getProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.port", Integer.valueOf(25));
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");

        Session session = Session.getDefaultInstance(props);
        MimeMessage mine_msg = new MimeMessage(session);
        mine_msg.setFrom(new InternetAddress(sendEmail, sendName));
        mine_msg.setRecipient(Message.RecipientType.TO, new InternetAddress(recMail  ));
        mine_msg.setSubject(strTitle);
        mine_msg.setContent(strMessage, "text/html;charset=euc-kr");

        Transport transport = session.getTransport();
        
        try
        {
          transport.connect(this.propertiesService.getString("smtpIp"), this.propertiesService.getString("smtpUser"), this.propertiesService.getString("smtpPwd"));
          transport.sendMessage(mine_msg, mine_msg.getAllRecipients());
          sendMailResult = true;
        }
        catch (Exception ex) {
        	LOGGER.error("sendMail ERROR:" + ex.toString());
            ex.printStackTrace();
        } finally {
          transport.close();
        }
        
        return sendMailResult;
	}
	/*
	 *   ?????? ?????? ????????? ?????? ??????
	 *  
	 */
	public int sendSMS(String strTitle, String msg, String sendMail,  String sendName,  String empMail, String mailCheck,
			           String emphandphone, String sendHandphone,  String smsCheck, String smsMsg) throws Exception {
		
		
		
		int ret = 0;
		try {
			
			if (mailCheck.equals("Y")){
				sendMail(strTitle, msg, sendMail, sendName, empMail);
			}
		
			if (smsCheck.equals("Y") && NVL(emphandphone, "").indexOf("-") > 0) {
				    /*
				    MailInfo mail = new MailInfo();
					mail.setMemberName(info.getEmpname());
					mail.setMsg(smsMsg);
			
					String[] destel = info.getEmphandphone().split("-");
					mail.setDestel1(destel[0].toString());
					mail.setDestel2(destel[1].toString());
					mail.setDestel3(destel[2].toString());
					String[] srctel = sendHandphone.split("-");
					mail.setSrctel1(srctel[0].toString());
					mail.setSrctel2(srctel[1].toString());
					mail.setSrctel3(srctel[2].toString());
					try{
					     ret = this.smsMapper.SmsInsertInfo(mail);
					} catch (Exception e1) {
					   LOGGER.error("e1" + e1.toString());
					}
				   */
			  }
		}catch (Exception e){
		LOGGER.error(" sendSMS ERROR:" + e.toString());
		}
		
		return ret;
	} 
	/*
	 *  ibats ???????????? ????????????   
	 * 
	 */
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
}
