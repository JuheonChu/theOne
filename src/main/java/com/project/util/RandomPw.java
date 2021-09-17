package com.project.util;

import java.util.Random;

public class RandomPw {
	public static String randompw(){
		Random ran = new Random();
		String value="";
		int num=0;
		for(int i=0;i<6;i++) {
			while(true) {
				num = (ran.nextInt()*123);
				if((47<num&&num<58)||(64<num&&num<91)||(96<num&&num<123)) {
					break;
				}
			}
			value +=(char)num;
		}
		return value;
	}
}
