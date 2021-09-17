package com.jh.controller;

import java.net.URLEncoder;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.dao.MapServiceDAO;
import com.project.util.KakaoGeoApi1;
import com.project.vo.MapServiceVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class MapServiceTest{
	@Autowired
	private MapServiceDAO dao;
	
	
	
	@Test
	public void collectMapLocs() throws Exception{
		
		List<MapServiceVO> mapLocs = dao.getMarkerInfoList();
		for(int i = 0; i < mapLocs.size();i++) {
			MapServiceVO loc = mapLocs.get(i);
    		String addr = KakaoGeoApi1.addrToCoord(URLEncoder.encode(loc.getAddress(),"UTF-8"));
    		String [] latlng = KakaoGeoApi1.getRegionAddress(addr);
    		System.out.println("[" + latlng[1]+ ", " + latlng[0] + "]");
		}
		
		MapServiceVO [] nullLocs = new MapServiceVO[2];
		nullLocs[0] = mapLocs.get(2);
		nullLocs[1] = mapLocs.get(mapLocs.size()-6);
		
	//	for(int i = 0; i < nullLocs.length;i++) {
	//		String [] strArr = KakaoGeoApi1.getRegionAddress(KakaoGeoApi1.addrToCoord(URLEncoder.encode(nullLocs[i].getAddress(),"UTF-8"))); 
	//		System.out.println("[" + strArr[0]+ ", " + strArr[1] + "]");
	//	}
		
	}
	
}
