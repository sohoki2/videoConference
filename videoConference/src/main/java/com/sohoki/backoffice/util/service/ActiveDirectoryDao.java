package com.sohoki.backoffice.util.service;


import java.util.Collections;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;



public class ActiveDirectoryDao {
	
	
	/**
     * 기본 루트.
     */

    private DirContext ldapContext;



    /**
     * Active Directory 서버의 호스트.
     */
    private String host = "active.dimdol.com";



    /**
     * Active Directory 서버의 포트.
     */

    private String port = "389";



    /**
     * 사용자.
     */

    private String username = "";



    /**
     * 패스워드.
     */

    private String password = "";



    /**
     * 기본 Distinguished Name,
     */

    private String baseDn = "OU=조직이름,DC=corp,DC=dimdol,DC=com";



    /**
     * 기본 생성자. Active Directory 서버와 연결한다.
     */    
    public ActiveDirectoryDao(String username, String password) {

        try {

            Hashtable ldapEnv = new Hashtable(5);
            ldapEnv.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
            ldapEnv.put(Context.PROVIDER_URL, "ldap://" + host + ":" + port);
            ldapEnv.put(Context.SECURITY_PRINCIPAL, username + "@corp.dimdol.com");
            ldapEnv.put(Context.SECURITY_CREDENTIALS, password);
            ldapContext = new InitialDirContext(ldapEnv);
        } catch (NamingException e) {
            throw new RuntimeException(e);
        }
    }



    /**
     * Active Directory 서버와의 연결을 종료한다.
     */

    public void close() {
        if (ldapContext != null) {
            try {
                ldapContext.close();
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
        }
    }



    /**
     * 사용자가 존재하는지 확인한다.
     * 
     * @param name
     * 사용자 아이디
     * @return 사용자가 존재하면 true를, 존재하지 않으면 false를 반환한다.
     */

    public boolean hasUser(String name) {
        try {
            NamingEnumeration all = ldapContext.search(baseDn, "name=" + name,  getSearchControl());
            return all.hasMoreElements();
        } catch (NamingException e) {
            throw new RuntimeException(e);
        }
    }



    /**

     * 사용자 정보를 java.util.Map 객체에 담아서 반환한다. 사용자가 존재하지 않으면
     * java.util.Collections.EMPTY_MAP 객체를 반환한다.
     * 
     * @param name
     *            사용자 아이디
     * @return 사용자 정보를 담고 있는 java.util.Map 객체
     */

    public Map getUser(String name) {
        try {
            NamingEnumeration all = ldapContext.search(baseDn, "name=" + name,  getSearchControl());

            while (all.hasMoreElements()) {
                SearchResult each = (SearchResult) all.nextElement();
                Map result = new HashMap();
                NamingEnumeration attributes = each.getAttributes().getAll();
                while (attributes.hasMoreElements()) {
                    Attribute attribute = (Attribute) attributes.nextElement();
                    result.put(attribute.getID(), attribute.get());
                }
                return result;
            }
            return Collections.EMPTY_MAP;
        } catch (NamingException e) {
            throw new RuntimeException(e);
        }
    }



    /**
     * 하위 노드에서도 검색하도록 설정한 SearchControls를 반환한다.
     * 
     * @return 하위 노드에서도 검색하도록 설정한 SearchControls
     */

    protected SearchControls getSearchControl() {
        SearchControls result = new SearchControls();
        result.setCountLimit(1);
        result.setSearchScope(SearchControls.SUBTREE_SCOPE);
        return result;
    }


    //사용법 
    public static void main(String[] args) throws Exception {

        ActiveDirectoryDao dao = new ActiveDirectoryDao("","");
        System.out.println(dao.hasUser("dimdol"));
        System.out.println(dao.getUser("dimdol").get("description"));
        dao.close();

    }

}
