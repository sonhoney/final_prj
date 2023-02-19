package com.naver.erp;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MypageServiceImpl implements MypageService{
	
	@Autowired
	private MypageDAO  mypageDAO;
	
	@Autowired
	private EmployeeDAO  employeeDAO;
	

	
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판 글] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public EmployeeDTO getMypage(int emp_no) {
		System.out.println( "MypageServiceImpl.getMypage 메소 호출 시작!");

		
		//------------------------------------------
		//BoardDAOImpl 객체의 getBoard 메소드를 호출하여
		// [1개 게시판 글]을 얻는다
		//------------------------------------------
		//EmployeeDTO mypage = this.mypageDAO.getMypage(emp_no);
		EmployeeDTO mypage = this.employeeDAO.getEmployee(emp_no);

		//------------------------------------------
		// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
		//------------------------------------------
		System.out.println( "MypageServiceImpl.getMypage 메소 호출 종료!");
		return mypage;
	}
	
	
	
	//m
		
			
		

	/*
	//[로그인한 직원 정보 수정 후 적용행의 개수]를 리턴하는 메소드 선언
	public int updatePage(EmployeeDTO employeeDTO) {
		
	}
	
	//[로그인한 직원의 정보]를 리턴하는 메소드 선언
	public EmployeeDTO getEmployeeDTO(String emp_no) {
		
	}
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	

}
