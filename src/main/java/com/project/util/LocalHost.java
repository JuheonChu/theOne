package com.project.util;
class CommonDomain{
	public static final String strCommon = "http://192.168.6.118:8080/";
}
public class LocalHost {
	public static final String strCommonDomain="http://192.168.6.118:8080/";
	
	public LocalHost() {
		
	}
	
	public static String getLocalHost() {
		return LocalHost.strCommonDomain;
	}
}
