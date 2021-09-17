package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MapServiceDAO;
import com.project.vo.MapServiceVO;

@Service
public class MapServiceImpl implements MapService {
	
	@Autowired
	private MapServiceDAO dao;

	@Override
	public List<MapServiceVO> selectlocationList() {
		return dao.getMarkerInfoList();
	}

}
