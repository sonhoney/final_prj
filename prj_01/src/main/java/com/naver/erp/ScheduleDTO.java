package com.naver.erp;

public class ScheduleDTO {

	private String cal_no;
	
	private String uid;
	private String subject;
	private String start_date;
	private String end_date;
	

	private String start_hour;
	private String start_minute;
	private String end_hour;
	private String end_minute;
	
    // 직접 입력한 시작 분 , 끝 분 
	private String sub_start_minute;
	private String sub_end_minute;
	
	
	
	
	
	public String getCal_no() {
		return cal_no;
	}
	public void setCal_no(String cal_no) {
		this.cal_no = cal_no;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getStart_hour() {
		return start_hour;
	}
	public void setStart_hour(String start_hour) {
		this.start_hour = start_hour;
	}
	public String getStart_minute() {
		return start_minute;
	}
	public void setStart_minute(String start_minute) {
		this.start_minute = start_minute;
	}
	public String getEnd_hour() {
		return end_hour;
	}
	public void setEnd_hour(String end_hour) {
		this.end_hour = end_hour;
	}
	public String getEnd_minute() {
		return end_minute;
	}
	public void setEnd_minute(String end_minute) {
		this.end_minute = end_minute;
	}
	public String getSub_start_minute() {
		return sub_start_minute;
	}
	public void setSub_start_minute(String sub_start_minute) {
		this.sub_start_minute = sub_start_minute;
	}
	public String getSub_end_minute() {
		return sub_end_minute;
	}
	public void setSub_end_minute(String sub_end_minute) {
		this.sub_end_minute = sub_end_minute;
	}
	
	
	
	

	
	
	
	
	
	
	
	
	

	
	
	
	
}
