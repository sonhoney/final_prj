package com.naver.erp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DailyDAOImpl implements DailyDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	
	//---------------------------------------------------------------------------------------------
	// 일일업무일지 리스트를 가져오는 dailyList 객체
	//---------------------------------------------------------------------------------------------
	public List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO){	
						
		List<Map<String,String>> dailyList = this.sqlSession.selectList(
				"com.naver.erp.DailyDAO.getDailyList"
				,dailyBusiSearchDTO
		);
		
		
		return dailyList;
	};

	//---------------------------------------------------------------------------------------------
	// 최종 결제자의 정보를 얻어오는 메소드 선언
	//---------------------------------------------------------------------------------------------
	public Map<String,String> getlastAppMan(DailyBusiSearchDTO dailyBusiSearchDTO){
		
		Map<String,String> getlastAppMan = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getlastAppMan"
				,dailyBusiSearchDTO
		);
		return getlastAppMan;
		
	};

	//---------------------------------------------------------------------------------------------
	// 만약 첫결재자 라면 바로 앞 결재자의 시간을 얻어오는 메소드
	//---------------------------------------------------------------------------------------------
	public String first_app_getSign_date(DailyBusiSearchDTO dailyBusiSearchDTO) {
		String firstAppGetSignDate = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.first_app_getSign_date"
				,dailyBusiSearchDTO
		);
		return firstAppGetSignDate;
	};

	//---------------------------------------------------------------------------------------------
	// 다음결제자의 결제시간을 얻어오는 메소드
	//---------------------------------------------------------------------------------------------
	public String next_app_getSign_date(DailyBusiSearchDTO dailyBusiSearchDTO) {
		String nextAppSignDate = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.next_app_getSign_date"
				,dailyBusiSearchDTO
		);
		return nextAppSignDate;
	};
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	// 일일업무보고서 총개수 구하기
	public int getdailyBusiListAllTotCnt(DailyBusiSearchDTO dailyBusiSearchDTO) {
		int daliyBusiAllTotCnt = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getdailyBusiListAllTotCnt"
				,dailyBusiSearchDTO);
		
		return daliyBusiAllTotCnt;
	}
	
	//---------------------------------------------------------------------------------------------
	
	
	

	//---------------------------------------------------------------------------------------------
	// 일일업무보고서 검색 결과물의 총개수 구하기
	public int getdailyBusiListTotCnt( DailyBusiSearchDTO dailyBusiSearchDTO) {
		int daliyBusiTotCnt = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getdailyBusiListTotCnt"
				,dailyBusiSearchDTO);
		
		return daliyBusiTotCnt;
		
	}
	//---------------------------------------------------------------------------------------------
	
	
	
	
	
	
	
	
	
	
	

	//---------------------------------------------------------------------------------------------
	// 결재여부 날짜 라턴 받는 메소드 
	public String getSign_date(DailyBusiSearchDTO dailyBusiSearchDTO) {
		String getSigndate = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getSign_date"
				,dailyBusiSearchDTO
		);
		return getSigndate;
	};

	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	// 결재여부 리턴 받는 메소드 
	//---------------------------------------------------------------------------------------------
	public String getSign_code(DailyBusiSearchDTO dailyBusiSearchDTO) {
		String getSignCode = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getSign_code"
				,dailyBusiSearchDTO
		);
		return getSignCode;
	};
	
	
	

	//---------------------------------------------------------------------------------------------
	// null 이라는건 최초작성자 라는 의미 
	// 넘어오는 데이터는 최초작성자의 emp_no 와 report_no
	// 다음 결재자 결재여부코드를 가져오는 메소드
	//---------------------------------------------------------------------------------------------
	public String next_app_getSign_code(DailyBusiSearchDTO dailyBusiSearchDTO) {
		String nextAppSignCode = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.next_app_getSign_code"
				,dailyBusiSearchDTO
		);
		return nextAppSignCode;
	};
	
	
	
	
	
	//---------------------------------------------------------------------------------------------
	// 자신이 작성한 일일업무보고서 적용 행의 개수 리턴 메소드
	//---------------------------------------------------------------------------------------------
	public int first_insertDailyReport(DailyBusiDTO dailyBusiDTO) {

		int firstInsertCnt = this.sqlSession.insert(
				"com.naver.erp.DailyDAO.first_insertDailyReport"
				,dailyBusiDTO
		);
		
		return firstInsertCnt;
	};

	//---------------------------------------------------------------------------------------------
	// 자신의 일일업무보고서의 다음결재자를 보고서결재정보 테이블에 적용하는 메소드
	//---------------------------------------------------------------------------------------------
	public int first_insertSignFinishReport_Sign_emp(DailyBusiDTO dailyBusiDTO) {
		
		int firstInsertSign = this.sqlSession.insert(
			"com.naver.erp.DailyDAO.first_insertSignFinishReport_Sign_emp"
			,dailyBusiDTO
		);
		
		return firstInsertSign;
	}
	
	
	
	// 최종 결제자의 정보를 얻어오는 메소드 선언 
	public Map<String,String> getlastAppMan(DailyBusiDTO dailyBusiDTO){
		
		Map<String,String> getlastAppMan = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getlastAppMan"
				,dailyBusiDTO
		);
		return getlastAppMan;
		
	};

	
	
	
	//---------------------------------------------------------------------------------------------
	// 일일업무보고서 번호에 해당하는 상세화면에 띄어줄 데이터 검색 결과 개수 리턴 메소드
	//---------------------------------------------------------------------------------------------
	public DailyBusiDTO getBoard(Map<String,String> getBoardData) {
		DailyBusiDTO dailyBusiDTO = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getBoard"
				,getBoardData				
		);		
		return dailyBusiDTO;
	};
	

	
	
	
	

	//---------------------------------------------------------------------------------------------
	// 결재/반려에서 결재코드 결재로 업데이트 성공 여부 리턴 메소드
	//---------------------------------------------------------------------------------------------
	public int updateSignCode(DailyBusiDTO dailyBusiDTO) {
		
		int updateSign = this.sqlSession.update(
				"com.naver.erp.DailyDAO.updateSignCode"
				,dailyBusiDTO
		);
		
		return updateSign;
		
	};
	
	//---------------------------------------------------------------------------------------------
	// 결재/반려에서 결재코드 결재로 업데이트 성공 시 새로운 결재코드 입력 행의 개수 리턴 메소드
	//---------------------------------------------------------------------------------------------
	public int new_insertSignFinishReport_Sign_emp(DailyBusiDTO dailyBusiDTO) {		
		int newInsertSign = this.sqlSession.insert(
			"com.naver.erp.DailyDAO.new_insertSignFinishReport_Sign_emp"
			,dailyBusiDTO
		);
		
		return newInsertSign;		
	};
	
	
	
	
	

	//---------------------------------------------------------------------------------------------
	// 결재/반려에서 결재코드 반려로 업데이트 성공 여부 리턴 메소드
	//---------------------------------------------------------------------------------------------
	public int updateSignCodeMinus(DailyBusiDTO dailyBusiDTO) {
		
		int updateSignCodeMinus = this.sqlSession.update(
				"com.naver.erp.DailyDAO.updateSignCodeMinus"
				,dailyBusiDTO
		);
		
		return updateSignCodeMinus;
	};
	
	//---------------------------------------------------------------------------------------------------------------------
	// 결재/반려에서 결재코드 반려로 업데이트 성공 시 반려테이블에 반려된 보고서번호와 반려사유 입력 행의 개수 리턴 메소드
	//---------------------------------------------------------------------------------------------------------------------
	public int insertReturnReport(DailyBusiDTO dailyBusiDTO) {
		
		int insertReturnReport = this.sqlSession.insert(
				"com.naver.erp.DailyDAO.insertReturnReport"
				,dailyBusiDTO
		);
		
		return insertReturnReport;
		
	};
	

	
	
	
	//---------------------------------------------------------------------------------------------
	// 등록화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	//---------------------------------------------------------------------------------------------
		public List<Next_App_Emp_List> get_next_app_list(DailyBusiDTO dailyBusiDTO){
			
			List<Next_App_Emp_List> next_app_list = this.sqlSession.selectList("com.naver.erp.DailyDAO.get_next_app_list", dailyBusiDTO);
			
			return next_app_list;
		}

	//---------------------------------------------------------------------------------------------
	// 상세화면 다음 결쟈자 목록 리스트 리턴하는 메소드 선언
	//---------------------------------------------------------------------------------------------
		public List<Next_App_Emp_List> get_next_app_list2(int emp_no2){
			
			List<Next_App_Emp_List> next_app_list = this.sqlSession.selectList("com.naver.erp.DailyDAO.get_next_app_list", emp_no2);
			
			return next_app_list;
		}
		
		
		
	//---------------------------------------------------------------------------------------------
	// 들어온 번호를 통해 컨텐츠내용 업데이트 하는 메소드 선언
	//---------------------------------------------------------------------------------------------
	public int alterDailBusiContent(DailyBusiDTO dailyBusiDTO) {
		int alterContent = this.sqlSession.update(
				"com.naver.erp.DailyDAO.alterDailBusiContent"
				,dailyBusiDTO
		);		
		return alterContent;		
	};
		
	//---------------------------------------------------------------------------------------------
	// 시간 다비우기
	//---------------------------------------------------------------------------------------------
	public int alterDeleteSignDate(DailyBusiDTO dailyBusiDTO) {
		int alterDeleteSignDate = this.sqlSession.update(
				"com.naver.erp.DailyDAO.alterDeleteSignDate"
				,dailyBusiDTO
		);			
		return alterDeleteSignDate;		
	};	
		
	//---------------------------------------------------------------------------------------------
	// 들어온 번호를 통해 다음 놈 사인코드 업데이트 하는 메소드 선언
	//---------------------------------------------------------------------------------------------
	public int alterNextAppUpdateSignCode(DailyBusiDTO dailyBusiDTO) {
		int alterSignCode = this.sqlSession.update(
				"com.naver.erp.DailyDAO.alterNextAppUpdateSignCode"
				,dailyBusiDTO
		);	

		return alterSignCode;		
	};	
		

	//---------------------------------------------------------------------------------------------------------------------------------------------
	
	public Map<String,String> getNextSign_finish_report(DailyBusiDTO dailyBusiDTO){		
		Map<String,String> getNextSignFinishReport = this.sqlSession.selectOne(
				"com.naver.erp.DailyDAO.getNextSign_finish_report"
				,dailyBusiDTO
		);
		return getNextSignFinishReport;
	};
	
	public int alter_Next_App_Sign_Code(DailyBusiDTO dailyBusiDTO) {
		int alterNextAppSignCode = this.sqlSession.update(
				"com.naver.erp.DailyDAO.alter_Next_App_Sign_Code"
				,dailyBusiDTO
		);	
		
		return alterNextAppSignCode;				
	};
	
	public int alter_Next_App_Sign_Date(DailyBusiDTO dailyBusiDTO) {
		int alterNextAppSignDate = this.sqlSession.update(
				"com.naver.erp.DailyDAO.alter_Next_App_Sign_Date"
				,dailyBusiDTO
		);			
		return alterNextAppSignDate;
	};
	//---------------------------------------------------------------------------------------------
		// 첫 결재자 입장에서 다음 결제자의 정보를 얻어오는 메소드 선언
		//---------------------------------------------------------------------------------------------
		public Map<String,String> getNextAppMan(DailyBusiDTO dailyBusiDTO){
			Map<String,String> getNextAppMan = this.sqlSession.selectOne(
					"com.naver.erp.DailyDAO.getNextAppMan"
					,dailyBusiDTO
			);

			return getNextAppMan;
			
		};

	//---------------------------------------------------------------------------------------------
		// 로그인 입장에서 다음 결제자의 정보를 얻어오는 메소드 선언
		//---------------------------------------------------------------------------------------------
		public Map<String,String> getLogin_NextAppMan(DailyBusiDTO dailyBusiDTO){
			Map<String,String> getNextAppMan = this.sqlSession.selectOne(
					"com.naver.erp.DailyDAO.getLogin_NextAppMan"
					,dailyBusiDTO
			);

			return getNextAppMan;
			
		};
		
	//---------------------------------------------------------------------------------------------
		// 다음 결재자 없으면 현 결재자의 시간을 업데이트 후 적용된 행의 개수를 리턴하는 메소드
		//---------------------------------------------------------------------------------------------
		public int app_setTime(DailyBusiDTO dailyBusiDTO) {		
			int appSetTime = this.sqlSession.update(
					"com.naver.erp.DailyDAO.app_setTime"
					,dailyBusiDTO
			);
			
			return appSetTime;
		};
//---------------------------------------------------------------------------------------------------------------------------------------------
	
	
		//**************************************************************************************************************************************
		 public String next_appList_getSign_date(Map<String,String> myInfo) {
				String nextAppListGetSignDate = this.sqlSession.selectOne(
						"com.naver.erp.DailyDAO.next_appList_getSign_date"
						,myInfo				
				);		
				return nextAppListGetSignDate;
		 };
		 
		 public String my_appList_getSign_date(Map<String,String>  myInfo) {
				String myAppListGetSignDate = this.sqlSession.selectOne(
						"com.naver.erp.DailyDAO.my_appList_getSign_date"
						,myInfo				
				);		
				return myAppListGetSignDate;
		 };
		 
		//**************************************************************************************************************************************
		//**************************************************************************************************************************************
		public int alterDeleteReturnReport(DailyBusiDTO dailyBusiDTO) {
			int alteralterDeleteReturnReport = this.sqlSession.update(
					"com.naver.erp.DailyDAO.alterDeleteReturnReport"
					,dailyBusiDTO
			);			
			return alteralterDeleteReturnReport;	
		};

		//**************************************************************************************************************************************
		//**************************************************************************************************************************************

		//**************************************************************************************************************************************
		 public List<Map<String,String>> getAppList(DailyBusiDTO dailyBusiDTO){
		  
		  List<Map<String,String>> appList = this.sqlSession.selectList(
					  	"com.naver.erp.DailyDAO.getAppList" 
						,dailyBusiDTO 
				  );
					  
		  return appList; 
		  };
			 
	
	
	
	
	

		//**************************************************************************************************************************************


	  
		  public String nextAppManEmp_no(Map<String,String> AppEmp_no) {
	            String nextAppManEmp_no = this.sqlSession.selectOne(
	                    "com.naver.erp.DailyDAO.nextAppManEmp_no"
	                    ,AppEmp_no
	            );
	            return nextAppManEmp_no;
	
	      };


		//**************************************************************************************************************************************
	          
	          
	          

		//*********12.10 추가**********************************************************************************************************************    
          
		  public int haveOrNoneReturn_report(DailyBusiDTO dailyBusiDTO) {
			int haveOrNoneReturn_report = this.sqlSession.selectOne(
					"com.naver.erp.DailyDAO.haveOrNoneReturn_report"
					,dailyBusiDTO
			);	
			System.out.println("호호호"+haveOrNoneReturn_report);
			return haveOrNoneReturn_report;	
		  };
		      
		      
		      
		  public int insertReturnResult(DailyBusiDTO dailyBusiDTO) {
			int insertReturnResult = this.sqlSession.update(
					"com.naver.erp.DailyDAO.insertReturnResult"
					,dailyBusiDTO
			);			
			return insertReturnResult;	
		};	
		//*********12.10 추가**********************************************************************************************************************  
	          
	          
	          
	          
	          
	          
	          
	          
	          
	          
	
	
	/*
	//[검색한 일일업무보고서 목록]을 리턴하는 메소드 선언
	List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO){
		return;
	}

	//[검색한 일일업무보고서 목록의 개수]를 리턴하는 메소드 선언 
	int getDailyListAllCnt(DailyBusiSearchDTO dailyBusiSearchDTO) {
		return;		
	}

	//[일일업무보고서 작성한 직원/보고서 정보 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int first_insertSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[다음 결재자/보고서 정보 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int first_insertSignFinishReport_Sign_emp(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[1개의 일일업무보고서 반려테이블에 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int first_insertReturnReport(DailyBusiDTO dailyBusiDTO)  {
		return;		
	}

	//[1개의 일일업무보고서 글]을 리턴하는 메소드 선언
	DailyBusiDTO getDailyDTO(Map<String, String> paramsMap) {
		return;		
	}

	//[1개의 일일업무보고서의 결재내역]을 리턴하는 메소드 선언
	List<Map<String, String>> getSignList(Map<String, String> paramsMap) {
		return;		
	}

	//[1개의 일일업무보고서의 반려 횟수]를 리턴하는 메소드 선언
	int getMax_return_no(Map<String, String> paramsMap) {
		return;		
	}

	//[1개의 일일업무보고서 수정 후 수정행의 개수]를 리턴하는 메소드 선언
	int updateDailyReport_inside(DailyBusiDTO dailyBusiDTO)  {
		return;		
	}

	//[반려된 일일업무보고서 작성한 직원의 결재상태 수정 후 수정행의 개수]를 리턴하는 메소드 선언
	int updateSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[반려된 일일업무보고서 다음 결재자의 결재상태 수정 후 수정행의 개수]를 리턴하는 메소드 선언
	int updateNextSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		return;	
	}

	//[1개의 일일업무보고서의 수정 시 1명의 다음 결재자]를 리턴하는 메소드 선언
	Map<String, String> pickNextEmployee(Map<String,String> paramsMap) {
		return;		
	}

	//[다음 결재자/보고서 정보 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int insertSignFinishReport(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[결재한 직원의 결재상태 수정 후 수정행의 개수]를 리턴하는 메소드 선언
	int updateSignFinishReport_Boryu(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[1개의 일일업무보고서의 수정횟수 1 증가 후 적용행의 개수]를 리턴하는 메소드 선언
	int updateDailyReport(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[최종 결재자와 이전 결재 리스트]를 리턴하는 메소드 선언
	List<String> getReturn_emp_no(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[반련된 보고서의 결재 리스트들 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int insertSignFinishReport_many(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[반려된 보고서 번호와 반려사유 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int insertReturnReport(DailyBusiDTO dailyBusiDTO) {
		return;		
	}

	//[결재최종완료된 보고서 입력 후 적용행의 개수]를 리턴하는 메소드 선언
	int insertSignFinishReport_many_finish(DailyBusiDTO dailyBusiDTO) {
		return;		
	}
	*/
}
