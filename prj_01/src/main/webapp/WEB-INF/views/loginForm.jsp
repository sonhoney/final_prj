<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/login.css">
    <script src="/js/jquery-1.11.0.min.js"></script>    
    <title>로그인</title>
    <script>

	$(function(){
	
		// 아이디 찾고 나서 로그인 창으로 올 때 
		$(".uid").val(${param.uid});
		
		
		//=================================================
		// 회원가입 후 가입한 아이디 가져와서 박아버리기 
		//=================================================
		if( false ){  // 잠시만 죽이자. 
		<c:if test="${!empty param.uid}">
		      alert("가입 축하드립니다. 당신의 아이디는 ==> " + ${param.uid} + " 입니다." );
		      
		</c:if>
		}
		
		var loginForm =  $("[name='loginForm']");
		
		//=================================================
		// 로그인 버튼 클릭 시 비동기 접근 하는 함수 호출
		//=================================================
		loginForm.find(".loginBtn").click(function(){
			
			loginCheck();
			
		})
		
		//=================================================
		// 회원가입 화면으로 이동 
		//=================================================
		loginForm.find(".memJoinBtn").click(function(){
			location.replace("/joinForm.do");
		})
		
		//=================================================
		// 아이디 / 비번 찾기 버튼 클릭 시 팝업창 띄우기 
		//=================================================	
		loginForm.find(".id_or_pwd_find").click(function(){
			
			window.open("/pwdFindForm.do" , "아이디비번찾기 페이지" ,"width=500,height=300,left=750,top=250");
			
			//location.replace("/joinForm.do");
		})
		
		
	})
	
	// 로그인 버튼 클릭 시 웹서버에 접근해서 아이디 암호 있나 체크 후 홈페이지로 이동.
function loginCheck(){
	
	var loginForm = $("[name='loginForm']");
	
	var uid = loginForm.find(".uid").val();
	var pwd = loginForm.find(".pwd").val();
	
	if( uid == null || pwd == null ){
		uid = ""; pwd = ""; alert("테스트용 문구 => null이라서 아이디,비번을 비웠답니다.");
	    return;
	}
	else{ uid = $.trim(uid);  pwd = $.trim(pwd);   }
	
	if( uid == "" ){alert("아이디가 비었습니다."); return; }
	if( pwd == "" ){alert("암호가 비었습니다."); return; }
	
	$.ajax(  
			{   
				
			    url:"/loginProc.do"	
			    ,type:"post"
			    ,data:$("[name='loginForm']").serialize()  
			    
			    ,success:function( cnt ){	
			    	if( cnt == 1  ){
			    		//alert("로그인 성공!");	
			    		
			    		//location.replace("/planList.do");
			    		document.mainForm.submit();
			    	}
					else if(cnt == 2){
						alert("승인 되지 않은 사원 입니다. 관리자에게 문의 해주세요.")
					}
			    	else{ alert("로그인 정보가 일치하지 않습니다."); }	
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("가입 후 아이디 가져오기 실패! 웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);
}
	</script>
</head>
<body>
	<form name="homeForm" method="post" action="/homeForm.do">
	  <input type="hidden" name="uid" value="${requestScope.uid}"> 
	  
	</form>
	
	<form name="mainForm" method="post" action="/main.do">
		<input type="hidden" name="uid" value="${requestScope.uid}">		
	  </form>


	<form name="boardList" method="post" action="/boardList.do">
	  <input type="hidden" name="uid" value="${requestScope.uid}"> 
	  
	</form>
    <header id="header">
       <a href=""><img src="images/header_logo.png" alt="logo"></a>
    </header>
    <!-- e.header -->
    <form name="loginForm" >
	    <section id="section1">
	        <article class="form">            
	                <fieldset>                    
	                    <input type="text" name="uid" class="uid"  id="uid" placeholder="아이디를 입력해주세요" value="${cookie.uid.value}"><br>
	                    
	                    <input type="password" name="pwd" class="pwd"  id="pwd" placeholder="비밀번호를 입력해주세요" value="${cookie.pwd.value}">
	                    
	                </fieldset>            
	        </article>
	        <article class="section1_text">
	            <div class="find">
					<ul>
						<li><a href="/idFindForm.do" target="_blank">아이디</a>|</li>
						<li><a href="/pwdFindForm.do" target="_blank">비밀번호 찾기</a></li>
					</ul>
				</div>
	            <div class="continue">
	                <input type="checkbox" name="is_login" value="yes" class="id_or_pwd_save" id="check"><label for="check"></label>
	                <p>아이디/비밀번호 저장</p>
	            </div>
	        </article>
	        <article class="section1_btn">
	            <input type="button" value="로그인" class="loginBtn" >
	            <a href="/joinForm.do" class="memJoinBtn">회원가입</a>	            
	        </article>

	    </section>
	    </form>
    <!-- e.section1 -->

   
   
</body>
</html>