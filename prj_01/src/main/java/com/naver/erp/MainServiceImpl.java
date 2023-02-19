package com.naver.erp;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MainServiceImpl implements MainService {

	
	@Autowired
	private MainDAO mainDAO; 
	
	
	
	
	public int getEmp10() {
		
		int getEmp10 = this.mainDAO.getEmp10();
		
		return getEmp10 ;
	}
	public int getEmp20(){
		
		int getEmp20 = this.mainDAO.getEmp20();
		
		return getEmp20 ;
	}
	public int getEmp30(){
		
		int getEmp30 = this.mainDAO.getEmp30();
		
		return getEmp30 ;
	}
	public int getEmp40(){
		
		int getEmp40 = this.mainDAO.getEmp40();
		
		return getEmp40 ;
	}
	public int getEmp50(){
		
		int getEmp50 = this.mainDAO.getEmp50();
		
		return getEmp50 ;
	}
	public int getEmp60(){
		
		int getEmp60 = this.mainDAO.getEmp60();
		
		return getEmp60 ;
	}
	
	
	
	
	
	public  Map<String,String> getApprovalTypeCnt ( MainDTO mainDTO ) {
		 Map<String,String> getATCnt = this.mainDAO.getApprovalTypeCnt( mainDTO );
				
				return getATCnt ;
	}
		
	

	

	public   Map<String,String>  getRegDeailyBusiTypeCnt(  Map<String,String> map  ){
		
		 Map<String,String> getRegDeailyBusiTypeCnt = this.mainDAO.getRegDeailyBusiTypeCnt( map );
			
			return getRegDeailyBusiTypeCnt ;
		
	}
	
	
	
		
		
	public    Map<String,String>  getRegSaleTypeCnt( Map<String,String> map ){
		
		 Map<String,String> getRegSaleTypeCnt = this.mainDAO.getRegSaleTypeCnt( map );
			
			return getRegSaleTypeCnt ;
	}

	public   Map<String,String>  getRegExTypeCnt( Map<String,String> map ){
		
		 Map<String,String> getRegExTypeCnt = this.mainDAO.getRegExTypeCnt( map );
			
			return getRegExTypeCnt ;
	}
	
	
}
