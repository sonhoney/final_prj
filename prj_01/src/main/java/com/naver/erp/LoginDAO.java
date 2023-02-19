package com.naver.erp;

import java.util.Map;

public interface LoginDAO {

	// 아이디 암호를 가지고 디비에 있나없나 체크 
	int getLoginCheck( Map<String,String> map );
	
	
	
	// <세트 바리>
	//==================================================
	
	// 비번을 찾기 위해 아이디 가지고 드가기
	String getPwd( Map<String,String> map );
	
	// 비번찾기 전에 해당 아이디가 디비에 존재하는지 여부 
	int exId( Map<String,String> map );
	
	// 아이디를 찾기 위해 암호 가지고 드가기 
	String getId( Map<String,String> map );
	
	// 아이디 찾기 전에 해당 암호가 디비에 존재하는지 여부 
	int exPwd( Map<String,String> map );
	
	//==================================================
	
	// 암호 변경 전에 먼저 실존한 아이디 암호 인지 판별 
	int getconfirmCnt( Map<String,String> map );
	
	// 기존에 아이디 암호가 정보가 존재 한다면 암호 변경
	int getChangeCnt( Map<String,String> map );
	
	// 로그인 성공 시 세션에 회원 이름 박으려고 
	String getName( Map<String,String> map );
	
	//****************************************************
	// 관리자인지 확인하기위해 emp_role 받아오기
	//****************************************************
	String getEmp_role( Map<String,String> map );
	
	// 승인여부를 가져오는 메소드 
	String  getAllowCode(String uid) ;
	
	// 직급을 가져오는 메소드
	String getjikupName(String uid) ;
}
