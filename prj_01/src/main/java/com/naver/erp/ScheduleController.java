package com.naver.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

@Controller
public class ScheduleController {

	@Autowired
	private ScheduleService scheduleService;

	// =====================================
	// 일정관리 화면 호출 하는 메소드
	// =====================================
	@RequestMapping(value = "/planList.do")
	public ModelAndView planList( NotificationDTO notificationDTO , HttpSession session 
					, @RequestParam(value = "alim" ,required=false) String alim 
					, @RequestParam(value = "dark" ,required=false) String dark
		) {
		
		// 페이지 이동 || 검색 시에만 이녀석들이 들어와서 jsp 페이지로 데이터가 간다.
		// System.out.println( "alim => " + alim + "/ " + "dark => " + dark );
		
		ModelAndView mav = new ModelAndView();
		
		if( alim != null  ) {
			mav.addObject("alim", alim );
		}
		if( dark != null  ) {
			mav.addObject("dark", dark );
		}
		
	    //==================================================
	    // 일정관리 안에서 알림 클릭 시 열람할 알람 데이터들을 
		// 가져와서 띄울 거 
	    //==================================================
		
		String uid = (String)session.getAttribute("uid");
        notificationDTO.setUid( uid );
		
		// 검색한 알림 게시물의 개수
		int SearchTotCnt = this.scheduleService.getSearchCnt( notificationDTO );
		
		
		// 알림 게시물의 총 개수 
		int ListTotCnt = this.scheduleService.getListCnt( uid );
		
		// int totListCnt = this.scheduleService.getTotCnt( uid );
		
		Map<String,Integer> pagingMap =  ScheduleUtil.getPagingMap(
				notificationDTO.getSelectPageNo()     // 선택한 페이지 번호
				, notificationDTO.getRowCntPerPage()  // 한 화면에 보여지는 행의 개수
				, SearchTotCnt                        // 검색한 게시물의 총 개수 
		);
		
		if( pagingMap.size() > 0 ) {
		
		notificationDTO.setBegin_rowNo(  pagingMap.get("begin_rowNo")  );
		notificationDTO.setEnd_rowNo(  pagingMap.get("end_rowNo")  );
		
		}
		
		
		List<Map<String, String>> shareList = this.scheduleService.getShareList( notificationDTO );

		mav.addObject("SearchTotCnt", SearchTotCnt); // 검색한 알림 개수
		mav.addObject("ListTotCnt", ListTotCnt);     // 그 회원 알림의 총 개수 
		mav.addObject("pagingMap", pagingMap);       // 페이징 정보 
        mav.addObject(  "shareList"  ,  shareList  );
		
		
		
		
		
		
	    //==================================================
	    // 일정관리 달력에 들어갈 uid 값의 유저의 모든 일정을 
        // 가져와서 달력에 띄우기 위에 가져올 녀석들..
	    //==================================================
		
		// 유저의 모든 일정 목록을 가져와서 모델앤뷰 객체에 저장.
		List<Map<String, String>> calendarList = this.scheduleService.getList(uid);

		//System.out.print( "calendarList => " + calendarList );
		
		int ListCnt = this.scheduleService.getListCnt( uid );
		
		mav.setViewName("planList.jsp");
        mav.addObject(  "ListCnt"  ,  ListCnt  );
		mav.addObject("calendarList", calendarList);

		return mav;
	}


	
	// =====================================
	// 해당 날짜에 클릭 후 일정등록 때려주는 메소드 
	// =====================================
	@RequestMapping(value = "/scheduleInsertProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int scheduleInsertProc(ScheduleDTO scheduleDTO) {

		int insertCnt = this.scheduleService.insertList( scheduleDTO );

		
//		 System.out.println( scheduleDTO.getUid() + "/" + scheduleDTO.getStart_date()
//		  + "/" + scheduleDTO.getSubject() + "/" + scheduleDTO.getEnd_date()
//		  + "/" + scheduleDTO.getEnd_hour()
//		  
//		  );
		 
		//System.out.println( insertCnt );

		return insertCnt;
	}	
	
	
	
	
	
	// =====================================
	// 해당 번호의 캘린더 목록 가져오기 
	// =====================================
	@RequestMapping(value = "/getCalInfo.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> getCalInfo( @RequestParam(value = "cal_no") String cal_no ) {

		//System.out.println( "pk 값은 =>" + cal_no );
		
		Map<String, String> getCalList = this.scheduleService.getCalList( cal_no );

		// 자바 해쉬맵객체 안의 키 말고 밸루값들 보여주는 메소드 
		//System.out.println(       getCalList.values()          );

		return getCalList;
	}
	
	
	


	// =====================================
	// 상세보기 팝업창에서 수정하는 메소드
	// =====================================
	@RequestMapping(value = "/calUpProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int calUpProc( ScheduleDTO scheduleDTO ) {

		//System.out.println(  scheduleDTO.getEnd_hour() + scheduleDTO.getEnd_minute()
		//                   + scheduleDTO.getStart_hour() + scheduleDTO.getStart_minute() );

		int scheduleUpCnt = this.scheduleService.getCalUpCnt( scheduleDTO );

		return scheduleUpCnt;
	}

	
	// =====================================
	// 상세보기 팝업창에서 삭제하는 메소드
	// =====================================
	@RequestMapping(value = "/calDelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int calDelProc( ScheduleDTO scheduleDTO ) {

		//System.out.println( "해당 달력 삭제시 달력 PK번호 => " + scheduleDTO.getCal_no()  );
		
		int scheduleDelCnt = this.scheduleService.getCalDelCnt( scheduleDTO );

		 
		
		return scheduleDelCnt;
	}

	
	
	// 일정 달력 상세보는 팝업 
	@RequestMapping(value = "/calPopup.do")
	public ModelAndView employeeJoin() {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("calDetail.jsp");

		return mav;
	}

	// 일정 달력 등록하는 팝업
	@RequestMapping(value = "/calInputPop.do")
	public ModelAndView calInputPop() {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("calRegForm.jsp");

		return mav;
	}

	// 일정 공유 하는 팝업 
	@RequestMapping(value = "/calSharing.do")
	public ModelAndView calSharing() {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("calSharing.jsp");

		return mav;
	}
	
	
	// =====================================
	// 일정 공유 팝업창에서 셀렉트 박스에 넣어줄 데이터 끌어오기
	// =====================================
	@RequestMapping(value = "/getShareOne.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Map<String, String>> getShareOne( @RequestParam(value = "uid") String uid ) {

		
		List<Map<String, String>> getEmpList = this.scheduleService.getEmpList( uid );

		
		return getEmpList;
	}
	
	
	// =====================================
	//  공유할 사람의 이름 가져오기 
	// =====================================
	@RequestMapping(value = "/getNameForm.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String,String> getNameForm( @RequestParam(value = "someone_to_share") String who ) {

		//System.out.println( "해당 달력 삭제시 달력 PK번호 => " + cal_no  );
		
		String getName = this.scheduleService.getName( who );

		Map<String,String> map = new HashMap<String,String>();
		map.put("getName",getName);
		
		return map;
	}
	
	
	
	
	
	
	
	
	// =====================================
	// 일정 공유 팝업창에서 공유 시 인설트 때릴거 
	// =====================================
	@RequestMapping(value = "/calShareProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int calShareProc( @RequestParam(value = "uid") String uid
			,@RequestParam(value = "someone_to_share") String someone_to_share
			,@RequestParam(value = "cal_no") String cal_no
			,@RequestParam(value = "subject") String subject
	) {

		
		
		// 공유할 정보를 일정공유 테이블에 인설트 때리기 전에 
		// 이미 같은 사람이 보낸 제목 , 날짜 또한 같은 일정이 있을 시 
		// 이미 공유한 일정입니다 라고 하게끔 때리기. 
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("uid",uid);
		map.put("someone_to_share",someone_to_share);
		map.put("cal_no",cal_no);
		map.put("subject",subject);
		
		int getCnt = this.scheduleService.getCnt( map );

		
		return getCnt;
	}
	
	
	
	
	
	
	
	
	
	
	
	
//	//==================================
//	// 알림 창 띄우는 팝업. 
//	//==================================
//	@RequestMapping(value = "/newsForm.do")
//	public ModelAndView newsForm( NotificationDTO notificationDTO  , HttpSession session ) {
//
//		ModelAndView mav = new ModelAndView();
//
//		String uid = (String)session.getAttribute("uid");
//		notificationDTO.setUid( uid );
//		
//		// 검색한 알림 게시물의 개수
//		int SearchTotCnt = this.scheduleService.getSearchCnt( notificationDTO );
//		
//		
//		// 알림 게시물의 총 개수 
//		int ListTotCnt = this.scheduleService.getListCnt( uid );
//		
//		// int totListCnt = this.scheduleService.getTotCnt( uid );
//		
//		Map<String,Integer> pagingMap =  Util.getPagingMap(
//				notificationDTO.getSelectPageNo()     // 선택한 페이지 번호
//				, notificationDTO.getRowCntPerPage()  // 한 화면에 보여지는 행의 개수
//				, SearchTotCnt                        // 검색한 게시물의 총 개수 
//		);
//		
//		if( pagingMap.size() > 0 ) {
//		
//		notificationDTO.setBegin_rowNo(  pagingMap.get("begin_rowNo")  );
//		notificationDTO.setEnd_rowNo(  pagingMap.get("end_rowNo")  );
//		
//		}
//		
//		
//		List<Map<String, String>> shareList = this.scheduleService.getShareList( notificationDTO );
//
//		mav.addObject("SearchTotCnt", SearchTotCnt); // 검색한 알림 개수
//		mav.addObject("ListTotCnt", ListTotCnt);     // 그 회원 알림의 총 개수 
//		mav.addObject("pagingMap", pagingMap);       // 페이징 정보 
//        mav.addObject(  "shareList"  ,  shareList  );
//        mav.setViewName("newsForm.jsp");
//        
//        
//		return mav;
//	}
	
	

	// =====================================
	// 알림창에서 상세보기 클릭 시 팝업창 띄우기!
	// =====================================
	// @RequestParam(value = "share_no") String share_no
	@RequestMapping(value = "/newsDetailForm.do")
	public ModelAndView newsDetailForm( ){

		ModelAndView mav = new ModelAndView();

		// 공유번호에 해당하는 스케줄목록의 한 행을 가져오기 	
		// Map<String, String> shareOneList = this.scheduleService.getOneList( share_no );
		
        mav.setViewName("newsDetailForm.jsp");
        //mav.addObject("shareOneList", shareOneList);
        
		return mav;
	}
	
	
	
	// =====================================
	// 위에서 띄운 팝업창에서 비동기로 상세보기 데이터 가져오기 
	// =====================================
	@RequestMapping(value = "/newsDetailProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String,String> getDetailData( @RequestParam(value = "share_no") String share_no ) {
	
		
		
		Map<String,String> getDetailData = this.scheduleService.getOneList( share_no );
	
		System.out.println( "컨트롤러 =>" + getDetailData );
		
		return getDetailData;
	}
	
	
	
	
	// =====================================
	// 알림 상세보기에서 수락 시 인설트 때리는 메소드 호출  
	// =====================================
	@RequestMapping(value = "/calInsert2.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int calInsert2( @RequestParam(value = "subject") String subject
			,@RequestParam(value = "start_date") String start_date
			,@RequestParam(value = "end_date") String end_date
			,HttpSession Session
	) {

		//uid  someone_to_share   cal_no  subject
		
		Map<String,String> map = new HashMap<String,String>();
		
		String uid = (String)Session.getAttribute("uid");
		
		map.put("uid",uid);
		map.put("subject",subject);
		map.put("start_date",start_date);
		map.put("end_date",end_date);
		
		int getPutCnt = this.scheduleService.getPutCnt( map );

		
		return getPutCnt;
	}
	
	
	// =====================================
	// 알림 상세보기에서 거절 시 델리트 때리는 메소드 호출  
	// 그리고 위에 수락 시 에도 일정 등록 후 삭제 할 거.
	// =====================================
	@RequestMapping(value = "/calShareDelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int calShareDelProc( @RequestParam(value = "share_no") String share_no ) {

		int getDelCnt = this.scheduleService.getDelCnt( share_no );

		
		return getDelCnt;
	}
	
	

	// =====================================
	//  일정완료 시 해당 캘린더 수정 때리면서 줄 긋기
	// =====================================
	@RequestMapping(value = "/calCompletProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int calCompletProc( @RequestParam(value = "cal_no") String cal_no ) {

		
		int getCompletCnt = this.scheduleService.getCompletCnt( cal_no );

		
		return getCompletCnt;
	}
	
	
	
	
	
}
