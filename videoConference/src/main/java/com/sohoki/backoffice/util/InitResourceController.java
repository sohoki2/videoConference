package com.sohoki.backoffice.util;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class InitResourceController {

	@Autowired
	private ServletContext servletContext;
	
	
	@PostConstruct
	public void init(){
		
	}
	
}
