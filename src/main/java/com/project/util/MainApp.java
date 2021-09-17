/**
 * @author John Chu
 * @param
 */

package com.project.util;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MainApp {

	private static String URL = "http://www.jobkorea.co.kr/Corp/Person/Find";
	private static String URLResume = "http://www.jobkorea.co.kr/Corp/Person/Find/ResumeView?";
	
	public static void main(String[] args) throws IOException {
		String KEY_WORD = "jquery";
		//System.out.println("URL :: " + URL + getParameter(KEY_WORD, 3,"EditDtDesc"));
		//1. Document를 가져온다.
		Document doc = Jsoup.connect(URL).post();
		Document doc2 = Jsoup.connect(URLResume).get();
		//2. 목록을 가져온다.
		System.out.println("" + doc.toString());
		Elements elements = doc.select(".table-list--person tbody tr");
		Elements resumes = doc.select("a");
		//System.out.println(resumes.toString());
		
		//3. 목록(배열)에서 정보를 가져온다.
		int idx = 0;
		
		for(Element element : elements) {
			//System.out.println(element.getElementsByTag(""));
			System.out.println(++idx + " : " + element.text());
		//	System.out.println(element.getElementsContainingOwnText("한국"));
			System.out.println("==========================================\n\n");
		}
		
		
	}

	
	/**
	 * URL 완성
	 * @param KEY_WORD
	 * @param PAGE
	 * @return
	 */
	public static String getParameter(int rNo) {
		return "rNo="+rNo;
	}
	
}
