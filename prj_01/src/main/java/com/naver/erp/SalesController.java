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
public class SalesController {
	@Autowired
	private SalesService salesService;
	@Autowired
	private SalesDAO salesDAO;
	
	//--------------------------------------------------------------------
		//가상주소 /dailyListForm.do 로 접근하면 호출되는 메소드 선언
		//--------------------------------------------------------------------
		@RequestMapping(value="/salesListForm.do")
		ModelAndView goSalesListForm(HttpSession session, SalesSearchDTO salesSearchDTO) {
			
			ModelAndView mav = new ModelAndView();
			
			//---------------------------------------------------
			// 현재 들어온 직원의 id 값 DailyBusiDTO에 저장하기
			//---------------------------------------------------
			String emp_no = (String)session.getAttribute("uid");
			int emp_no2 = Integer.parseInt(emp_no);
			salesSearchDTO.setEmp_no(emp_no2);
			//---------------------------------------------------
			String emp_name = (String)session.getAttribute("emp_name");
			salesSearchDTO.setEmp_name(emp_name);
			

			//--------------------------------
			// 영업업무보고서 총개수 구하기
			//--------------------------------
			int salesAllTotCnt = this.salesDAO.getsalesListAllTotCnt(salesSearchDTO);
			
			//-----------------------------------------------
			// 영업업무보고서 검색 결과물의 총개수 구하기
			//-----------------------------------------------
			int salesTotCnt = this.salesDAO.getsalesListTotCnt(salesSearchDTO);
			
			System.out.println(salesSearchDTO.getMin_year_month());
			System.out.println(salesSearchDTO.getMax_year_month());
			
			
			
			
			//*********************************************************************
			// 페이징 처리 관련 데이터와 기타 데이터(DB 연동시 필요한 데이터, 보정된 선택 페이지 번호 등)가 저장된 HashMap 객체 얻기
			// Util 객체의 getPagingMap 라는 메소드 호출로 얻는다.
			//*********************************************************************
			Map<String,Integer> pagingMap = SalesUtill.getPagingMap(
					salesSearchDTO.getSelectPageNo()	//선택한 페이지 번호
					, salesSearchDTO.getRowCntPerPage()	// 한 화면에 보여지는 행의 개수
					, salesTotCnt						// 검색된 게시판의 총 개수
			);
			// BoardSearchDTO 객체의 selectPageNo 속성변수에 보정된 선택페이지 번호 재저장하기
			salesSearchDTO.setSelectPageNo( pagingMap.get("selectPageNo") );
			// BoardSearchDTO 객체의 begin_rowNo 속성변수에 검색 결과물에서 페이지번호에 맞게 부분을 가져올때 시작행 번호 재저장하기
			salesSearchDTO.setBegin_rowNo( pagingMap.get("begin_rowNo") );
			// BoardSearchDTO 객체의 end_rowNo 속성변수에 검색 결과물에서 페이지번호에 맞게 부분을 가져올때 끝행 번호 재저장하기
			salesSearchDTO.setEnd_rowNo( pagingMap.get("end_rowNo") ); 
			
			System.out.println(salesSearchDTO.getEmp_no());
			
			
			
			//-----------------------------------
			// 일일업무보고서 리스트 가져오기
			//-----------------------------------
			List<Map<String,String>> salesList = this.salesService.getSalesList(salesSearchDTO);
			
			
			
			
			//-----------------------------------
			// 최종결제자 얻어오기
			//-----------------------------------
			Map<String,String> lastAppMan = new HashMap<String,String>();
	
			for(int i =0; i<salesList.size(); i++) {
				int report_no = 0;
				int report_code = 0;

				//---------------------------------------------------
				// 만약 얻어온 업무보고서 리트스가 비어있지않으면
				//---------------------------------------------------
				if(salesList.get(i).get("report_no")!=null) {
					//-----------------------------------------------------------
					// i번째 업무보고서 리포트번호를 변수 report_no 에 저장하고
					//-----------------------------------------------------------
					report_no =  Integer.parseInt(salesList.get(i).get("report_no")) ;	
					report_code	=  Integer.parseInt(salesList.get(i).get("report_code")) ;	
					
					// DailyBusiDTO 에 변수 report_no 를 넣어주기
					salesSearchDTO.setReport_no(report_no);
					salesSearchDTO.setReport_code(report_code);
					
					// 저장된 report_no 를 가지고 최종결제자 얻어오기
					lastAppMan = this.salesDAO.getlastAppMan(salesSearchDTO);
					if(lastAppMan!=null) {
					// 얻어온 마지막 결제자의 사인코드 저장하기
					String last_sign_code = lastAppMan.get("last_sign_code");
					// 얻어온 마지막 결제자의 보고서 번호 얻어오기
					String last_sign_finish_no = lastAppMan.get("last_sign_finish_no");
					// 얻어온 마지막 결제자의 날짜 얻어오기
					String last_sign_date = lastAppMan.get("last_sign_date");
					salesSearchDTO.setLast_sign_date(last_sign_date);
					
					// 얻어온 마지막 결제자의 직원번호 얻어오기
					String last_emp_no = lastAppMan.get("last_emp_no");
					
					//------------------------------------------------
					// i 번째 업무보고서에 얻어온 데이터 넣어주기
					//------------------------------------------------
					salesList.get(i).put("last_sign_code", last_sign_code);
					salesList.get(i).put("last_sign_finish_no", last_sign_finish_no);
					salesList.get(i).put("last_sign_date", last_sign_date);
					salesList.get(i).put("last_emp_no", last_emp_no);
					}
				}
				
			}
			//-----------------------------------------
			// 다음결제자의 시간을 얻어오기
			//-----------------------------------------
			String next_app_getSign_date = new String();
			
			for(int i =0; i<salesList.size(); i++) {
				
				int report_no = 0;
				int report_code = 0;
				
				//---------------------------------------------------
				// 만약 얻어온 업무보고서 리트스가 비어있지않으면
				//---------------------------------------------------
				if(salesList.get(i).get("report_no")!=null) {
					
					//-----------------------------------------------------------
					// i번째 업무보고서 리포트번호를 변수 report_no 에 저장하고
					//-----------------------------------------------------------
					report_no =  Integer.parseInt(salesList.get(i).get("report_no")) ;	
					report_code	=  Integer.parseInt(salesList.get(i).get("report_code")) ;	
						
					// DailyBusiDTO 에 변수 report_no 를 넣어주기
					salesSearchDTO.setReport_no(report_no);
					salesSearchDTO.setReport_code(report_code);
					//---------------------------------------
					// 만약 첫 작성자면
					//---------------------------------------
					if(String.valueOf(salesList.get(i).get("emp_no")).equals(emp_no)) {
						System.out.println("들옴");
						next_app_getSign_date =  this.salesDAO.first_app_getSign_date(salesSearchDTO);	
						salesList.get(i).put("next_app_getSign_date", next_app_getSign_date);
						
					}				
					//---------------------------------------
					// 만약 첫 작성자가 아니면 
					//---------------------------------------
					else{
						next_app_getSign_date =  this.salesDAO.next_app_getSign_date(salesSearchDTO);					
						salesList.get(i).put("next_app_getSign_date", next_app_getSign_date);
					}
					
					
				}
				
			}
				
			if(salesList!=null) {		
				mav.addObject("salesAllTotCnt",salesAllTotCnt);
				mav.addObject("salesTotCnt",salesTotCnt);
				mav.addObject("salesList",salesList);
				mav.addObject("pagingMap", pagingMap);
				mav.addObject("selectPageNo", pagingMap.get("selectPageNo"));
			}
			

			mav.setViewName("salesListForm.jsp");
			return mav;
		}

		//******************************************************************************************************************
		// 일일업무보고서 등록을 누르면 호출되는 메소드 선언
		//******************************************************************************************************************
		@RequestMapping(value="/salesRegForm.do")
		ModelAndView goSalesRegForm(HttpSession session,SalesDTO salesDTO) {
			ModelAndView mav = new ModelAndView();
			
			String emp_no = (String)session.getAttribute("uid");
			int emp_no2 = Integer.parseInt(emp_no);
			String emp_name = (String)session.getAttribute("emp_name");
			String jikup_name = (String)session.getAttribute("jikup_name");
			
			salesDTO.setEmp_no(emp_no2);
			salesDTO.setEmp_name(emp_name);
			salesDTO.setEmp_name(jikup_name);

			List<Next_App_Emp_List> next_app_list = this.salesService.get_next_app_list(salesDTO);
			
			mav.addObject("next_app_list", next_app_list); 
			mav.setViewName("salesRegForm.jsp");
			return mav;
		}
		
		

		//******************************************************************************************************************	
		
		
		
		
		
				
		//******************************************************************************************************************		
		@RequestMapping(
				value="/salesRegProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		int insertSalesReport(HttpSession session, SalesDTO salesDTO) {


			//----------------------------------------------------
			// 올라간 영업보고서 적용행의 갯수 얻어오기
			//----------------------------------------------------
			int insertSalesReporttCnt = this.salesService.first_insertSalesReport(salesDTO);		
					
			return insertSalesReporttCnt;		
		}	
		//******************************************************************************************************************
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//******************************************************************************************************************
		// 일일업무보고서 상세보기를 누르면 호출되는 메소드 선언
		//******************************************************************************************************************
		@RequestMapping(value="/SalesDetailForm.do")
		public ModelAndView boardDetailForm(
				@RequestParam(value="report_no") int report_no
				,@RequestParam(value="report_code") int report_code
				,HttpSession session
		) {
			// 가지고 들어온 내 직원번호를 emp_no 변수안에 넣어주고
			String emp_no = (String)session.getAttribute("uid");
			// 가지고 들어온 직원번호를 int 형으로 형변환후 변수 emp_no2 에 저장하기
			int emp_no2 = Integer.parseInt(emp_no);
			//---------------------------------------------------
			
			// 위에 선언된 변수들을 통해 DailyBusiDTO 에 상세정보 담아오기
			SalesDTO salesDTO = this.salesService.getBoard(report_no,emp_no2,report_code); 

			salesDTO.setLogin_emp_no(emp_no2);
			
			 List<Next_App_Emp_List> next_app_list = this.salesDAO.get_next_app_list2(emp_no2);
			 
			//------------------------------------------------------------------------------
			// 저장된 report_no 를 가지고 최종결제자 얻어오기
			Map<String,String> lastAppMan = new HashMap<String,String>();
			lastAppMan = this.salesDAO.getlastAppMan(salesDTO);
			//------------------------------------------------------------------------------
			// 저장된 report_no 를 가지고 다음결제자 얻어오기
			Map<String,String> nextAppMan = new HashMap<String,String>();
			
			if(emp_no2 == salesDTO.getEmp_no()) {
				nextAppMan = this.salesDAO.getLogin_NextAppMan(salesDTO);
			}
			else {
				nextAppMan = this.salesDAO.getNextAppMan(salesDTO);
			}
			
			//------------------------------------------------------------------------------
			// 첫결제자 아닌 사람의 다음결제자의 직원번호 얻어오기 
	          String nextAppManEmp_no = new String();

	          Map<String,String> AppEmp_no = new HashMap<String,String>();

	            // 해시맵에 넘어온 리포트번호와 직원번호 넣어주기
	          AppEmp_no.put("report_no",     Integer.toString(report_no));
	          AppEmp_no.put("emp_no",     Integer.toString(emp_no2));
	          AppEmp_no.put("report_code",     Integer.toString(report_code));

	          nextAppManEmp_no = this.salesDAO.nextAppManEmp_no(AppEmp_no);
			
			
			//**************************************************************************************************************************************
			//**************************************************************************************************************************************
			//------------------------------------------------------------------------------
			// 저장된 report_no 를 결제리스트 뽑아오기
			List<Map<String,String>> appList = this.salesDAO.getAppList(salesDTO); 
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
				
				next_appList_getSign_date = this.salesDAO.next_appList_getSign_date(myInfo);
				
				if(next_appList_getSign_date!=null) {
					appList.get(i).put("next_app_date", next_appList_getSign_date);
				}			
				else if((nextAppMan.get("next_sign_code").equals("0") && lastAppMan.get("last_sign_code").equals("0")) || (nextAppMan.get("next_sign_code").equals("1")&& lastAppMan.get("last_sign_code").equals("1"))){
					 
					System.out.println("들옴");
					next_appList_getSign_date = this.salesDAO.my_appList_getSign_date(myInfo);
					appList.get(i).put("next_app_date", next_appList_getSign_date);
				}
				
			}
			//**************************************************************************************************************************************
			//**************************************************************************************************************************************
			/*
			//------------------------------------------------------------------------------
			// 저장된 report_no 를 결제리스트 뽑아오기
			//List<Map<String,String>> appList = this.dailyDAO.getAppList(dailyBusiDTO); 				
			//------------------------------------------------------------------------------
			*/
								
			ModelAndView mav = new ModelAndView();
			mav.addObject("next_app_list", next_app_list); 
			mav.setViewName("SalesDetailForm.jsp");
			mav.addObject("salesDTO",salesDTO);	
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
				value="/salesUpdelProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		int signDailBusiReport(HttpSession session, SalesDTO salesDTO) {
			
			int insertDailBusiReportCnt = 0;
			//---------------------------------------------------
			// 현재 들어온 직원의 id 값 DailyBusiDTO에 저장하기
			//---------------------------------------------------
			String emp_no = (String)session.getAttribute("uid");
			int emp_no2 = Integer.parseInt(emp_no);
			salesDTO.setEmp_no(emp_no2);
			//---------------------------------------------------
			
			//---------------------------------------------------
			// 만약 결재를 눌렀다면
			//---------------------------------------------------
			if(salesDTO.getApproval_yesNo()==0) {
				insertDailBusiReportCnt = this.salesService.signDailBusiReport(salesDTO);						
			}			
			//---------------------------------------------------
			// 만약 반려를 눌렀다면
			//---------------------------------------------------	
			else if(salesDTO.getApproval_yesNo()==1) {
				insertDailBusiReportCnt = this.salesService.signMinusBusiReport(salesDTO);			
			}
			
			
			return insertDailBusiReportCnt;		
			
		}
		//***********************************************************************************
		
		
		//***********************************************************************************
		// 수정 시 호출되는 메소드 선언
		//***********************************************************************************
		@RequestMapping(
				value="/salesAlterProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		int alterDailBusiReport(HttpSession session, SalesDTO salesDTO) {
					
			int alterBusiReport = this.salesService.alterDailBusiReport(salesDTO);
							
			return alterBusiReport;		
			
		}
		//***********************************************************************************
		
		
		
		
		
		
		
		
		
		
		
}
