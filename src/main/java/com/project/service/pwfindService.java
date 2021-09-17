package com.project.service;

import com.project.vo.IdfindVO;


public interface pwfindService {
	 public void SendEmail(IdfindVO idvo);
	 
	 public void update(String id, String pw);
}
