package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
    
	@Autowired
	private MainDAO mainDAO;
	
	@Autowired
	private MainService mainService;
   
	@RequestMapping(value = "/main.do")
    public ModelAndView main(
    		HttpSession session
    		,HttpServletRequest request
    		,MainDTO mainDTO
    		,@RequestParam(value="report_type" ,required=false) String report_type
    		
    	){

		List<Map<String,String>> boardList =  this.mainDAO.getBoardList(  );

    	
		
		
		
        ModelAndView mav = new ModelAndView() ;
        
        String uid = (String)session.getAttribute("uid");
        Map<String,String> map = new HashMap<String,String>() ;
        if( report_type == null ) {
        	
        	report_type = "1";
        	
        }
        map.put("uid", uid);
        map.put("report_type", report_type);
        
        System.out.println( "컨트롤러 =>" +  report_type );
        
        if( report_type.equals("1")  ) {
        	
        	Map<String,String> getRegDeailyBusiTypeCnt = this.mainService.getRegDeailyBusiTypeCnt( map );
        	

//            System.out.println( "일일  컨트롤러 =>" +  getRegDeailyBusiTypeCnt.values() 
//            +  "일일  컨트롤러 =>" +  String.valueOf(getRegDeailyBusiTypeCnt.get("d_report")) );
        	
            mav.addObject("DeailyCnt", getRegDeailyBusiTypeCnt); 
        }
        else if(  report_type.equals("2") ) {
        	
        	Map<String,String> getRegSaleTypeCnt = this.mainService.getRegSaleTypeCnt( map );
            mav.addObject("SaleCnt", getRegSaleTypeCnt);
            
//            System.out.println( "영업  컨트롤러 =>" +  getRegSaleTypeCnt.values() 
//            +  "영업  컨트롤러 =>" +  String.valueOf(getRegSaleTypeCnt.get("s_report")) );
        }  
        else {
        	
        	Map<String,String> getRegExTypeCnt = this.mainService.getRegExTypeCnt( map );
            mav.addObject("ExCnt", getRegExTypeCnt);

//            System.out.println( "지출  컨트롤러 =>" +  getRegExTypeCnt.values() 
//            +  "지출  컨트롤러 =>" +  String.valueOf(getRegExTypeCnt.get("e_report")) );
        }
       
        
     
        //====================== ========================
        // 부서별 직원 수를 리턴하는 메소드 호출!!!! 
        //==============================================
        int emp10 = this.mainService.getEmp10();    
        int emp20 = this.mainService.getEmp20(); 
        int emp30 = this.mainService.getEmp30(); 
        int emp40 = this.mainService.getEmp40(); 
        int emp50 = this.mainService.getEmp50(); 
        int emp60 = this.mainService.getEmp60();  

        
        //==============================================
        // 결재 보고서 수를 
        //==============================================
        //String uid = (String)session.getAttribute("uid");
        
        mainDTO.setUid( uid );
        
        // jsp 페이지 에서 셀렉트 박스에 -선택- 사항이 있었을 때 사용할 조건문 
        if(  mainDTO.getR_num() == null  || mainDTO.getR_num() == ""   ) {
        	mainDTO.setR_num("1");
        }
        
        System.out.println( mainDTO.getR_num()  );
        
        Map<String,String> getATCnt = this.mainService.getApprovalTypeCnt( mainDTO );        
        
        mav.addObject(  "boardList" , boardList );
        mav.addObject("emp10", emp10);
        mav.addObject("emp20", emp20);
        mav.addObject("emp30", emp30);
        mav.addObject("emp40", emp40);
        mav.addObject("emp50", emp50);
        mav.addObject("emp60", emp60);
        mav.addObject("getATCnt", getATCnt);        
        mav.setViewName("main.jsp");
        
        return mav ;
        
    }
 // /logout.do로 접근하면 호출되는 메소드 선언
    @RequestMapping(value="/logout.do")
    public ModelAndView logout(
        HttpSession session
    ) {

        // session의 모든 값 삭제
        session.invalidate();

        // [ModelAndView 객체] 생성
        // 로그아웃 버튼 클릭 시 로그인 화면으로 redirect 
        ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

        return mav;
    }  
}
