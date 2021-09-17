package com.project.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MemberDAO;
import com.project.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

   @Autowired
   MemberDAO dao;

   public MemberServiceImpl() {

   }

   public MemberServiceImpl(MemberDAO dao) {
      this.dao = dao;
   }

   @Override
   public void signup(MemberVO vo) {
      dao.insertMember(vo);
   }
   
   @Override
   public void signupWOFile(MemberVO vo) {
      dao.insertMemberWOFile(vo);
      
   }

   @Override
   public boolean loginChk(MemberVO vo, HttpSession session) {
      //System.out.println("여기서 iBatisException이 뜹니다.");
      boolean result = dao.loginChk(vo);
      if(result) {
         MemberVO temp = viewMember(vo);
         
         session.setAttribute("userid", temp.getId());
         session.setAttribute("userpw", temp.getPassword());
         session.setAttribute("userno", temp.getIdx());
      }
      return result;
   }
   
   @Override
   public boolean loginChkWithImg(MemberVO vo, HttpSession session) {
      //System.out.println("여기서 iBatis Exception이뜰거임");
      MemberVO loginMember = dao.loginMember(vo);
      boolean result = dao.loginChk(loginMember);
      if(result) {
         MemberVO temp = loginMember;
         //System.out.println("파일명 존재 : MemberServiceImpl: " + temp.getFilename());
         session.setAttribute("userid", temp.getId());
         session.setAttribute("userpw", temp.getPassword());
         session.setAttribute("userno", temp.getPassword());
         session.setAttribute("useremoji",temp.getFilename());
         session.setAttribute("member", loginMember);
      
      }
      return result;
   }

   @Override
   public MemberVO viewMember(MemberVO vo) {
      return dao.viewMember(vo);
   }

   @Override
   public void logout(HttpSession session) {
      session.invalidate();

   }

   @Override
   public void changeInfo(MemberVO vo) {
      dao.changeInfo(vo);
      
   }

   @Override
   public void deleteMember(int member_id) {
      //dao.deleteMember(member_id);
      dao.deleteMember(member_id);
      
   }

   @Override
   public List<MemberVO> selectAll() {
      return dao.selectAll();
   }

   @Override
   public String hasImgFile(String id) {
      return dao.getImgFile(id);
   }

   @Override
   public int idOverlapCheck(String id) {
      return dao.idOverlapCheck(id);
   }

   @Override
   public boolean checkId(String id) {
      if(dao.checkId(id)!=null) {
         return true;
      } else {
         return false;
      }
      
   }

   @Override
   public boolean checkPw(String id, String password) {
      if(dao.checkPw(id, password)!=null) {
         return true;
      } else {
         return false;
      }
   }

   @Override
   public String findIdByIdx(int idx) {
      return dao.findIdByName(idx);
   }

   @Override
   public void signupfranchise(MemberVO vo) {
      dao.signupfranchise(vo);
      
   }

   @Override
   public void signupfranchisewofile(MemberVO vo) {
      dao.signupfranchisewofile(vo);
      
   }

   @Override
   public int getNamesCount(String name) {
      return dao.getNamesCount(name);
   }

   @Override
   public String selectIDWithFranchisekey(String franchisekey) {
      return dao.selectIDwithFranchisekey(franchisekey);
   }

   @Override
   public MemberVO checkMember(int idx) {
      
      return dao.checkMember(idx);
   }

   @Override
   public MemberVO selectMember(String id) {
      return dao.selectMember(id);
   }
   
   @Override
   public List<MemberVO> findid(String name, String email, String phone) {
      return dao.findid(name, email, phone);
   }

   @Override
   public void infoupdate(MemberVO vo) {
      dao.infoupdate(vo);
   }

   @Override
   public int idCheck(String id) {
      int result = dao.idCheck(id);
      return result;
   }
}