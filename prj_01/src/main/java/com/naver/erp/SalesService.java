package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface SalesService {
	//[1개의 영업보고서 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int first_insertSalesReport(SalesDTO salesDTO); 
	
	List<Map<String,String>> getSalesList(SalesSearchDTO salesSearchDTO);
	
	SalesDTO getBoard(int report_no,int emp_no2, int report_code);
	
	int signDailBusiReport(SalesDTO salesDTO);
	
	int signMinusBusiReport(SalesDTO salesDTO);	
	
	int alterDailBusiReport(SalesDTO salesDTO);
	
	
	
	
	
	
	

	// 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list(SalesDTO salesDTO);
	
	
	
	
	
	
	
	
	
	
	
	
	
}
