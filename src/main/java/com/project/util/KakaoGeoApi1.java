package com.project.util;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;

import com.project.service.MapService;
import com.project.vo.MapServiceVO;
public class KakaoGeoApi1 {
	@Autowired
	static
	MapService mapservice;
	
    public static void main(String[] args) throws Exception {
    	
    	
    //	List<MapServiceVO> locations = mapservice.selectlocationList();
    	
    //	for(int i = 0; i < locations.size();i++) {
    //		MapServiceVO loc = locations.get(i);
    //		String addr = addrToCoord(URLEncoder.encode(loc.getAddress(),"UTF-8"));
    //		String [] latlng = getRegionAddress(addr);
    //		System.out.println("[" + latlng[0]+ ", " + latlng[1] + "]");
    		
    		
    //	}
         
     
 //      String addr = addrToCoord(URLEncoder.encode("경기 고양시 덕양구 대주로 52-98  (화정동)","UTF-8"));
 //      String [] latlng = getRegionAddress(addr);
      // System.out.println(latlng[0]); //126.xxxx (경도) ===> x
      // System.out.println(latlng[1]); //37.63922.. (위도) ===> y
        //String parsedAddress = getRegionAddress(addr);
        //System.out.println(parsedAddress);
        //System.out.println(addr.indexOf("x", 289));
       
        //System.out.println(coordToAddr("37.5665958","126.9783813"));
  //    System.out.println(latlng[0]);
    }
     
    public static String addrToCoord(String addr){
         
        String url = "https://dapi.kakao.com/v2/local/search/address.json?query="+addr;
        String json = "";
        try{
            json = getJSONData(url);
        }catch(Exception e){
             
            e.printStackTrace();
        }
        return json;
    }
 
    public static String coordToAddr(String x, String y){
         
        String url = "https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+x+"&y="+y+"&input_coord=WGS84";
        String json = "";
        try{
            json = getJSONData(url);
        }catch(Exception e){
             
            e.printStackTrace();
        }
        return json;
    }
     
     
    private static String getJSONData(String apiUrl) throws Exception {
        String jsonString = new String();
        String buf;
        String apikey = "0071bab4e0ba935cefd3166f7c763591"; //apikey
         
        URL url = new URL(apiUrl);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        String auth = "KakaoAK "+apikey;
        conn.setRequestMethod("GET");
        conn.setRequestProperty("X-Requested-With", "curl");
        conn.setRequestProperty("Authorization", auth);
         
        BufferedReader br = new BufferedReader(new InputStreamReader(
                conn.getInputStream(), "UTF-8"));
        while ((buf = br.readLine()) != null) {
        	//System.out.println(buf +" ");
    
            jsonString += buf;
        }
        return jsonString;
    }
    
    public static String[] getRegionAddress(String jsonString) {
    	String [] latlng = new String[2];
    	
    	String value = "";
    	String x = "";
    	JSONObject jObj = (JSONObject)JSONValue.parse(jsonString);
    	JSONObject meta = (JSONObject)jObj.get("meta");
    	
    	long size = (long)meta.get("total_count");//length of the elements
    	if(size > 0) {
    		JSONArray jArray = (JSONArray)jObj.get("documents");
    		JSONObject subJObj = (JSONObject)jArray.get(0);
    		JSONObject roadAddress = (JSONObject)subJObj.get("road_address");
    		String latitude = (String)subJObj.get("y");
        	String longitude = (String)subJObj.get("x");
    		if(roadAddress == null) {
    			JSONObject subsubJObj = (JSONObject)subJObj.get("address");
    			value = (String)subsubJObj.get("address_name");
    			String lat = (String)subsubJObj.get("x");
    			String lng=  (String)subsubJObj.get("y");
    		//	System.out.println("lat: " + lat + " , lng: " + lng);
    			latlng[0] = lat;
    			latlng[1] = lng;
    		}else {
    			value = (String)roadAddress.get("address_name");
    			String lat2 = (String)roadAddress.get("x");
    			String lng2 = (String)roadAddress.get("y");
    			latlng[0] = lat2;
    			latlng[1] = lng2;
    	//		System.out.println("lat: " + lat2 + " , lng: " + lng2);
    		}
    		if(value.equals("") || value == null) {
    			subJObj = (JSONObject)jArray.get(1);
    			subJObj = (JSONObject)subJObj.get("address");
    			String lat = (String)subJObj.get("x");
    			String lng = (String)subJObj.get("y");
    			latlng[0] = lat;
    			latlng[1] = lng;
    			value = (String)subJObj.get("address_name");
    		}
    	}
    	return latlng;
    }
}