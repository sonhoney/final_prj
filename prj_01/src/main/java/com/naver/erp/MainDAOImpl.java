package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MainDAOImpl implements MainDAO{

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

	public int getEmp10() {
		
		int getEmp10 = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getEmp10"
		);
		
		return getEmp10 ;
	}
	public int getEmp20(){
		
		int getEmp20 = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getEmp20"
		);
		
		return getEmp20 ;
	}
	public int getEmp30(){
		
		int getEmp30 = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getEmp30"
		);
		
		return getEmp30 ;
	}
	public int getEmp40(){
		
		int getEmp40 = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getEmp40"
		);
		
		return getEmp40 ;
	}
	public int getEmp50(){
		
		int getEmp50 = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getEmp50"
		);
		
		return getEmp50 ;
	}
	public int getEmp60(){
		
		int getEmp60 = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getEmp60"
		);
		
		return getEmp60 ;
	}
	
	
	
	
	public  Map<String,String> getApprovalTypeCnt( MainDTO mainDTO ){
		
		System.out.println( "메인DAO =>" + mainDTO.getR_num() 
		+ mainDTO.getUid() );
		
		 Map<String,String> getATCnt = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getApprovalTypeCnt"
				 ,mainDTO
		);
		
		return getATCnt ;
	}  
	
	
	
	
	public  Map<String,String>  getRegDeailyBusiTypeCnt( Map<String,String> map ){
		
//		System.out.println( "메인DAO =>" + dashboardDTO.getR_num() 
//		+ dashboardDTO.getUid() );
		
		 Map<String,String> getRegDeailyBusiTypeCnt = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getRegDeailyBusiTypeCnt"
				 ,map
		);
		
		return getRegDeailyBusiTypeCnt ;
	}
	
	
	
	public  Map<String,String>  getRegSaleTypeCnt( Map<String,String> map ){
		

		
		 Map<String,String> getRegSaleTypeCnt = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getRegSaleTypeCnt"
				 ,map
		);
		
		return getRegSaleTypeCnt ;
	}
	
	
	

	public  Map<String,String>  getRegExTypeCnt( Map<String,String> map ){
		

		
		 Map<String,String> getRegExTypeCnt = this.sqlSession.selectOne(
				"com.naver.erp.MainDAO.getRegExTypeCnt"
				 ,map
		);
		
		return getRegExTypeCnt ;
	}
	//******************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//******************************************
	public List<Map<String,String>> getBoardList(  ){
		
		//------------------------------------------------------------
		// SqlSessionTemplate 객체의 selectList 메소드 호출로 
		// n행m열의 게시판 글을 List<Map<String,String>> 로 받아오기
		//------------------------------------------------------------
		List<Map<String,String>> boardList = this.sqlSession.selectList(
				//-----------------------------------------
				// 실행할 SQL 구문의 위치 지정
				//-----------------------------------------
				"com.naver.erp.MainDAO.getBoardList"
					//--------------------------------------
					// 위에서 말하는 SQL 구문위치는 
					// *.xml 파일 내부의 아래와 같은 곳에 있다.
					//--------------------------------------
					// <mapper namespace="com.naver.erp.BoardDAO">
					//    <select id="getBoardList"> select구문 </select>
					// </mapper>
					//--------------------------------------
		
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
	
	
	
	
	


	
}





















