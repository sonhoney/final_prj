package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAOImpl implements MypageDAO{

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



	
	
	//****************************************************
	// [로그인한 직원 정보]를 리턴하는 메소드 선언
	//****************************************************
	public Map<String,String> getMypage(String uid) {
		System.out.println( "MypageDAOImpl.getEmployeeDTO 메소드 호출 시작!");
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [1개 게시판 글 정보] 얻기
		// selectOne 은 1행 m열의 select 결과를 얻을 때 사용하는 메소드이다.
		//-------------------------------------------------------
		Map<String,String> getMypage = this.sqlSession.selectOne(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.MypageDAO.getMypage"	
				//-----------------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-----------------------------------------
				,uid		
		);
		System.out.println( getMypage );
		//-------------------------------------------------------
		// [1개 게시판 글 정보] 리턴하기
		//-------------------------------------------------------
		System.out.println( "MypageDAOImpl.getEmployeeDTO 메소드 호출 종료!");
		return getMypage;		
		
	}
/*
	
	//****************************************************
	// 수정할 게시판의 비밀번호 존재 개수를 리턴하는 메소드 선언
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
	
	*/
}





















