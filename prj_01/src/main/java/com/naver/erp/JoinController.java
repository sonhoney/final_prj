package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class JoinController {
	
	
	@Autowired
	private JoinService joinService;    

	//===================================================
	// 회원가입 화면 띄우기
	//===================================================
	@RequestMapping(value="/joinForm.do")
	public ModelAndView loginEmpl() {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("joinForm.jsp");
		
		return mav;
	}

	//===================================================
	// 회원가입 시 employee 테이블에 insert 때리기 
	//===================================================
	@RequestMapping( 
			value="/joinProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody	
	public int joinMember( JoinDTO joinDTO ) {
		
//		System.out.println("조인컨트롤러 => " + joinDTO.getUname() );
//		System.out.println("조인컨트롤러 => " + joinDTO.getPwd() );
//		System.out.println("조인컨트롤러 => " + joinDTO.getEmail() );
		
		int joinCnt = this.joinService.getJoinCnt( joinDTO );
		
		
		return joinCnt; 
	}
	
	//===================================================
	// 회원가입 후 pk 번호이자 아이디 인 emp_no 가져오기 
	//===================================================
	@RequestMapping( 
			value="/memberIdProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody	
	public Map<String,String> memberIdProc( JoinDTO joinDTO ) {
		
		
		// 아이디 가져오는 대략적 지시하는 서비스 클래스의 겟아이디 호출 
		String uid = this.joinService.getId( joinDTO );
		
		

		// System.out.println("아이디 => " + uid );
		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("uid", uid);
		
		return map; 
	}
	
	
	//===================================================
	// 회원가입 이 후 아이디 띄워줄 창 
	//===================================================
	@RequestMapping(value="/idView.do")
	public ModelAndView idView() {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("idView.jsp");
		
		return mav;
	}
	
	
	
	
	
}
