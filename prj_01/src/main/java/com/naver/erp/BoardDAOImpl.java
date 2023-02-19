package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO{

	//+++++++++++++++++++++++++++++++++++++++
	// SqlSessionTemplate 객체를 생성해 속변 sqlSession 에 저장
	// @Autowired 어노테이션을 붙이면 속성변수 자료형에 맞는 SqlSessionTemplate 객체를 생성한 후 
	// 객체의 메위주를 속성변수 저장한다.
	//----------------------------------------
	// SqlSessionTemplate 객체의 기능
	//----------------------------------------
		// DB 연동 시 사용하는 객체이다.
		// xml 파일에 있는 SQL 구문을 읽어서 DB 에 SQL 명령을 내린 후
		// 그 결과값을 받아오는 객체이다. 그렇게 해주는 메소드가 존재한다.
	//+++++++++++++++++++++++++++++++++++++++
	@Autowired
	private SqlSessionTemplate sqlSession;


	//******************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//******************************************
	public List<Map<String,String>> getBoardList( BoardSearchDTO boardSearchDTO ){
		
		//------------------------------------------------------------
		// SqlSessionTemplate 객체의 selectList 메소드 호출로 
		// n행m열의 게시판 글을 List<Map<String,String>> 로 받아오기
		//------------------------------------------------------------
		List<Map<String,String>> boardList = this.sqlSession.selectList(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.getBoardList"
					//--------------------------------------
					// 위에서 말하는 SQL 구문위치는 
					// *.xml 파일 내부의 아래와 같은 곳에 있다.
					//--------------------------------------
					// <mapper namespace="com.naver.erp.BoardDAO">
					//    <select id="getBoardList"> select구문 </select>
					// </mapper>
					//--------------------------------------
			    ,  boardSearchDTO
		
		);

		/*List<Map<String,String>> boardList = new ArrayList<String,String>();
		Map<String,String> map1 = new HashMapMap<String,String>();
		map1.put("b_no",1);
		map1.put("subject","제목1");
		map1.put("content","내용1");
		map1.put("writer","작성자1");

		boardList.add(map1);

		Map<String,String> map2 = new HashMapMap<String,String>();
		map2.put("b_no",2);
		map2.put("subject","제목2");
		map2.put("content","내용2");
		map2.put("writer","작성자2");

		boardList.add(map2);*/


		return boardList;
	}
	


	//******************************************
	// [검색한 게시판 목록]의 총개수 리턴하는 메소드 선언
	//******************************************
	public int  getBoardListTotCnt( BoardSearchDTO boardSearchDTO ) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [검색한 게시판 목록]의 총개수 얻기
		// selectOne 은 1행 m열의 select 결과를 얻을 때 사용하는 메소드이다.
		//-------------------------------------------------------
		int boardListTotCnt = this.sqlSession.selectOne(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.getBoardListTotCnt"	
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------  
				,boardSearchDTO		
		);
		return boardListTotCnt;
	}

	


	//******************************************
	// [검색한 게시판 목록]의 총개수 리턴하는 메소드 선언
	//******************************************
	public int  getBoardListAllTotCnt(  ) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [게시판 목록]의 총개수 얻기
		// selectOne 은 1행 m열의 select 결과를 얻을 때 사용하는 메소드이다.
		//-------------------------------------------------------
		int boardListAllTotCnt = this.sqlSession.selectOne(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.getBoardListAllTotCnt"	
		);
		return boardListAllTotCnt;
	}
	
	
	
	
	
	//****************************************************
	// [게시판 글 입력 후 입력 적용 행의 개수]를 리턴하는 메소드 선언
	//****************************************************
	public int insertBoard(BoardDTO boardDTO) {
		//------------------------------------------------------------
		// SqlSessionTemplate 객체의 insert 메소드 호출로 
		// 게시판 글 입력 SQL 구문을 실행하고 입력 성공 행의 개수얻기
		//------------------------------------------------------------
		int boardRegCnt = sqlSession.insert(		
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.insertBoard"
				
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,boardDTO
				
		);
		return boardRegCnt;
	}
	

	//****************************************************
	// [게시판 글 출력번호 1 증가하고 수정 행의 개수] 리턴하는 메소드 선언
	//****************************************************
	public int updatePrintNo(BoardDTO boardDTO) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여
		// [게시판 글 출력번호 1 증가하고 수정 행의 개수] 얻기
		//-------------------------------------------------------
		int updatePrintNoCnt = sqlSession.update(
				"com.naver.erp.BoardDAO.updatePrintNo"		// 실행할 SQL 구문의 위치 지정
				,boardDTO									// 실행할 SQL 구문에서 사용할 데이터 지정
		);
		//-------------------------------------------------------
		// [수정 행의 개수] 리턴하기
		//-------------------------------------------------------
		return updatePrintNoCnt;
	}
	
	
	//******************************************
	// [게시판 글] 내용을 비우는 , 즉 비우는 업데이트를 하는 메소드 선언
	//******************************************
	public int updateBoardEmpty( BoardDTO boardDTO ){
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 [조회수 증가]하기
		//-------------------------------------------------------
		int updateCount = this.sqlSession.update(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.updateBoardEmpty"
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,boardDTO				
		);
		return updateCount;
	}
	

	//******************************************
	// 삭제될 게시판글의 동생 글의 출력 순서번호를 1씩 감소 시키기
	//******************************************
	public int updatePrintNoDown( BoardDTO boardDTO ){
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 
		// 삭제될 게시판글의 동생 글의 출력 순서번호를 1씩 감소 시키기
		//-------------------------------------------------------
		int updatePrintNoDownCount = this.sqlSession.update(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.updatePrintNoDown"
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,boardDTO				
		);
		return updatePrintNoDownCount;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	//****************************************************
	// [게시판 글 조회수 증가하고 수정행의 개수] 리턴하는 메소드 선언
	//****************************************************
	public int updateReadcount(int b_no) {
		//System.out.println( "BoardDAOImpl.updateReadcount 메소 호출 시작!");
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 [조회수 증가]하기
		//-------------------------------------------------------
		int updateCount = this.sqlSession.update(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.updateReadcount"
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,b_no				
		);
		//System.out.println( "BoardDAOImpl.updateReadcount 메소 호출 종료!");
		return updateCount;
	}
	
	//****************************************************
	// [1개 게시판 글 정보] 리턴하는 메소드 선언
	//****************************************************
	public BoardDTO getBoard(int b_no) {
		//System.out.println( "BoardDAOImpl.getBoard 메소 호출 시작!");
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [1개 게시판 글 정보] 얻기
		// selectOne 은 1행 m열의 select 결과를 얻을 때 사용하는 메소드이다.
		//-------------------------------------------------------
		BoardDTO board = this.sqlSession.selectOne(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.getBoard"	
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,b_no		
		);
		//System.out.println( board );
		//-------------------------------------------------------
		// [1개 게시판 글 정보] 리턴하기
		//-------------------------------------------------------
		//System.out.println( "BoardDAOImpl.getBoard 메소 호출 종료!");
		return board;		
		
	}

	//****************************************************
	// 삭제/수정할 게시판의 존재 개수를 리턴하는 메소드 선언
	//****************************************************
	public int getBoardCnt(int b_no) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [게시판의 존재 개수] 얻기
		//-------------------------------------------------------
		int boardCnt = this.sqlSession.selectOne(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.getBoardCnt" 
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,b_no							        
		);
		return boardCnt;
	}
	
	//****************************************************
	// 삭제/수정할 게시판의 비밀번호 존재 개수를 리턴하는 메소드 선언
	//****************************************************
	public int getBoardPwdCnt(BoardDTO boardDTO) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [비밀번호 존재 개수] 얻기
		//-------------------------------------------------------
		int boardPwdCnt = this.sqlSession.selectOne(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.getBoardPwdCnt" // 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,boardDTO							   
		);
		return boardPwdCnt;
	}
	
	//****************************************************
	// 게시판 수정 후 수정행의 적용 개수를 리턴하는 메소드선언
	//****************************************************
	public int updateBoard(BoardDTO boardDTO) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 
		// [게시판 수정 명령]한 후 수정 적용행의 개수얻기
		//-------------------------------------------------------
		int updateBoardCnt = this.sqlSession.update(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.updateBoard"
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,boardDTO							     
		);
		return updateBoardCnt;
	}
	
	//****************************************************
	// 게시판 삭제 명령한 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	public int deleteBoard(BoardDTO boardDTO) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 delete(~,~) 를 호출하여 
		// [게시판 삭제 명령]한 후 삭제 적용행의 개수얻기
		//-------------------------------------------------------
		int deleteBoardCnt = this.sqlSession.delete(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.BoardDAO.deleteBoard"
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,boardDTO							     
		);
		return deleteBoardCnt;
	}
	
}





















