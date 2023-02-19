package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class MeetingController {

	

	@Autowired
	private MeetingService  meetingService ;



	// 회의장 예약화면으로 이동하는 메소드
	@RequestMapping(value="/meetingResForm.do")
	public ModelAndView meetingResForm() {
		
		
		ModelAndView mav = new ModelAndView() ;
		mav.setViewName("meetingResForm.jsp");

		return mav ;
	}
	// 상세화면 으로 이동하는 메소드
	@RequestMapping(value="/meetingDetailForm.do")
	public ModelAndView meetingDetailForm( @RequestParam(value="b_no") int b_no ) {
		
		MeetingDTO meetingDTO = this.meetingService.getBoard(b_no);

		ModelAndView mav = new ModelAndView() ;
		mav.addObject("meetingDTO", meetingDTO) ;
		mav.setViewName("meetingDetailForm.jsp");
		System.out.println( "사원번호 "+ meetingDTO.getEmp_no()+"");

		return mav ;
	}

	// 수정 화면 으로 이동하는 메소드
	@RequestMapping(value="/meetingUpDelForm.do")
	public ModelAndView meetingUpDelForm( @RequestParam(value="b_no") int b_no ) {
		
		MeetingDTO meetingDTO = this.meetingService.getBoard(b_no);

		ModelAndView mav = new ModelAndView() ;
		mav.addObject("meetingDTO", meetingDTO) ;
		mav.setViewName("meetingUpDelForm.jsp");

		return mav ;
	}


	// 회의장 예약 게시판으로 이동하는 메소드
	@RequestMapping(value="/meetingBoardList.do")
	public ModelAndView meetingBoardList(MBoardSearchDTO mBoardSearchDTO) {
		
		// 총개수 저장할 변수 선언 
		int meetingBoardTotCnt = this.meetingService.getTotcnt() ;

		// 검색된 개수 저장할 변수 선언
		int meetingSearchCnt = this.meetingService.getSearchCnt(mBoardSearchDTO) ;
		

		
		//*******************************************
		// 페이징 처리 관련 데이터와 기타 데이터(DB 연동시 필요한 데이터,보정된 선택 페이지 번호 등)가 저장된 HashMap 객체 얻기
		// Util 객체의 getPagingMap 라는 메소드 호출로 얻는다.
		//*******************************************
		Map<String,Integer> pagingMap = Util.getPagingMap(
			mBoardSearchDTO.getSelectPageNo()       // 선택한 페이지 번호
				, mBoardSearchDTO.getRowCntPerPage()    // 한 화면에 보여지는 행의 개수
				, meetingSearchCnt                          // 검색된 게시판의 총개수
		);

		//*******************************************
		// BoardSearchDTO 객체의 selectPageNo 속성변수 보정된 선택페이지 번호 재 저장하기
		// BoardSearchDTO 객체의 begin_rowNo 속성변수에 검색 결과물에서 페이지번호 맞게 부분을 가져올 때 시작행 번호를 저장하기
		// BoardSearchDTO 객체의 end_rowNo 속성변수에 검색 결과물에서 페이지번호 맞게 부분을 가져올 때 끝행 번호를 저장하기
		//*******************************************
		mBoardSearchDTO.setSelectPageNo( (int)pagingMap.get("selectPageNo")  );
		mBoardSearchDTO.setBegin_rowNo( (int)pagingMap.get("begin_rowNo")  ); 
		mBoardSearchDTO.setEnd_rowNo( (int)pagingMap.get("end_rowNo")  );
		

		// 게시판 목록 저장할 변수 List 객체 선언
		List<Map<String,String>> mboardList =  this.meetingService.getBoardList( mBoardSearchDTO);
		
		
		ModelAndView mav = new ModelAndView() ;
		mav.addObject("pagingMap", pagingMap) ;
		mav.addObject("meetingSearchCnt", meetingSearchCnt) ;
		mav.addObject("mboardList", mboardList) ;
		mav.addObject("meetingBoardTotCnt",meetingBoardTotCnt) ;
		mav.addObject(  "selectPageNo" , (int)pagingMap.get("selectPageNo") );


		mav.setViewName("meetingBoardList.jsp");

		return mav ;
	}
	

	// 회의장 예약페이지에서 예약 버튼 클릭시 실행되는 메소드
	@RequestMapping(
		value="/meetingResProc.do"
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int meetingResProc( MeetingDTO meetingDTO ){

			int meetResCnt = this.meetingService.insertMeetingBoard( meetingDTO ) ;
			
			return meetResCnt;
	}

	// 예약 수정시 실행되는 메소드
	@RequestMapping(
		value="/meetingUpProc.do"
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int meetingUpProc( MeetingDTO meetingDTO ){

			int updateCnt = this.meetingService.updateMeetingBoard( meetingDTO ) ;
			
			return updateCnt;
	}

	// 예약 삭제시 실행되는 메소드
	@RequestMapping(
		value="/meetingDelProc.do"
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int meetingDelProc( MeetingDTO meetingDTO ){

			int deleteCnt = this.meetingService.deleteMeetingBoard( meetingDTO ) ;
			
			return deleteCnt;
	}


	
	
	// 예약폼에 입력양식이 모두 입력됐을경우 예약가능한 회의실 목록을 가져오는 메소드
	@RequestMapping(
		value="/getCanResRoom.do"
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public HashMap<String,String> getCanResRoom(MeetingDTO meetingDTO){
		
		
		List<Map<String,String>> getCanResRooms =  this.meetingService.getCanResRoomList(meetingDTO) ;
												
		HashMap<String,String> rooms = new HashMap<String,String>( );
		
		for( int i=0 ; i<getCanResRooms.size() ; i++){
			System.out.println( getCanResRooms.get(i).get("room_code") );
			
			String room_code =getCanResRooms.get(i).get("room_code") ;
			String room_name =getCanResRooms.get(i).get("room_name") ;

			rooms.put(room_code,room_name) ;
		}


		return rooms ;
		
	}


	
	
	
	
	
}
