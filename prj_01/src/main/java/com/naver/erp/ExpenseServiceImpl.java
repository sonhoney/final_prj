package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ExpenseServiceImpl implements ExpenseService {
	
	@Autowired
	private ExpenseDAO expenseDAO;
	
	public int first_insertExpenseReport(ExpenseDTO expenseDTO) {
		
		// 첫 업무보고서 등록시 적용된 행의 개수를 리턴받기
		int userExpenseReport = this.expenseDAO.first_insertExpenseReport(expenseDTO);
		
		int first_insertSign = 0;
		
		// 만약 업무보고서 등록이 성공했으면
		if(userExpenseReport==1) {
			// 다음결제자 정보를 등록후 개수 리턴받기
			first_insertSign  = this.expenseDAO.first_insertSignFinishReport_Sign_emp(expenseDTO);
		}
				
		return userExpenseReport;	
	};	
	
	public List<Map<String,String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO){
		
		// 업무보고서 리스트를 받아오기 
		List<Map<String,String>> ExpenseList = this.expenseDAO.getExpenseList(expenseSearchDTO);
		
		for(int i =0; i<ExpenseList.size(); i++) {
			// i 번째 업무보고서 리스트 번호 저장
			int report_no =  Integer.parseInt(ExpenseList.get(i).get("report_no")) ;
			// 	DailyBusiDTO 객체에 리포트 번호 세팅
			expenseSearchDTO.setReport_no(report_no);
			
			int report_code =  Integer.parseInt(ExpenseList.get(i).get("report_code")) ;				
			expenseSearchDTO.setReport_code(report_code);
			
			// 그 리포트 번호의 사인코드 얻어오기
			String sign_code = this.expenseDAO.getSign_code(expenseSearchDTO);
			// 얻어온 사인코드 i 번째 업무보고서에 넣어주기
			ExpenseList.get(i).put("sign_code", sign_code);
			
			// 만약 사인코드가 null 이라면 즉 첫 결제자 이거나 마지막 결제자면
			if(sign_code==null) {
				sign_code = this.expenseDAO.next_app_getSign_code(expenseSearchDTO);
				ExpenseList.get(i).put("sign_code", sign_code);
			}
			
		}
		return ExpenseList;
	};
	
	
	
	
	public ExpenseDTO getBoard(int report_no,int emp_no2,int report_code) {		
		// 해시맵 생성하기
		Map<String,String> getBoardData = new HashMap<String,String>();
		
		// 해시맵에 넘어온 리포트번호와 직원번호 넣어주기
		getBoardData.put("report_no", 	Integer.toString(report_no));
		getBoardData.put("emp_no2", 	Integer.toString(emp_no2));
		getBoardData.put("report_code", 	Integer.toString(report_code));
		
		// 넘어온 데이터로 게시글 상세정보 담아오기
		ExpenseDTO getBoard = this.expenseDAO.getBoard(getBoardData); 
		
				
		return getBoard;
	}; 
	
	public int signExpenseReport(ExpenseDTO expenseDTO) {
		
		// 사인 코드를 0으로 업데이트 하고 
		int updateSignCode = this.expenseDAO.updateSignCode(expenseDTO);
		System.out.println("업데이트값" + updateSignCode);
		
		// 다음결제자를 넣었으면
		if(expenseDTO.getNextAppNoPerson()==null || expenseDTO.getNextAppNoPerson().equals("")) {
			
			// 수정해서 올라온 결제면 밑에 작업 하지말고 다음 결제자 sign_code -1 해주기
			Map<String,String> getNextSign_finish_report = this.expenseDAO.getNextSign_finish_report(expenseDTO);
			
			// 다음결제자 정보로 새롭게 만들기
			if(updateSignCode==1) {
				// 다음놈이 없으면 만들기
				if(getNextSign_finish_report==null) {
					int new_insertSign =  this.expenseDAO.new_insertSignFinishReport_Sign_emp(expenseDTO);
				}
				// 수정해서 올라온거라 다음놈이 있으면
				else if(getNextSign_finish_report!=null) {
					int getNextEmp_no = Integer.parseInt(getNextSign_finish_report.get("emp_no"));
					
					expenseDTO.setEmp_no(getNextEmp_no);

					// 다음 놈의 사인코드 바꿔주기
					int alterNextAppSignCode = this.expenseDAO.alter_Next_App_Sign_Code(expenseDTO);
					
					// 다음 놈의 시간도 바꿔주기
					int alterNextAppSignDate = this.expenseDAO.alter_Next_App_Sign_Date(expenseDTO);
					
				}
			}
		}
		
		// 다음결제자가 없으면			
		else {					
			//결제 시간을 현재로 맞춰주기
			int app_setTime = this.expenseDAO.app_setTime(expenseDTO);
		}	
		return updateSignCode;
		
	};	
	
	public int signMinusExpenseReport(ExpenseDTO expenseDTO) {
		System.out.println("들옴1");
		// sign_code 전부 -1 로 변경하기
		int updateSignCodeMinus = this.expenseDAO.updateSignCodeMinus(expenseDTO);
		System.out.println("들옴2");
		
		// 반려테이블 반려사유 저장하기
		if(updateSignCodeMinus>0) {

			//------------------------------------------------------
			// 우선 있는지 체크하기 없으면 넣어주기
			//------------------------------------------------------
			int haveOrNone = this.expenseDAO.haveOrNoneReturn_report(expenseDTO);
			
			if(haveOrNone==0) {
				System.out.println("haveOrNone!!!!");
				int insert_return_report = this.expenseDAO.insertReturnReport(expenseDTO);				
			}
			else {
				int insert_return_result = this.expenseDAO.insertReturnResult(expenseDTO);
			}
			
			int app_setTime = this.expenseDAO.app_setTime(expenseDTO);
		}
		
		return updateSignCodeMinus;
	};	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public int alterExpenseReport(ExpenseDTO expenseDTO) {

		// 들어온 번호를 통해 비용 업데이트 하고 	
		int alterExpensePrice = this.expenseDAO.alterExpensePrice(expenseDTO);
		
		// 들어온 번호를 통해 영수증번호 업데이트
		int alterExpenseReceipt_no = this.expenseDAO.alterExpenseReceipt_no(expenseDTO); 
		
		// 들어온 번호를 통해 비고 업데이트
		int alterRemarks = this.expenseDAO.alterRemarks(expenseDTO); 
		
		if(alterExpensePrice==1) {
			// 시간 다비우기
			int alterDeleteSignDate = this.expenseDAO.alterDeleteSignDate(expenseDTO);
		// 윗놈의 결제정보를 미결제로 바꾸기
			int alterNextAppUpdateSignCode = this.expenseDAO.alterNextAppUpdateSignCode(expenseDTO);
			
			//**************************************************************************************************
			//**************************************************************************************************
		// return_report 비우기
			int alterDeleteReturnReport = this.expenseDAO.alterDeleteReturnReport(expenseDTO);
			//**************************************************************************************************
			//**************************************************************************************************s
		}
		return alterExpensePrice;
		
	};
	
	
	

	//-------------------------------------------------------------------------------------------------------------------
	// 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	//-------------------------------------------------------------------------------------------------------------------
	public List<Next_App_Emp_List> get_next_app_list(ExpenseDTO expenseDTO){
		List<Next_App_Emp_List> next_app_list = this.expenseDAO.get_next_app_list(expenseDTO);

		return next_app_list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
