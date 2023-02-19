package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface ScheduleDAO {

	// 스케줄 리스트 가져오기 
	List<Map<String,String>> getList( String uid );
	
	// 일정관리에 들어간 데이터를 디비에 박기 
	int insertList( ScheduleDTO scheduleDTO );
	
   
	
	// 삭제할 일정 없애구 성공여부 리턴
	int getCalDelCnt( ScheduleDTO scheduleDTO ); 
	
	// 삭제하기 전에 공유가 된 일정인지 리턴 
	int  getCalShareCnt( ScheduleDTO scheduleDTO );
	
	
	
	// 수정할 일정 없애구 성공여부 리턴
	int getCalUpCnt( ScheduleDTO scheduleDTO );
	
	
	// 해당 번호의 캘린더 목록 가져오기 
	Map<String,String> getCalList( String cal_no );
	
	
	// 해당 아이디 이외에 모든 직원 리스트 가져오기
	List<Map<String,String>> getEmpList( String uid );
	
	
	// 해당 데이터들고 일정공유 테이블에 인설트 후 적용개수 리턴 
	int getCnt( Map<String,String> map );
	
	
	
	
	
	// 해당 아이디로 들어온 알림 리스트 뽑아오기 
	List<Map<String,String>> getShareList( NotificationDTO notificationDTO );
	
	
	
	
	// 해당 아이디로 알림게시물에 들어온 후 검색 했을 때 결과물 개수 
	int getSearchCnt( NotificationDTO notificationDTO );
	
	
	
	
	// 해당 아이디로 들어왔을 때 알림 개수 뽑아 오기 
	int getListCnt( String uid );
	
	
	// 알림 상세보기 드갈 때 현재 클릭한 알림 정보 가져오기 
	Map<String,String> getOneList( String share_no );
	
	
	// 일정공유 받은 쪽에서 수락 시 일정 인설트 때리는
    int getPutCnt( Map<String,String> map );
	
	
    // 일정공유 받은 쪽에서 거절 시 스케줄공유 델리트 때리는
    int getDelCnt( String share_no );
	
    
    // 공유한 그 사람의 이름을 가져오는 
    String getName( String who );
	

    // 해당 캘린더 제목에 줄 긋기  
    int getCompletCnt( String cal_no );
	
	
	
	
	
}
