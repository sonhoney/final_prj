package com.naver.erp;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDAO loginDAO; 
	
	

	//===========================================
	// 아이디 암호를 넣은 해쉬맵 객체 메위주
	//===========================================
	public int getLoginCheck( Map<String,String> map ) {
		
		int getCnt = this.loginDAO.getLoginCheck( map );
		
		return  getCnt;
	}
	
	
    //===========================================
	// 비번을 찾기 위해 아이디 가지고 드가기
    //===========================================
	public String getPwd( Map<String,String> map ) {
		  
		// ex : existence 존재 의 약어 
		int exIdCnt = this.loginDAO.exId( map );
		System.out.println( "서비스 클래스 아이디 있나없나 개수 =>  " + exIdCnt ); 
		
		// 부등호가 <  이거 일땐 리턴값이 zero 가 아닌 null 로 계속 나왔다.
		// 이유가 무엇일까...?  null 과 0 의 관계에 관한 것일까?!?!?
		
		if( exIdCnt <= 0 ) {
			return "zero";
		}
		
		
		String pwd = this.loginDAO.getPwd( map );
		   
		return pwd;
	}
	
    //===========================================
	// 아이디를 찾기 위해 암호 가지고 드가기
    //===========================================
	public String getId( Map<String,String> map ) {
		  
		// ex : existence 존재 의 약어 
		int exPwdCnt = this.loginDAO.exPwd( map );
		System.out.println( "서비스 클래스 아이디 있나없나 개수 =>  " + exPwdCnt ); 
		
		// 부등호가 <  이거 일땐 리턴값이 zero 가 아닌 null 로 계속 나왔다.
		// 이유가 무엇일까...?  null 과 0 의 관계에 관한 것일까?!?!?
		
		if( exPwdCnt <= 0 ) {
			return "zero";
		}
		
		
		String id = this.loginDAO.getId( map );
		   
		return id;
	}	
	
	
	
	

    //===========================================
	// 비번 변경을 위해 아이디 암호 , 새로운 암호 가져가기 
    //===========================================
	public int getChangeCnt( Map<String,String> map ) {
		
		int confirmCnt =  this.loginDAO.getconfirmCnt( map );
		
		if( confirmCnt <= 0 ) {
			return 0 ;
		}
		
		int changeCnt = this.loginDAO.getChangeCnt( map );
					
		return changeCnt ;
	}
	
	
	

    //===========================================
	// 로그인 치고 성공하면 세션에 회원이름 저장하려고 
    //===========================================
	public String getName( Map<String,String> map ) {

		String getName = this.loginDAO.getName( map );
		
		
		return  getName ;
	}
	
	
	//===========================================
	// 관리자인지 확인하기위해 emp_role 받아오기
    //===========================================
	public String getEmp_role( Map<String,String> map ) {

		String getEmp_role = this.loginDAO.getEmp_role( map );
		
		
		return  getEmp_role ;
	}
	
	
	public String getAllowCode(String uid) {

		String allowCode = this.loginDAO.getAllowCode(uid) ;
		
		return  allowCode ;
	}

	public String getjikupName(String uid){
		String jikup_name = this.loginDAO.getjikupName(uid);
		
		return jikup_name ;
	}
	
	
	
	
}
