package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DailyServiceImpl implements DailyService {
	

	@Autowired
	private DailyDAO dailyDAO;
	
		//-------------------------------------------------------------------------------------------------------------------
		// 일일업무보고서 목록 화면에 보여질 목록들 얻는 메소드 
		//-------------------------------------------------------------------------------------------------------------------
		public List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO){
			
			List<Map<String,String>> dailyList = this.dailyDAO.getDailyList(dailyBusiSearchDTO);
			
			for(int i =0; i<dailyList.size(); i++) {
				int report_no = 0;

				
				if(dailyList.get(i).get("report_no")!=null ) {
					report_no =  Integer.parseInt(dailyList.get(i).get("report_no")) ;
						
					dailyBusiSearchDTO.setReport_no(report_no);
					
					String sign_date = this.dailyDAO.getSign_date(dailyBusiSearchDTO);
					
					dailyList.get(i).put("sign_date", sign_date);
					
					String sign_code = this.dailyDAO.getSign_code(dailyBusiSearchDTO);
					
					dailyList.get(i).put("sign_code", sign_code);
					
					if(sign_code==null) {
						sign_code = this.dailyDAO.next_app_getSign_code(dailyBusiSearchDTO);
						dailyList.get(i).put("sign_code", sign_code);
					}
				}
			}
			return dailyList;
		};
	
	
		//--------------------------------------------------------------------------------
		// 선택한 업무보고서 상세정보를 담아오는 메소드 		
		//--------------------------------------------------------------------------------
		public DailyBusiDTO getBoard(int report_no,int emp_no2) {
			
			// 해시맵 생성하기
			Map<String,String> getBoardData = new HashMap<String,String>();
			
			// 해시맵에 넘어온 리포트번호와 직원번호 넣어주기
			getBoardData.put("report_no", 	Integer.toString(report_no));
			getBoardData.put("emp_no2", 	Integer.toString(emp_no2));
			
			// 넘어온 데이터로 게시글 상세정보 담아오기
			DailyBusiDTO getBoard = this.dailyDAO.getBoard(getBoardData); 
			
					
			return getBoard;
			
		};
	
		//-------------------------------------------------------------------------------------------------------------------
		// [1개의 일일업무보고서 입력 후 적용행의 개수]를 리턴하는 메소드 선언
		//-------------------------------------------------------------------------------------------------------------------
		public int first_insertDailyReport(DailyBusiDTO dailyBusiDTO) {
			
			int userDailyReport = this.dailyDAO.first_insertDailyReport(dailyBusiDTO);
			
			int first_insertSign = 0;
			
			if(userDailyReport==1) {
				first_insertSign  = this.dailyDAO.first_insertSignFinishReport_Sign_emp(dailyBusiDTO);
			}
			
			return userDailyReport;		
		}
		
		
		
		
		
		
		
		

		//-------------------------------------------------------------------------------------------------------------------
		// 결재/반려에서 결재 성공 시 데이터
		//-------------------------------------------------------------------------------------------------------------------
		public int signDailBusiReport(DailyBusiDTO dailyBusiDTO) {
			
			// 사인 코드를 0으로 업데이트 하고 
			int updateSignCode = this.dailyDAO.updateSignCode(dailyBusiDTO);
			
			// 다음결제자를 넣었으면
			if(dailyBusiDTO.getNextAppNoPerson()==null || dailyBusiDTO.getNextAppNoPerson().equals("")) {
				
				// 수정해서 올라온 결제면 밑에 작업 하지말고 다음 결제자 sign_code -1 해주기
				Map<String,String> getNextSign_finish_report = this.dailyDAO.getNextSign_finish_report(dailyBusiDTO);
				
				// 다음결제자 정보로 새롭게 만들기
				if(updateSignCode==1) {
					// 다음놈이 없으면 만들기
					if(getNextSign_finish_report==null) {
						int new_insertSign =  this.dailyDAO.new_insertSignFinishReport_Sign_emp(dailyBusiDTO);
					}
					// 수정해서 올라온거라 다음놈이 있으면
					else if(getNextSign_finish_report!=null) {
						int getNextEmp_no = Integer.parseInt(getNextSign_finish_report.get("emp_no"));
						
						dailyBusiDTO.setEmp_no(getNextEmp_no);

						// 다음 놈의 사인코드 바꿔주기
						int alterNextAppSignCode = this.dailyDAO.alter_Next_App_Sign_Code(dailyBusiDTO);
						
						// 다음 놈의 시간도 바꿔주기
						int alterNextAppSignDate = this.dailyDAO.alter_Next_App_Sign_Date(dailyBusiDTO);
						
					}
				}
			}
			
			// 다음결제자가 없으면			
			else {					
				//결제 시간을 현재로 맞춰주기
				int app_setTime = this.dailyDAO.app_setTime(dailyBusiDTO);
			}	
			return updateSignCode;
		};

		
		//-------------------------------------------------------------------------------------------------------------------
		// 결재/반려에서 반려 성공 시 데이터
		//-------------------------------------------------------------------------------------------------------------------
		public int signMinusBusiReport(DailyBusiDTO dailyBusiDTO) {
			
			// sign_code 전부 -1 로 변경하기
			int updateSignCodeMinus = this.dailyDAO.updateSignCodeMinus(dailyBusiDTO);
			
			
			
			// 반려테이블 반려사유 저장하기
			if(updateSignCodeMinus>0) {
				//------------------------------------------------------
				// 우선 있는지 체크하기 없으면 넣어주기
				//------------------------------------------------------
				int haveOrNone = this.dailyDAO.haveOrNoneReturn_report(dailyBusiDTO);//추가
				if(haveOrNone==0) {
					System.out.println("haveOrNone!!!!");
					int insert_return_report = this.dailyDAO.insertReturnReport(dailyBusiDTO);
				}
				else {
					int insert_return_result = this.dailyDAO.insertReturnResult(dailyBusiDTO);//추가
				}
				
				int app_setTime = this.dailyDAO.app_setTime(dailyBusiDTO);
			}
			return updateSignCodeMinus;
		};
		
		
		
		
		
		
		
		//-------------------------------------------------------------------------------------------------------------------
		// 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
		//-------------------------------------------------------------------------------------------------------------------
		public List<Next_App_Emp_List> get_next_app_list(DailyBusiDTO dailyBusiDTO){
			List<Next_App_Emp_List> next_app_list = this.dailyDAO.get_next_app_list(dailyBusiDTO);

			return next_app_list;
		}
		
		
		
		
		//--------------------------------------------------------------------------------
		// (가제)수정시 일어나는 메소드		
		//--------------------------------------------------------------------------------
		public int alterDailBusiReport(DailyBusiDTO dailyBusiDTO) {

			// 들어온 번호를 통해 컨텐츠내용 업데이트 하고 	
			int alterDailBusiContent = this.dailyDAO.alterDailBusiContent(dailyBusiDTO);
			
			if(alterDailBusiContent==1) {
				// 시간 다비우기
				int alterDeleteSignDate = this.dailyDAO.alterDeleteSignDate(dailyBusiDTO);
				// 윗놈의 결제정보를 미결제로 바꾸기
				int alterNextAppUpdateSignCode = this.dailyDAO.alterNextAppUpdateSignCode(dailyBusiDTO);	//**************************************************************************************************
				//**************************************************************************************************
			// return_report 비우기
				int alterDeleteReturnReport = this.dailyDAO.alterDeleteReturnReport(dailyBusiDTO);
				//**************************************************************************************************
				//**************************************************************************************************
			}
			return alterDailBusiContent;
		};
		
		
		
		//*********************************************************************************************************
		//*********************************************************************************************************
		//*********************************************************************************************************
		//*********************************************************************************************************
		
		
	/*
	//검색한 일일업무보고서 목록]을 리턴하는 메소드 선언 
	List<Map<String, String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO){
		return;
	}
	
	//[검색한 일일업무보고서 목록의 개수]를 리턴하는 메소드 선언 
	int getDailyListAllCnt(DailyBusiSearchDTO dailyBusiSearchDTO) {
		return;		
	}

	

	//[1개의 일일업무보고서 글]을 리턴하는 메소드 선언
	DailyBusiDTO getDailyDTO(Map<String, String> paramsMap) {
		return;		
	}

	//[1개의 일일업무보고서의 결재내역]을 리턴하는 메소드 선언
	List<Map<String, String>> getSignList(Map<String, String> paramsMap){
		return;		
	}

	//[1개의 일일업무보고서의 반려 횟수]를 리턴하는 메소드 선언
	int getMax_return_no(Map<String, String> paramsMap) {
		return;		
	}

	//[1개의 일일업무보고서의 결재/반려 후 적용행의 개수]를 리턴하는 메소드 선언	
	int signDailyBusiReport(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[1개의 일일업무보고서의 수정 시 1명의 다음 결재자 정보/보고서 정보]를 리턴하는 메소드 선언
	Map<String, String> pickNextEmployee(Map<String,String> paramsMap){
		return;		
	}
	*/
	
}
