package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{
   
   @Autowired
   private SqlSession sqlSession;

   @Override
   public void insertMember(MemberVO vo) {
      sqlSession.insert("com.project.mapper.MemberMapper.insertMember",vo);
   }

   @Override
   public void insertMemberWOFile(MemberVO vo) {
      sqlSession.insert("com.project.mapper.MemberMapper.insertMemberNoFile",vo);
      
   }
   
   @Override
   public int idOverlapCheck(String id) {
      int idCheck = sqlSession.selectOne("com.project.mapper.MemberMapper.idOverlapCheck", id);
      return idCheck;
   }

   @Override
   public String checkId(String id) {
      return sqlSession.selectOne("com.project.mapper.MemberMapper.CheckId", id); // 일치하는 ID 반환
   }

   @Override
   public String checkPw(String id, String password) {
      Map<String, String> map  = new HashMap<String, String>();
      map.put("id",id);
      map.put("password",password);
      return sqlSession.selectOne("com.project.mapper.MemberMapper.CheckPw",map); // 일치하는 Password 반환
   }

   @Override
   public boolean loginChk(MemberVO vo) {
      String name = sqlSession.selectOne("com.project.mapper.MemberMapper.loginChk",vo); //id와 pw에상응하는 유저의 속성값하나를 임의로찝음
      return (name == null)? false :true;
   }

   @Override
   public MemberVO viewMember(MemberVO vo) {
      return sqlSession.selectOne("com.project.mapper.MemberMapper.viewMember", vo);
   }

   @Override
   public void logout(HttpSession session) {
      session.removeAttribute("id");
      session.removeAttribute("pw");
      
   }

   @Override
   public void changeInfo(MemberVO vo) {
      sqlSession.update("com.project.mapper.MemberMapper.modifyMember",vo);
      
   }

   @Override
   public void deleteMember(int member_id) {
      sqlSession.delete("com.project.mapper.MemberMapper.deleteMember",member_id);      
   }


   @Override
   public MemberVO loginMember(MemberVO vo) {
      MemberVO member = sqlSession.selectOne("com.project.mapper.MemberMapper.loginMember",vo);
      return member;
   }


   @Override
   public List<MemberVO> selectAll() {
      return sqlSession.selectList("com.project.mapper.MemberMapper.selectAllMember");
   }


   @Override
   public String getImgFile(String id) {
      //List<String> images = sqlSession.selectList("com.jh.mapper.MemberMapper.findImgs");
      try {
         String imgFileName = sqlSession.selectOne("com.project.mapper.MemberMapper.findImgfile",id); // null
         
         if(imgFileName == null) {
            System.out.println("img null임.");
            return "";
         }else {
            return imgFileName;
         }
      }catch(Exception e) {
         e.getCause();
      }
      
      return "";
      
   }


   @Override
   public CharSequence count_receive_note(String payload) {
      return null;
   }


   @Override
   public String findIdByName(int idx) {
      //Map<String, String> map = new HashMap<String, String>();
      //map.put("name", name);
      //map.put("brand", brand);
      return sqlSession.selectOne("com.project.mapper.MemberMapper.findIdByIdx",idx);
   }


   @Override
   public void signupfranchise(MemberVO vo) {
      sqlSession.insert("com.project.mapper.MemberMapper.insertfranchise",vo);
      
   }


   @Override
   public void signupfranchisewofile(MemberVO vo) {
      sqlSession.insert("com.project.mapper.MemberMapper.insertfranchiseWOfile",vo);
      
   }


   @Override
   public int getNamesCount(String name) {
      return sqlSession.selectOne("com.project.mapper.MemberMapper.getNamesCount", name);
   }


   @Override
   public String selectIDwithFranchisekey(String franchisekey) {
      return sqlSession.selectOne("com.project.mapper.MemberMapper.selectIDWithFranchiseKey",franchisekey);
   }

   @Override
   public MemberVO checkMember(int idx) {
      Map<String, Integer> map = new HashMap<String, Integer>();
      map.put("idx", idx);
      
      return sqlSession.selectOne("com.project.mapper.MemberMapper.checkMember", map);
   }

   @Override
   public MemberVO selectMember(String id) {
      Map<String, String> map = new HashMap<String, String>();
      map.put("id", id);
      
      return sqlSession.selectOne("com.project.mapper.MemberMapper.selectMember", map);
   }
   
   @Override
   public void randompw(String id, String pw) {
      Map<String, String> map = new HashMap<String, String>();
      map.put("id", id);
      map.put("password", pw);
      sqlSession.update("com.project.mapper.MemberMapper.randompw", map);
      
   }

   @Override
   public List<MemberVO> findid(String name, String email, String phone) {
      Map<String, String> map = new HashMap<String, String>();
      map.put("name", name);
      map.put("email", email);
      map.put("phone", phone);
      return sqlSession.selectList("com.project.mapper.MemberMapper.findid", map);
   }
   
   @Override
   public void infoupdate(MemberVO vo) {
      sqlSession.update("com.project.mapper.MemberMapper.infoupdate", vo);
   }

   @Override
   public int idCheck(String id) {
      int result = sqlSession.selectOne("com.project.mapper.MemberMapper.idCheck", id);
      return result;
   }
   
}