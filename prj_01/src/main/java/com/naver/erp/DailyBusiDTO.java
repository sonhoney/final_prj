package com.naver.erp;

//[일일업무보고서]의 입력/수정/결재/반려 관련 데이터를 담아 이동하는 getter/setter 메소드 선언
public class DailyBusiDTO {
	
	private int report_no;
	private int report_code;
	private int busi_type_code;
	private String busi_start_date;
	private String busi_end_date;
	private int emp_no;
	private int revise_cnt;	
	private String busi_type_name;	
	
	private String busi_content;	
	private String emp_name;
	private int sign_code;
	private int approval_yesNo;
	private String return_result;
	
	private int next_app_emp_no; // 다음 결재자 사원번호
    private String next_app_emp_name; // 다음 결재자 이름
    private String next_app_emp_jikup_name; // 다음 결재자 직급이름
    private String next_app_dep_name; //다음 결재자 부서이름


	private String nextAppNoPerson;
	private String sign_date;
    private int login_emp_no;
    
    private String dep_name;
    private String jikup_name;
    
    
    
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
	public int getLogin_emp_no() {
		return login_emp_no;
	}
	public void setLogin_emp_no(int login_emp_no) {
		this.login_emp_no = login_emp_no;
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
	public String getNext_app_dep_name() {
		return next_app_dep_name;
	}
	public void setNext_app_dep_name(String next_app_dep_name) {
		this.next_app_dep_name = next_app_dep_name;
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
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public int getSign_code() {
		return sign_code;
	}
	public void setSign_code(int sign_code) {
		this.sign_code = sign_code;
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
	
	//----------------------------------------
	//----------------------------------------	
	
	
	
	

}
