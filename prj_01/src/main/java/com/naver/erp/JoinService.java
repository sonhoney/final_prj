package com.naver.erp;


public interface JoinService {

  // 회원가입 인설트 적용개수 리턴 받는 메소드  
  int getJoinCnt( JoinDTO joinDTO );
	
  // 회원가입 후 바로 아이디 가져오기 
  String getId( JoinDTO joinDTO );
  

}
