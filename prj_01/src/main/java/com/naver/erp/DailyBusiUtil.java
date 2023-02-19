package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

public class DailyBusiUtil {

		public static Map<String,Integer> getPagingMap(
			int selectPageNo
			, int rowCntPerPage
			, int totCnt
		){
			Map<String,Integer> map = new HashMap<String,Integer>();
			
			try {
				if( totCnt==0) {
					map.put("selectPageNo", selectPageNo);
					map.put("begin_rowNo", 0);
					map.put("end_rowNo", 0);
					map.put("last_pageNo", 0);
					map.put("begin_pageNo_perPage", 0);
					map.put("end_pageNo_perPage", 0);
					return map;
				}
				//--------------------------------------------------------
				if(selectPageNo<=0) {
					selectPageNo =1;
				}
				
				if(rowCntPerPage<=0) {
					rowCntPerPage =10;
				}
				//--------------------------------------------------------
				// 최대 끝 행 번호
				int last_pageNo = (totCnt/rowCntPerPage);
				if(totCnt%rowCntPerPage>0) {last_pageNo++;}
				if(selectPageNo>last_pageNo) {selectPageNo =last_pageNo;}
								// 아래 처럼도 가능
								// int last_pageNo = totCnt/rowCntPerPage + (totCnt%rowCntPerPage==0?0:1);
								// int last_pageNo = (int)(Math.ceil(totCnt*1.0/rowCntPerPage));
				//--------------------------------------------------------
				// 마지막 행 번호
				int end_rowNo = selectPageNo * rowCntPerPage;
				// 시작 행 번호
				int begin_rowNo = end_rowNo-rowCntPerPage+1;
					if(end_rowNo>totCnt) {end_rowNo = totCnt;}
				
				//--------------------------------------------------------
				// 화면에 보여지는 페이지번호 개수
				int	pageNoCnt_perPage =10;
				// 화면에 보여지는 시작 페이지번호
				int begin_pageNo_perPage = (int)Math.floor( (selectPageNo-1)/pageNoCnt_perPage )*pageNoCnt_perPage +1;
				// 화면에 보여지는 마지막 페이지번호
				int end_pageNo_perPage = begin_pageNo_perPage+pageNoCnt_perPage-1;
					if(end_pageNo_perPage>last_pageNo) {
						end_pageNo_perPage = last_pageNo;
					}

				//--------------------------------------------------------
				map.put("selectPageNo", selectPageNo);
				map.put("last_pageNo", last_pageNo);
				map.put("begin_rowNo", begin_rowNo);
				map.put("end_rowNo", end_rowNo);
				
				map.put("serialNo_asc", begin_rowNo);
				map.put("serialNo_desc", totCnt - begin_rowNo +1);
				
				map.put("begin_pageNo_perPage", begin_pageNo_perPage);
				map.put("end_pageNo_perPage", end_pageNo_perPage);
				//--------------------------------------------------------
				
				return map;
				
	
			}
			catch(Exception ex) {
				return new HashMap<String,Integer>();
			}

		}

		
		
		
		
		
		
		
		
		
}




/*---------------------------------------------------------------------------------------------------------------------------------------
검색 총 개수    한화면에보여지는행의개수  선택한페이지번호    시작행번호     마지막행번호		화면당보여지는		화면당보여지는
																								시작페이지번호		마지막페이지번호
---------------------------------------------------------------------------------------------------------------------------------------
  105                     10                     1                 1              10				  1					  10
  105                     10                     2                 11             20				  1					  10
  105                     10                     3                 21             30				  1					  10
  105                     10                     4                 31             50				  1					  10
  105                     10                     5                 41             50				  1					  10
  105                     10                     6                 51             60				  1					  10
  105                     10                     7                 61             70				  1					  10
  105                     10                     8                 71             80				  1					  10
  105                     10                     9                 81             90				  1					  10
  105                     10                    10                 91            100				  1					  10
  105                     10                    11                101            105				 11					  11
---------------------------------------------------------------------------------------------------------------------------------------
마지막행번호 = 선택한페이지번호 * 한화면에보여지는행의개수
시작행번호 = 마지막행번호-한화면에보여지는행의개수+1
*/
