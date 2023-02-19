package com.naver.erp;

import java.util.List;

public class ExpenseSearchDTO {
	private int emp_no;
	private int report_no;
	private int report_code;
	private String report_name;
	private int expense_price;
	private String expense_date;
	private int receipt_no;
	private String remarks;
	private int next_app_emp_no;
	private String return_result;
	private String emp_name;


 
	//----------------------------------------------------------------------------------------------------
	private String keyword; //키워드
	
	private String expense_min_price1; //최소 비용
	private String expense_max_price1; //최대 비용  
	
	

	private List<String> expense_field_code; //지출분야
	private List<String> expense_method_code; //지출수단
	private List<String> sign_code; //결재여부

	private int selectPageNo; //페이지넘버
	private int rowCntPerPage; //헹 개수
	
	private int begin_rowNo; //시작행의 넘버
	private int end_rowNo;	// 끝행의 넘버

	private String min_year;	// 업무시작 년
	private String min_month;	// 업무시작 월
	private String max_year; 	// 업무끝 년
	private String max_month; 	// 업무끝 월
	
	private String min_year_month;	// 업무시작 년월
	private String max_year_month; // 업무끝 년월





	private String sort;
	//----------------------------------------------------------------------------------------------------



	
	
	
	
	
	
	
	
	
	

	public int getEmp_no() {
		return emp_no;
	}




	public String getEmp_name() {
		return emp_name;
	}




	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}




	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}




	public int getReport_no() {
		return report_no;
	}




	public void setReport_no(int report_no) {
		this.report_no = report_no;
	}




	public int getReport_code() {
		return report_code;
	}




	public void setReport_code(int report_code) {
		this.report_code = report_code;
	}




	public String getReport_name() {
		return report_name;
	}




	public void setReport_name(String report_name) {
		this.report_name = report_name;
	}




	public int getExpense_price() {
		return expense_price;
	}




	public void setExpense_price(int expense_price) {
		this.expense_price = expense_price;
	}




	public String getExpense_date() {
		return expense_date;
	}




	public void setExpense_date(String expense_date) {
		this.expense_date = expense_date;
	}




	public int getReceipt_no() {
		return receipt_no;
	}




	public void setReceipt_no(int receipt_no) {
		this.receipt_no = receipt_no;
	}




	public String getRemarks() {
		return remarks;
	}




	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}




	public int getNext_app_emp_no() {
		return next_app_emp_no;
	}




	public void setNext_app_emp_no(int next_app_emp_no) {
		this.next_app_emp_no = next_app_emp_no;
	}




	public String getReturn_result() {
		return return_result;
	}




	public void setReturn_result(String return_result) {
		this.return_result = return_result;
	}




	public String getKeyword() {
		return keyword;
	}




	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}








	public String getExpense_min_price1() {
		return expense_min_price1;
	}




	public void setExpense_min_price1(String expense_min_price1) {
		this.expense_min_price1 = expense_min_price1;
	}




	public String getExpense_max_price1() {
		return expense_max_price1;
	}




	public void setExpense_max_price1(String expense_max_price1) {
		this.expense_max_price1 = expense_max_price1;
	}




	public List<String> getExpense_field_code() {
		return expense_field_code;
	}




	public void setExpense_field_code(List<String> expense_field_code) {
		this.expense_field_code = expense_field_code;
	}




	public List<String> getExpense_method_code() {
		return expense_method_code;
	}




	public void setExpense_method_code(List<String> expense_method_code) {
		this.expense_method_code = expense_method_code;
	}




	public List<String> getSign_code() {
		return sign_code;
	}




	public void setSign_code(List<String> sign_code) {
		this.sign_code = sign_code;
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




	public String getMin_year() {
		return min_year;
	}




	public void setMin_year(String min_year) {
		this.min_year = min_year;
	}




	public String getMin_month() {
		return min_month;
	}




	public void setMin_month(String min_month) {
		this.min_month = min_month;
	}




	public String getMax_year() {
		return max_year;
	}




	public void setMax_year(String max_year) {
		this.max_year = max_year;
	}




	public String getMax_month() {
		return max_month;
	}




	public void setMax_month(String max_month) {
		this.max_month = max_month;
	}




	public String getMin_year_month() {
		return min_year_month;
	}




	public void setMin_year_month(String min_year_month) {
		this.min_year_month = min_year_month;
	}




	public String getMax_year_month() {
		return max_year_month;
	}




	public void setMax_year_month(String max_year_month) {
		this.max_year_month = max_year_month;
	}




	public String getSort() {
		return sort;
	}




	public void setSort(String sort) {
		this.sort = sort;
	}




	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


	
	
	
}
