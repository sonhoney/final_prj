package com.naver.erp;

import java.util.List;

public class DailyBusiSearchDTO {
		


	private int busi_type_code;
	private String busi_start_date;
	private String busi_end_date;
	private int revise_cnt;	
	private String busi_type_name;	
	
	private String busi_content;	
	private int approval_yesNo;
	private String return_result;
	
	private int next_app_emp_no; // 다음 결재자 사원번호
    private String next_app_emp_name; // 다음 결재자 이름
    private String next_app_emp_jikup_name; // 다음 결재자 직급이름
    private String next_app_dep_name; //다음 결재자 부서이름


	private String nextAppNoPerson;
	private String sign_date;
    private int login_emp_no;
    
	
	
	
	
		private int report_no;
		private int report_code;
		private int emp_no;
		private String emp_name;
	
		private String keyword; //키워드

		private List<String> busi_type; //업무분야
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
		

		private String min_hour; 	// 업무시작 시간
		private String min_minute; // 업무시작 분
		private String max_hour; // 업무끝 시간
		private String max_minute; // 업무끝 분
		
		private String min_hour_minute; // 업무시작 시,분
		private String max_hour_minute; // 업무끝 시,분

		private String sort;
		
		

		
		
		
		
		
		
		
		
		
		
		
		
		public int getBusi_type_code() {
			return busi_type_code;
		}

		public void setBusi_type_code(int busi_type_code) {
			this.busi_type_code = busi_type_code;
		}

		public String getBusi_start_date() {
			return busi_start_date;
		}

		public void setBusi_start_date(String busi_start_date) {
			this.busi_start_date = busi_start_date;
		}

		public String getBusi_end_date() {
			return busi_end_date;
		}

		public void setBusi_end_date(String busi_end_date) {
			this.busi_end_date = busi_end_date;
		}

		public int getRevise_cnt() {
			return revise_cnt;
		}

		public void setRevise_cnt(int revise_cnt) {
			this.revise_cnt = revise_cnt;
		}

		public String getBusi_type_name() {
			return busi_type_name;
		}

		public void setBusi_type_name(String busi_type_name) {
			this.busi_type_name = busi_type_name;
		}

		public String getBusi_content() {
			return busi_content;
		}

		public void setBusi_content(String busi_content) {
			this.busi_content = busi_content;
		}

		public int getApproval_yesNo() {
			return approval_yesNo;
		}

		public void setApproval_yesNo(int approval_yesNo) {
			this.approval_yesNo = approval_yesNo;
		}

		public String getReturn_result() {
			return return_result;
		}

		public void setReturn_result(String return_result) {
			this.return_result = return_result;
		}

		public int getNext_app_emp_no() {
			return next_app_emp_no;
		}

		public void setNext_app_emp_no(int next_app_emp_no) {
			this.next_app_emp_no = next_app_emp_no;
		}

		public String getNext_app_emp_name() {
			return next_app_emp_name;
		}

		public void setNext_app_emp_name(String next_app_emp_name) {
			this.next_app_emp_name = next_app_emp_name;
		}

		public String getNext_app_emp_jikup_name() {
			return next_app_emp_jikup_name;
		}

		public void setNext_app_emp_jikup_name(String next_app_emp_jikup_name) {
			this.next_app_emp_jikup_name = next_app_emp_jikup_name;
		}

		public String getNext_app_dep_name() {
			return next_app_dep_name;
		}

		public void setNext_app_dep_name(String next_app_dep_name) {
			this.next_app_dep_name = next_app_dep_name;
		}

		public String getNextAppNoPerson() {
			return nextAppNoPerson;
		}

		public void setNextAppNoPerson(String nextAppNoPerson) {
			this.nextAppNoPerson = nextAppNoPerson;
		}

		public String getSign_date() {
			return sign_date;
		}

		public void setSign_date(String sign_date) {
			this.sign_date = sign_date;
		}

		public int getLogin_emp_no() {
			return login_emp_no;
		}

		public void setLogin_emp_no(int login_emp_no) {
			this.login_emp_no = login_emp_no;
		}

		public int getReport_code() {
			return report_code;
		}

		public void setReport_code(int report_code) {
			this.report_code = report_code;
		}

		public int getReport_no() {
			return report_no;
		}

		public void setReport_no(int report_no) {
			this.report_no = report_no;
		}

		public int getEmp_no() {
			return emp_no;
		}

		public void setEmp_no(int emp_no) {
			this.emp_no = emp_no;
		}

		public String getEmp_name() {
			return emp_name;
		}

		public void setEmp_name(String emp_name) {
			this.emp_name = emp_name;
		}

		public String getKeyword() {
			return keyword;
		}

		public void setKeyword(String keyword) {
			this.keyword = keyword;
		}

	
		
		public String getKeyword1() {
			return keyword;
		}

		public void setKeyword1(String keyword1) {
			this.keyword = keyword1;
		}

		public List<String> getBusi_type() {
			return busi_type;
		}

		public void setBusi_type(List<String> busi_type) {
			this.busi_type = busi_type;
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

		public String getMin_hour() {
			return min_hour;
		}

		public void setMin_hour(String min_hour) {
			this.min_hour = min_hour;
		}

		public String getMin_minute() {
			return min_minute;
		}

		public void setMin_minute(String min_minute) {
			this.min_minute = min_minute;
		}

		public String getMax_hour() {
			return max_hour;
		}

		public void setMax_hour(String max_hour) {
			this.max_hour = max_hour;
		}

		public String getMax_minute() {
			return max_minute;
		}

		public void setMax_minute(String max_minute) {
			this.max_minute = max_minute;
		}

		public String getMin_hour_minute() {
			return min_hour_minute;
		}

		public void setMin_hour_minute(String min_hour_minute) {
			this.min_hour_minute = min_hour_minute;
		}

		public String getMax_hour_minute() {
			return max_hour_minute;
		}

		public void setMax_hour_minute(String max_hour_minute) {
			this.max_hour_minute = max_hour_minute;
		}

		public String getSort() {
			return sort;
		}

		public void setSort(String sort) {
			this.sort = sort;
		}
		
		


}
