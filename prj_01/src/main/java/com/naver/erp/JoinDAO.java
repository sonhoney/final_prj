package com.naver.erp;

public interface JoinDAO {

	// 회원가입 인설트 적용개수 리턴 받는 메소드  
	int getJoinCnt( JoinDTO joinDTO );
	
    // 회원가입 후 아이디 가져오기 
	String getId( JoinDTO joinDTO );
 
	// 중복된 주민 번호 체크 
	int overlapCheck( JoinDTO joinDTO );
}
