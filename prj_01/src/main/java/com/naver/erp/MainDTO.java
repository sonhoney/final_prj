package com.naver.erp;

public class MainDTO {
	
	private int b_no;
	private String subject;
	private String content;
	private String writer;
	private int readcount;
	private String reg_date;
	private int group_no;
	private int prnumber_no;
	private int prnumber_level;
	private String uid;
	private String r_num;
	
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public int getPrnumber_no() {
		return prnumber_no;
	}
	public void setPrnumber_no(int prnumber_no) {
		this.prnumber_no = prnumber_no;
	}
	public int getPrnumber_level() {
		return prnumber_level;
	}
	public void setPrnumber_level(int prnumber_level) {
		this.prnumber_level = prnumber_level;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getR_num() {
		return r_num;
	}

	public void setR_num(String r_num) {
		this.r_num = r_num;
	}
	
}