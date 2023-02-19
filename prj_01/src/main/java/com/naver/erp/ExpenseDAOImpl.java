package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ExpenseDAOImpl implements ExpenseDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int first_insertExpenseReport(ExpenseDTO expenseDTO) {
		
		int firstInsertCnt = this.sqlSession.insert(
				"com.naver.erp.ExpenseDAO.first_insertExpenseReport"
				,expenseDTO
		);
		return firstInsertCnt;
	};
	
	public int first_insertSignFinishReport_Sign_emp(ExpenseDTO expenseDTO) {		
		int firstInsertSign = this.sqlSession.insert(
			"com.naver.erp.ExpenseDAO.first_insertSignFinishReport_Sign_emp"
			,expenseDTO
		);
		
		return firstInsertSign;
	};
	
	public List<Map<String,String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO){
		
		List<Map<String,String>> expenseList = this.sqlSession.selectList(
			"com.naver.erp.ExpenseDAO.getExpenseList"
			,expenseSearchDTO
		);
		
		
		return expenseList;
	};
	
	public ExpenseDTO getBoard(Map<String,String> getBoardData) {
		ExpenseDTO expenseDTO = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getBoard"
				,getBoardData				
		);		
		return expenseDTO;
	}; 
	
	public Map<String,String> getlastAppMan(ExpenseSearchDTO expenseSearchDTO){
		
		Map<String,String> getlastAppMan = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getlastAppMan"
				,expenseSearchDTO
		);
		return getlastAppMan;
	};
	public Map<String,String> getlastAppMan(ExpenseDTO expenseDTO){
		
		Map<String,String> getlastAppMan = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getlastAppMan"
				,expenseDTO
		);
		return getlastAppMan;
	};
	
	public Map<String,String> getNextAppMan(ExpenseDTO expenseDTO){		
		Map<String,String> getNextAppMan = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getNextAppMan"
				,expenseDTO
		);
		return getNextAppMan;
	};
	
	public 	int updateSignCode(ExpenseDTO expenseDTO) {		
		int updateSign = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.updateSignCode"
				,expenseDTO
		);
		
		return updateSign;
	};
	
	public 	Map<String,String> getNextSign_finish_report(ExpenseDTO expenseDTO){
		Map<String,String> getNextSignFinishReport = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getNextSign_finish_report"
				,expenseDTO
		);
		return getNextSignFinishReport;
		
	};
	
	public 	int new_insertSignFinishReport_Sign_emp(ExpenseDTO expenseDTO) {
		int newInsertSign = this.sqlSession.insert(
				"com.naver.erp.ExpenseDAO.new_insertSignFinishReport_Sign_emp"
				,expenseDTO
			);
			
			return newInsertSign;
	};
	
	
	public 	int alter_Next_App_Sign_Code(ExpenseDTO expenseDTO) {
		int alterNextAppSignCode = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alter_Next_App_Sign_Code"
				,expenseDTO
		);	
		
		return alterNextAppSignCode;
	};
	
	public int alter_Next_App_Sign_Date(ExpenseDTO expenseDTO) {
		int alterNextAppSignDate = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alter_Next_App_Sign_Date"
				,expenseDTO
		);			
		return alterNextAppSignDate;
	};
	
	public int app_setTime(ExpenseDTO expenseDTO) {
		int appSetTime = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.app_setTime"
				,expenseDTO
		);
		
		return appSetTime;
	};
	
	public 	int updateSignCodeMinus(ExpenseDTO expenseDTO) {
		
		int updateSignCodeMinus = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.updateSignCodeMinus"
				,expenseDTO
		);
		
		return updateSignCodeMinus;
		
	};
	
	public int insertReturnReport(ExpenseDTO expenseDTO) {
		
		int insertReturnReport = this.sqlSession.insert(
				"com.naver.erp.ExpenseDAO.insertReturnReport"
				,expenseDTO
		);
		
		return insertReturnReport;
	};
	
	public String getSign_code(ExpenseDTO expenseDTO) {
		String getSignCode = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getSign_code"
				,expenseDTO
		);
		return getSignCode;
	};
	public String getSign_code(ExpenseSearchDTO expenseSearchDTO) {
		String getSignCode = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getSign_code"
				,expenseSearchDTO
		);
		return getSignCode;
	};
	
	public 	String next_app_getSign_code(ExpenseSearchDTO expenseSearchDTO) {
		String nextAppSignDate = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.next_app_getSign_code"
				,expenseSearchDTO
		);
		return nextAppSignDate;
	};
	
	public 	String first_app_getSign_date(ExpenseSearchDTO expenseSearchDTO) {
		String firstAppGetSignDate = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.first_app_getSign_date"
				,expenseSearchDTO
		);
		return firstAppGetSignDate;
	};
	
	public 	String next_app_getSign_date(ExpenseSearchDTO expenseSearchDTO) {
		String nextAppSignDate = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.next_app_getSign_date"
				,expenseSearchDTO
		);
		return nextAppSignDate;
	};	

	public int alterExpenseReceipt_no(ExpenseDTO expenseDTO) {
		int alterReceipt_no = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alterExpenseReceipt_no"
				,expenseDTO
		);		
		return alterReceipt_no;
	}; 
	
	public int alterExpensePrice(ExpenseDTO expenseDTO) {
		int alterPrice = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alterExpensePrice"
				,expenseDTO
		);		
		return alterPrice;
	};
	
	public int alterRemarks(ExpenseDTO expenseDTO) {
		int alterReMarks = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alterRemarks"
				,expenseDTO
		);		
		return alterReMarks;
	}; 
	
	public 	int alterDeleteSignDate(ExpenseDTO expenseDTO) {
		int alterDeleteSignDate = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alterDeleteSignDate"
				,expenseDTO
		);			
		return alterDeleteSignDate;	
	};
	
	public 	int alterNextAppUpdateSignCode(ExpenseDTO expenseDTO) {
		int alterSignCode = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alterNextAppUpdateSignCode"
				,expenseDTO
		);	
		System.out.println(alterSignCode);	
		return alterSignCode;	
	};
	
	
	
	
	
	
	
	


	//---------------------------------------------------------------------------------------------
	// 영업업무보고서 총개수 구하기
	public int getexpenseListAllTotCnt(ExpenseSearchDTO expenseSearchDTO) {
		int expenseAllTotCnt = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getexpenseListAllTotCnt"
				,expenseSearchDTO);
		
		return expenseAllTotCnt;
	}
	
	//---------------------------------------------------------------------------------------------
	//---------------------------------------------------------------------------------------------
	// 일일업무보고서 검색 결과물의 총개수 구하기
	public int getexpenseListTotCnt( ExpenseSearchDTO expenseSearchDTO) {
		int expenseTotCnt = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getexpenseListTotCnt"
				,expenseSearchDTO);
		
		return expenseTotCnt;
		
	}
	//---------------------------------------------------------------------------------------------
		


	//---------------------------------------------------------------------------------------------
	// 등록화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	//---------------------------------------------------------------------------------------------
	public List<Next_App_Emp_List> get_next_app_list(ExpenseDTO expenseDTO){
		
		List<Next_App_Emp_List> next_app_list = this.sqlSession.selectList("com.naver.erp.ExpenseDAO.get_next_app_list", expenseDTO);
		
		return next_app_list;
	}
	

	//---------------------------------------------------------------------------------------------
	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언2
	//---------------------------------------------------------------------------------------------
		public List<Next_App_Emp_List> get_next_app_list2(int emp_no2){
			
			List<Next_App_Emp_List> next_app_list = this.sqlSession.selectList("com.naver.erp.ExpenseDAO.get_next_app_list2", emp_no2);
			
			return next_app_list;
		}
		
	

	//---------------------------------------------------------------------------------------------
	// 로그인 입장에서 다음 결제자의 정보를 얻어오는 메소드 선언
	//---------------------------------------------------------------------------------------------
	public Map<String,String> getLogin_NextAppMan(ExpenseDTO expenseDTO){
		Map<String,String> getNextAppMan = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.getLogin_NextAppMan"
				,expenseDTO
		);

		return getNextAppMan;
		
	};
	
	
	
	//********************************************************************
	public int alterDeleteReturnReport(ExpenseDTO expenseDTO) {
		int alterDeleteReturnReport = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.alterDeleteReturnReport"
				,expenseDTO
		);			
		return alterDeleteReturnReport;
	};
	
	public List<Map<String,String>> getAppList(ExpenseDTO expenseDTO){
		  
		  List<Map<String,String>> appList = this.sqlSession.selectList(
					  	"com.naver.erp.ExpenseDAO.getAppList" 
						,expenseDTO 
				  );
					  
		  return appList;
	}; 
	
	public String next_appList_getSign_date(Map<String,String> myInfo) {
		String nextAppListGetSignDate = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.next_appList_getSign_date"
				,myInfo				
		);		
		return nextAppListGetSignDate;
	};
	
	public String my_appList_getSign_date(Map<String,String> myInfo) {
		String myAppListGetSignDate = this.sqlSession.selectOne(
				"com.naver.erp.ExpenseDAO.my_appList_getSign_date"
				,myInfo				
		);		
		return myAppListGetSignDate;
	};
	
	
	
	public String nextAppManEmp_no(Map<String,String> AppEmp_no) {
        String nextAppManEmp_no = this.sqlSession.selectOne(
                "com.naver.erp.ExpenseDAO.nextAppManEmp_no"
                ,AppEmp_no
        );
        return nextAppManEmp_no;

  };
	
	
	
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@12.10추가@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	  public int haveOrNoneReturn_report(ExpenseDTO expenseDTO) {
			int haveOrNoneReturn_report = this.sqlSession.selectOne(
					"com.naver.erp.ExpenseDAO.haveOrNoneReturn_report"
					,expenseDTO
			);	
			System.out.println("호호호"+haveOrNoneReturn_report);
			return haveOrNoneReturn_report;	
	};

	
	
	public int insertReturnResult(ExpenseDTO expenseDTO) {
		int insertReturnResult = this.sqlSession.update(
				"com.naver.erp.ExpenseDAO.insertReturnResult"
				,expenseDTO
		);			
		return insertReturnResult;	
	};	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
