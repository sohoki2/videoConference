package sutil;

public class Encrypt {

	
	 public static String com_Encode(String strData){
		 
		 return "";
	 }
     public static String com_Decode(String strData){
		 
		 return "";
	 }
	 
	
	 public String EncodeBySType(String strData) {
		   String strRet = null;
		   strRet = Encrypt.com_Encode(":" + strData + ":sisenc" );
		   return strRet;	
	 }
	 public String DecodeBySType(String strData) {
		   String strRet = null;
		   int e, d, s, i=0;
		   
		   strRet = Encrypt.com_Decode(strData);
		   e = strRet.indexOf(":");
		   d = strRet.indexOf(":sisenc");
		   strRet = strRet.substring(e+1, d);	   
		   return strRet;	   
	 }
	
}
