package com.naver.erp;

import java.util.HashMap;
import java.util.Map;


// 자주 쓰이는 기능을 가진 메소드를 가진 클래스.
public class ScheduleUtil {

	// 해쉬맵에는 키값에 맞물리는 데이터는 객체이여야 한다. 고로 int 같은 기본형은 x 
	// Integer : 기본형을 관리하는 객체 
	public static Map<String,Integer> getPagingMap( 
			int selectPageNo 
			, int rowCntPerPage 
			, int totCnt 
	){
		/* **************************************************
		   [게시판 목록 화면에서 페이징 처리에 관련된 데이터]
		   **************************************************
		   3개 인자를 매개변수로 받는데, 
		   --------------------------------------------------
		   selectPageNo : 선택한 페이지 번호를 받아오는데 
		                  <주의> 로그인 시 가져오는 페이지 번호가 없기에 
		                         디폴트값 0 에서 1 로 갱신함으로써 게시물을 가져올 때
		                         1~10행 까지 받아오게 설정. 
		   --------------------------------------------------
		   rowCntPerPage : 한 페이지 당 가져오는 게시물의 개수를 10개로 선언하여 받아오는데 
		                   <주의> 로그인 시 가져오는 한페이지의 행개수가 없기 때문에 
		                          디폴트값 0 에서 10 로 갱신하여 1~10행 까지 받아오게 설정. 
		   --------------------------------------------------
		   totCnt : 게시물 목록 화면에서 키워드 검색으로 나온 결과물의 개수를 받아오는데,
		            <주의> 로그인 시에도 총개수를 받아오지만 selectPageNo , rowCntPerPage 디폴트 값
		                   이기에 1~10 행의 까지 받아오게 설정. 
		                   
		   <★주의★> 총개수가 없다면 이 안의 로직들은 계산이 안되기에 아무것도 없는 해쉬맵객체를 리턴,
		              컨트롤러에서 호출하고 나서 리턴된 해쉬맵객체를 꺼내는 코딩을 스킵하게 하였다. 
		              총개수가 없는 조건은 현재 키워드 검색 시 조건에 맞는 게시물이 없을 때만 이다.
		   ************************************************** */ 
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		
		try {
            
			
			
			//System.out.println( "페이지넘 =>" + selectPageNo + " 한 페이지개수 =>" + rowCntPerPage + " 총개수 => " + totCnt ); 
			
			
			//-------------------------------------------------------
			// 검색한 게시물이 없다면 비어있는 해쉬맵 객체 리턴. 
			if( totCnt == 0 ) { return map; }
			// 로그인 시 들고오는 rowCntPerPage 가 없기에 여기서 갱신
			if( rowCntPerPage == 0 ) {   rowCntPerPage = 5; }
            
			//-------------------------------------------------------
			// 로그인 성공 시 페이지 번호가 디폴트값으로 드가기에 여서 1 로 갱신. 
			if( selectPageNo <= 0 ) {
				selectPageNo = 1; 
			}
			
			//-------------------------------------------------------
			// 마지막 페이지번호를 구하는 공식
			int last_pageNo =  totCnt / rowCntPerPage ;
			
			//-------------------------------------------------------
			// 총개수가 딱맞게 떨어지지 않을 수 있으니 
			// 총개수에서 한화면에보여지는행 개수 를 나누고 나머지가 있다면 + 1 
			if( (totCnt % rowCntPerPage) > 0 ) {last_pageNo++;}
			
			
            //-------------------------------------------------------
			// 선택한 페이지 번호가 마지막 페이지보다 클 경우 보정. 
			if( selectPageNo >  last_pageNo ) { selectPageNo = last_pageNo;  }
			
			//-------------------------------------------------------
			// 검색할 페이지 번호 클릭 시 가져올 마지막행번호
			int end_rowNo = selectPageNo * rowCntPerPage ;

			//-------------------------------------------------------
			// 검색할 페이지 번호 클릭 시 가져올 시작행번호 
			int begin_rowNo = end_rowNo - rowCntPerPage + 1;

			// 검색해서 나오는 게시물의 총 개수에 맞춰 마지막행번호 갱신
			if( end_rowNo > totCnt ) { end_rowNo = totCnt; }

            //-------------------------------------------------------
			// 현재화면에 보이는 페이지의 최대 개수가 10 개로 설정 후
			// 현재 선택한 페이지 번호에 따라 1 ~ 10 , 11 ~ 20 , ~ , 이 나오는 공식.
			//-------------------------------------------------------
			int pageNoCnt_perPage = 5; 
			int begin_pageNo_perPage = (int)Math.floor( ( selectPageNo -1 )/pageNoCnt_perPage )*pageNoCnt_perPage + 1; 
			int end_pageNo_perPage = begin_pageNo_perPage + pageNoCnt_perPage - 1;
			if( end_pageNo_perPage > last_pageNo ) { end_pageNo_perPage = last_pageNo; }
			//-------------------------------------------------------
			
			//----------------------------------
			// 역순 일련번호 구하기 
            //----------------------------------
			 
			
			//-------------------------------------------------------
			// 이 셀렉페이지번호 와 한페이지의행개수 는  로그인 시  갱신할 수도 있으니 같이 뱉어줌. 
		    map.put( "selectPageNo", selectPageNo );
		    map.put( "rowCntPerPage", rowCntPerPage );
		    map.put( "begin_rowNo", begin_rowNo );  
			map.put( "end_rowNo", end_rowNo );
			
			
			map.put( "serialNo_asc", begin_rowNo );
			map.put( "serialNo_desc", totCnt - begin_rowNo + 1 );
			
			
			map.put( "begin_pageNo_perPage", begin_pageNo_perPage );
			map.put( "end_pageNo_perPage", end_pageNo_perPage );
			map.put( "last_pageNo", last_pageNo );
			//-------------------------------------------------------
			return map;  
			  
		}catch(Exception e) {
			return new HashMap<String,Integer>();
		}
	    
		
		
		
	 }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
