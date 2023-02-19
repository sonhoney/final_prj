package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ScheduleDAOImpl implements ScheduleDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	
	// 스케줄 리스트 가져오기 
	public List<Map<String,String>> getList( String uid ){
		
		 List<Map<String,String>> a = null;
		 
		List<Map<String,String>> getList = this.sqlSession.selectList(
				 "com.naver.erp.ScheduleDAO.getList"
				,uid
	    );
		
		
		//System.out.println( "DAO클래스 =>  " + getList );
		
		return getList;
		
	}
	
	
	// 일정관리에 들어간 데이터를 디비에 박기 
	public int insertList( ScheduleDTO scheduleDTO ) {
		
		int insertCnt = this.sqlSession.insert(
				 "com.naver.erp.ScheduleDAO.insertList"
				,scheduleDTO
		);
		
		return insertCnt;
	}
	
	
	
	
	
	// 삭제할 일정 없애구 성공여부 리턴
	public int getCalDelCnt( ScheduleDTO scheduleDTO ) {
		
		int getCalDelCnt = this.sqlSession.delete(
				 "com.naver.erp.ScheduleDAO.getCalDelCnt"
				,scheduleDTO
		);
		
		//System.out.println( "스케줄DAO 일정삭제 개수 => " + getCalDelCnt  );
		
		return getCalDelCnt;
		
	}
	
	// 삭제하기 전에 공유가 된 일정인지 리턴 
	public int  getCalShareCnt( ScheduleDTO scheduleDTO ) {
		
		int getCalShareCnt = this.sqlSession.selectOne(
				 "com.naver.erp.ScheduleDAO.getCalShareCnt"
				,scheduleDTO
		);
		
		return getCalShareCnt;
	}
	
	
	
	
	
	
	// 수정할 일정 수정떄리구 성공여부 리턴
	public int getCalUpCnt( ScheduleDTO scheduleDTO ) {
		
		int getCalUpCnt = this.sqlSession.update(
				 "com.naver.erp.ScheduleDAO.getCalUpCnt"
				,scheduleDTO
		);
		
		//System.out.println( "스케줄DAO 일정 수정 개수 => " + getCalUpCnt  );
		
		return getCalUpCnt;
		
	}
	
	
	
	// 해당 번호의 캘린더 목록 가져오기 
	public Map<String,String> getCalList( String cal_no ){
		
		Map<String,String> getCalList = this.sqlSession.selectOne(
				"com.naver.erp.ScheduleDAO.getCalList"
				,cal_no
		);
		
		return getCalList;
		
	}
	
	
	
	// 해당 아이디 이외에 모든 직원 리스트 가져오기
	public List<Map<String,String>> getEmpList( String uid ){
		
		List<Map<String,String>> getEmpList = this.sqlSession.selectList(
				"com.naver.erp.ScheduleDAO.getEmpList"
				,uid
		);
		
		return getEmpList; 
	}
	
	
	
	// 해당 데이터들고 일정공유 테이블에 인설트 후 적용개수 리턴 
	public int getCnt( Map<String,String> map ) {
		
		int getCnt = this.sqlSession.insert(
				"com.naver.erp.ScheduleDAO.getCnt"
				,map
		);
		
		return getCnt;
	}
	
	
	
	
	
	
	
	
	
	// 해당 아이디로 들어온 알림 리스트 뽑아오기 
	public List<Map<String,String>> getShareList( NotificationDTO notificationDTO ){
		
		List<Map<String,String>> getShareList = this.sqlSession.selectList(
				"com.naver.erp.ScheduleDAO.getShareList"
				,notificationDTO
		);
		
		return getShareList;
		
	}
	
	
	
	// 해당 아이디로 알림게시물에 들어온 후 검색 했을 때 결과물 개수 
	public int getSearchCnt( NotificationDTO notificationDTO ) {
		
		int getSearchCnt = this.sqlSession.selectOne(
				"com.naver.erp.ScheduleDAO.getSearchCnt"
				,notificationDTO
		);
		
		return getSearchCnt;
	}
	
	
	
	
	
	
	
	
	
	
	
	// 해당 아이디로 들어왔을 때 알림 개수 뽑아 오기 
	public int getListCnt( String uid ) {
		
		int getListCnt = this.sqlSession.selectOne(
				"com.naver.erp.ScheduleDAO.getListCnt"
				,uid
		);
		
		
		return getListCnt;
	}
	
	
	
	
	// 알림 상세보기 드갈 때 현재 클릭한 알림 정보 가져오기 
	public Map<String,String> getOneList( String share_no ){
		
		Map<String,String> getOneList = this.sqlSession.selectOne(
				"com.naver.erp.ScheduleDAO.getOneList"
				,share_no
		);
		
		return getOneList;
	}
	
	
	
	// 일정공유 받은 쪽에서 수락 시 일정 인설트 때리는
    public int getPutCnt( Map<String,String> map ) {
    	
    	int getPutCnt = this.sqlSession.insert(
				"com.naver.erp.ScheduleDAO.getPutCnt"
				,map
		);
    	
    	return getPutCnt ;
    }
	
	
    // 일정공유 받은 쪽에서 거절 시 스케줄공유 델리트 때리는
    public int getDelCnt( String share_no ) {
    	
    	int getDelCnt = this.sqlSession.delete(
				"com.naver.erp.ScheduleDAO.getDelCnt"
				,share_no
		);
    	
    	return getDelCnt ;
    }
	
	
    // 공유한 그 사람의 이름을 가져오는 
	public String getName( String who ){
		
		String getName = this.sqlSession.selectOne(
				"com.naver.erp.ScheduleDAO.getName"
				,who
		);
		
		return getName;
	}
	
	
	
    // 이 회원의 알림목록 총 개수 가져오기
	public int getTotCnt( String uid ) {
		
		int getTotCnt = this.sqlSession.selectOne(
				"com.naver.erp.ScheduleDAO.getTotCnt"
				,uid
		);
		
		return getTotCnt;
	}
	
	
	
    // 해당 캘린더 제목에 줄 긋기  
	public int getCompletCnt( String cal_no ) {
		
		int getCompletCnt = this.sqlSession.update(
				"com.naver.erp.ScheduleDAO.getCompletCnt"
				,cal_no
		);
		
		return getCompletCnt;
	}
	
	// 아직 xml 파일에는 안만듬. 
	
	
	
	
}
