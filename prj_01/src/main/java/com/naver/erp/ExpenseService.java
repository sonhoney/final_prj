package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface ExpenseService {
	
	//[1개의 지출보고서 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int first_insertExpenseReport(ExpenseDTO expenseDTO);	
	
	// 지출보고서 리스트를 받아오는 메소드
	List<Map<String,String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO);
	
	// 선택한 지출보고서 상세정보를 담아오는 메소드 
	ExpenseDTO getBoard(int report_no,int emp_no2,int report_code); 
	
	// 결재를 누르면 적용되는 행의 개수 를 리턴하는 메소드 선언
	int signExpenseReport(ExpenseDTO expenseDTO);	
	
	// 반려를 누르면 적용되는 행의 개수 를 리턴하는 메소드 선언	
	int signMinusExpenseReport(ExpenseDTO expenseDTO);	
	
	// 수정시 일어나는 메소드
	int alterExpenseReport(ExpenseDTO expenseDTO);
	
	
	
	
	


	// 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list(ExpenseDTO expenseDTO);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
