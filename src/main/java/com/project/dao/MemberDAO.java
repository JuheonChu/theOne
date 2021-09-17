package com.project.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.project.vo.MemberVO;

public interface MemberDAO {

   public void insertMember(MemberVO vo);// 회원가입

   public void insertMemberWOFile(MemberVO vo);// 빤딱이없는 회원가입

   public boolean loginChk(MemberVO vo); // 회원로그인

   public MemberVO loginMember(MemberVO vo);

   public MemberVO viewMember(MemberVO vo);// 회원 로그인정보

   public void logout(HttpSession session);

   public void changeInfo(MemberVO vo);

   public void deleteMember(int member_id);

   public List<MemberVO> selectAll();

   public String getImgFile(String id);

   public String findIdByName(int idx);

   public int getNamesCount(String name);

   //public int getIdsCount(String name);
   
   public int idCheck(String id);

   public int idOverlapCheck(String id);

   public String checkId(String id);

   public String checkPw(String id, String password);

   public CharSequence count_receive_note(String payload);

   public void signupfranchise(MemberVO vo);

   public void signupfranchisewofile(MemberVO vo);

   public String selectIDwithFranchisekey(String franchisekey);

   public MemberVO checkMember(int idx);

   public MemberVO selectMember(String id);
   
   public void randompw(String id, String pw);

   public List<MemberVO> findid(String name, String email, String phone);
   
   public void infoupdate(MemberVO vo);
}