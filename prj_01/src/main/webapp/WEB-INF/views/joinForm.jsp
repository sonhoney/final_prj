<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html><head>
<meta charset="UTF-8">
<title>회원가입</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/join.css"> 
<script src="/js/join.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

var joinForm;

$(function(){
	
	joinForm = $("[name='joinForm']");

	
	//=================================================
	// 회원가입 버튼 클릭 시 유효성 체크 하는 joinCheck() 함수호출.
	//=================================================
	joinForm.find("[name='join_btn']").click(function(){
		
		joinCheck();
	})
	
	//=================================================
	// 로그인 화면으로 이동 (단, 들고가는 정보 없음)
	//=================================================
	joinForm.find(".loginBtn").click(function(){
		location.replace("/loginForm.do");
	})
	
	
	
	
	
    //============================================
	// 비밀번호 확인 체크 
    //============================================
	var pwd = joinForm.find(".pwd");
	var pwd_confirm = joinForm.find(".pwd_confirm");
	
	
	
		// 비번확인에서 커서 빠질 때 발생하는 이벤트 
		pwd_confirm.keyup(function(){
			
			var pwdVal = pwd.val();
			var pwd_confirmVal = pwd_confirm.val();
			
			//alert( pwdVal + "  " + pwd_confirmVal    ); return;
			
			if( !(pwdVal == pwd_confirmVal) ){
				joinForm.find(".notEquals").text( "비밀번호가 일치하지 않습니다." ).css('color','#ff585c').css('font-size','0.75rem'); 
			}
			else{ joinForm.find(".notEquals").text( "" ); }
		})
		
		pwd.keyup(function(){
		     
			var pwdVal = $(this).val();
			var pwd_confirmVal = pwd_confirm.val();
			
			//alert( pwdVal + "  " + pwd_confirmVal    ); return;
			
			if( !(pwdVal == pwd_confirmVal) ){
				joinForm.find(".notEquals").text( "비밀번호가 일치하지 않습니다." ).css('color','#ff585c').css('font-size','0.75rem');
			}
			else if( (pwdVal == pwd_confirmVal) ){ joinForm.find(".notEquals").text( "" ); }
			
			
		})
		
		
	//============================================
	// 입력칸이 2개 이상일 때 한칸에서 입력완료하면 자동으로 포커스 다음껄로 가게 하기 
    //============================================
    	
    //*****************	
    // 주민번호 
    //*****************	
	var FJN = joinForm.find(".front_jumin_num");
	var BJN = joinForm.find(".back_jumin_num");
	
	FJN.keyup(function(){
		var thisObj = $(this);
		var val = thisObj.val();
		var nums = "1234567890";
		var num  = "";
		
		if( val == null ){ val = ""; }
		
		for( var i = 0  ; i < val.length ; i++ ){			
			var str = val.charAt(i);
			if( nums.indexOf( str ) >= 0 ){
				num = num + str ;
			}			
		}
		// 반복문 종료 후 숫자문자만 박힌 변수 num 을 다시 입력양식에 박기
		// 숫자문자가 안들어왔다면 길이가 없는 문자 박기 
		thisObj.val( num );
		
		// 입력양식의 최대 길이 만큼 문자가 드가면 다음칸 포커스 이동
		if( val.length >= $(this).attr("maxlength") ){
			joinForm.find(".back_jumin_num").focus();
		}		
		
	})
	
	BJN.keyup(function(){
		var thisObj = $(this);
		var val = thisObj.val();
		var nums = "1234567890";
		var num  = "";
		
		if( val == null ){ val = ""; }
		
		for( var i = 0  ; i < val.length ; i++ ){			
			var str = val.charAt(i);
			if( nums.indexOf( str ) >= 0 ){
				num = num + str ;
			}			
		}
		thisObj.val( num );

	})
	
	
	//*****************	
    // 전화번호 
    //*****************	
    
    
	var tel_num1 = joinForm.find(".tel_num1");
	var tel_num2 = joinForm.find(".tel_num2");
	var tel_num3 = joinForm.find(".tel_num3");

	
	tel_num2.keyup(function(){
		
		// 감히 첫째형이 안드갔는데 동생들이 드갈 순 없지 
		if( tel_num1.val() == "" ){
			tel_num2.val(""); tel_num3.val("");
		}
		
		var thisObj = $(this);
		var val = thisObj.val();
		
		// 감히 두째인 내가 비워졌는데 막내가 있을 순 없쥐...
		if( val == "" ){
			tel_num3.val("");
		}
		
		
		var nums = "1234567890";
		var num  = "";
		
		for( var i = 0  ; i < val.length ; i++ ){			
			var str = val.charAt(i);
			if( nums.indexOf( str ) >= 0 ){
				num = num + str ;
			}			
		}
		thisObj.val( num );
		// 입력양식의 최대 길이 만큼 문자가 드가면 다음칸 포커스 이동
		if( val.length >= $(this).attr("maxlength") ){
			joinForm.find(".tel_num3").focus();
		}
		
	})
  	tel_num3.keyup(function(){
  		
  	    // 감히 두째형이 안드갔는데 동생이 드갈 순 없지 
  		if( tel_num2.val() == "" ){
			tel_num3.val("");
		}
  		
		var thisObj = $(this);
		var val = thisObj.val();
		var nums = "1234567890";
		var num  = "";
		
		for( var i = 0  ; i < val.length ; i++ ){			
			var str = val.charAt(i);
			if( nums.indexOf( str ) >= 0 ){
				num = num + str ;
			}			
		}
		thisObj.val( num );			
	})  
    
    
    
    //============================================
	// 주민번호 뒷자리 입력시 첫번째 이후로 * 표시하기 
    //============================================	
	
	// var name = "NAME";  name = name.replace(/(?<=.{1})./gi, "*");
	// 0번째 인덱스 이후로 마스킹 처리해주는 정규표현식 인데 
	// 현재 에로한 상황은 처리해주는건 좋은데 원본 데이터를 지키지 못한다.
	// DB 에 마스킹 처리가 된 데이터를 줄수는 없으니. . .
	
	
	
	//============================================
	// 전화번호 맨앞자리 셀렉트박스 체인지 이벤트 시 동생을 지우기 
    //============================================	
	joinForm.find(".tel_num1").change(function(){
		var tel_num1 = joinForm.find(".tel_num1").val();	
		if( tel_num1 == "" ){
			joinForm.find(".tel_num2").val("");
			joinForm.find(".tel_num3").val("");	
			return;
		}
		else{ joinForm.find(".tel_num2").focus(); }
	})	
	
	
	//============================================
	// 이메일 직접입력 체크 시 || 선택 체크 시 
    //============================================	
    var writeDomain = joinForm.find(".writeDomain");
    var choiceDomain = joinForm.find(".choiceDomain");
    var domain = joinForm.find(".domain");		
    var domain2 = joinForm.find(".domain2");	
    
    // 일단 숨기기
    choiceDomain.hide();
    domain2.hide();
	
    
    writeDomain.click(function(){

    	writeDomain.hide(); 
    	domain.hide();      domain.val("");
    	
    	
        choiceDomain.show(); 
        domain2.show();
    })
    choiceDomain.click(function(){

    	writeDomain.show();
        domain.show();
   	
        choiceDomain.hide(); 
        domain2.hide();      domain2.val("");
   })
   
   
   // 11/28 월  내가 할 거는 주소 따고 주민번호 마스킹 처리하면서 원본 살리기 
   
   
   
   
   
})// 보디태그 읽고 난 후 실핼할 자스 코드 블록 끝 ■■■■■■■■■■■■■■■■■■■■■

function joinCheck(){
	
	var joinForm = $("[name='joinForm']");	
	
	
	
  	// 12/05 유효성 체크 시 공백 제거 싸그리 포함 시키자! 
		
	//============================================
	// 이름 유효성 
    //============================================
	var uname = joinForm.find(".uname").val().trim();
	
  	
  	
	if( uname.split(" ").join("") == "" ){
		 alert("이름 입력란이 비었습니다.");
		 joinForm.find(".uname").val("");
		 joinForm.find(".uname").focus();
		 return;
	}
	
    if( uname == null ){ uname = ""; }
    uname = $.trim(uname);
	var regExp = new RegExp(/^[가-힣]{2,7}$/);
	if( regExp.test(uname) == false ){
		   alert("이름은 한글로만 작성하시오.");
		   joinForm.find(".uname").val("");
		   joinForm.find(".uname").focus();
		   return;		   
	}
	
   
	//============================================
	// 비번 유효성 
    //============================================
	var pwd = joinForm.find(".pwd").val().trim();
    if( pwd == null ){ pwd = ""; }	
    pwd = $.trim(pwd);
	regExp = new RegExp(/^[a-z|0-9]{4,10}$/);
	if( regExp.test(pwd) == false ){
		   alert("암호는 4~10 자 사이로 영소문 또는 숫자로만 기입하시오.");
		   joinForm.find(".pwd").val("");
		   joinForm.find(".pwd").focus();
		   return;		   
	}
	
	
	//============================================
	// 비번 확인은 기존과 일치하지 않을 때 경고   
    //============================================
    var pwd_confirm = joinForm.find(".pwd_confirm");
	var pwd_confirm_val = joinForm.find(".pwd_confirm").val().trim();
    if( pwd_confirm_val == null ){ pwd_confirm_val = ""; }	
    pwd_confirm_val = $.trim(pwd_confirm_val);
	
	
		if( pwd != pwd_confirm_val ){
			alert("암호가 일치하지 않습니다.");
			pwd_confirm.val("");
			pwd_confirm.focus();
			return;
		}
	
		
		
    //============================================
	// 소속 부서 체크 
	//============================================
	var affiliation_dept = joinForm.find(".affiliation_dept").val();
    if( affiliation_dept == null ){ affiliation_dept = ""; }	
    
    if( affiliation_dept == "" ){
		alert("소속 부서를 선택하시오.");
		return;
    }
    
    

    // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    
    // 주민번호 유효성 체크 때려놓은건데 실존하는 주민 아니면 안들어가니까 
    // 테스트 할때는 이거 false 로 박아놓고 레즈고 ~ 
    
    // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    if( false ){

		//============================================
		// 주민번호 유효성 
	    //============================================
		var f_jumin = joinForm.find(".front_jumin_num").val().trim();
		var b_jumin = joinForm.find(".back_jumin_num").val().trim();
		
		//if( jumin_num == null ){ jumin_num = ""; }
		
		var jumin_num = f_jumin + b_jumin ;
		
		jumin_num = jumin_num.split("");
		var num = [2,3,4,5,6,7,8,9,2,3,4,5];
		
		// 마지막 한자리는 빼야하니까 - 1
		for(var i = 0 ; i < jumin_num.length -1 ; i++ ){		
			jumin_num[i] = jumin_num[i] * num[i] ;
		}
		
		// 주민 마지막 번호 따로 보관쓰 
		var lastJumin_num = jumin_num[ jumin_num.length - 1 ];
		
		// 주민넘버의 모든 수를 더해서 sum 변수 안에 저장.
		var sum = 0 ;
		for( var i = 0 ; i < jumin_num.length -1 ; i++ ){
			sum += jumin_num[i];
		}
		
		sum = sum % 11;
		sum = 11 - sum; 
		
		if( sum > 9 ){
			sum = sum % 10; 		
		}
		
		if( sum != lastJumin_num ){
			alert( "유효하지 않은 주민등록번호입니다!!" );
			return; 
		}
	
    }//  주민 이프문 블록 끝 
    
    
    
    
	
	//============================================
	// 이메일  유효성 
    //============================================
	var email = joinForm.find(".email").val().trim();
    if( email == null ){ email = ""; }	
	regExp = new RegExp(/^[A-Za-z0-9_\.\-]+$/);
	if( regExp.test(email) == false ){
		   alert("이메일 형식에 맞게 기입하시오.");
		   joinForm.find(".email").val("");
		   joinForm.find(".email").focus();
		   return;		   
	}

	
	// 도메인이  선택 과 입력  둘다 기입 안됬을 때 경고 
	var domain = joinForm.find(".domain").val().trim();
	var domain2 = joinForm.find(".domain2").val().trim();
    if( domain == "" && domain2 == "" ){
    	alert("도메인을 선택 또는 입력 하십시오.");
    	return;
    }
	
    // 선택한 도메인이 없을 경우 
    if( domain == "" ){
        regExp = new RegExp(/^@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/);
	    if( regExp.test( domain2 ) == false ){
		     alert("도메인 형식에 맞게 기입하시오.");
		     joinForm.find(".domain2").val("");
		     joinForm.find(".domain2").focus();
		     return;		   
	    }
    
    }
	

	
	//============================================
	// 전화번호 유효성 
    //============================================
	var tel_num1 = joinForm.find(".tel_num1").val().trim();
	var tel_num2 = joinForm.find(".tel_num2").val().trim();
	var tel_num3 = joinForm.find(".tel_num3").val().trim();
    if( tel_num2 == null || tel_num3 == null ){ tel_num2 = ""; tel_num3 = "";  }
    
    if( tel_num1 == "" ){ alert("첫째 전화번호 기입!"); return; }
    if( tel_num2 == "" ){ alert("두째 전화번호 기입!"); return; }
    if( tel_num3 == "" ){ alert("셋째 전화번호 기입!"); return; }
    
    regExp = new RegExp(/^[0-9]{4}$/);
    if( regExp.test( tel_num2 ) == false ){
    	alert(" '-' 를 제외한 숫자 4자로만 기입! "); 
    	joinForm.find(".tel_num2").val("");
    	joinForm.find(".tel_num3").val("");
    	joinForm.find(".tel_num2").focus();
    	return;
    }
    if( regExp.test( tel_num3 ) == false ){
    	alert(" '-' 를 제외한 숫자 4자로만 기입! "); 
    	joinForm.find(".tel_num3").val("");
    	joinForm.find(".tel_num3").focus();
    	return;
    }
	
	//============================================
    // 회원가입 비동기 방식으로 웹서버에 접근
	//============================================
	$.ajax(  
			{   
				
			    url:"/joinProc.do"	
			    ,type:"post"
			    ,data:$("[name='joinForm']").serialize()  
			    
			    ,success:function( Cnt ){	
			    	if( Cnt != 1 ){ alert("중복된 회원정보 입니다."); return;  }
			    	if( Cnt ==  1 ){
			    		alert("회원 가입신청 성공!");
			    			
			    			//============================================
			    		    // 가입신청 후 아이디 비동기로 가져와서 로그인화면
			    		    // 으로 넘어갈 때 넘기기
			    			//============================================
			    			$.ajax(  
			    					{   
			    						
			    					    url:"/memberIdProc.do"	
			    					    ,type:"post"
			    					    ,data:$("[name='joinForm']").serialize()  
			    					    
			    					    ,success:function( json ){	
			    					    	var id = json["uid"];
			    					    		$("[name='loginForm']").find(".uid").val( id );
			    					    	    //alert( $("[name='loginForm']").find(".uid").val() );
			    					    		
			    			                   //============================================
			    		                       // 아이디 가져온 후 팝업창에서 아이디 띄우기  
			    			                   //============================================
			    			                      window.open("/idView.do","아이디 보여주는 페이지","width=400,height=550,top=250,left=800");	   
			    					    	   // document.loginForm.submit();
			    					    	
			    					    }
			    						 
			    				        //----------------------------------------
			    					    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    					    //----------------------------------------
			    				        ,error:function(){ alert("가입 후 아이디 가져오기 실패! 웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			    					}
			    			);
			    			
			    		
			        }
			    	else{ alert("회원가입 실패!!"); return; }
			    	
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
		);	
	
	
	
}

function hi(){
	//alert("hi");
}


</script>
</head>
<body>


<form name="loginForm" method="post" action="/loginForm.do">
	<input type="hidden" name="uid" class="uid"  id="uid">
</form>

<!----------------------- 회원가입 풤태그 시작 --------------------------->
<form name="joinForm">

 <header id="header">		
        <a href=""><img src="images/header_logo.png" alt="logo"></a>		
    </header>
    <!-- e.header -->

    <section id="section1">
        <article class="section1_information">
            
                <fieldset>
 
					 <table>	
					 			
					 	<tr>
					 		
							<td>				
							<!-------------------------------------------------------->
							<input type="text" name="uname" placeholder="이름" class="uname" size="20" maxlength="10">
							<!-------------------------------------------------------->
							</td>	
					 	<tr>
					 		
							<td>		
							<!-------------------------------------------------------->
							<input type="password" name="pwd" class="pwd" placeholder="비밀번호" size="10" maxlength="20">
							<!-------------------------------------------------------->	
							<!-------------------------------------------------------->
							<input type="password" name="pwd_confirm" placeholder="비밀번호 확인" class="pwd_confirm" size="10" maxlength="20">
							<!-------------------------------------------------------->
							<span class="notEquals" ></span>
							</td>		
					 	<tr>
							
							<td>		
							<!-------------------------------------------------------->
							<select name="affiliation_dept" class="affiliation_dept" >
								<option value="">ㅡ 소속부서 선택 ㅡ
								<option value="10">행정
								<option value="20">사무
								<option value="30">구매
								<option value="40">접대
								<option value="50">회계
								<option value="60">기타
							</select> 
							<!-------------------------------------------------------->
							</td>		
					 	<tr>                                  
							
							<td>
							<!-------------------------------------------------------->
							<input type="text" name="front_jumin_num" class="front_jumin_num" size="10" maxlength="6" placeholder="주민번호 앞자리">
							-
							<input type="password" name="back_jumin_num" class="back_jumin_num" size="10" maxlength="7" placeholder="주민번호 뒷자리">
							<!-------------------------------------------------------->
							</td>		
					 	<tr>
							
							<td>			
							<!-------------------------------------------------------->
							<input type="text" name="email" class="email"  maxlength="20" placeholder="이메일을 입력해주세요">
							<select name="domain" class="domain" >
								<option value="">ㅡ 도메인 선택 ㅡ
								<option value="@naver.com">@naver.com
								<option value="@daum.com">@daum.com
								<option value="@kakao.com">@kakao.com
								<option value="@google.com">@google.com
							</select>    
							<input type="text" name="domain2" class="domain2"  maxlength="20" value="" placeholder="@부터 도메인 직접입력">
							<input type="button" value="직접입력" class="writeDomain">
							<input type="button" value="선&nbsp;&nbsp;&nbsp;&nbsp;택" class="choiceDomain">
							<!-------------------------------------------------------->
							</td>		
					 	<tr>
						
							<td>			
							<!-------------------------------------------------------->
							<select name="tel_num1" class="tel_num1">
								<option value="">ㅡ 휴대폰 앞자리 ㅡ
								<option value="010">010
								<option value="011">011	
								<option value="012">012				
							</select>
							-
							<input type="text" name="tel_num2" class="tel_num2" size="4" maxlength="4" placeholder="휴대폰 번호">
							-
							<input type="text" name="tel_num3" class="tel_num3" size="4" maxlength="4" placeholder="휴대폰 번호">
							<!-------------------------------------------------------->
							</td>
					</table>
 					</fieldset>
					
 					</article>
 						<article class="section1_btn">
							<input type="button" name="join_btn" value="회원가입" class="joinBtn">
							<input type="reset" value="다시 작성" class="reset">
							<input type="button" class="loginBtn" value="로그인 화면" >
						</article>
					</section>
					
</form>
<!----------------------- 회원가입 풤태그 끝 --------------------------->


</body>
</html>


