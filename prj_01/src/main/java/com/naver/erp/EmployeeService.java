package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface EmployeeService {


	//****************************************************
	// [1개 게시판 글] 리턴하는 메소드 선언
	//****************************************************
	//EmployeeDTO getEmployee( int emp_no, boolean isEmployeeDetailForm);

	EmployeeDTO getEmployee( int emp_no);
	

	//****************************************************
	// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	int updateEmp(EmployeeDTO employeeDTO);

	//****************************************************
	// [1개 게시판] 삭제 실행하고 삭제 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	int deleteEmp(EmployeeDTO employeeDTO);

	List<Map<String,String>> getMgrList (EmployeeDTO employeeDTO) ;

	//****************************************************
	// 사번 중복체크하고 중복 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	int check_emp_no(EmployeeDTO employeeDTO);

	
} //public interface EmployeeService { 끝
