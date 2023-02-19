package com.naver.erp;

import java.util.List;
import java.util.Map;
//인터페이스로 DailyDAOImpl 의 메소드 목록을 규정

import javax.servlet.http.HttpSession;

public interface DailyDAO {
	


	//-----------------------------------------------------------------------------------------------------------
	// 일일업무일지 리스트를 가져오는 dailyList 객체
	List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO);
	

	// 최종 결제자의 정보를 얻어오는 메소드 선언 
	Map<String,String> getlastAppMan(DailyBusiSearchDTO dailyBusiSearchDTO);

	
	// 만약 첫결재자 라면 바로 앞 결재자의 시간을 얻어오는 메소드 
	String first_app_getSign_date(DailyBusiSearchDTO dailyBusiSearchDTO);

	
	// 다음결제자의 결제시간을 얻어오는 메소드 
	String next_app_getSign_date(DailyBusiSearchDTO dailyBusiSearchDTO);


	// 일일업무보고서 총개수 구하기
	int getdailyBusiListAllTotCnt(DailyBusiSearchDTO dailyBusiSearchDTO);

	// 일일업무보고서 검색 결과물의 총개수 구하기
	int getdailyBusiListTotCnt( DailyBusiSearchDTO dailyBusiSearchDTO);
	
	//-----------------------------------------------------------------------------------------------------------
	
	
	// 결재여부 날짜 라턴 받는 메소드 
	String getSign_date(DailyBusiSearchDTO dailyBusiSearchDTO);
	
	// 결재여부 코드 라턴 받는 메소드 
	String getSign_code(DailyBusiSearchDTO dailyBusiSearchDTO);
	
	
	// 다음 결재자 결재여부코드를 가져오는 메소드
	String next_app_getSign_code(DailyBusiSearchDTO dailyBusiSearchDTO);
	
	
	// 자신이 작성한 일일업무보고서 적용 행의 개수 리턴 메소드
	int first_insertDailyReport(DailyBusiDTO dailyBusiDTO);
	

	// 자신의 일일업무보고서의 다음결재자를 보고서결재정보 테이블에 적용하는 메소드
	public int first_insertSignFinishReport_Sign_emp(DailyBusiDTO dailyBusiDTO); 


	// 최종 결제자의 정보를 얻어오는 메소드 선언 
	Map<String,String> getlastAppMan(DailyBusiDTO dailyBusiDTO);
	
	//-----------------------------------------------------------------------------------------------------------
	// 일일업무보고서 번호에 해당하는 상세화면에 띄어줄 데이터 검색 결과 개수 리턴 메소드
	public DailyBusiDTO getBoard(Map<String,String> getBoardData);

	
	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list2(int emp_no2);
	//-----------------------------------------------------------------------------------------------------------

	//-----------------------------------------------------------------------------------------------------------
	// 결재/반려에서 결재코드 업데이트 성공 여부 리턴 메소드
	int updateSignCode(DailyBusiDTO dailyBusiDTO);
	
	
	// 결재/반려에서 새로운 결재코드 입력 행의 개수 리턴 메소드
	int new_insertSignFinishReport_Sign_emp(DailyBusiDTO dailyBusiDTO);
	//-----------------------------------------------------------------------------------------------------------
	
	
	
	//-----------------------------------------------------------------------------------------------------------
	// 결재/반려에서 결재코드 반려로 업데이트 성공 여부 리턴 메소드
	int updateSignCodeMinus(DailyBusiDTO dailyBusiDTO);
	
	
	// 결재/반려에서 결재코드 반려로 업데이트 성공 시 반려테이블에 반려된 보고서번호와 반려사유 입력 행의 개수 리턴 메소드
	int insertReturnReport(DailyBusiDTO dailyBusiDTO);
	//-----------------------------------------------------------------------------------------------------------

	
	

	// 등록화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	List<Next_App_Emp_List> get_next_app_list(DailyBusiDTO dailyBusiDTO);
	
	

	//-----------------------------------------------------------------------------------------------------------
	// 들어온 번호를 통해 컨텐츠내용 업데이트 하는 메소드 선언
	int alterDailBusiContent(DailyBusiDTO dailyBusiDTO);
	
	// 시간 다비우기
	int alterDeleteSignDate(DailyBusiDTO dailyBusiDTO);

	// 들어온 번호를 통해 윗 결제자의 sign_code 업데이트 하는 메소드 선언	
	int alterNextAppUpdateSignCode(DailyBusiDTO dailyBusiDTO);

	//-----------------------------------------------------------------------------------------------------------
	

	Map<String,String> getNextSign_finish_report(DailyBusiDTO dailyBusiDTO);
	

	int alter_Next_App_Sign_Code(DailyBusiDTO dailyBusiDTO);
	
	int alter_Next_App_Sign_Date(DailyBusiDTO dailyBusiDTO);

	// 다음 결제자의 정보를 얻어오는 메소드 선언 
	Map<String,String> getNextAppMan(DailyBusiDTO dailyBusiDTO);


	// 로그인한 사람의 다음 결제자의 정보를 얻어오는 메소드 선언 getLogin_NextAppMan
	Map<String,String> getLogin_NextAppMan(DailyBusiDTO dailyBusiDTO);
	
	// 다음 결재자 없으면 현 결재자의 시간을 업데이트 후 적용된 행의 개수를 리턴하는 메소드 
	int app_setTime(DailyBusiDTO dailyBusiDTO);
	//**************************************************************************************************************************************
	//**************************************************************************************************************************************

	// 불완전 요소 777
	 List<Map<String,String>> getAppList(DailyBusiDTO dailyBusiDTO); 
	 
 String next_appList_getSign_date(Map<String,String> myInfo);
 
 String my_appList_getSign_date(Map<String,String>  myInfo);
 
 int alterDeleteReturnReport(DailyBusiDTO dailyBusiDTO);
	//**************************************************************************************************************************************
	//**************************************************************************************************************************************
 String nextAppManEmp_no(Map<String,String> AppEmp_no);

 
 
 
 
 
 
 

	//*************************12.10추가******************************************************************************************
	int haveOrNoneReturn_report(DailyBusiDTO dailyBusiDTO);
 

	int insertReturnResult(DailyBusiDTO dailyBusiDTO);
 
 
 
	
}
