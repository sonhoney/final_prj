package com.naver.erp;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmployeeController {
	@Autowired
	private EmployeeDAO employeeDAO; 
	@Autowired
	private EmployeeService employeeService;
	
		
	
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 가상주소 /empList.do로 접근하면 호출되는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping( value="/empList.do")
		
		public ModelAndView empList( 
				EmployeeSearchDTO 	employeeSearchDTO
				,HttpServletRequest request 
				, HttpServletResponse response 
				, Object handler
				) throws IOException{
				System.out.println("EmployeeController.empList 메소드 호출");
				HttpSession session = request.getSession();  
				String emp_role = (String)session.getAttribute("emp_role");	
				
				// 만약 emp_role이 user면 메인 화면으로 보내기
				/*
					if(emp_role!="admin") {
						response.sendRedirect( "/boardList.do" );
					}
				*/
				
				//*******************************************
				// 게시판의 [총 개수] 구하기 
				// 검색된 놈의 총 개수가 아닌 모든 총 개수 구하기
				// (DB연동)
				//*******************************************
					// DAOImpl 객체의 getBoardListAllTotCnt 메소드 호출하여 게시판의 총 개수 구하기
				int empAllTotCnt = this.employeeDAO.getEmpListAllTotCnt();
				//*******************************************
				// 게시판의 [검색 결과물의 총 개수] 구하기.
				// 검색된 놈의 총 개수
				// (DB연동)
				//*******************************************
				int empTotCnt = this.employeeDAO.getEmpListTotCnt(employeeSearchDTO);
					
				//*******************************************
				// [페이징 처리 관련 데이터와 기타 데이터(DB 연동 시 필요한 데이터, 보정된 선택 페이지 번호 등)]가 저장된 HashMap 객체 얻기
				// Util 객체의 getPagingMap라는 메소드 호출로 얻는다.
				//*******************************************
				Map<String,Integer> pagingMap = Util.getPagingMap(
						employeeSearchDTO.getSelectPageNo() 	//int selectPageNo	선택한 페이지 번호가 boardSearchDTO에 들어있다.
						,employeeSearchDTO.getRowCntPerPage()  //,int rowCntPerPage	한 화면에 보여지는 행의 개수
						,empTotCnt						// 검색된 사원의 총 개수
					);
				
				//*******************************************
				// BoardSearchDTO 객체의 selectPageNo 속성변수에 보정된 선택 페이지 번호를 재저장한다.
				// BoardSearchDTO 객체의 begin_rowNo 속성변수에 검색 결과물에서 페이지 번호에 맞게 일정 부분을 가져올 때 시작행 번호를 저장하기
				// BoardSearchDTO 객체의 end_rowNo 속성변수에 검색 결과물에서 페이지 번호에 맞는 부분을 가져올 때 끝행 번호를 저장하기
				// 보정된 선택 페이지 번호는 setSelectPageNo 안 HashMap 객체에 있다..?
				// 1페이지 당 
				//*******************************************
				employeeSearchDTO.setSelectPageNo( (int)pagingMap.get("selectPageNo") );
				employeeSearchDTO.setBegin_rowNo( (int)pagingMap.get("begin_rowNo") ); //begin_rowNo 데이터베이스에서 시작행번호 가져옴
				employeeSearchDTO.setEnd_rowNo( (int)pagingMap.get("end_rowNo") );
				
				
			//*******************************************
			// [ModelAndView 객체] 생성하기
			// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
			// [ModelAndView 객체] 리턴하기
			//*******************************************
			
			List<Map<String,String>> empList =  this.employeeDAO.getEmpList( employeeSearchDTO );
			
			ModelAndView mav = new ModelAndView( );

			
			mav.addObject(  "empList" , empList );
			mav.addObject(  "empTotCnt" , empTotCnt );
			mav.addObject(  "empAllTotCnt" , empAllTotCnt );
			mav.addObject(  "pagingMap" , pagingMap );
			mav.addObject(  "selectPageNo" , (int)pagingMap.get("selectPageNo"));
		
		
			mav.setViewName( "empList.jsp" );
				System.out.println("EmployeeController.empList 메소드 호출 끝");
			return  mav;
		
		}
		
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// /empDetailForm.do 접속 시 호출되는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping( value="/empDetailForm.do" )
		public ModelAndView empDetailForm( 	
				
				//---------------------------------------
				// "emp_no" 라는 파라미터명의 파라미터값이 저장되는 매개변수 emp_no 선언
				// 싱세보기할 게시판 고유 번호가 들어오는 매개변수선언
				//---------------------------------------
				@RequestParam(value="emp_no") int emp_no
				//@RequestBody(value="emp_pwd_confirm") int emp_pwd_confirm
		){
					System.out.println( "EmployeeController.empDetailForm 메소 호출 시작!");
					System.out.println( "employeeDTO.getEmployee() => " + emp_no );
			
			//*******************************************
			// [EmployeeService 객체]의 getEmployee 메소드 호출로 [1개의 게시판 글]을 employeeDTO 객체에 담아오기
			//*******************************************
				EmployeeDTO employeeDTO = this.employeeService.getEmployee(emp_no); 
			
					System.out.println( "여기는 컨트롤러 empDetailForm.do.getEmployee() 번호=> " + employeeDTO.getEmp_no() );
					System.out.println( "여기는 컨트롤러 empDetailForm.do.getEmployee() 직속상관이름=> " + employeeDTO.getEmp_name2() );
					System.out.println( "여기는 컨트롤러 empDetailForm.do.getEmployee() 비번=> " + employeeDTO.getEmp_pwd() );
					//System.out.println( "여기는 컨트롤러 empDetailForm.do.getEmployee() 새비번확인=> " + employeeDTO.getEmp_pwd_confirm() );
			//System.out.println( "EmployeeController.empDetailForm 11");
			//*******************************************
			// [ModelAndView 객체] 생성하기
			// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
			// [ModelAndView 객체]에 1개의 게시판 글을 저장한 EmployeeDTO 객체 저장하기
			//*******************************************
			ModelAndView mav = new ModelAndView( );
			mav.addObject("employeeDTO", employeeDTO);

			mav.setViewName( "empDetailForm.jsp");
			

			System.out.println( "EmployeeController.empDetailForm 메소 호출 종료!");
			//System.out.println( "여기는 컨트롤러 empDetailForm.do.empUpProc(employeeDTO) " + empUpProc(employeeDTO) );
			System.out.println( "여기는 컨트롤러 empDetailForm.do.getEmployee() 비번=> " + employeeDTO.getEmp_pwd() );
			System.out.println( "여기는 컨트롤러 empDetailForm.do.getEmployee() 새비번확인=> " + employeeDTO.getEmp_pwd_confirm() );
			//*******************************************
			// [ModelAndView 객체] 리턴하기
			//*******************************************
			return mav;
		}
		
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// 가상주소 /empRegForm.do 로 접근하면 호출되는 메소드 선언
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			@RequestMapping( value="/empRegForm.do")
			public ModelAndView empRegForm( ){
				
				//*******************************************
				// [ModelAndView 객체] 생성하기
				// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
				// [ModelAndView 객체] 리턴하기
				//*******************************************
				ModelAndView mav = new ModelAndView( );
				mav.setViewName( "empRegForm.jsp" );
				return mav;
			}
			
		
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// /empRegProc.do 로 접근하면 호출되는 메소드 선언하기
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			@RequestMapping( 
					value="/empRegProc.do" 
					,method=RequestMethod.POST
					,produces="application/json;charset=UTF-8"
			)
			@ResponseBody
			public int empRegProc( 
					//*******************************************
					// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
					//*******************************************
						// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같으면
						// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
					EmployeeDTO employeeDTO
			){
				
				System.out.println("empRegProc 메소드 진입");
				//*******************************************
				// [BoardDAOImpl 객체]의 insertBoard 메소드 호출로 
				// 게시판 글 입력하고 [입력 적용행의 개수] 얻기
				//*******************************************
				int empRegCnt = this.employeeDAO.insertEmp(employeeDTO);
					
				//*******************************************
				// [입력 적용행의 개수] 얻기
				//*******************************************
				return empRegCnt;
			}
			
		
		
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// /empUpDelForm.do 접속 시 호출되는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping(value="empUpDelForm.do" )
		public ModelAndView empUpDelForm( 
				//---------------------------------------
				// "emp_no" 라는 파라미터명의 파라미터값이 저장되는 매개변수 b_no 선언
				// 수정 또는 삭제할 게시판 고유 번호가 들어오는 매개변수선언
				//---------------------------------------
				@RequestParam(value="emp_no") int emp_no	
				
		) {
			//*******************************************
			// [BoardServiceImpl 객체]의 getBoard 메소드 호출로 [1개의 게시판 글]을 BoardDTO 객체에 담기
			//*******************************************
			EmployeeDTO employeeDTO = this.employeeService.getEmployee(emp_no);  
			
			
			//*******************************************
			// [ModelAndView 객체] 생성하기
			// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
			// [ModelAndView 객체]에 BoardDTO 객체 저장하기
			//*******************************************
			ModelAndView mav = new ModelAndView( );
			mav.setViewName("empUpDelForm.jsp");
			mav.addObject("employeeDTO", employeeDTO);
			//*******************************************
			// [ModelAndView 객체] 리턴하기
			//*******************************************
			return mav;
		}


		@RequestMapping( 
				value="/mgrListProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		public HashMap mgrListProc( 
				EmployeeDTO employeeDTO
		) {
			
			System.out.println( employeeDTO.getEmp_no()+" 사번 전송 성공");
			System.out.println( employeeDTO.getDep_no()+" 부서번호 전송 성공");

			
			List<Map<String,String>> mgrList = this.employeeService.getMgrList(employeeDTO) ;

			HashMap<String,String> mgrMap = new HashMap<String,String>() ; 

			for(int i=0 ; i <mgrList.size() ; i++ ){
				System.out.println(mgrList.get(i));

				String mgrEmpNo = mgrList.get(i).get("mgr_emp_no") ;
				String mgrName = mgrList.get(i).get("mgr_name") ;

				mgrMap.put(mgrEmpNo, mgrName) ;
				
			}

			return mgrMap;
		}
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// /empUpPorc.do 로 접근하면 호출되는 메소드 선언하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping( 
				value="/empUpProc.do" 
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		public int empUpProc( 
				//*******************************************
				// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
				//*******************************************
				EmployeeDTO employeeDTO
		) {
			System.out.println( "여기는 컨트롤러 empUpPorc.do.getEmp_pwd() => " + employeeDTO.getEmp_pwd() );
			System.out.println( "여기는 컨트롤러 empUpPorc.do.getEmp_pwd_confirm() => " + employeeDTO.getEmp_pwd_confirm() );
			
			//-----------------------------------------------------
			// BoardServeImpl 객체의 updateBoard 메소드 호출로 업데이트된 행의 개수얻기
			//-----------------------------------------------------
			int updateEmpcnt = this.employeeService.updateEmp(employeeDTO);
			//-----------------------------------------------------
			// 업데이트된 행의 개수 리턴하기
			//-----------------------------------------------------
			return updateEmpcnt;
		}
		
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// /empDelProc.do 로 접근하면 호출되는 메소드 선언하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping( 
				value="/empDelProc.do" 
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		public int empDelProc( 
				//*******************************************
				// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
				//*******************************************
				EmployeeDTO employeeDTO
		) {

			//-----------------------------------------------------
			// EmployeeServeImpl 객체의 deleteBoard 메소드 호출로 게시판글을 삭제하고 삭제된 행의 개수얻기
			//-----------------------------------------------------
			int deleteEmpcnt = this.employeeService.deleteEmp(employeeDTO);
			//-----------------------------------------------------
			// 업데이트된 행의 개수 리턴하기
			//-----------------------------------------------------
			return deleteEmpcnt;
		}


		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// /emp_no_check.do 로 접근하면 호출되는 메소드 선언하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		
		@RequestMapping( 
				value="/emp_no_check.do" 
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		public int emp_no_check( 
				//*******************************************
				// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
				//*******************************************
				EmployeeDTO employeeDTO
		) {
			//System.out.println( "컨트롤러.emp_no_check => " + boardDTO.getB_no() );
			//-----------------------------------------------------
			// BoardServeImpl 객체의 updateBoard 메소드 호출로 업데이트된 행의 개수얻기
			//-----------------------------------------------------
			int emp_no_check_cnt = this.employeeService.check_emp_no(employeeDTO);
			//-----------------------------------------------------
			// 업데이트된 행의 개수 리턴하기
			//-----------------------------------------------------
			System.out.println( "컨트롤러 check_emp_no: " + emp_no_check_cnt );

			return emp_no_check_cnt;
		}
		
		
		
}  //public class EmployeeController { 끝
		
	