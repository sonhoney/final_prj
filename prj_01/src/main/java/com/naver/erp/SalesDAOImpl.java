package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SalesDAOImpl implements SalesDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int first_insertSalesReport(SalesDTO salesDTO) {

		int firstInsertCnt = this.sqlSession.insert(
				"com.naver.erp.SalesDAO.first_insertSalesReport"
				,salesDTO
		);
		return firstInsertCnt;
		
	};
	
	public int first_insertSignFinishReport_Sign_emp(SalesDTO salesDTO) {

			int firstInsertSign = this.sqlSession.insert(
				"com.naver.erp.SalesDAO.first_insertSignFinishReport_Sign_emp"
				,salesDTO
			);
			return firstInsertSign;
		
	};
	
	public List<Map<String,String>> getSalesList(SalesSearchDTO salesSearchDTO){
		
		List<Map<String,String>> salesList = this.sqlSession.selectList(
			"com.naver.erp.SalesDAO.getSalesList"
			,salesSearchDTO
		);
		
		
		return salesList;
	};
	
	public SalesDTO getBoard(Map<String,String> getBoardData) {
		SalesDTO salesDTO = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getBoard"
				,getBoardData				
		);		
		return salesDTO;
	}; 
	
	public Map<String,String> getlastAppMan(SalesSearchDTO salesSearchDTO){
		
		Map<String,String> getlastAppMan = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getlastAppMan"
				,salesSearchDTO
		);
		return getlastAppMan;
		
	};

	public Map<String,String> getlastAppMan(SalesDTO salesDTO){
		
		Map<String,String> getlastAppMan = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getlastAppMan"
				,salesDTO
		);
		return getlastAppMan;
		
	};
	
	public Map<String,String> getNextAppMan(SalesDTO salesDTO){
		
		Map<String,String> getNextAppMan = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getNextAppMan"
				,salesDTO
		);
		return getNextAppMan;
		
	};
	
	public String first_app_getSign_date(SalesSearchDTO salesSearchDTO) {
		String firstAppGetSignDate = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.first_app_getSign_date"
				,salesSearchDTO
		);
		return firstAppGetSignDate;
	};
	
	public String next_app_getSign_date(SalesSearchDTO salesSearchDTO) {
		String nextAppSignDate = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.next_app_getSign_date"
				,salesSearchDTO
		);
		return nextAppSignDate;
		
	};
	
	public String getSign_code(SalesSearchDTO salesSearchDTO) {
		String getSignCode = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getSign_code"
				,salesSearchDTO
		);
		return getSignCode;
		
	};
	
	public String next_app_getSign_code(SalesSearchDTO salesSearchDTO) {
		String nextAppSignDate = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.next_app_getSign_code"
				,salesSearchDTO
		);
		return nextAppSignDate;
	};
	
	public int updateSignCode(SalesDTO salesDTO) {
		
		int updateSign = this.sqlSession.update(
				"com.naver.erp.SalesDAO.updateSignCode"
				,salesDTO
		);
		
		return updateSign;
		
	};
	
	public Map<String,String> getNextSign_finish_report(SalesDTO salesDTO){	
		Map<String,String> getNextSignFinishReport = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getNextSign_finish_report"
				,salesDTO
		);
		return getNextSignFinishReport;
		
	};
	
	
	public int new_insertSignFinishReport_Sign_emp(SalesDTO salesDTO) {
		int newInsertSign = this.sqlSession.insert(
				"com.naver.erp.SalesDAO.new_insertSignFinishReport_Sign_emp"
				,salesDTO
			);
			
			return newInsertSign;	
		
	};
	
	public int alter_Next_App_Sign_Code(SalesDTO salesDTO) {
		int alterNextAppSignCode = this.sqlSession.update(
				"com.naver.erp.SalesDAO.alter_Next_App_Sign_Code"
				,salesDTO
		);	
		
		return alterNextAppSignCode;
		
	};	
	
	public int alter_Next_App_Sign_Date(SalesDTO salesDTO) {
		int alterNextAppSignDate = this.sqlSession.update(
				"com.naver.erp.SalesDAO.alter_Next_App_Sign_Date"
				,salesDTO
		);			
		return alterNextAppSignDate;
	};
	
	public int app_setTime(SalesDTO salesDTO) {
		int appSetTime = this.sqlSession.update(
				"com.naver.erp.SalesDAO.app_setTime"
				,salesDTO
		);
		
		return appSetTime;
		
	};
	
	public 	int updateSignCodeMinus(SalesDTO salesDTO) {
		
		int updateSignCodeMinus = this.sqlSession.update(
				"com.naver.erp.SalesDAO.updateSignCodeMinus"
				,salesDTO
		);
		
		return updateSignCodeMinus;
		
	};
	
	public 	int insertReturnReport(SalesDTO salesDTO) {
		
		int insertReturnReport = this.sqlSession.insert(
				"com.naver.erp.SalesDAO.insertReturnReport"
				,salesDTO
		);
		
		return insertReturnReport;
		
	};
	
	public int alterSalesContent(SalesDTO salesDTO) {
		int alterContent = this.sqlSession.update(
				"com.naver.erp.SalesDAO.alterSalesContent"
				,salesDTO
		);		
		return alterContent;
		
	};
	
	public int alterSalesResult(SalesDTO salesDTO) {
		int alterResult = this.sqlSession.update(
				"com.naver.erp.SalesDAO.alterSalesResult"
				,salesDTO
		);		
		return alterResult;
		
	};
	
	
	public 	int alterDeleteSignDate(SalesDTO salesDTO) {
		int alterDeleteSignDate = this.sqlSession.update(
				"com.naver.erp.SalesDAO.alterDeleteSignDate"
				,salesDTO
		);			
		return alterDeleteSignDate;	
	};
	
	public 	int alterNextAppUpdateSignCode(SalesDTO salesDTO) {
		int alterSignCode = this.sqlSession.update(
				"com.naver.erp.SalesDAO.alterNextAppUpdateSignCode"
				,salesDTO
		);	
		System.out.println(alterSignCode);	
		return alterSignCode;	
		
	};
	
	

	//---------------------------------------------------------------------------------------------
	// 로그인 입장에서 다음 결제자의 정보를 얻어오는 메소드 선언
	//---------------------------------------------------------------------------------------------
	public Map<String,String> getLogin_NextAppMan(SalesDTO salesDTO){
		Map<String,String> getNextAppMan = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getLogin_NextAppMan"
				,salesDTO
		);

		return getNextAppMan;
		
	};
	

	
	//---------------------------------------------------------------------------------------------
	// 등록화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	//---------------------------------------------------------------------------------------------
		public List<Next_App_Emp_List> get_next_app_list(SalesDTO salesDTO){
			
			List<Next_App_Emp_List> next_app_list = this.sqlSession.selectList("com.naver.erp.SalesDAO.get_next_app_list", salesDTO);
			
			return next_app_list;
		}

		

	//---------------------------------------------------------------------------------------------
	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	//---------------------------------------------------------------------------------------------
		public List<Next_App_Emp_List> get_next_app_list2(int emp_no2){
			
			List<Next_App_Emp_List> next_app_list = this.sqlSession.selectList("com.naver.erp.SalesDAO.get_next_app_list2", emp_no2);
			
			return next_app_list;
		}
		
		
	


	//---------------------------------------------------------------------------------------------
	// 영업업무보고서 총개수 구하기
	public int getsalesListAllTotCnt(SalesSearchDTO salesSearchDTO) {
		int salesAllTotCnt = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getsalesListAllTotCnt"
				,salesSearchDTO);
		
		return salesAllTotCnt;
	}
	
	//---------------------------------------------------------------------------------------------
	
	//---------------------------------------------------------------------------------------------
	// 일일업무보고서 검색 결과물의 총개수 구하기
	public int getsalesListTotCnt( SalesSearchDTO salesSearchDTO) {
		int salesTotCnt = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.getsalesListTotCnt"
				,salesSearchDTO);
		
		return salesTotCnt;
		
	}
	//---------------------------------------------------------------------------------------------
	

	//***********************************************************************
	//***********************************************************************
	public int alterDeleteReturnReport(SalesDTO salesDTO) {
		int alterDeleteReturnReport = this.sqlSession.update(
				"com.naver.erp.SalesDAO.alterDeleteReturnReport"
				,salesDTO
		);			
		return alterDeleteReturnReport;	
	};
	
	public List<Map<String,String>> getAppList(SalesDTO salesDTO){
		  
		  List<Map<String,String>> appList = this.sqlSession.selectList(
					  	"com.naver.erp.SalesDAO.getAppList" 
						,salesDTO 
				  );
					  
		  return appList; 
	}; 
	
	public String next_appList_getSign_date(Map<String,String> myInfo) {
		String nextAppListGetSignDate = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.next_appList_getSign_date"
				,myInfo				
		);		
		return nextAppListGetSignDate;
	};
	
	public String my_appList_getSign_date(Map<String,String> myInfo) {
		String myAppListGetSignDate = this.sqlSession.selectOne(
				"com.naver.erp.SalesDAO.my_appList_getSign_date"
				,myInfo				
		);		
		return myAppListGetSignDate;
	};
	//***********************************************************************
	//***********************************************************************
	public String nextAppManEmp_no(Map<String,String> AppEmp_no) {
        String nextAppManEmp_no = this.sqlSession.selectOne(
                "com.naver.erp.SalesDAO.nextAppManEmp_no"
                ,AppEmp_no
        );
        return nextAppManEmp_no;

  };
	
  
	//***********************************************************************

	 public int haveOrNoneReturn_report(SalesDTO salesDTO) {
			int haveOrNoneReturn_report = this.sqlSession.selectOne(
					"com.naver.erp.SalesDAO.haveOrNoneReturn_report"
					,salesDTO
			);	
			System.out.println("호호호"+haveOrNoneReturn_report);
			return haveOrNoneReturn_report;	
	 };
	
	public int insertReturnResult(SalesDTO salesDTO) {
		int insertReturnResult = this.sqlSession.update(
				"com.naver.erp.SalesDAO.insertReturnResult"
				,salesDTO
		);			
		return insertReturnResult;	
	};	


	
	
}
