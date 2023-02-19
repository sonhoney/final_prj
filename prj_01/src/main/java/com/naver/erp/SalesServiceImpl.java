package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SalesServiceImpl implements SalesService {
	@Autowired
	private SalesDAO salesDAO;
	
	//--------------------------------------------------------------------------------
	//[1개의 일일업무보고서 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	//--------------------------------------------------------------------------------
		public int first_insertSalesReport(SalesDTO salesDTO) {
			// 첫 업무보고서 등록시 적용된 행의 개수를 리턴받기
			int userSalesReport = this.salesDAO.first_insertSalesReport(salesDTO);
			int first_insertSign = 0;
			// 만약 업무보고서 등록이 성공했으면
			if(userSalesReport==1) {
				// 다음결제자 정보를 등록후 개수 리턴받기
				first_insertSign  = this.salesDAO.first_insertSignFinishReport_Sign_emp(salesDTO);
			}	
			return userSalesReport;		
		}

		//--------------------------------------------------------------------------------
		//--------------------------------------------------------------------------------
		public List<Map<String,String>> getSalesList(SalesSearchDTO salesSearchDTO){
			List<Map<String,String>> salesList = this.salesDAO.getSalesList(salesSearchDTO);
			
			for(int i =0; i<salesList.size(); i++) {
				// i 번째 업무보고서 리스트 번호 저장
				int report_no =  Integer.parseInt(salesList.get(i).get("report_no")) ;
				// 	DailyBusiDTO 객체에 리포트 번호 세팅
				salesSearchDTO.setReport_no(report_no);
				
				int report_code =  Integer.parseInt(salesList.get(i).get("report_code")) ;				
				salesSearchDTO.setReport_code(report_code);
				
				// 그 리포트 번호의 사인코드 얻어오기
				String sign_code = this.salesDAO.getSign_code(salesSearchDTO);
				// 얻어온 사인코드 i 번째 업무보고서에 넣어주기
				salesList.get(i).put("sign_code", sign_code);
				
				// 만약 사인코드가 null 이라면 즉 첫 결제자 이거나 마지막 결제자면
				if(sign_code==null) {
					sign_code = this.salesDAO.next_app_getSign_code(salesSearchDTO);
					salesList.get(i).put("sign_code", sign_code);
				}
				
			}
			
			return salesList;
			
		}
		//--------------------------------------------------------------------------------
		
		public SalesDTO getBoard(int report_no,int emp_no2, int report_code) {			
			// 해시맵 생성하기
			Map<String,String> getBoardData = new HashMap<String,String>();
			
			// 해시맵에 넘어온 리포트번호와 직원번호 넣어주기
			getBoardData.put("report_no", 	Integer.toString(report_no));
			getBoardData.put("emp_no2", 	Integer.toString(emp_no2));
			getBoardData.put("report_code", 	Integer.toString(report_code));
			
			// 넘어온 데이터로 게시글 상세정보 담아오기
			SalesDTO getBoard = this.salesDAO.getBoard(getBoardData); 
			
					
			return getBoard;
		};
		
		public int signDailBusiReport(SalesDTO salesDTO) {
			
			// 사인 코드를 0으로 업데이트 하고 
			int updateSignCode = this.salesDAO.updateSignCode(salesDTO);
			System.out.println("업데이트값" + updateSignCode);
			
			// 다음결제자를 넣었으면
			if(salesDTO.getNextAppNoPerson()==null || salesDTO.getNextAppNoPerson().equals("")) {
				System.out.println("2");
				
				// 수정해서 올라온 결제면 밑에 작업 하지말고 다음 결제자 sign_code -1 해주기
				Map<String,String> getNextSign_finish_report = this.salesDAO.getNextSign_finish_report(salesDTO);
				System.out.println("3");

				
				
				// 다음결제자 정보로 새롭게 만들기
				if(updateSignCode==1) {
					System.out.println("4");
					// 다음놈이 없으면 만들기
					if(getNextSign_finish_report==null) {
						System.out.println("5");
						int new_insertSign =  this.salesDAO.new_insertSignFinishReport_Sign_emp(salesDTO);
					}
					// 수정해서 올라온거라 다음놈이 있으면
					else if(getNextSign_finish_report!=null) {
						System.out.println("6");
						int getNextEmp_no = Integer.parseInt(getNextSign_finish_report.get("emp_no"));
						
						salesDTO.setEmp_no(getNextEmp_no);

						// 다음 놈의 사인코드 바꿔주기
						System.out.println("7");
						int alterNextAppSignCode = this.salesDAO.alter_Next_App_Sign_Code(salesDTO);
						
						// 다음 놈의 시간도 바꿔주기
						System.out.println("8");
						int alterNextAppSignDate = this.salesDAO.alter_Next_App_Sign_Date(salesDTO);
						
					}
				}
			}
			
			// 다음결제자가 없으면			
			else {					
				//결제 시간을 현재로 맞춰주기
				int app_setTime = this.salesDAO.app_setTime(salesDTO);
			}	
			return updateSignCode;
		};
			
		
		
		public int signMinusBusiReport(SalesDTO salesDTO) {
			
			// sign_code 전부 -1 로 변경하기
			int updateSignCodeMinus = this.salesDAO.updateSignCodeMinus(salesDTO);
			
			// 반려테이블 반려사유 저장하기
			if(updateSignCodeMinus>0) {
				//------------------------------------------------------
				// 우선 있는지 체크하기 없으면 넣어주기
				//------------------------------------------------------
				int haveOrNone = this.salesDAO.haveOrNoneReturn_report(salesDTO);
				System.out.println(haveOrNone + "안녕");
				
				if(haveOrNone==0) {
					System.out.println("haveOrNone!!!!");
					int insert_return_report = this.salesDAO.insertReturnReport(salesDTO);					
				}
				else {
					int insert_return_result = this.salesDAO.insertReturnResult(salesDTO);
				}
				int app_setTime = this.salesDAO.app_setTime(salesDTO);
			}
			
			return updateSignCodeMinus;
		};	
		
		
		
		public int alterDailBusiReport(SalesDTO salesDTO) {

			// 들어온 번호를 통해 새일컨텐츠내용 업데이트 하고 	
			int alterSalesContent = this.salesDAO.alterSalesContent(salesDTO);
			
			// 들어온 번호를 통해 새일리절트내용 업데이트
			int alterSalesResult = this.salesDAO.alterSalesResult(salesDTO); 
			
			if(alterSalesContent==1) {
				// 시간 다비우기
				int alterDeleteSignDate = this.salesDAO.alterDeleteSignDate(salesDTO);
			// 윗놈의 결제정보를 미결제로 바꾸기
				int alterNextAppUpdateSignCode = this.salesDAO.alterNextAppUpdateSignCode(salesDTO);
				//**************************************************************************************************
				//**************************************************************************************************
				// 리턴 리포트가 있으면
			// return_report 비우기
				int alterDeleteReturnReport = this.salesDAO.alterDeleteReturnReport(salesDTO);
				// 
				//**************************************************************************************************
				//**************************************************************************************************
			}
			return alterSalesContent;
		};
		
		
		
		
		
		
		
		
		
		

		//-------------------------------------------------------------------------------------------------------------------
		// 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
		//-------------------------------------------------------------------------------------------------------------------
		public List<Next_App_Emp_List> get_next_app_list(SalesDTO salesDTO){
			List<Next_App_Emp_List> next_app_list = this.salesDAO.get_next_app_list(salesDTO);

			return next_app_list;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
