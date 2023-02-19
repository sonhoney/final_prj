package com.naver.erp;

import java.util.Map;

public interface MainService {

	
	int getEmp10();	
	int getEmp20();
	int getEmp30();
	int getEmp40();
	int getEmp50();
	int getEmp60();
	
	
	
	 Map<String,String> getApprovalTypeCnt(  MainDTO mainDTO  );   

	 Map<String,String>  getRegDeailyBusiTypeCnt( Map<String,String> map );
	
	
	 Map<String,String>  getRegSaleTypeCnt( Map<String,String> map );

	 Map<String,String>  getRegExTypeCnt( Map<String,String> map );
	 
}
