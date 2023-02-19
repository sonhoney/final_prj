package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	private EmployeeDAO  employeeDAO;	
	/*
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판 글] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public EmployeeDTO getEmployee(int emp_no, boolean isEmployeeDetailForm ) {
		System.out.println( "EmployeeServiceImpl.getEmployee 메소 호출 시작!");
		
		if( isEmpDetailForm ) {
			
			//------------------------------------------
			// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
			// [조회수 증가]하고 수정한 행의 개수를 얻는다
			//------------------------------------------
			int updateCount = this.boardDAO.updateReadcount(b_no);
	
			//------------------------------------------
			// [조회수 증가]하고 수정한 행의 개수가 0개면, 즉 삭제되어서 없다면
			//------------------------------------------
			if( updateCount==0 ) { return null;} 
			
		}
		//------------------------------------------
		//EmployeeServiceImpl 객체의 getEmployee 메소드를 호출하여
		// [1개 게시판 글]을 얻는다
		//------------------------------------------
		EmployeeDTO employee = this.employeeDAO.getEmployee(emp_no);
		//------------------------------------------
		// [1개 게시판 글]이 저장된 EmployeeDTO 객체 리턴하기
		//------------------------------------------
		System.out.println( "EmployeeServiceImpl.getEmployee 메소 호출 종료!");
		
		return employee;
	}
	*/
	
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판 글] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public EmployeeDTO getEmployee(int emp_no) {
		System.out.println( "EmployeeServiceImpl.getEmployee 메소 호출 시작!");
		System.out.println( "EmployeeServiceImpl.getEmployee에 " + emp_no );
		/*
		if( isEmpDetailForm ) {
			
			//------------------------------------------
			// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
			// [조회수 증가]하고 수정한 행의 개수를 얻는다
			//------------------------------------------
			int updateCount = this.boardDAO.updateReadcount(b_no);
	
			//------------------------------------------
			// [조회수 증가]하고 수정한 행의 개수가 0개면, 즉 삭제되어서 없다면
			//------------------------------------------
			if( updateCount==0 ) { return null;} 
			
		}*/
		//------------------------------------------
		//EmployeeServiceImpl 객체의 getEmployee 메소드를 호출하여
		// [1개 게시판 글]을 얻는다
		//------------------------------------------
		EmployeeDTO employee = this.employeeDAO.getEmployee(emp_no);
		//------------------------------------------
		// [1개 게시판 글]이 저장된 EmployeeDTO 객체 리턴하기
		//------------------------------------------
		System.out.println( "EmployeeServiceImpl.getEmployee 메소 호출 종료!");
		
		return employee;
	}
	
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public int updateEmp(EmployeeDTO employeeDTO) {
			System.out.println( "EmployeeServiceImpl updateEmp 메소드 진입!");
			//----------------------------------
			// 수정할 게시판의 개수 얻기
			// 만약 수정할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
			//----------------------------------
			int empCnt = this.employeeDAO.getEmpCnt( employeeDTO.getEmp_no() );
			System.out.println( "EmployeeServiceImpl getEmpCnt=>>" + employeeDTO.getEmp_no() );

			if( empCnt==0 ) {
				System.out.println( "EmployeeServiceImpl empCnt: " + empCnt);
				return 0;
			}
			
			
			
			//----------------------------------
			// 수정 실행하고 수정 적용행의 개수 얻기
			//----------------------------------
			int updateEmpCnt = this.employeeDAO.updateEmp( employeeDTO );
			
			//----------------------------------
			// 수정 실행하고 수정 적용행의 개수 리턴하기
			//----------------------------------
			System.out.println( "BoardServiceImpl updateBoard 메소드 종료!");
			return updateEmpCnt;
		}

		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public int deleteEmp(EmployeeDTO employeeDTO) {
			//----------------------------------
			// 삭제할 게시판의 개수 얻기
			// 만약 삭제할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
			//----------------------------------
			int empCnt = this.employeeDAO.getEmpCnt( employeeDTO.getEmp_no() );
			if( empCnt==0 ) {
				return 0;
			}
			/*
			//----------------------------------
			// 암호의 존재 개수 얻기
			// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
			//----------------------------------
			int boardPwdCnt = this.boardDAO.getBoardPwdCnt( boardDTO );
			if( boardPwdCnt==0 ) {
				return -1;
			}
			*/
			/*
			//------------------------------------------
			// [BoardDAOImpl 객체]의 getBoardChildrenCnt 메소드를 호출하여
			// [삭제할 게시판의 자식글 존재 개수]를 얻는다
			//------------------------------------------
			int boardChildrenCnt = this.boardDAO.getBoardChildrenCnt(boardDTO);
			if( boardChildrenCnt>0 ) {
				int updateBoardCnt = this.boardDAO.updateBoardEmpty( boardDTO );
				return -2;
				
			}
			*/
			
			//----------------------------------
			// 삭제 실행하고 삭제 적용행의 개수 얻기
			//----------------------------------
			int deleteEmpCnt = this.employeeDAO.deleteEmp( employeeDTO );

			return deleteEmpCnt;
			
		}

		public List<Map<String,String>> getMgrList (EmployeeDTO employeeDTO){
			List<Map<String,String>> mgrList = this.employeeDAO.getMgrList(employeeDTO) ;

			return mgrList; 
		}

		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 사번 중복체크하고 중복 적용행의 개수를 리턴하는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public int check_emp_no(EmployeeDTO employeeDTO) {
			System.out.println( "EmployeeServiceImpl check_emp_no 메소드 진입!");
			
			
			
			//----------------------------------
			// 수정 실행하고 수정 적용행의 개수 얻기
			//----------------------------------
			int emp_no_check_cnt = this.employeeDAO.check_emp_no( employeeDTO );
			System.out.println( "EmployeeServiceImpl check_emp_no: " );
			
			//----------------------------------
			// 수정 실행하고 수정 적용행의 개수 리턴하기
			//----------------------------------
			System.out.println( "EmployeeServiceImpl check_emp_no 메소드 종료!");
			return emp_no_check_cnt;
			
		}



		
		
} //public class EmployeeServiceImpl implements EmployeeService { 끝
	