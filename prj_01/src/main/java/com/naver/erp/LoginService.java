package com.naver.erp;

import java.util.Map;

public interface LoginService {

    // 아이디 암호를 넣은 해쉬맵 객체 메위주
	int getLoginCheck( Map<String,String> map );  
	
	
	// 비번을 찾기 위해 아이디 가지고 드가기
	String getPwd( Map<String,String> map );
	
	
	// 비번 변경을 위해 아이디 암호 , 새로운 암호 가져가기 
	int getChangeCnt( Map<String,String> map );
	
	
	// 로그인 치고 성공하면 세션에 회원이름 저장하려고 
	String getName( Map<String,String> map );
	
	
	// 암호를 가지고 가서 해당 암호의 아이디를 가져오기 
	String getId( Map<String,String> map );

	//****************************************************
	// 관리자 인지 확인 하기위 emp_role 받아오기
	//****************************************************
	String getEmp_role( Map<String,String> map );

	// 승인 여부를 가져오는 메소드
	String getAllowCode(String uid) ;

	// 직급 가져오는 메소드
	String getjikupName(String uid) ;
	
}
