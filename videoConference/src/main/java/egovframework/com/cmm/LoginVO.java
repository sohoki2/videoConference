package egovframework.com.cmm;

import java.io.Serializable;

/**
 * @Class Name : LoginVO.java
 * @Description : Login VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.03    박지욱          최초 생성
 *
 *  @author 공통서비스 개발팀 박지욱
 *  @since 2009.03.03
 *  @version 1.0
 *  @see
 *  
 */
public class LoginVO {
	
	
	/** 아이디 */
	private String mberId;
	/** 이름 */
	private String mberNm;
	
	/** 이메일주소 */
	private String mberEmailAddress;
	
	/** 비밀번호 */
	private String password;
	/** 비밀번호 힌트 */
	private String passwordHint;
	/** 비밀번호 정답 */
	private String passwordCnsr;
	
	/** 관리자ㅣ 분 */
	private String authorCode;
	
	/** 조직(부서)ID */
	private String groupId;
	
	/** 조직(부서)명 */
	private String groupNm;
	/** 고유아이디 */
		
	/** 사용자 권한정보 */
	private String roleCode;	
	private String centerId;	
	/** 이동 통신 번호 **/
	private String mbtlNum;	
	
	private String ip;
	private String username;
	private String userid;
	private String name;	
	private String userSe;
	private String authority;
	private String unieqeid ;
	private String mberSttus;
	private String parentGroupId;
	
	
	/** 추가 **/
	private String strUserId;
	private String strPassWord; 
	private String strUserNm; 
	private String strUserSe; 
	private String strUserEmail;
	private String strOrgnztId;
	private String strRoleCode;
	private String strCenterId;
	private String strAuthorCode;	
	private String strParentGroupId;
	
	
	
	
	
	
	


	public String getParentGroupId() {
		return parentGroupId;
	}

	public void setParentGroupId(String parentGroupId) {
		this.parentGroupId = parentGroupId;
	}

	public String getStrParentGroupId() {
		return strParentGroupId;
	}

	public void setStrParentGroupId(String strParentGroupId) {
		this.strParentGroupId = strParentGroupId;
	}

	public String getMberEmailAdress() {
		return mberEmailAddress;
	}

	public void setMberEmailAdress(String mberEmailAdress) {
		this.mberEmailAddress = mberEmailAdress;
	}

	public String getStrUserId() {
		return strUserId;
	}

	public void setStrUserId(String strUserId) {
		this.strUserId = strUserId;
	}

	public String getStrPassWord() {
		return strPassWord;
	}

	public void setStrPassWord(String strPassWord) {
		this.strPassWord = strPassWord;
	}

	public String getStrUserNm() {
		return strUserNm;
	}

	public void setStrUserNm(String strUserNm) {
		this.strUserNm = strUserNm;
	}

	public String getStrUserSe() {
		return strUserSe;
	}

	public void setStrUserSe(String strUserSe) {
		this.strUserSe = strUserSe;
	}

	public String getStrUserEmail() {
		return strUserEmail;
	}

	public void setStrUserEmail(String strUserEmail) {
		this.strUserEmail = strUserEmail;
	}

	public String getStrOrgnztId() {
		return strOrgnztId;
	}

	public void setStrOrgnztId(String strOrgnztId) {
		this.strOrgnztId = strOrgnztId;
	}

	public String getStrRoleCode() {
		return strRoleCode;
	}

	public void setStrRoleCode(String strRoleCode) {
		this.strRoleCode = strRoleCode;
	}

	public String getStrCenterId() {
		return strCenterId;
	}

	public void setStrCenterId(String strCenterId) {
		this.strCenterId = strCenterId;
	}

	public String getStrAuthorCode() {
		return strAuthorCode;
	}

	public void setStrAuthorCode(String strAuthorCode) {
		this.strAuthorCode = strAuthorCode;
	}

	public String getMberSttus() {
		return mberSttus;
	}

	public void setMberSttus(String mberSttus) {
		this.mberSttus = mberSttus;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public String getUnieqeid() {
		return unieqeid;
	}

	public void setUnieqeid(String unieqeid) {
		this.unieqeid = unieqeid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserSe() {
		return userSe;
	}

	public void setUserSe(String userSe) {
		this.userSe = userSe;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getMbtlNum() {
		return mbtlNum;
	}

	public void setMbtlNum(String mbtlNum) {
		this.mbtlNum = mbtlNum;
	}

	
	
	
	

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getMberId() {
		return mberId;
	}

	public void setMberId(String mberId) {
		this.mberId = mberId;
	}

	public String getMberNm() {
		return mberNm;
	}

	public void setMberNm(String mberNm) {
		this.mberNm = mberNm;
	}

	public String getMberEmailAddress() {
		return mberEmailAddress;
	}

	public void setMberEmailAddress(String mberEmailAddress) {
		this.mberEmailAddress = mberEmailAddress;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordHint() {
		return passwordHint;
	}

	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}

	public String getPasswordCnsr() {
		return passwordCnsr;
	}

	public void setPasswordCnsr(String passwordCnsr) {
		this.passwordCnsr = passwordCnsr;
	}

	public String getAuthorCode() {
		return authorCode;
	}

	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getGroupNm() {
		return groupNm;
	}

	public void setGroupNm(String groupNm) {
		this.groupNm = groupNm;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getCenterId() {
		return centerId;
	}

	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	
		
}
