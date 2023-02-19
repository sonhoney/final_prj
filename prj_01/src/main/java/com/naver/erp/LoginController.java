package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller

public class LoginController {

	@Autowired
	private LoginService loginService; 

	//===========================================	
	// 로그인 홈 화면 띄우기 
	//===========================================	
	@RequestMapping(value="/loginForm.do")
	public ModelAndView loginEmpl( @RequestParam( value="uid" , required = false ) String uid ){
		
		ModelAndView mav = new ModelAndView();
		
		//System.out.println( "로그인 컨트롤러 =>  " +  uid  );
		
		mav.setViewName("loginForm.jsp");
		mav.addObject("uid", uid);
		
		return mav;
	}

	//===================================================
	// 로그인 시 비동기 로 이메소드 호출해서 로그인 여부 리턴 
	//===================================================
	   @RequestMapping( 
		         value="/loginProc.do" 
		         ,method=RequestMethod.POST
		         ,produces="application/json;charset=UTF-8"
		   )
		   @ResponseBody   
		   public int loginProc( 
		         @RequestParam( value="uid" ) String uid   
		         ,@RequestParam( value="pwd" ) String pwd      
		         ,@RequestParam( value="is_login" , required=false ) String is_login
		         ,HttpSession session  
		         ,HttpServletResponse response
		   ) {
		      
		      Map<String,String> map = new HashMap<String,String>();
		      
		      map.put("uid",uid);
		      map.put("pwd",pwd);


		      
		      int Cnt = this.loginService.getLoginCheck( map ); 
		            
		      

		      if( Cnt == 1 ) {
		         
		         String emp_name = this.loginService.getName( map );
		         String emp_role = this.loginService.getEmp_role( map );
		         String allowCode = this.loginService.getAllowCode(uid) ;
		         String jikup_name = this.loginService.getjikupName(uid) ;
		         if(allowCode.equals("가입승인")){
		            Cnt= 1;
		         }
		         
		         else if( allowCode.equals("승인대기") ){
		            Cnt= 2;
		         }

		         session.setAttribute("emp_name", emp_name);
		         session.setAttribute("uid", uid);
		         session.setAttribute("emp_role", emp_role);
		         session.setAttribute("jikup_name", jikup_name);
		         
		         if( is_login == null ) {
		            Cookie cookie = new Cookie("uid" , null);
		            Cookie cookie1 = new Cookie("pwd" , null);
		            cookie.setMaxAge(0);
		            cookie1.setMaxAge(0);
		            response.addCookie(cookie);
		            response.addCookie(cookie1);
		         }
		         else {
		            Cookie cookie = new Cookie("uid" , uid);
		            Cookie cookie1 = new Cookie("pwd" , pwd);
		            cookie.setMaxAge(60*60*24);
		            cookie1.setMaxAge(60*60*24);
		            response.addCookie(cookie);
		            response.addCookie(cookie1);            
		         }
		         
		      }
		      
		      
		      return Cnt; 
		   }
	
	//===================================================
	// 암호 찾는 팝업창 페이지 띄우기  
	//===================================================	
	@RequestMapping(value="/pwdFindForm.do")
	public ModelAndView xxxForm( ){
		
		ModelAndView mav = new ModelAndView();
		
		//System.out.println( "로그인 컨트롤러 =>  " +  uid  );
		
		int xxx = 1;
		
		mav.setViewName("pwdFindForm.jsp");
		mav.addObject("xxx", xxx );
		
		return mav;
	}

	
	
	//===================================================
	// 아이디 찾는 팝업창 페이지 띄우기   
	//===================================================	
	@RequestMapping(value="/idFindForm.do")
	public ModelAndView yyyForm( ){
		
		ModelAndView mav = new ModelAndView();
		
		int xxx = 2;
		
		mav.setViewName("idFindForm.jsp");
		mav.addObject("xxx", xxx );
		
		return mav;
	}
	
	
	
	//===================================================
	// 아이디 가지고 비번 찾는 기능.
	//===================================================
	@RequestMapping( 
			value="/findPwdProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody	
	public Map<String,String> findPwdProc( 
			@RequestParam( value="uid" ) String uid			
	) {
		
		// System.out.println( "로그인 컨트롤러 => " + uid );
		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("uid",uid);
		 	

		String getPwd = this.loginService.getPwd( map );
			
		System.out.println( "로그인 컨트롤러 => " + getPwd );
		
		Map<String,String> map2 = new HashMap<String,String>();
		
		map2.put("getPwd",getPwd);
		
		return map2; 
	}
	

	//===================================================
	// 암호 가지고 아이디 찾는 기능.
	//===================================================
	@RequestMapping( 
			value="/findIdProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody	  
	public Map<String,String> findIdProc( 
			@RequestParam( value="pwd" ) String pwd	
			,@RequestParam( value="juminF" ) String juminF
			,@RequestParam( value="juminB" ) String juminB
	) {
		
		// System.out.println( "로그인 컨트롤러 => " + uid );
		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("pwd",pwd);
		map.put("juminF",juminF);
		map.put("juminB",juminB);
		 	

		String getId = this.loginService.getId( map );
		
		Map<String,String> map2 = new HashMap<String,String>();
		
//		String notFind = "";
//		if( getId == -1 ) {
//			notFind = "zero"; 
//		}
			
		System.out.println( "로그인 컨트롤러 => " + getId );
		
		map2.put("getId",getId);
		
		
		
		return map2; 
	}
	
	
	
	//===================================================
	// 아이디 찾는 팝업창 페이지 띄우기   
	//===================================================	
	@RequestMapping(value="/pwdChangeForm.do")
	public ModelAndView zzzForm( ){
		
		ModelAndView mav = new ModelAndView();
		
		int zzz = 3;
		
		mav.setViewName("pwdChangeForm.jsp");
		mav.addObject("zzz", zzz );
		
		return mav;
	}

	
	//===================================================
	// 아이디 가지고 비번 찾는 기능.
	//===================================================
	@RequestMapping( 
			value="/changePwdProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody	
	public int changePwdProc( 
			@RequestParam( value="uid" ) String uid
			,@RequestParam( value="pwd" ) String pwd
			,@RequestParam( value="new_pwd" ) String new_pwd
	) {
		
		// pwd  new_pwd  new_pwd_confirm
		
		// System.out.println( "로그인 컨트롤러 => " + uid );
		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("uid",uid);
		map.put("pwd",pwd);
		map.put("new_pwd",new_pwd);
		 	

		int getChangeCnt = this.loginService.getChangeCnt( map );
		
		return getChangeCnt; 
	}	
	
	
	
}
