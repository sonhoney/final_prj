package com.naver.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class JoinServiceImpl implements JoinService{
     
	// [속성변수] 
	//-----------------------------------------------
	@Autowired
	private JoinDAO joinDAO; 

	
	//-----------------------------------------------
	
  //===========================================	
  // 회원가입 인설트 적용개수 리턴 받는 메소드  
  //===========================================	
   public int getJoinCnt( JoinDTO joinDTO ) {
	   
	   // 아이디 가져오기 전 이미 같은 주민이 있는 지 체크 
	   // 테이블 설계 시 제약조건에 unique 가 없어서 이렇게 합니다.
	   int cnt =  this.joinDAO.overlapCheck( joinDTO );
	   if( cnt > 0 ) { return 2 ; }
	   
	   int joinCnt = this.joinDAO.getJoinCnt( joinDTO );
	   
	   return joinCnt;
   }
	

   //===========================================	
   // 회원가입 후 바로 아이디 가져오기 
   //===========================================	
   public String getId( JoinDTO joinDTO ) {
   
	   // 아이디 가져오는 메소드 호출 
	   String id = this.joinDAO.getId( joinDTO );
	   
	   return id;
   }
   


   
   
}
