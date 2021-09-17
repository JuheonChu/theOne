package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO{

	@Autowired
	private SqlSession sqlSession;
	
	/*게시글 작성ㄷ*/
	@Override
	public void write(BoardVO vo) {
		
		sqlSession.insert("com.project.mapper.BoardMapper.insert", vo);
		//
		
	}

	@Override
	public List<BoardVO> selectList() {
		//BoardVO bvo = new BoardVO("테스트 작가999", "테스트제목938", "Test내용478");
		return sqlSession.selectList("com.project.mapper.BoardMapper.selectAll");
		//com.jh.vo.BoardVO
		//sqlSession.selectList(statement, parameter)
	}
	
	@Override
	public List<BoardVO> selectAll2(int size, int offset){
		Map <String, Integer> map = new HashMap<String, Integer>();
		map.put("size", size);
		map.put("offset", offset);
		return sqlSession.selectList("com.project.mapper.BoardMapper.selectAll2", map);
	}

	/*게시글 삭제*/
	@Override
	public void deleteBoard(int bno) {
		sqlSession.delete("com.project.mapper.BoardMapper.deleteBoard",bno);
		
	}

	/*게시글 수정*/
	@Override
	public void updateBoardWOFile(BoardVO vo) {
		sqlSession.update("com.project.mapper.BoardMapper.updateBoardWOFile",vo);
		
	}
	
	/*게시글수정2 */
	@Override
	public void updateBoardWithFile(BoardVO vo) {
		sqlSession.update("com.project.mapper.BoardMapper.updateBoardWithFile",vo);
		
	}
	
	
	
	/*조회수 증가*/
	@Override
	public void increaseViewCount(int bno) {
		sqlSession.update("com.project.mapper.BoardMapper.increaseviewcount",bno);
		
	}
	/*상세보기*/
	@Override
	public BoardVO read(int bno) {
		return sqlSession.selectOne("com.project.mapper.BoardMapper.view", bno);
	}

	@Override
	public int getMaxBno(BoardVO vo) {
		return sqlSession.selectOne("com.project.mapper.BoardMapper.bnoMax",vo);
	}

	//부모 게시글의 ref을 얻어옵니다.
	@Override
	public int getParentBoardRef(BoardVO vo) {
		return sqlSession.selectOne("com.project.mapper.BoardMapper.getBoardReplyInfo", vo);
	}

	@Override
	public void addComment(BoardVO vo) {
		sqlSession.update("com.project.mapper.BoardMapper.updateReply", vo);//step = step +1
		//updateBoardReplyStepLevel
		sqlSession.insert("com.project.mapper.BoardMapper.insertBoardReply", vo);//level, step +1씩 시켜주고 insert
		//sqlSession.insert("",vo);
		
	}

	@Override
	public String getImgFileByWriter(String writer, int bno) { // 사용자의 id를넣어서 그사용자의 membertable 빤딱이 컬럼값을알아낸다.
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			//Integer 
			map.put("writer",writer);
			map.put("bno", bno);
			
			String imgName = sqlSession.selectOne("com.project.mapper.BoardMapper.findImgbyWriterID", map);
			return imgName;
		}catch(Exception e) {
			System.out.println(e.getCause());
		}
		return null;
		
	}

	
	

}
