package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface ExpenseDAO {
	
	// 첫 지출보고서 등록시 적용된 행의 개수를 리턴하는 메소드 
	int first_insertExpenseReport(ExpenseDTO expenseDTO);
	
	// 첫 지출보고서 등록시 다음결제자를 등록하는 메소드 
	int first_insertSignFinishReport_Sign_emp(ExpenseDTO expenseDTO);
	
	// 지출보고서 리스트를 받아오는 메소드 	
	List<Map<String,String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO);
	
	// 선택한 지출보고서 상세정보를 담아오는 메소드 
	ExpenseDTO getBoard(Map<String,String> getBoardData); 
	
	// 최종 결제자의 정보를 얻어오는 메소드 선언 
	Map<String,String> getlastAppMan(ExpenseSearchDTO expenseSearchDTO);
	
	// 최종 결제자의 정보를 얻어오는 메소드 선언 
	Map<String,String> getlastAppMan(ExpenseDTO expenseDTO);
	
	// 다음 결제자의 정보를 얻어오는 메소드 선언
	Map<String,String> getNextAppMan(ExpenseDTO expenseDTO);
	
	// 결제성공시 사인코드를 0 으로 업데이트 후 적용된 행의 개수를 리턴하는 메소드 
	int updateSignCode(ExpenseDTO expenseDTO);
	
	Map<String,String> getNextSign_finish_report(ExpenseDTO expenseDTO);
	
	// 결제성공시 다음결제자의 정보를 입력 후 적용된 행의 개수를 리턴하는 메소드 
	int new_insertSignFinishReport_Sign_emp(ExpenseDTO expenseDTO);
	
	// 다음 결재자의 사인코드 바꿔주기
	int alter_Next_App_Sign_Code(ExpenseDTO expenseDTO);
	
	// 다음 결재자의 사인날짜 바꿔주기	
	int alter_Next_App_Sign_Date(ExpenseDTO expenseDTO);
	
	// 다음 결재자 없으면 현 결재자의 시간을 업데이트 후 적용된 행의 개수를 리턴하는 메소드 
	int app_setTime(ExpenseDTO expenseDTO);
	
	// 반려시 사인코드를 1 로 업데이트 한 후 적용된 행의 개수를 리턴하는 메소드
	int updateSignCodeMinus(ExpenseDTO expenseDTO);
	
	// 반려시 반려사유테이블에 반려사유 저장후 적용된 행의 개수를 리턴하는 메소드 
	int insertReturnReport(ExpenseDTO expenseDTO);
	
	// 업무보고서 목록 얻어올때 결제자의 결제 상태 얻어오는 메소드
	String getSign_code(ExpenseSearchDTO expenseSearchDTO);

	// 업무보고서 목록 얻어올때 결제자의 결제 상태 얻어오는 메소드
	String getSign_code(ExpenseDTO expenseDTO);
	
	// 만약 다음결제자의 사인코드가 비어있다면 다음결제자의 사인코드 얻어오는 메소드 
	String next_app_getSign_code(ExpenseSearchDTO expenseSearchDTO);
	
	// 만약 첫결재자 라면 바로 앞 결재자의 시간을 얻어오는 메소드 
	String first_app_getSign_date(ExpenseSearchDTO expenseSearchDTO);
	
	// 다음결제자의 결제시간을 얻어오는 메소드 
	String next_app_getSign_date(ExpenseSearchDTO expenseSearchDTO);	
	
	// 지출가격을 수정하는 메소드
	int alterExpensePrice(ExpenseDTO expenseDTO);

	// 지출영수증을 수정하는 메소드
	int alterExpenseReceipt_no(ExpenseDTO expenseDTO); 
	
	// 비고란을 수정하는 메소드	
	int alterRemarks(ExpenseDTO expenseDTO); 
	
	// 결제날짜를 비워주는 메소드		
	int alterDeleteSignDate(ExpenseDTO expenseDTO);

	// 다음결제자의 사인코드를 바꿔주는 메소드	
	int alterNextAppUpdateSignCode(ExpenseDTO expenseDTO);
	
	
	
	
	
	
	
	
	
	
	
	

	// 지출업무보고서 총개수 구하기
	int getexpenseListAllTotCnt(ExpenseSearchDTO expenseSearchDTO);

	// 지출업무보고서 검색 결과물의 총개수 구하기
	int getexpenseListTotCnt(ExpenseSearchDTO expenseSearchDTO);
	
	

	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list(ExpenseDTO expenseDTO);


	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list2(int emp_no2);



	// 로그인한 사람의 다음 결제자의 정보를 얻어오는 메소드 선언 getLogin_NextAppMan
	Map<String,String> getLogin_NextAppMan(ExpenseDTO expenseDTO);
	
	
	
	
	//****************************************************************************
		int alterDeleteReturnReport(ExpenseDTO expenseDTO);
		List<Map<String,String>> getAppList(ExpenseDTO expenseDTO); 
		String next_appList_getSign_date(Map<String,String> myInfo);
		String my_appList_getSign_date(Map<String,String> myInfo);
		
	
	
	
	
		String nextAppManEmp_no(Map<String,String> AppEmp_no);
	
	

		//****************************************************************************
	
		int haveOrNoneReturn_report(ExpenseDTO expenseDTO);
	

		int insertReturnResult(ExpenseDTO expenseDTO);

		
		
		
		
		
		
		
		
	
	
}
