package com.naver.erp;

public class EmployeeSearchDTO {

	private String keyword;
	private String depSearch;
	private String jikupSearch;
	
	
	private int selectPageNo;
	private int rowCntPerPage;
	
	private int begin_rowNo;
	private int end_rowNo;
	
	private String sort ;

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getDepSearch() {
		return depSearch;
	}

	public void setDepSearch(String depSearch) {
		this.depSearch = depSearch;
	}

	public String getJikupSearch() {
		return jikupSearch;
	}

	public void setJikupSearch(String jikupSearch) {
		this.jikupSearch = jikupSearch;
	}

	public int getSelectPageNo() {
		return selectPageNo;
	}

	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}

	public int getRowCntPerPage() {
		return rowCntPerPage;
	}

	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}

	public int getBegin_rowNo() {
		return begin_rowNo;
	}

	public void setBegin_rowNo(int begin_rowNo) {
		this.begin_rowNo = begin_rowNo;
	}

	public int getEnd_rowNo() {
		return end_rowNo;
	}

	public void setEnd_rowNo(int end_rowNo) {
		this.end_rowNo = end_rowNo;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	
	
	
	
	
}

