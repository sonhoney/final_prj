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
public class DailyBusinessController {

	@Autowired
	private DailyDAO dailyDAO;
	
	@Autowired
	private DailyService dailyService;
	
	

//----------------------------------------------------------------------------------------------------------------------------
	// 일일보고서 리스트 화면
	// 가상주소 /dailyListForm.do 로 접근하면 호출되는 메소드 선언
//----------------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/dailyListForm.do")
	ModelAndView godailyListForm(HttpSession session, DailyBusiSearchDTO dailyBusiSearchDTO) {
		
		ModelAndView mav = new ModelAndView();
		
		//---------------------------------------------------
		String emp_no = (String)session.getAttribute("uid");
		int emp_no2 = Integer.parseInt(emp_no);
		String emp_name = (String)session.getAttribute("emp_name");
		
		dailyBusiSearchDTO.setEmp_no(emp_no2);
		dailyBusiSearchDTO.setEmp_name(emp_name);
		//---------------------------------------------------
		
		//--------------------------------
		// 일일업무보고서 총개수 구하기
		//--------------------------------
		int daliyBusiAllTotCnt = this.dailyDAO.getdailyBusiListAllTotCnt(dailyBusiSearchDTO);

		//-----------------------------------------------
		// 일일업무보고서 검색 결과물의 총개수 구하기
		//-----------------------------------------------
		int daliyBusiTotCnt = this.dailyDAO.getdailyBusiListTotCnt(dailyBusiSearchDTO);
		
		//*********************************************************************
		// 페이징 처리 관련 데이터와 기타 데이터(DB 연동시 필요한 데이터, 보정된 선택 페이지 번호 등)가 저장된 HashMap 객체 얻기
		// Util 객체의 getPagingMap 라는 메소드 호출로 얻는다.
		//*********************************************************************
		Map<String,Integer> pagingMap = DailyBusiUtil.getPagingMap(
				dailyBusiSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				, dailyBusiSearchDTO.getRowCntPerPage()	// 한 화면에 보여지는 행의 개수
				, daliyBusiTotCnt						// 검색된 게시판의 총 개수
		);
		// BoardSearchDTO 객체의 selectPageNo 속성변수에 보정된 선택페이지 번호 재저장하기
		dailyBusiSearchDTO.setSelectPageNo( pagingMap.get("selectPageNo") );
		// BoardSearchDTO 객체의 begin_rowNo 속성변수에 검색 결과물에서 페이지번호에 맞게 부분을 가져올때 시작행 번호 재저장하기
		dailyBusiSearchDTO.setBegin_rowNo( pagingMap.get("begin_rowNo") );
		// BoardSearchDTO 객체의 end_rowNo 속성변수에 검색 결과물에서 페이지번호에 맞게 부분을 가져올때 끝행 번호 재저장하기
		dailyBusiSearchDTO.setEnd_rowNo( pagingMap.get("end_rowNo") ); 
		
		System.out.println(dailyBusiSearchDTO.getEmp_no());
		
		// 검색된 일일업무보고서 목록 얻기
		List<Map<String,String>> dailyList = this.dailyService.getDailyList(dailyBusiSearchDTO);


			//-----------------------------------
			// 최종결제자 얻어오기
			//-----------------------------------
			Map<String,String> lastAppMan = new HashMap<String,String>();
			
			for(int i =0; i<dailyList.size(); i++) {
				int report_no = 0;

				//---------------------------------------------------
				// 만약 얻어온 업무보고서 리트스가 비어있지않으면
				//---------------------------------------------------
				if(dailyList.get(i).get("report_no")!=null) {
					//-----------------------------------------------------------
					// i번째 업무보고서 리포트번호를 변수 report_no 에 저장하고
					//-----------------------------------------------------------
					report_no =  Integer.parseInt(dailyList.get(i).get("report_no")) ;			
					
					// DailyBusiDTO 에 변수 report_no 를 넣어주기
					dailyBusiSearchDTO.setReport_no(report_no);
					
					// 저장된 report_no 를 가지고 최종결제자 얻어오기
					lastAppMan = this.dailyDAO.getlastAppMan(dailyBusiSearchDTO);
					
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
					dailyList.get(i).put("last_sign_code", last_sign_code);
					dailyList.get(i).put("last_sign_finish_no", last_sign_finish_no);
					dailyList.get(i).put("last_sign_date", last_sign_date);
					dailyList.get(i).put("last_emp_no", last_emp_no);


				}
				
			}
			//-----------------------------------------
			// 다음결제자의 시간을 얻어오기
			//-----------------------------------------
			String next_app_getSign_date = new String();
			
			for(int i =0; i<dailyList.size(); i++) {
				
				int report_no = 0;
				
				//---------------------------------------------------
				// 만약 얻어온 업무보고서 리트스가 비어있지않으면
				//---------------------------------------------------
				if(dailyList.get(i).get("report_no")!=null) {
					
					//-----------------------------------------------------------
					// i번째 업무보고서 리포트번호를 변수 report_no 에 저장하고
					//-----------------------------------------------------------
					report_no =  Integer.parseInt(dailyList.get(i).get("report_no")) ;		

					// DailyBusiDTO 에 변수 report_no 를 넣어주기
					dailyBusiSearchDTO.setReport_no(report_no);
					
					//---------------------------------------
					// 만약 첫 작성자면
					//---------------------------------------
					if(String.valueOf(dailyList.get(i).get("emp_no")).equals(emp_no)) {
						next_app_getSign_date =  this.dailyDAO.first_app_getSign_date(dailyBusiSearchDTO);					
						dailyList.get(i).put("next_app_getSign_date", next_app_getSign_date);
						
					}				
					//---------------------------------------
					// 만약 첫 작성자가 아니면 
					//---------------------------------------
					else{
						next_app_getSign_date =  this.dailyDAO.next_app_getSign_date(dailyBusiSearchDTO);					
						dailyList.get(i).put("next_app_getSign_date", next_app_getSign_date);
					}
					
				}
				
			}

		mav.setViewName("dailyListForm.jsp");
		
		if(dailyList!=null) {		
			mav.addObject("daliyBusiAllTotCnt",daliyBusiAllTotCnt);
			mav.addObject("daliyBusiTotCnt",daliyBusiTotCnt);
			mav.addObject("dailyList",dailyList);
			mav.addObject("pagingMap", pagingMap);
			mav.addObject("selectPageNo", pagingMap.get("selectPageNo"));
		}
		
		return mav;
	}
	
	
	
	
	

//----------------------------------------------------------------------------------------------------------------------------
	// 일일보고서 등록화면
	// 가상주소 /dailybusinessRegForm.do 로 접근하면 호출되는 메소드 선언
//----------------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/dailybusinessRegForm.do")
	ModelAndView godailyRegForm(HttpSession session, DailyBusiDTO dailyBusiDTO) {

		ModelAndView mav = new ModelAndView();

		String emp_no = (String)session.getAttribute("uid");
		int emp_no2 = Integer.parseInt(emp_no);
		String emp_name = (String)session.getAttribute("emp_name");
		String jikup_name = (String)session.getAttribute("jikup_name");
		
		dailyBusiDTO.setEmp_no(emp_no2);
		dailyBusiDTO.setEmp_name(emp_name);
		dailyBusiDTO.setEmp_name(jikup_name);
		  
		List<Next_App_Emp_List> next_app_list = this.dailyService.get_next_app_list(dailyBusiDTO);
		
		mav.addObject("next_app_list", next_app_list); 
		mav.setViewName("dailybusinessRegForm.jsp");
		return mav;
	}

		
	
	
	
	

//----------------------------------------------------------------------------------------------------------------------------
	// [비동기] 일일보고서 등록 적용행의 개수 리턴하는 메소드 
	// 가상주소 /dailyBusiRegProc.do 로 접근하면 [1개의 일일업무보고서 입력 적용행의 개수]를 리턴하는 메소드 선언
//----------------------------------------------------------------------------------------------------------------------------	
	@RequestMapping(
			value="/dailyBusiRegProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int insertDailBusiReport(HttpSession session, DailyBusiDTO dailyBusiDTO) {

		
		int insertDailBusiReportCnt = this.dailyService.first_insertDailyReport(dailyBusiDTO);		
		return insertDailBusiReportCnt;		
	}
	
	
	
	
	
	


//----------------------------------------------------------------------------------------------------------------------------
	// 일일보고서 상세 화면 
	// 가상주소 /dailyBusinessDetailForm.do 로 접근하면 호출되는 메소드 선언
//----------------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/dailyBuisDetailForm.do")
	public ModelAndView boardDetailForm(
			HttpSession session
			,@RequestParam(value="report_no") int report_no
			,@RequestParam(value="report_no") int report_code //<-------------
	) {

		 String emp_no = (String)session.getAttribute("uid");
		 int emp_no2 = Integer.parseInt(emp_no);

		DailyBusiDTO dailyBusiDTO = this.dailyService.getBoard(report_no,emp_no2); 

		
		  dailyBusiDTO.setLogin_emp_no(emp_no2);
		  
		 List<Next_App_Emp_List> next_app_list =this.dailyDAO.get_next_app_list2(emp_no2);
		  //---------------------------------------------------------------------------
		  // 저장된 report_no 를 가지고 최종결제자 얻어오기
		  Map<String,String> lastAppMan = new
		  HashMap<String,String>(); lastAppMan = this.dailyDAO.getlastAppMan(dailyBusiDTO);
		  //---------------------------------------------------------------------------
		  // 저장된 report_no 를 가지고 다음결제자 얻어오기 
		  Map<String,String> nextAppMan = new HashMap<String,String>(); //로그인하는 사람과 보고서 작성한 사람이 같으면 
		  if(emp_no2 ==dailyBusiDTO.getEmp_no()) { 
			  nextAppMan = this.dailyDAO.getLogin_NextAppMan(dailyBusiDTO);
		  } 
		  else { 
			  nextAppMan = this.dailyDAO.getNextAppMan(dailyBusiDTO); 
		  }
	
		  
		//---------------------------------------------------------------------------
          // 첫결제자 아닌 사람의 다음결제자의 직원번호 얻어오기 
          String nextAppManEmp_no = new String();

          Map<String,String> AppEmp_no = new HashMap<String,String>();

            // 해시맵에 넘어온 리포트번호와 직원번호 넣어주기
          AppEmp_no.put("report_no",     Integer.toString(report_no));
          AppEmp_no.put("emp_no",     Integer.toString(emp_no2));
          AppEmp_no.put("report_code",     Integer.toString(report_code));

          nextAppManEmp_no = this.dailyDAO.nextAppManEmp_no(AppEmp_no);
		  
		  
		  
        //------------------------------------------------------------------------------
		//**************************************************************************************************************************************
				//************************************************************************************************************************************** //<-------------
				//------------------------------------------------------------------------------
				// 저장된 report_no 를 결제리스트 뽑아오기
				List<Map<String,String>> appList = this.dailyDAO.getAppList(dailyBusiDTO); 
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
					
					next_appList_getSign_date = this.dailyDAO.next_appList_getSign_date(myInfo);
					
					if(next_appList_getSign_date!=null) {
						appList.get(i).put("next_app_date", next_appList_getSign_date);
					}			
					else if(/*next_appList_getSign_date==null &&*/ (nextAppMan.get("next_sign_code").equals("0") && lastAppMan.get("last_sign_code").equals("0")) || (nextAppMan.get("next_sign_code").equals("1")&& lastAppMan.get("last_sign_code").equals("1"))){
						 
						System.out.println("들옴");
						next_appList_getSign_date = this.dailyDAO.my_appList_getSign_date(myInfo);
						appList.get(i).put("next_app_date", next_appList_getSign_date);
					}
					
				}
				//**************************************************************************************************************************************
				//**************************************************************************************************************************************
		ModelAndView mav = new ModelAndView();
		 mav.addObject("next_app_list", next_app_list);
		mav.setViewName("dailyBuisDetailForm.jsp");
		mav.addObject("dailyBusiDTO",dailyBusiDTO);		
		mav.addObject("lastAppMan",lastAppMan);
		mav.addObject("nextAppMan",nextAppMan);
		mav.addObject("appList",appList); //<-------------
		mav.addObject("nextAppManEmp_no",nextAppManEmp_no);
		
		return mav;
		
	}	
	//***********************************************************************************
	// 수정 시 호출되는 메소드 선언
	//***********************************************************************************
	@RequestMapping(
			value="/dailyAlterProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	int alterDailBusiReport(HttpSession session, DailyBusiDTO dailyBusiDTO) {
				
		int alterBusiReport = this.dailyService.alterDailBusiReport(dailyBusiDTO);
						
		return alterBusiReport;		
		
	}
	//***********************************************************************************
	
	
	
	
	
	

	//----------------------------------------------------------------------------------------------------------------------------
		// [비동기] 일일보고서 상세화면에서 결재/반려 적용행의 개수 리턴하는 메소드
		// 가상주소 /dailyUpdelProc.do 로 접근하면 호출되는 메소드 선언
	//----------------------------------------------------------------------------------------------------------------------------
	@RequestMapping(
			value="/dailyUpdelProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	int signDailBusiReport(HttpSession session, DailyBusiDTO dailyBusiDTO) {
		
		int insertDailBusiReportCnt = 0;
			//---------------------------------------------------
			String emp_no = (String)session.getAttribute("uid");
			int emp_no2 = Integer.parseInt(emp_no);
			dailyBusiDTO.setEmp_no(emp_no2);
			//---------------------------------------------------

		//---------------------------------------------------
		// 만약 결재를 눌렀다면
		//---------------------------------------------------
		if(dailyBusiDTO.getApproval_yesNo()==0) {
			insertDailBusiReportCnt = this.dailyService.signDailBusiReport(dailyBusiDTO);						
		}		
		//---------------------------------------------------
		// 만약 반려를 눌렀다면
		//---------------------------------------------------	
		else if(dailyBusiDTO.getApproval_yesNo()==1) {
			insertDailBusiReportCnt = this.dailyService.signMinusBusiReport(dailyBusiDTO);			
		}
		return insertDailBusiReportCnt;		
		
	}
	
	
	
	/*
	//가상주소 /dailyBusiRegForm.do 로 접근하면 호출되는 메소드 선언
	ModelAndView godailyRegForm(HttpSession session) {
		return;		
	}

	//가상주소 /dailyUpdelForm.do 로 접근하면 호출되는 메소드 선언
	ModelAndView goexpenseUpdelForm(HttpSession session, @RequestParam Map<String, String> paramsMap) {
		return;		
	}

	//가상주소 /dailyUpdelProc.do 로 접근하면 [1개의 일일업무보고서 수정/결재 적용행의 개수]를 리턴하는 메소드 선언
	int signDailBusiReport(HttpSession session, DailyBusiDTO dailyBusiDTO) {
		return;		
	}
	*/
}
