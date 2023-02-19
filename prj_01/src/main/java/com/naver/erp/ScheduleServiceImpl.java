package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleDAO scheduleDAO;
	
	
	
	
	// 스케줄 리스트 가져오기 
	public List<Map<String,String>> getList( String uid ){
		
		List<Map<String,String>> getList = this.scheduleDAO.getList( uid );
		
		return getList;
	}
	
	// 일정관리에 들어간 데이터를 디비에 박기 
	public int insertList( ScheduleDTO scheduleDTO ) {
		
		int getCnt = this.scheduleDAO.insertList(scheduleDTO);
		
		return getCnt;
		
	}
	

	
	// 삭제할 일정 없애구 성공여부 리턴
	public int getCalDelCnt( ScheduleDTO scheduleDTO ) {
	
	// 삭제할 일정관리 번호가 공유했는지 알려주는 메소드 호출	
	int Cnt = this.scheduleDAO.getCalShareCnt( scheduleDTO );
	
	if( Cnt > 0 ) {
		
		return 2;
	}
		
    int getDelCnt = this.scheduleDAO.getCalDelCnt( scheduleDTO );
	
	  return getDelCnt;
	}
	
	
	
	// 수정할 일정 없애구 성공여부 리턴
	public int getCalUpCnt( ScheduleDTO scheduleDTO ) {
	
    int getCnt = this.scheduleDAO.getCalUpCnt( scheduleDTO );
	
	  return getCnt;
	
	}
	
	
	
	// 해당 번호의 캘린더 목록 가져오기 
	public Map<String,String> getCalList( String cal_no ){
		
		Map<String,String> getCalList = this.scheduleDAO.getCalList( cal_no );
		
		return getCalList;
	}
	
	
	
	// 해당 아이디 이외에 모든 직원 리스트 가져오기
	public List<Map<String,String>> getEmpList( String uid ){
		
		List<Map<String,String>> getEmpList = this.scheduleDAO.getEmpList( uid );
		
		return getEmpList;
	}
	
	
	// 해당 데이터들고 일정공유 테이블에 인설트 후 적용개수 리턴 
	public int getCnt( Map<String,String> map ) {
		
		int getCnt = this.scheduleDAO.getCnt( map );
		
		return getCnt ;
		
	}
	
	
	
	// 해당 아이디로 들어온 알림 리스트 뽑아오기 
	public List<Map<String,String>> getShareList( NotificationDTO notificationDTO ){
		
		List<Map<String,String>> getShareList = this.scheduleDAO.getShareList( notificationDTO );
		
		return  getShareList;
	}
	
	
	
	// 해당 아이디로 알림게시물에 들어온 후 검색 했을 때 결과물 개수 
	public int getSearchCnt( NotificationDTO notificationDTO ) {
		
		int getSearchCnt = this.scheduleDAO.getSearchCnt( notificationDTO );
		
		return getSearchCnt;
	}
	
	
	
	
	
	
	
	// 해당 아이디로 들어왔을 때 알림 개수 뽑아 오기 
	public 	int getListCnt( String uid ) {
		
		int getListCnt = this.scheduleDAO.getListCnt( uid );
		
		return getListCnt;
	}
	
	
	
	// 알림 상세보기 드갈 때 현재 클릭한 알림 정보 가져오기 
	public Map<String,String> getOneList( String share_no ){
		
		Map<String,String> getOneList = this.scheduleDAO.getOneList( share_no );
		
		return getOneList;
		
	}
	 
	
	// 일정공유 받은 쪽에서 수락 시 일정 인설트 때리는
	public int getPutCnt( Map<String,String> map ) {
		
		int getPutCnt = this.scheduleDAO.getPutCnt( map );
		
		return getPutCnt;
	}
	
	
    // 일정공유 받은 쪽에서 거절 시 스케줄공유 델리트 때리는
	public int getDelCnt( String share_no ) {
		
		int getDelCnt = this.scheduleDAO.getDelCnt( share_no );
		
		return getDelCnt;
	}
	
	
    // 공유한 그 사람의 이름을 가져오는 
	public String getName( String who ){
		
		String getName = this.scheduleDAO.getName( who );
		
		return getName;
	}
	
	
	
    // 해당 캘린더 제목에 줄 긋기  
	public int getCompletCnt( String cal_no ) {
		
		int getCompletCnt = this.scheduleDAO.getCompletCnt( cal_no );
		
		return getCompletCnt;
	}
	
	

//    // 이 회원의 알림목록 총 개수 가져오기
//	public int getTotCnt( String uid ) {
//		
//		int getTotCnt = this.scheduleDAO.getTotCnt( uid );
//		
//		return getTotCnt;
//	}
	
	
	
	
	
	
	
	
	
}
