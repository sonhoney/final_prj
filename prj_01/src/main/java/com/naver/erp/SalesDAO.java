package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface SalesDAO {

	int first_insertSalesReport(SalesDTO salesDTO);
	
	int first_insertSignFinishReport_Sign_emp(SalesDTO salesDTO);
	
	List<Map<String,String>> getSalesList(SalesSearchDTO salesSearchDTO);
	
	SalesDTO getBoard(Map<String,String> getBoardData); 
	
	Map<String,String> getlastAppMan(SalesSearchDTO salesSearchDTO);
	
	Map<String,String> getlastAppMan(SalesDTO salesDTO);
	
	Map<String,String> getNextAppMan(SalesDTO salesDTO);
	
	String first_app_getSign_date(SalesSearchDTO salesSearchDTO);
	
	String next_app_getSign_date(SalesSearchDTO salesSearchDTO);	
	
	String getSign_code(SalesSearchDTO salesSearchDTO);
	
	String next_app_getSign_code(SalesSearchDTO salesSearchDTO);
	
	int updateSignCode(SalesDTO salesDTO);
	
	Map<String,String> getNextSign_finish_report(SalesDTO salesDTO);
	
	int new_insertSignFinishReport_Sign_emp(SalesDTO salesDTO);
	
	int alter_Next_App_Sign_Code(SalesDTO salesDTO);
	
	int alter_Next_App_Sign_Date(SalesDTO salesDTO);
	
	int app_setTime(SalesDTO salesDTO);
	
	int updateSignCodeMinus(SalesDTO salesDTO);
	
	int insertReturnReport(SalesDTO salesDTO);
	
	int alterSalesContent(SalesDTO salesDTO);
	
	int alterSalesResult(SalesDTO salesDTO); 
	
	int alterDeleteSignDate(SalesDTO salesDTO);
	
	int alterNextAppUpdateSignCode(SalesDTO salesDTO);


	
	

	// 로그인한 사람의 다음 결제자의 정보를 얻어오는 메소드 선언 getLogin_NextAppMan
	Map<String,String> getLogin_NextAppMan(SalesDTO salesDTO);
	

	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list(SalesDTO salesDTO);
	//-----------------------------------------------------------------------------------------------------------
	

	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list2(int emp_no2);
	
	
	
	
	

	// 영업업무보고서 총개수 구하기
	int getsalesListAllTotCnt(SalesSearchDTO salesSearchDTO);

	// 일일업무보고서 검색 결과물의 총개수 구하기
	int getsalesListTotCnt(SalesSearchDTO salesSearchDTO);
	
	
	
	
	//***********************************************************************
		//***********************************************************************
		int alterDeleteReturnReport(SalesDTO salesDTO);
		List<Map<String,String>> getAppList(SalesDTO salesDTO); 
		String next_appList_getSign_date(Map<String,String> myInfo);
		String my_appList_getSign_date(Map<String,String> myInfo);
		
		String nextAppManEmp_no(Map<String,String> AppEmp_no);

		//***********************************************************************
		
		int haveOrNoneReturn_report(SalesDTO salesDTO);
		
		int insertReturnResult(SalesDTO salesDTO);
	
	
	
	
}
