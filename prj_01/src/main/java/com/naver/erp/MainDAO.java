package com.naver.erp;

import java.util.List;
import java.util.Map;


public interface MainDAO {
	
	int getEmp10();	
	int getEmp20();
	int getEmp30();
	int getEmp40();
	int getEmp50();
	int getEmp60();
	
	
	
	
	
	 Map<String,String> getApprovalTypeCnt( MainDTO mainDTO );   

	

	 Map<String,String>  getRegDeailyBusiTypeCnt( Map<String,String> map );
		
		
	 Map<String,String>  getRegSaleTypeCnt( Map<String,String> map );

	 Map<String,String>  getRegExTypeCnt( Map<String,String> map );
	//******************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//******************************************
	List<Map<String,String>> getBoardList( );

	
	
} //public interface BoardDAO { 끝
