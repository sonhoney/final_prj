package com.naver.erp;

import java.util.List;

public class SalesSearchDTO {
	
	
	private int report_no;
	//--------------------------------
	private String emp_name;
	private String sales_type_name;
	private String dep_name;
	private String jikup_name;
	private int approval_yesNo;

	

    private int login_emp_no;
	

	private String report_name;
	private int sales_type_code;
	private String sales_date_start;
	private String sales_date_end;
	private String sales_content;
	private String sales_result;
	private int emp_no;
	private int revise_cnt;
	private String sales_company;
	private String sales_name;
	private String sales_jikup;
	private String sales_phone;
	private int next_app_emp_no;
	
	
	

	private String nextAppNoPerson;
	
	

	//--------------------------------
	private int report_code;
	private String return_result;
	//--------------------------------
	
	

	//----------------------------------------------------------------------------------------------------
	private String keyword; //키워드

	private List<String> sales_type; //방문목적
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
	

	private String sign_min_year; 	// 업무시작 시간
	private String sign_min_month; // 업무시작 분
	private String sign_max_year; // 업무끝 시간
	private String sign_max_month; // 업무끝 분
	
	private String sign_min_year_month; // 업무시작 시,분
	private String sign_max_year_month; // 업무끝 시,분

	private String sort;
	//----------------------------------------------------------------------------------------------------
	private String last_sign_date;
	public int getReport_no() {
		return report_no;
	}
	public void setReport_no(int report_no) {
		this.report_no = report_no;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getSales_type_name() {
		return sales_type_name;
	}
	public void setSales_type_name(String sales_type_name) {
		this.sales_type_name = sales_type_name;
	}
	public String getDep_name() {
		return dep_name;
	}
	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}
	public String getJikup_name() {
		return jikup_name;
	}
	public void setJikup_name(String jikup_name) {
		this.jikup_name = jikup_name;
	}
	public int getApproval_yesNo() {
		return approval_yesNo;
	}
	public void setApproval_yesNo(int approval_yesNo) {
		this.approval_yesNo = approval_yesNo;
	}
	public int getLogin_emp_no() {
		return login_emp_no;
	}
	public void setLogin_emp_no(int login_emp_no) {
		this.login_emp_no = login_emp_no;
	}
	public String getReport_name() {
		return report_name;
	}
	public void setReport_name(String report_name) {
		this.report_name = report_name;
	}
	public int getSales_type_code() {
		return sales_type_code;
	}
	public void setSales_type_code(int sales_type_code) {
		this.sales_type_code = sales_type_code;
	}
	public String getSales_date_start() {
		return sales_date_start;
	}
	public void setSales_date_start(String sales_date_start) {
		this.sales_date_start = sales_date_start;
	}
	public String getSales_date_end() {
		return sales_date_end;
	}
	public void setSales_date_end(String sales_date_end) {
		this.sales_date_end = sales_date_end;
	}
	public String getSales_content() {
		return sales_content;
	}
	public void setSales_content(String sales_content) {
		this.sales_content = sales_content;
	}
	public String getSales_result() {
		return sales_result;
	}
	public void setSales_result(String sales_result) {
		this.sales_result = sales_result;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public int getRevise_cnt() {
		return revise_cnt;
	}
	public void setRevise_cnt(int revise_cnt) {
		this.revise_cnt = revise_cnt;
	}
	public String getSales_company() {
		return sales_company;
	}
	public void setSales_company(String sales_company) {
		this.sales_company = sales_company;
	}
	public String getSales_name() {
		return sales_name;
	}
	public void setSales_name(String sales_name) {
		this.sales_name = sales_name;
	}
	public String getSales_jikup() {
		return sales_jikup;
	}
	public void setSales_jikup(String sales_jikup) {
		this.sales_jikup = sales_jikup;
	}
	public String getSales_phone() {
		return sales_phone;
	}
	public void setSales_phone(String sales_phone) {
		this.sales_phone = sales_phone;
	}
	public int getNext_app_emp_no() {
		return next_app_emp_no;
	}
	public void setNext_app_emp_no(int next_app_emp_no) {
		this.next_app_emp_no = next_app_emp_no;
	}
	public String getNextAppNoPerson() {
		return nextAppNoPerson;
	}
	public void setNextAppNoPerson(String nextAppNoPerson) {
		this.nextAppNoPerson = nextAppNoPerson;
	}
	public int getReport_code() {
		return report_code;
	}
	public void setReport_code(int report_code) {
		this.report_code = report_code;
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
	public List<String> getSales_type() {
		return sales_type;
	}
	public void setSales_type(List<String> sales_type) {
		this.sales_type = sales_type;
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
	public String getSign_min_year() {
		return sign_min_year;
	}
	public void setSign_min_year(String sign_min_year) {
		this.sign_min_year = sign_min_year;
	}
	public String getSign_min_month() {
		return sign_min_month;
	}
	public void setSign_min_month(String sign_min_month) {
		this.sign_min_month = sign_min_month;
	}
	public String getSign_max_year() {
		return sign_max_year;
	}
	public void setSign_max_year(String sign_max_year) {
		this.sign_max_year = sign_max_year;
	}
	public String getSign_max_month() {
		return sign_max_month;
	}
	public void setSign_max_month(String sign_max_month) {
		this.sign_max_month = sign_max_month;
	}
	public String getSign_min_year_month() {
		return sign_min_year_month;
	}
	public void setSign_min_year_month(String sign_min_year_month) {
		this.sign_min_year_month = sign_min_year_month;
	}
	public String getSign_max_year_month() {
		return sign_max_year_month;
	}
	public void setSign_max_year_month(String sign_max_year_month) {
		this.sign_max_year_month = sign_max_year_month;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getLast_sign_date() {
		return last_sign_date;
	}
	public void setLast_sign_date(String last_sign_date) {
		this.last_sign_date = last_sign_date;
	}
	
	
	
	
	
	
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
