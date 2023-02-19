package com.naver.erp;

import java.util.Map;

public interface MypageService {
	
	//****************************************************
	// [1개 게시판 글] 리턴하는 메소드 선언
	//****************************************************
	EmployeeDTO getMypage( int emp_no);

	//mypageUpProc.do
	//int updateMypage(Map<String, String> mypage);
	
	

	
	/*
	//[로그인한 직원 정보 수정 후 적용행의 개수]를 리턴하는 메소드 선언
	public int updatePage(EmployeeDTO employeeDTO) ;
	//[로그인한 직원의 정보]를 리턴하는 메소드 선언
	public EmployeeDTO getEmployeeDTO(String emp_no) ;
	*/
}
