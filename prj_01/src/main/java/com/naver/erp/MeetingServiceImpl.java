package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MeetingServiceImpl implements MeetingService{

    @Autowired
    private MeetingDAO meetingDAO ;
    

    // 회의장 예약 성공시 1을 리턴하는 메소드
    public int insertMeetingBoard(MeetingDTO meetingDTO){
        
        int insertCnt = this.meetingDAO.insertMeetingBoard(meetingDTO) ;

        return insertCnt;
    }
    // 예약된 회의장 게시물 총 개수 리턴하는 메소드
    public int  getTotcnt(){
        int totCnt = this.meetingDAO.getTotcnt() ;

        return totCnt ;
    }

    // 예약된 회의장 List를 가져오는 메소드
    public List<Map<String,String>> getBoardList(MBoardSearchDTO mBoardSearchDTO){

        List<Map<String,String>> mboardList = this.meetingDAO.getBoardList(mBoardSearchDTO) ;
        
        return mboardList ;
    }

    // 예약 가능한 회의장 List를 가져오는 메소드 
    public List<Map<String,String>> getCanResRoomList(MeetingDTO meetingDTO){
        
        List<Map<String,String>> getCanResRooms = this.meetingDAO.getCanResRoomList(meetingDTO) ;
        System.out.println("MeetingServiceImpl에서 getCanResRoomList실행");
        
        return getCanResRooms ;
    }

    // 검색 개수를 리턴하는 메소드 
    public int getSearchCnt(MBoardSearchDTO mBoardSearchDTO){
        int meetingSearchCnt = this.meetingDAO.getSearchCnt(mBoardSearchDTO) ;
        
        return meetingSearchCnt; 
    }

    public MeetingDTO getBoard( int b_no){

        MeetingDTO meetingDTO = this.meetingDAO.getBoard(b_no) ;
        
        return meetingDTO;
    } 

    // 예약 수정 메소드 
    public int updateMeetingBoard(MeetingDTO meetingDTO){
        
        int updateCnt = this.meetingDAO.updateMeetingBoard(meetingDTO) ;

        return  updateCnt;
    }
    
    // 예약 삭제 메소드
    public int deleteMeetingBoard(MeetingDTO meetingDTO){

        int deleteCnt = this.meetingDAO.deleteMeetingBoard(meetingDTO );

        return deleteCnt; 
    }
    
    
    
    
}
