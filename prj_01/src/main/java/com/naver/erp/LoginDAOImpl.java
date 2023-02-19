package com.naver.erp;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAOImpl implements LoginDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	

	//===========================================
	// 아이디 암호를 가지고 디비에 있나없나 체크 
	//===========================================
	public int getLoginCheck( Map<String,String> map ) {
		
		int getCnt = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getLoginCheck"
				,map
		);
		
		return getCnt;
	}

	//===========================================
	// 비번을 찾기 위해 아이디 가지고 드가기
	//===========================================
	public String getPwd( Map<String,String> map ) {

		String pwd = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getPwd"
				,map
		);
		
		return pwd;
	}
	
	
	//===========================================
	// 비번찾기 전에 해당 아이디가 디비에 존재하는지 여부 
	//===========================================
	public int exId( Map<String,String> map ) {
		
		int getCnt = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.exId"
				,map
		);
		
		System.out.println( "DAO =>  " + getCnt ); 
		
		return getCnt;
	}	
	


	//===========================================
	// 아이디를 찾기 위해 암호 가지고 드가기 
	//===========================================
	public String getId( Map<String,String> map ) {

		String id = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getId"
				,map
		);
		
		return id;
	}
	
	
	//===========================================
	// 아이디 찾기 전에 해당 암호가 디비에 존재하는지 여부 
	//===========================================
	public int exPwd( Map<String,String> map ) {
		
		int getCnt = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.exPwd"
				,map
		);
		
		System.out.println( "DAO =>  " + getCnt ); 
		
		return getCnt;
	}	
	

	//===========================================
	// 암호 변경 전에 먼저 실존한 아이디 암호 인지 판별 
	//===========================================
	public int getconfirmCnt( Map<String,String> map ) {
		
		int getconfirmCnt = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getconfirmCnt"
				,map
		);
		
		return getconfirmCnt;
	}

	//===========================================
	// 기존에 아이디 암호가 정보가 존재 한다면 암호 변경
	//===========================================
	public int getChangeCnt( Map<String,String> map ) {
		
		int getChangeCnt = this.sqlSession.update(
				"com.naver.erp.LoginDAO.getChangeCnt"
				,map
		);
		
		return getChangeCnt;
	}
	
	

	//===========================================
	// 로그인 성공 시 세션에 회원 이름 박으려고 
	//===========================================
	public String getName( Map<String,String> map ) {
		
		String getName = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getName"
				,map
		);
		
		return getName;
	}


	//****************************************************
	// 관리자인지 확인하기위해 emp_role 받아오기
	//****************************************************
	public String getEmp_role( Map<String,String> map ) {
		
		String getEmp_role = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getEmp_role"
				,map
		);
		
		return getEmp_role;
	}
	

	public String getAllowCode(String uid){

		String allowCode = this.sqlSession.selectOne(
			"com.naver.erp.LoginDAO.getAllowCode"
			,uid
		);

		return allowCode;
	}

	public String getjikupName(String uid){
		String jikup_name = this.sqlSession.selectOne(
			"com.naver.erp.LoginDAO.getjikupName"
			,uid
		);

		return jikup_name ;
	}
	
	
}
