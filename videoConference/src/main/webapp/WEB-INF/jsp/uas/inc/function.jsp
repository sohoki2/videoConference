<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.net.URL" %>
<%!
	/********************************************************************************
	 *
	 * �ٳ� ��������
	 *
	 * - Function Library
	 *      ���� ������ �ʿ��� Function �� ������ ����
	 *
	 * ���� �ý��� ������ ���� ���ǻ����� �����ø� ���񽺰��������� ���� �ֽʽÿ�.
	 * DANAL Commerce Division Technique supporting Team
	 * EMail : tech@danal.co.kr
	 *
	 ********************************************************************************/
	
	 /******************************************************
	 * �������� URL ����
	 ******************************************************/
	final String DN_SERVICE_URL = "https://uas.teledit.com/uas/";

	/******************************************************
	 * SET TIMEOUT
	 ******************************************************/
	final int DN_CONNECT_TIMEOUT = 5000;
	final int DN_TIMEOUT = 30000;

	/******************************************************
	 * ID		: �ٳ����� ������ �帰 CPID
	 * PWD		: �ٳ����� ������ �帰 CPPWD
	 * ORDERID	: CP �ֹ�����
	 ******************************************************/
	final String ID  = "B010007034";
	final String PWD = "kv0C6KWKhx";
	final String ORDERID = "ORDERID";

	/******************************************************
	 * CHARSET ���� ( UTF-8:Default or EUC-KR )
	 ******************************************************/
	final String CHARSET = "EUC-KR";
//	final String CHARSET = "UTF-8";

	/******************************************************
	 * - CallTrans
	 *      �ٳ� ������ ����ϴ� �Լ��Դϴ�.
	 ******************************************************/
	public Map CallTrans( Map data ){
		
		String REQ_STR = data2str(data);
		String RES_STR = "";
        

		HttpClient hc = new HttpClient();
		hc.setConnectionTimeout( DN_CONNECT_TIMEOUT );
		hc.setTimeout( DN_TIMEOUT );

		try{
			int nStatus = hc.retrieve( "POST", DN_SERVICE_URL, REQ_STR, CHARSET, CHARSET );

			if( nStatus != 0) {
				RES_STR = "RETURNCODE=-1&RETURNMSG=NETWORK ERROR(" +nStatus+ ":12 : "+ DN_SERVICE_URL + ")";
			} else {
				RES_STR = hc.getResponseBody();
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return str2data( RES_STR );
	}

	public Map str2data(String str) {

		Map map = new HashMap();
		StringTokenizer st = new StringTokenizer(str,"&"); 

		while(st.hasMoreTokens()){

	    	String pair = st.nextToken();
	    	int index = pair.indexOf('=');

	    	if(index > 0){
	    		//map.put(pair.substring(0,index).trim(),urlDecode(pair.substring(index+1)));
				map.put(pair.substring(0,index).trim(), pair.substring(index+1));
			}
	 	}

		return map;
	}

	public String data2str(Map data) {

		Iterator i = data.keySet().iterator();
		StringBuffer sb = new StringBuffer();
	
		while(i.hasNext()){
	    		Object key = i.next();
	    		Object value = data.get(key);
	    		sb.append(key.toString()+"="+value+"&");
		}

		if(sb.length()>0) {
			return sb.substring(0,sb.length()-1);
		} else {
	    		return "";
		}
    }
	
	public String MakeFormInput(Map map,String[] arr) {

		StringBuffer ret = new StringBuffer();

		if( arr!=null )
		{
			for( int i=0;i<arr.length;i++ )
			{
				if( map.containsKey(arr[i]) )
				{
					map.remove( arr[i] );
				}
			}
		}

		Iterator i = map.keySet().iterator();

		while( i.hasNext() )
		{
			String key = (String)i.next();
			String value = (String)map.get(key);
			
			ret.append( "<input type=\"hidden\" name=\"" );
			ret.append( key );
			ret.append( "\" value=\"" );
			ret.append( value );
			ret.append( "\">" );
			ret.append( "\n" );
		}

		return ret.toString();
	}

	public String MakeFormInputHTTP(Map HTTPVAR,String arr) {

		StringBuffer ret = new StringBuffer();
		String key = "";
		String[] value = null;

		Iterator i = HTTPVAR.keySet().iterator();

		while( i.hasNext() )
		{
			key = (String)i.next();

			if( key.equals(arr) )
			{
				continue;
			}

			value = (String[])HTTPVAR.get(key);
			
			for( int j=0;j<value.length;j++ )
			{
				ret.append( "<input type=\"hidden\" name=\"" );
				ret.append( key );
				ret.append( "\" value=\"" );
				ret.append( value[j] );
				ret.append( "\">" );
				ret.append( "\n" );
			}
		}

		return ret.toString();
	}

	public String GetBgColor(String BgColor) {

		/*
		 * Default : Blue
		 */
		int Color = 0;
		int nBgColor = Integer.parseInt(BgColor);

		if( nBgColor > 0 && nBgColor < 11 )
		{
			Color = nBgColor;
		}

		if( Color >= 0 && Color <= 9 )
		{
			return "0" + Integer.toString(Color);
		}
		else
		{
			return Integer.toString(Color);
		}
	}
%>
