package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/*
	//******************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//******************************************
	public List<Map<String,String>> getEmpList( ){
		//------------------------------------------------------------
		// SqlSessionTemplate 객체의 selectList 메소드 호출로 
		// n행m열의 게시판 글을 List<Map<String,String>> 로 받아오기
		//------------------------------------------------------------
	
		List<Map<String,String>> empList = this.sqlSession.selectList(
				"com.naver.erp.EmployeeDAO.getEmpList"
				
		);
		return empList;
	}
	*/
	
	//******************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//******************************************
	public List<Map<String,String>> getEmpList( EmployeeSearchDTO 	employeeSearchDTO ){
		
			System.out.println(  "여기는 DAOImpl employeeSearchDTO.getDepSearch => " + employeeSearchDTO.getDepSearch() );
			System.out.println(  "여기는 DAOImpl employeeSearchDTO.getJikupSearch => " + employeeSearchDTO.getJikupSearch() );
		//------------------------------------------------------------
		// SqlSessionTemplate 객체의 selectList 메소드 호출로 
		// n행m열의 게시판 글을 List<Map<String,String>> 로 받아오기
		//------------------------------------------------------------
	
		List<Map<String,String>> getEmpList = this.sqlSession.selectList(
				"com.naver.erp.EmployeeDAO.getEmpList"
				, employeeSearchDTO
				
		);
		return getEmpList;
	}

		//****************************************************
		// [1개 게시판 글 정보] 리턴하는 메소드 선언
		//****************************************************
		public EmployeeDTO getEmployee(int emp_no) {
				System.out.println( "EmployeeDAOImpl.getEmployee 메소 호출 시작!");
			//-------------------------------------------------------
			// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [1개 게시판 글 정보] 얻기
			// selectOne 은 1행 m열의 select 결과를 얻을 때 사용하는 메소드이다.
			//-------------------------------------------------------
			EmployeeDTO employee = this.sqlSession.selectOne(
					//-----------------------------------------
					// 실행할 SQL 구문의 위치 지정
					//-----------------------------------------
					"com.naver.erp.EmployeeDAO.getEmployee"	
					//-----------------------------------------
					// 실행할 SQL 구문에서 사용되는 데이터
					//-----------------------------------------
					,emp_no		
			);
				System.out.println( employee );
			//-------------------------------------------------------
			// [1개 게시판 글 정보] 리턴하기
			//-------------------------------------------------------
				System.out.println( "EmployeeDAOImpl.getEmployee 메소 호출 종료!");
			return employee;		
			
		}
	
	//****************************************
	// [검색한 사원 목록]의 총개수 리턴하는 메소드 선언
	//****************************************
	public int getEmpListTotCnt(EmployeeSearchDTO employeeSearchDTO) {
		//-----------------------------------------
		// [SqlSesseion 객체]의 selectOne(~,~)를 호출하여 [검색한 게시판 목록 개수] 얻기
		// selectOne은 1행 m열의 select 결과를 얻을 때 사용하는 메소드이다.
		//-----------------------------------------
		int empListTotCnt = this.sqlSession.selectOne(
				//-------------------------------
				// 실행할 SQL 구문 위치 지정
				//-------------------------------
				"com.naver.erp.EmployeeDAO.getEmpListTotCnt"
				//-------------------------------
				// 실행할 SQL 구문에서 사용되는 데이터
				//-------------------------------
				,employeeSearchDTO
				
			);
		return empListTotCnt;
	}

	
	//****************************************
	// [사원 목록]의 총 개수 리턴하는 메소드 선언
	//****************************************
	public int getEmpListAllTotCnt() {
		//-----------------------------------------
		// [SqlSesseion 객체]의 selectOne(~,~)를 호출하여 [게시판 목록]의 총 개수 얻기
		// selectOne은 1행 m열의 select 결과를 얻을 때 사용하는 메소드이다.
		//-----------------------------------------
		int empListAllTotCnt = this.sqlSession.selectOne(
				//-------------------------------
				// 실행할 SQL 구문 위치 지정
				//-------------------------------
				"com.naver.erp.EmployeeDAO.getEmpListAllTotCnt"
				
				
			);
		return empListAllTotCnt;
	}

	
		//****************************************************
		// [게시판 글 입력 후 입력 적용 행의 개수]를 리턴하는 메소드 선언
		//****************************************************
		public int insertEmp(EmployeeDTO employeeDTO) {
			//------------------------------------------------------------
			// SqlSessionTemplate 객체의 insert 메소드 호출로 
			// 게시판 글 입력 SQL 구문을 실행하고 입력 성공 행의 개수얻기
			//------------------------------------------------------------
			int empRegCnt = sqlSession.insert(		
					//-----------------------------------------
					// 실행할 SQL 구문의 위치 지정
					//-----------------------------------------
					"com.naver.erp.EmployeeDAO.insertEmp"
					
					//-----------------------------------------
					// 실행할 SQL 구문에서 사용되는 데이터
					//-----------------------------------------
					,employeeDTO
					
			);
			return empRegCnt;
		}
	

		//****************************************************
		// 삭제/수정할 게시판의 존재 개수를 리턴하는 메소드 선언
		//****************************************************
		public int getEmpCnt(int emp_no) {
			//-------------------------------------------------------
			// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [게시판의 존재 개수] 얻기
			//-------------------------------------------------------
			int empCnt = this.sqlSession.selectOne(
					//-----------------------------------------
					// 실행할 SQL 구문의 위치 지정
					//-----------------------------------------
					"com.naver.erp.EmployeeDAO.getEmpCnt" 
					//-----------------------------------------
					// 실행할 SQL 구문에서 사용되는 데이터
					//-----------------------------------------
					,emp_no					        
			);
			return empCnt;
		}
		
		
		
		
		//****************************************************
		// 게시판 수정 후 수정행의 적용 개수를 리턴하는 메소드선언
		//****************************************************
		public int updateEmp(EmployeeDTO employeeDTO) {
			//-------------------------------------------------------
			// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 
			// [게시판 수정 명령]한 후 수정 적용행의 개수얻기
			//-------------------------------------------------------
			int updateEmpCnt = this.sqlSession.update(
					//-----------------------------------------
					// 실행할 SQL 구문의 위치 지정
					//-----------------------------------------
					"com.naver.erp.EmployeeDAO.updateEmp"
					//-----------------------------------------
					// 실행할 SQL 구문에서 사용되는 데이터
					//-----------------------------------------
					,employeeDTO							     
			);
			return updateEmpCnt;
		}
		
		//****************************************************
		// 게시판 삭제 명령한 후 삭제 적용행의 개수를 리턴하는 메소드 선언
		//****************************************************
		public int deleteEmp(EmployeeDTO employeeDTO) {
			//-------------------------------------------------------
			// [SqlSessionTemplate 객체]의 delete(~,~) 를 호출하여 
			// [게시판 삭제 명령]한 후 삭제 적용행의 개수얻기
			//-------------------------------------------------------
			int deleteEmpCnt = this.sqlSession.delete(
					//-----------------------------------------
					// 실행할 SQL 구문의 위치 지정
					//-----------------------------------------
					"com.naver.erp.EmployeeDAO.deleteEmp"
					//-----------------------------------------
					// 실행할 SQL 구문에서 사용되는 데이터
					//-----------------------------------------
					,employeeDTO							     
			);
			return deleteEmpCnt;
		}

		public List<Map<String,String>> getMgrList (EmployeeDTO employeeDTO){
			
			List<Map<String,String>> mgrList = this.sqlSession.selectList(
				"com.naver.erp.EmployeeDAO.getMgrList"
				, employeeDTO
			);

			return mgrList ;

		}

		//****************************************************
		// 사번 중복체크 후 중복행의 적용 개수를 리턴하는 메소드선언
		//****************************************************
		public int check_emp_no(EmployeeDTO employeeDTO) {
			//-------------------------------------------------------
			// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 
			// [게시판 수정 명령]한 후 수정 적용행의 개수얻기
			//-------------------------------------------------------
			int emp_no_check_cnt = this.sqlSession.selectOne(
					//-----------------------------------------
					// 실행할 SQL 구문의 위치 지정
					//-----------------------------------------
					"com.naver.erp.EmployeeDAO.check_emp_no"
					//-----------------------------------------
					// 실행할 SQL 구문에서 사용되는 데이터
					//-----------------------------------------
					,employeeDTO							     
			);
			return emp_no_check_cnt;
		}



	
} // public class EmployeeDAOImpl implements EmployeeDAO { 끝
	
	