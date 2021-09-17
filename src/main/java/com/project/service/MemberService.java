package com.project.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.project.vo.MemberVO;

public interface MemberService {

   public void signup(MemberVO vo);

   public void signupWOFile(MemberVO vo);

   public boolean loginChk(MemberVO vo, HttpSession session);

   public boolean loginChkWithImg(MemberVO vo, HttpSession session);

   public MemberVO viewMember(MemberVO vo);

   public void logout(HttpSession session);

   public void changeInfo(MemberVO vo);

   public void deleteMember(int memeber_id);

   public List<MemberVO> selectAll();

   public String hasImgFile(String id);

   public int idOverlapCheck(String id);

   public boolean checkId(String id);

   public boolean checkPw(String id, String password);

   public String findIdByIdx(int idx);

   public int getNamesCount(String name);

   public void signupfranchise(MemberVO vo);

   public void signupfranchisewofile(MemberVO vo);

   public String selectIDWithFranchisekey(String franchisekey);

   public MemberVO checkMember(int idx);

   public MemberVO selectMember(String id);

   public List<MemberVO> findid(String name, String email, String phone);
   
   public void infoupdate(MemberVO vo);
   
   public int idCheck(String id);
}