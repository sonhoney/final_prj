package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ExpenseController {
	
	@Autowired
	private ExpenseService expenseService;
	@Autowired
	private LoginDAO loginDAO;
	@Autowired
	private ExpenseDAO expenseDAO;
		//--------------------------------------------------------------------
		//가상주소 /expenseListForm.do 로 접근하면 호출되는 메소드 선언
		//--------------------------------------------------------------------
		@RequestMapping(value="/expenseListForm.do")
		ModelAndView goExpenseListForm(HttpSession session, ExpenseSearchDTO expenseSearchDTO) {
			
			ModelAndView mav = new ModelAndView();
			
			//---------------------------------------------------
			// 현재 들어온 직원의 id 값 expenseDTO에 저장하기
			//---------------------------------------------------
			String emp_no = (String)session.getAttribute("uid");
			int emp_no2 = Integer.parseInt(emp_no);
			expenseSearchDTO.setEmp_no(emp_no2);
			//---------------------------------------------------
			String emp_name = (String)session.getAttribute("emp_name");
			expenseSearchDTO.setEmp_name(emp_name);
		
			
			//--------------------------------
			// 영업업무보고서 총개수 구하기
			//--------------------------------
			int expenseAllTotCnt = this.expenseDAO.getexpenseListAllTotCnt(expenseSearchDTO); 
			
			//-----------------------------------------------
			// 영업업무보고서 검색 결과물의 총개수 구하기
			//-----------------------------------------------
			int expenseTotCnt = this.expenseDAO.getexpenseListTotCnt(expenseSearchDTO);
			
			System.out.println(expenseTotCnt);
			
			//*********************************************************************
			// 페이징 처리 관련 데이터와 기타 데이터(DB 연동시 필요한 데이터, 보정된 선택 페이지 번호 등)가 저장된 HashMap 객체 얻기
			// Util 객체의 getPagingMap 라는 메소드 호출로 얻는다.
			//*********************************************************************
			Map<String,Integer> pagingMap = ExpenseUtill.getPagingMap(
					expenseSearchDTO.getSelectPageNo()	//선택한 페이지 번호
					, expenseSearchDTO.getRowCntPerPage()	// 한 화면에 보여지는 행의 개수
					, expenseTotCnt						// 검색된 게시판의 총 개수
			);
			// BoardSearchDTO 객체의 selectPageNo 속성변수에 보정된 선택페이지 번호 재저장하기
			expenseSearchDTO.setSelectPageNo( pagingMap.get("selectPageNo") );
			// BoardSearchDTO 객체의 begin_rowNo 속성변수에 검색 결과물에서 페이지번호에 맞게 부분을 가져올때 시작행 번호 재저장하기
			expenseSearchDTO.setBegin_rowNo( pagingMap.get("begin_rowNo") );
			// BoardSearchDTO 객체의 end_rowNo 속성변수에 검색 결과물에서 페이지번호에 맞게 부분을 가져올때 끝행 번호 재저장하기
			expenseSearchDTO.setEnd_rowNo( pagingMap.get("end_rowNo") ); 
			
			System.out.println(expenseSearchDTO.getEmp_no());
			
			

			//-----------------------------------
			// 지출업무보고서 리스트 가져오기
			//-----------------------------------
			List<Map<String,String>> expenseList = this.expenseService.getExpenseList(expenseSearchDTO);
			
			
			
			//-----------------------------------
			// 최종결제자 얻어오기
			//-----------------------------------
			Map<String,String> lastAppMan = new HashMap<String,String>();
			
			for(int i =0; i<expenseList.size(); i++) {
				int report_no = 0;
				int report_code = 0;
				
				//---------------------------------------------------
				// 만약 얻어온 업무보고서 리트스가 비어있지않으면
				//---------------------------------------------------
				if(expenseList.get(i).get("report_no")!=null) {
					//-----------------------------------------------------------------------
					// i번째 업무보고서 리포트번호를 변수 report_no,report_code 에 저장하고
					//-----------------------------------------------------------------------
					report_no =  Integer.parseInt(expenseList.get(i).get("report_no")) ;	
					report_code	=  Integer.parseInt(expenseList.get(i).get("report_code")) ;
					//-----------------------------------------------------------------------
					// expenseDTO 에 변수 report_no,report_code 를 넣어주기
					//-----------------------------------------------------------------------
					expenseSearchDTO.setReport_no(report_no);
					expenseSearchDTO.setReport_code(report_code);

					//-----------------------------------------------------------------------
					// 저장된 report_no,report_code 를 가지고 최종결제자 얻어오기
					//-----------------------------------------------------------------------
					lastAppMan = this.expenseDAO.getlastAppMan(expenseSearchDTO);
					
					// 얻어온 마지막 결제자의 사인코드 저장하기
					String last_sign_code = lastAppMan.get("last_sign_code");
					// 얻어온 마지막 결제자의 보고서 번호 얻어오기
					String last_sign_finish_no = lastAppMan.get("last_sign_finish_no");
					// 얻어온 마지막 결제자의 날짜 얻어오기
					String last_sign_date = lastAppMan.get("last_sign_date");
					// 얻어온 마지막 결제자의 직원번호 얻어오기
					String last_emp_no = lastAppMan.get("last_emp_no");
					
					//------------------------------------------------
					// i 번째 업무보고서에 얻어온 데이터 넣어주기
					//------------------------------------------------
					expenseList.get(i).put("last_sign_code", last_sign_code);
					expenseList.get(i).put("last_sign_finish_no", last_sign_finish_no);
					expenseList.get(i).put("last_sign_date", last_sign_date);
					expenseList.get(i).put("last_emp_no", last_emp_no);
					
				}
				
			}
			
			//-----------------------------------------
			// 다음결제자의 시간을 얻어오기
			//-----------------------------------------
			String next_app_getSign_date = new String();
			
			for(int i =0; i<expenseList.size(); i++) {
				
				int report_no = 0;
				int report_code = 0;
				
				//---------------------------------------------------
				// 만약 얻어온 업무보고서 리트스가 비어있지않으면
				//---------------------------------------------------
				if(expenseList.get(i).get("report_no")!=null) {

					//----------------------------------------------------------------------
					// i번째 업무보고서 리포트번호를 변수 report_no,report_code 에 저장하고
					//----------------------------------------------------------------------
					report_code	=  Integer.parseInt(expenseList.get(i).get("report_code")) ;	
					report_no =  Integer.parseInt(expenseList.get(i).get("report_no")) ;		
					
					//-----------------------------------------------------------
					// DailyBusiDTO 에 변수 report_no,report_code 를 넣어주기
					//-----------------------------------------------------------
					expenseSearchDTO.setReport_no(report_no);
					expenseSearchDTO.setReport_code(report_code);

					//---------------------------------------
					// 만약 첫 작성자면
					//---------------------------------------
					if(String.valueOf(expenseList.get(i).get("emp_no")).equals(emp_no)) {
						next_app_getSign_date =  this.expenseDAO.first_app_getSign_date(expenseSearchDTO);					
						expenseList.get(i).put("next_app_getSign_date", next_app_getSign_date);
						
					}				
					//---------------------------------------
					// 만약 첫 작성자가 아니면 
					//---------------------------------------
					else{
						next_app_getSign_date =  this.expenseDAO.next_app_getSign_date(expenseSearchDTO);					
						expenseList.get(i).put("next_app_getSign_date", next_app_getSign_date);
					}										
				}				
			}					
			mav.setViewName("expenseListForm.jsp");						
			if(expenseList!=null) {		
				mav.addObject("expenseList",expenseList);
				mav.addObject("expenseAllTotCnt",expenseAllTotCnt);
				mav.addObject("expenseTotCnt",expenseTotCnt);
				mav.addObject("pagingMap", pagingMap);
				mav.addObject("selectPageNo", pagingMap.get("selectPageNo"));  
			}						
			return mav;
		}
		
		
		
		
		
		//******************************************************************************************************************
		// 지출보고서 등록을 누르면 호출되는 메소드 선언
		//******************************************************************************************************************
		@RequestMapping(value="/expenseRegForm.do")
		ModelAndView goExpenseRegForm(HttpSession session,ExpenseDTO expenseDTO) {
			ModelAndView mav = new ModelAndView();
			

			String emp_no = (String)session.getAttribute("uid");
			int emp_no2 = Integer.parseInt(emp_no);
			String emp_name = (String)session.getAttribute("emp_name");
			String jikup_name = (String)session.getAttribute("jikup_name");
			
			expenseDTO.setEmp_no(emp_no2);
			expenseDTO.setEmp_name(emp_name);
			expenseDTO.setEmp_name(jikup_name);

			List<Next_App_Emp_List> next_app_list = this.expenseService.get_next_app_list(expenseDTO);
			
			mav.addObject("next_app_list", next_app_list); 
			mav.setViewName("expenseRegForm.jsp");
			return mav;
		}
		
		
		
		
		
		
		
		
		//******************************************************************************************************************
		//가상주소 /expenseRegProc.do 로 접근하면 [1개의 일일업무보고서 입력 적용행의 개수]를 리턴하는 메소드 선언
		//******************************************************************************************************************
		@RequestMapping(
				value="/expenseRegProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		int insertExpenseReport(HttpSession session, ExpenseDTO expenseDTO) {
			
			//----------------------------------------------------
			// 올라간 업무보고서 적용행의 갯수 얻어오기
			//----------------------------------------------------
			int insertExpenseReportCnt = this.expenseService.first_insertExpenseReport(expenseDTO);		
					
			return insertExpenseReportCnt;		
		}
		
		
		
		
		

		//******************************************************************************************************************
		// 지출보고서 상세보기를 누르면 호출되는 메소드 선언
		//******************************************************************************************************************
		@RequestMapping(value="/expenseDetailForm.do")
		public ModelAndView boardDetailForm(
				@RequestParam(value="report_no") int report_no
				,@RequestParam(value="report_code") int report_code
				,HttpSession session
		) {
			//---------------------------------------------------
			// 가지고 들어온 내 직원번호를 emp_no 변수안에 넣어주고
			String emp_no = (String)session.getAttribute("uid");
			// 가지고 들어온 직원번호를 int 형으로 형변환후 변수 emp_no2 에 저장하기
			int emp_no2 = Integer.parseInt(emp_no);
			//---------------------------------------------------

			//---------------------------------------------------
			// 위에 선언된 변수들을 통해 DailyBusiDTO 에 상세정보 담아오기
			//---------------------------------------------------
			ExpenseDTO expenseDTO = this.expenseService.getBoard(report_no,emp_no2,report_code); 

			expenseDTO.setLogin_emp_no(emp_no2);
			
			 List<Next_App_Emp_List> next_app_list = this.expenseDAO.get_next_app_list2(emp_no2);
			
			//------------------------------------------------------------------------------
			// 저장된 report_no,report_code 를 가지고 최종결제자 얻어오기
			//------------------------------------------------------------------------------
			Map<String,String> lastAppMan = new HashMap<String,String>();
			lastAppMan = this.expenseDAO.getlastAppMan(expenseDTO);
			//------------------------------------------------------------------------------
			// 저장된 report_no,report_code 를 가지고 다음결제자 얻어오기
			//------------------------------------------------------------------------------
			Map<String,String> nextAppMan = new HashMap<String,String>();
			

			if(emp_no2 == expenseDTO.getEmp_no()) {
				nextAppMan = this.expenseDAO.getLogin_NextAppMan(expenseDTO);
			}
			else {
				nextAppMan = this.expenseDAO.getNextAppMan(expenseDTO);
			}
			
			//------------------------------------------------------------------------------
			// 첫결제자 아닌 사람의 다음결제자의 직원번호 얻어오기 
	          String nextAppManEmp_no = new String();

	          Map<String,String> AppEmp_no = new HashMap<String,String>();

	            // 해시맵에 넘어온 리포트번호와 직원번호 넣어주기
	          AppEmp_no.put("report_no",     Integer.toString(report_no));
	          AppEmp_no.put("emp_no",     Integer.toString(emp_no2));
	          AppEmp_no.put("report_code",     Integer.toString(report_code));

	          nextAppManEmp_no = this.expenseDAO.nextAppManEmp_no(AppEmp_no);
			//**************************************************************************************************************************************
			//**************************************************************************************************************************************
			//------------------------------------------------------------------------------
			// 저장된 report_no 를 결제리스트 뽑아오기
			List<Map<String,String>> appList = this.expenseDAO.getAppList(expenseDTO); 
			System.out.println("라스트사인코드"+nextAppMan.get("next_emp_no"));
			//-----------------------------------------
			// 다음결제자의 시간을 얻어오기
			//-----------------------------------------
			String next_appList_getSign_date = new String();
			
			for(int i =0; i<appList.size(); i++) {

				Map<String,String> myInfo = new HashMap<String,String>();
				
				String myReport_no = String.valueOf(appList.get(i).get("report_no"));
				String myReport_code = String.valueOf(appList.get(i).get("report_code"));
				String myEmp_no = String.valueOf(appList.get(i).get("emp_no"));
				
				myInfo.put("report_no", myReport_no);
				myInfo.put("report_code", myReport_code);
				myInfo.put("emp_no", myEmp_no);
				
				next_appList_getSign_date = this.expenseDAO.next_appList_getSign_date(myInfo);
				
				if(next_appList_getSign_date!=null) {
					appList.get(i).put("next_app_date", next_appList_getSign_date);
				}			
				else if(/*next_appList_getSign_date==null &&*/ (nextAppMan.get("next_sign_code").equals("0") && lastAppMan.get("last_sign_code").equals("0")) || (nextAppMan.get("next_sign_code").equals("1")&& lastAppMan.get("last_sign_code").equals("1"))){
					 
					System.out.println("들옴");
					next_appList_getSign_date = this.expenseDAO.my_appList_getSign_date(myInfo);
					appList.get(i).put("next_app_date", next_appList_getSign_date);
				}
				
			}
			//**************************************************************************************************************************************
			//**************************************************************************************************************************************
			//------------------------------------------------------------------------------
			// 저장된 report_no 를 결제리스트 뽑아오기
			//List<Map<String,String>> appList = this.dailyDAO.getAppList(expenseDTO); 				
			//------------------------------------------------------------------------------
											
			ModelAndView mav = new ModelAndView();
			mav.setViewName("expenseDetailForm.jsp");
			mav.addObject("next_app_list", next_app_list);
			mav.addObject("expenseDTO",expenseDTO);	
			mav.addObject("lastAppMan",lastAppMan);
			mav.addObject("nextAppMan",nextAppMan);
			mav.addObject("appList",appList);
			mav.addObject("nextAppManEmp_no",nextAppManEmp_no);
			return mav;
			
		}	
		//******************************************************************************************************************
		
		//***********************************************************************************
		// 결제 또는 반려 시 호출되는 메소드 선언
		//***********************************************************************************
		@RequestMapping(
				value="/expenseUpdelProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		int signExpenseReport(HttpSession session, ExpenseDTO expenseDTO) {
			
			int insertExpenseReportCnt = 0;
			//---------------------------------------------------
			// 현재 들어온 직원의 id 값 ExpenseDTO 에 저장하기
			//---------------------------------------------------
			String emp_no = (String)session.getAttribute("uid");
			int emp_no2 = Integer.parseInt(emp_no);
			expenseDTO.setEmp_no(emp_no2);
			//---------------------------------------------------
			
			//---------------------------------------------------
			// 만약 결재를 눌렀다면
			//---------------------------------------------------
			if(expenseDTO.getApproval_yesNo()==0) {
				insertExpenseReportCnt = this.expenseService.signExpenseReport(expenseDTO);						
			}			
			//---------------------------------------------------
			// 만약 반려를 눌렀다면
			//---------------------------------------------------	
			else if(expenseDTO.getApproval_yesNo()==1) {
				insertExpenseReportCnt = this.expenseService.signMinusExpenseReport(expenseDTO);			
			}
			
			
			return insertExpenseReportCnt;		
			
		}
		//***********************************************************************************
		
		
		//***********************************************************************************
		// 수정 시 호출되는 메소드 선언
		//***********************************************************************************
		@RequestMapping(
				value="/expenseAlterProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		int alterExpenseReport(HttpSession session, ExpenseDTO expenseDTO) {
					
			int alterBusiReport = this.expenseService.alterExpenseReport(expenseDTO);
							
			return alterBusiReport;		
			
		}
		//***********************************************************************************
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
