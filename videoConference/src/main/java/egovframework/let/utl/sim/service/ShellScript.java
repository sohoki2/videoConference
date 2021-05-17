package egovframework.let.utl.sim.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class ShellScript {

	
	public ShellScript(){
		
	}
	//서버에서  shell 사용 스크립트
	public String callHadoopEmpInfo(String cmd) throws IOException {
		String s;
		String result = "";
		Runtime rt = Runtime.getRuntime();
		Process p = rt.exec(cmd);
		
		BufferedReader stdinput = new  BufferedReader(new InputStreamReader(p.getInputStream()));
		while ((s =stdinput.readLine())!= null){
			result = result + s;
		}
		
		return result;
	}
}
