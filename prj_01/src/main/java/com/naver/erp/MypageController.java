package com.naver.erp;

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
public class MypageController {
	//가상주소 /myPageForm.do 로 접근하면 호출되는 메소드 선언
	//+++++++++++++++++++++++++++++++++++++++
	// MypageDAO 인터페이스 구현한 클래스를 찾아서 객체화 해서  속변 MypageDAO 에 객체의 메위주를 저장.
	// MypageDAO 인터페이스 구현한 클래스를 찾을때 그 클래스의 이름은 무었이든 상관없다.
	// 단 MypageDAO 인터페이스 구현한 클래스는 한개만 만들어야한다.
	// <주의> 관용적으로 클래스 이름에 DAO 가 들어 있으면 직접 DB 연동을 하는 메소드를 소유한 클래스이다.
	//+++++++++++++++++++++++++++++++++++++++
	@Autowired
	private	MypageDAO mypageDAO; 
	@Autowired
	private	MypageService mypageService; 
	@Autowired
	private	EmployeeService employeeService; 

	
	
	

		
	  //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	   // 가상주소 /boardList.do 로 접근하면 호출되는 메소드 선언
	   //      @RequestMapping 내부에, method="ReqeustMethod.POST  가 없으므로
	   //      가상주소 /boardList.do로 접근 시 get 또는 post 방식 접근 모두 허용한다.
	   //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	   @RequestMapping( value="/mypageMain.do")
	   public ModelAndView mypageMain(
	         EmployeeDTO employeeDTO
	         ,HttpServletRequest request
	         ,HttpServletResponse response
	         //,@RequestParam(value="uid") int emp_no
	   ){
			
			//System.out.println(response.equals(employeeDTO));
		
			//EmployeeDTO employeeDTO1 = this.employeeService.getEmployee(emp_no);  
			
			
	      HttpSession session = request.getSession();
	      
	      String uid = (String)session.getAttribute("uid");
	      String pwd = (String)session.getAttribute("pwd");
	      String emp_name = (String)session.getAttribute("emp_name");
	      
	      Map<String,String> mypage = this.mypageDAO.getMypage(uid);
	      System.out.println( "여기는 컨트롤러 mypageMain.do.mypage해시맵에이거있음=> " + mypage );
	      //EmployeeDTO mypageMain =  this.employeeService.getEmployee( emp_no );

	      
	      //--------------------------------------------------
	      // [ModelAndView 객체] 생성하기
	      //--------------------------------------------------
	      ModelAndView mav = new ModelAndView();
	      
	      //--------------------------------------------------
	      // [ModelAndView 객체]의 setViewName 메소드 호출하여  
	      // [호출할 JSP 페이지명]을 문자로 저장하기
	      // [호출할 JSP 페이지명] 앞에 붙는 위치 경로는 
	      // application.properties   에서 
	      // spring.mvc.view.prefix=/WEB-INF/views/     에 설정한다.
	      // [호출할 JSP 페이지명] 뒤에 붙는 확장자는 
	      // application.properties   에서 
	      // spring.mvc.view.suffix=.jsp     에 설정한다. 근데 이거는 여기서 생략했다.
	      // <참고>기본적으로 저장 경로에서 webapp 폴더까지는 자동으로 찾아간다. (정민규 주석작품)
	      //--------------------------------------------------
	      mav.addObject(  "uid" , uid );
	      mav.addObject(  "emp_name" , emp_name );
	      mav.addObject(  "mypage" , mypage );
	      mav.addObject("employeeDTO", employeeDTO);
	     // System.out.println( "여기는 컨트롤러 mypageMain.do.mypage해시맵에이거있음=> " + employeeDTO.getMgr_emp_no() );
	      mav.setViewName( "mypageMain.jsp" );
	      
			//System.out.println("MypageController.mypageMain 메소드: " employeeDTO.getEmp_no() );

	      //--------------------------------------------------
	      // [ModelAndView 객체] 리턴하기
	      //--------------------------------------------------
			System.out.println( "여기는 컨트롤러 mypageMain 호출 끝" );

	      return  mav;
	      
	   }
	   
	
	   //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// /boardUpDelForm.do 접속 시 호출되는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping(value="mypageUpdate.do" )
		public ModelAndView mypageUpdate( 
				HttpServletRequest request
		        ,HttpServletResponse response
				//---------------------------------------
				// "b_no" 라는 파라미터명의 파라미터값이 저장되는 매개변수 b_no 선언
				// 수정 또는 삭제할 게시판 고유 번호가 들어오는 매개변수선언
				//---------------------------------------
				,@RequestParam(value="emp_no") int emp_no	
		) {
			HttpSession session = request.getSession();
		      
		    String uid = (String)session.getAttribute("uid");
		    String pwd = (String)session.getAttribute("pwd");
		    String emp_name = (String)session.getAttribute("emp_name");
		      
		    Map<String,String> mypage = this.mypageDAO.getMypage(uid);
			//*******************************************
			// [BoardServiceImpl 객체]의 getBoard 메소드 호출로 [1개의 게시판 글]을 BoardDTO 객체에 담기
			//*******************************************
			EmployeeDTO employeeDTO = this.employeeService.getEmployee(emp_no); 		     
			//System.out.println( "여기는 컨트롤러 mypageUpdate.do.mypage해시맵에이거있음=> " + mypage );
			//*******************************************
			// [ModelAndView 객체] 생성하기
			// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
			// [ModelAndView 객체]에 BoardDTO 객체 저장하기
			//*******************************************
			ModelAndView mav = new ModelAndView( );
			
			// mav.addObject(  "mypage" , mypage );
			 mav.setViewName("mypageUpdate.jsp");
			 mav.addObject(  "mypage" , mypage );
			 mav.addObject("employeeDTO", employeeDTO);
			//*******************************************
			// 	[ModelAndView 객체] 리턴하기
			//*******************************************
			return mav;
		}
		
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
				// /empUpPorc.do 로 접근하면 호출되는 메소드 선언하기
				//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
				@RequestMapping( 
						value="/mypageUpProc.do" 
						,method=RequestMethod.POST
						,produces="application/json;charset=UTF-8"
				)
				@ResponseBody
				public int mypageUpProc( 
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
	


}
