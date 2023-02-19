package com.naver.erp;

import java.util.List;
import java.util.Map;


public interface MypageDAO {
	
	//[로그인한 직원 정보 수정 후 적용행의 개수]를 리턴하는 메소드 선언
	
	

	
	 //[로그인한 직원의 정보를]를 리턴하는 메소드 선언
	Map<String,String> getMypage(String uid);

	//[로그인한 직원의 정보를]를 리턴하는 메소드 선언
	//Map<String,String> getMypage(int uid);
	
	
} 
