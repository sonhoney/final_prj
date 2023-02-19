package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MeetingDAOImpl implements MeetingDAO{

    @Autowired
	private SqlSessionTemplate sqlSession;

    // 회의장 예약 성공시 1을 리턴하는 메소드
    public int insertMeetingBoard(MeetingDTO meetingDTO){
        
        int insertCnt = this.sqlSession.insert(
            //실행할 구문 위치 지정
            "com.naver.erp.MeetingDAO.insertMeetingBoard"
            , meetingDTO) ;
         
                
        return insertCnt;

    }

    // 예약된 회의장 게시물 총 개수 리턴하는 메소드
    public int  getTotcnt(){

        int totCnt = this.sqlSession.selectOne(
            "com.naver.erp.MeetingDAO.getTotcnt"
        );
        
        return totCnt ;
    }
    // 예약된 회의장 List를 가져오는 메소드
    public List<Map<String,String>> getBoardList(MBoardSearchDTO mBoardSearchDTO){
        
        List<Map<String,String>> mboardList = this.sqlSession.selectList(
				
				"com.naver.erp.MeetingDAO.getBoardList"
			    ,  mBoardSearchDTO

		);

        return mboardList ;
 
    }
    
    // 예약 가능한 회의장 List를 가져오는 메소드
    public List<Map<String,String>> getCanResRoomList(MeetingDTO meetingDTO){
        List<Map<String,String>> getCanResRooms = this.sqlSession.selectList(
            "com.naver.erp.MeetingDAO.getCanResRoomList"  
            ,meetingDTO
        );
        System.out.println("MeetingDAOImpl에서 getCanResRoomList실행");
        
        
        return getCanResRooms;
    }

    // 검색된 게시물 총개수를 리턴하는 메소드 
    public int getSearchCnt(MBoardSearchDTO mBoardSearchDTO){
        int meetingSearchCnt = this.sqlSession.selectOne(
            "com.naver.erp.MeetingDAO.getSearchCnt"
            ,mBoardSearchDTO
        ) ;

        return meetingSearchCnt ;

    }
    // 상세화면 목록을 가져오는 메소드
    public MeetingDTO getBoard(int b_no){

        MeetingDTO meetingDTO = this.sqlSession.selectOne(
            "com.naver.erp.MeetingDAO.getBoard"
            ,b_no
        );
        return meetingDTO ;
    }

    // 예약 수정하는 메소드
    public int updateMeetingBoard( MeetingDTO meetingDTO){
        int updateCnt  = this.sqlSession.update(
            "com.naver.erp.MeetingDAO.updateMeetingBoard"
            ,meetingDTO
        );

        return updateCnt ;
    }

    // 예약 삭제하는 메소드 
    public int deleteMeetingBoard( MeetingDTO meetingDTO){
        int updateCnt  = this.sqlSession.delete(
            "com.naver.erp.MeetingDAO.deleteMeetingBoard"
            ,meetingDTO
        );

        return updateCnt ;
    }




}
