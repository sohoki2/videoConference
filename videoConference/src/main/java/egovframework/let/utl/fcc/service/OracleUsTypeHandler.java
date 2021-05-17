package egovframework.let.utl.fcc.service;

import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.slf4j.Logger;
 
@MappedTypes({ String.class })
public class OracleUsTypeHandler extends BaseTypeHandler<String> {

	private static Logger logger = org.slf4j.LoggerFactory.getLogger(OracleUsTypeHandler.class);

	private static String ISO88591_ENCODE = "ISO8859_1";
	private static String GBK_ENCODE = "EUC_KR";
	private static String UTF8_ENCODE = "UTF-8";
	
	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, String parameter, JdbcType jdbcType) throws SQLException {
		try {
			String paramStr = null;
			if (null != parameter) {
				paramStr = (String) parameter;
				if (GBK_ENCODE.equals(getEncode(paramStr))) {
					if (null != parameter) {
						ps.setString(i,
								new String((parameter).getBytes(GBK_ENCODE),
										ISO88591_ENCODE));
					}
				}
			} else {
				ps.setString(i, parameter);
			}
		} catch (UnsupportedEncodingException e) {
			ps.setString(i, (String) parameter);
			logger.debug("StringTypeHandler encode Exception");
		}
	}

	@Override
	public String getNullableResult(ResultSet rs, String columnName)
			throws SQLException {
		try {
			if (null != rs.getString(columnName)) {
				String columnValue = rs.getString(columnName);
				if (ISO88591_ENCODE.equals(getEncode(columnValue))) {
					return new String(columnValue.getBytes(ISO88591_ENCODE),
							GBK_ENCODE);
				}
			}
		} catch (UnsupportedEncodingException e) {
			logger.debug("StringTypeHandler encode Exception");
		}
		return rs.getString(columnName);
	}

	@Override
	public String getNullableResult(ResultSet rs, int columnIndex)
			throws SQLException {
		return rs.getString(columnIndex);
	}

	@Override
	public String getNullableResult(CallableStatement cs, int columnIndex)
			throws SQLException {
		return cs.getString(columnIndex);
	}

	// 
	private String getEncode(String str) {
		String encode = null;
		if (verifyEncode(str, GBK_ENCODE)) {
			encode = GBK_ENCODE;
		} else if (verifyEncode(str, ISO88591_ENCODE)) {
			encode = ISO88591_ENCODE;
		} else if (verifyEncode(str, UTF8_ENCODE)) {
			encode = UTF8_ENCODE;
		}

		return encode;
	}

	// 
	private boolean verifyEncode(String str, String encode) {
		try {
			if (str.equals(new String(str.getBytes(encode), encode))) {
				return true;
			}
		} catch (UnsupportedEncodingException e) {
			logger.debug("StringTypeHandler encode UnsupportedEncoding");
		}
		return false;
	}
	/*
	public Object getResult(ResultGetter getter) throws SQLException {
		String str = null;
		try {
			str = new String(getter.getString().getBytes("8859_1"), "EUC_KR");
		} catch (UnsupportedEncodingException e) {
			this.logger.debug("UnsupportedEncodingException : "
					+ e.getMessage());
			str = getter.getString();

		} catch (Exception localException) {

		}
		return str;
	}

	@Override
	public void setParameter(ParameterSetter setter, Object parameter)
			throws SQLException {
		String str = null;

		try {
			str = new String(((String) parameter).getBytes("EUC_KR"), "8859_1");
		} catch (UnsupportedEncodingException e) {

			this.logger.debug("UnsupportedEncodingException : " + e.getMessage()); 
			str = (String) parameter;
		} catch (Exception localException) {

		}
		setter.setString(str);
		
	}

	@Override
	public Object valueOf(String s) {
		// TODO Auto-generated method stub
		return s;
	}
	*/
	
}
