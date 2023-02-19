package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface MeetingService {

    // 회의장 예약 성공시 1을 리턴하는 메소드
    int insertMeetingBoard(MeetingDTO meetingDTO) ;
    // 예약된 회의장 게시물 총 개수 리턴하는 메소드
    int getTotcnt() ;
    // 예약된 회의장 List를 가져오는 메소드
    List<Map<String,String>> getBoardList(MBoardSearchDTO mBoardSearchDTO);
    // 예약 가능한 회의장 List를 가져오는 메소드 
    List<Map<String,String>> getCanResRoomList(MeetingDTO meetingDTO);
    // 검색된 게시물 총개수 리턴하는 메소드
    int getSearchCnt(MBoardSearchDTO mBoardSearchDTO) ;
    // 상세화면 데이터를 가져오는 메소드 
    MeetingDTO getBoard( int b_no); 
    // 예약 수정 메소드 
    int updateMeetingBoard(MeetingDTO meetingDTO) ; 
    // 예약 삭제 메소드
    int deleteMeetingBoard(MeetingDTO meetingDTO);

    
}
