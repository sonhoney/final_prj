package com.naver.erp;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JoinDAOImpl implements JoinDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	

	//===========================================	
	// 회원가입 인설트 적용개수 리턴 받는 메소드  
	//===========================================	
	public int getJoinCnt( JoinDTO joinDTO ) {
		
		int joinCnt = this.sqlSession.insert(
				"com.naver.erp.JoinDAO.getJoinCnt"
				,joinDTO
		);
				
		
	    return joinCnt;
	}
	

	//===========================================	
    // 회원가입 후 아이디 가져오기 
	//===========================================	
	public String getId( JoinDTO joinDTO ) {
		
		String id = this.sqlSession.selectOne(
				"com.naver.erp.JoinDAO.getId"
				,joinDTO
		);
		
		// 회원가입 시 주민번호가 같은 사람이 가입 시 
		// 매퍼에서 결과값이 String 즉 , 하나만 나와야하는데 
		// 2개 이상 나올 시 에러에러...
		
		return id;
	}
	
	

	//===========================================	
	// 중복된 주민 번호 체크 
	//===========================================	
	public int overlapCheck( JoinDTO joinDTO ) {
		
		int overlapCnt = this.sqlSession.selectOne(
				"com.naver.erp.JoinDAO.overlapCheck"
				,joinDTO
		);
		
		return overlapCnt;
	}
	
	
	
}
