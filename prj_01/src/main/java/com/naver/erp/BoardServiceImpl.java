package com.naver.erp;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BoardServiceImpl implements BoardService {
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// BoardDAO 인터페이스 구현한 클래스를 찾아서 객체화 해서  속변 boardDAO 에 객체의 메위주를 저장.
	// BoardDAO 인터페이스 구현한 클래스를 찾을때 그 클래스의 이름은 무었이든 상관없다.
	// 단 BoardDAO 인터페이스 구현한 클래스는 한개만 만들어야한다.
	// <주의> 관용적으로 클래스 이름에 DAO 가 들어 있으면 직접 DB 연동을 하는 메소드를 소유한 클래스이다.
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@Autowired
	private BoardDAO  boardDAO;
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int insertBoard( BoardDTO boardDTO) {
		System.out.println("보드서비스 insertBoard 시작");
		
		//*********************************************
		// BoardDAOImpl 객체의  insertBoard 메소드 호출하여 게시판 글 입력 후 입력 적용 행의 개수 얻기
		//*********************************************
		int boardRegCnt = this.boardDAO.insertBoard(boardDTO);
		//*********************************************
		// 1개 게시판 글 입력 적용 행의 개수 리턴하기
		//*********************************************
		System.out.println("보드서비스 insertBoard 끝");
		return boardRegCnt;
		
	}
	
	
	
	
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판 글] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public BoardDTO getBoard(int b_no , boolean isBoardDetailForm ) {
		//System.out.println("보드서비스 getBoard");
		
		if( isBoardDetailForm ) {
			//------------------------------------------
			// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
			// [조회수 증가]하고 수정한 행의 개수를 얻는다
			//------------------------------------------
			int updateCount = this.boardDAO.updateReadcount(b_no);
			//System.out.println("보드서비스 updateReadcount 호출해 조회수 증가");
			//------------------------------------------
			// [조회수 증가]하고 수정한 행의 개수가 0개면, 즉 삭제되어서 없다면
			//------------------------------------------
			if( updateCount==0 ) { return null;} 
		}
		
		//------------------------------------------
		//BoardDAOImpl 객체의 getBoard 메소드를 호출하여
		// [1개 게시판 글]을 얻는다
		//------------------------------------------
		BoardDTO board = this.boardDAO.getBoard(b_no);
		//System.out.println("보드서비스 getBoard 호출해 [1개 게시판 글]을 얻기");
		//------------------------------------------
		// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
		//------------------------------------------
		//System.out.println( "BoardServiceImpl.getBoard 메소 호출 종료!");
		//System.out.println("보드서비스 getBoard 끝");
		return board;
	}

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int updateBoard(BoardDTO boardDTO) {
		//System.out.println("보드서비스 updateBoard1");		
		//----------------------------------
		// 수정할 게시판의 개수 얻기
		// 만약 수정할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
		//----------------------------------
		int boardCnt = this.boardDAO.getBoardCnt( boardDTO.getB_no() );
		//System.out.println("보드서비스 updateBoard2");	
		if( boardCnt==0 ) {
			return 0;
		}
		
		
		//----------------------------------
		// 수정 실행하고 수정 적용행의 개수 얻기
		//----------------------------------
		int updateBoardCnt = this.boardDAO.updateBoard( boardDTO );
		//System.out.println("보드서비스 updateBoard3");	
		//----------------------------------
		// 수정 실행하고 수정 적용행의 개수 리턴하기
		//----------------------------------
		//System.out.println("보드서비스 updateBoard 끝");
		return updateBoardCnt;
	}


	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int deleteBoard(BoardDTO boardDTO) {
		//System.out.println("보드서비스 deleteBoard");
		//----------------------------------
		// 삭제할 게시판의 개수 얻기
		// 만약 삭제할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
		//----------------------------------
		int boardCnt = this.boardDAO.getBoardCnt( boardDTO.getB_no() );
		if( boardCnt==0 ) {
			return 0;
		}
		
		
		//----------------------------------
		// 삭제 실행하고 삭제 적용행의 개수 얻기
		//----------------------------------
		int deleteBoardCnt = this.boardDAO.deleteBoard( boardDTO );
		//System.out.println("보드서비스 deleteBoard 끝");
			return deleteBoardCnt;
			
		}

		
	
	
	
	
	
} //public class BoardServiceImpl implements BoardService { 끝
















/*
	//[1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	int deleteBoard(BoardDTO boardDTO) {
		return;
	}
	
	//[1개 게시판 글] 리턴하는 메소드 선언
	BoardDTO getBoardDTO(int b_no) {
		return;		
	}
	
	//조회수 증가 없이 [수정/삭제 할 1개의 게시판 글 정보] 리턴하는 메소드 선언
	BoardDTO getBoardDTO_without_upReadcount(int b_no) {
		return;		
	}
	
	//검색한 게시판 목록] 리턴하는 메소드 선언
	List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO){
		return;		
	}
	
	//[검색한 게시판 목록 개수] 리턴하는 메소드 선언
	int getBoardListAllCnt(BoardSearchDTO boardSearchDTO) {
		return;		
	}

	//[1개 게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	int insertBoard(BoardDTO boardDTO) {
		return;		
	}

	//[1개 게시판] 수정 후 수정 적용행의 개수를 리턴하는 메소드 선언
	int updateBoard(BoardDTO boardDTO) {
		return;		
	}

}
*/