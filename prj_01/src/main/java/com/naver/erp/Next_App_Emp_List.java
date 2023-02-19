package com.naver.erp;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class Next_App_Emp_List {

	private String emp_name;
	private String jikup_name;
	private String emp_no;
	private String dep_name;
	
	
	public String getDep_name() {
		return dep_name;
	}
	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getJikup_name() {
		return jikup_name;
	}
	public void setJikup_name(String jikup_name) {
		this.jikup_name = jikup_name;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	
	
}
