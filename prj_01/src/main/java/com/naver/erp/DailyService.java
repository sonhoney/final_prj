package com.naver.erp;

import java.util.List;
import java.util.Map;

//인터페이스로 DailyServiceImpl 의 메소드 목록을 규정
public interface DailyService {

	
	// 일일업무보고서 목록 화면에 보여질 목록들 얻는 메소드 
	List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO);
	
	
	
	//[1개의 일일업무보고서 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int first_insertDailyReport(DailyBusiDTO dailyBusiDTO); 
	
	
	// 결재/반려에서 결재 성공 시 데이터
	int signDailBusiReport(DailyBusiDTO dailyBusiDTO);
	
	// 결재/반려에서 반려 성공 시 데이터
	int signMinusBusiReport(DailyBusiDTO dailyBusiDTO);
	


	// 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list(DailyBusiDTO dailyBusiDTO);


	// 선택한 업무보고서 상세정보를 담아오는 메소드 
	DailyBusiDTO getBoard(int report_no,int emp_no2);
	

	// 수정시 일어나는 메소드
	int alterDailBusiReport(DailyBusiDTO dailyBusiDTO);
	
	

}