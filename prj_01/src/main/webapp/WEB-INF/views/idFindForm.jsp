<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

$(function(){

	$(".id_find_btn").click(function(){
		findId();
		
		// 계속 웹서버 응답 실패 뜨길래 DB문제인것 같았는데 
		// 왜인진 모르겠지만 이 닫기 코드 때문에 작동이 안됬었다...
		// 스스로 팝업창 닫기 
		//self.close();
	})
	
	// 팝업 닫기 
	$(".close").click(function(){
		self.close();
	})
	
	
	// 비번 입력란에 숫자만 입력되게 	
	$(".pwd").keyup(function(){
		var thisObj = $(this);
		var uid = thisObj.val();
		var nums = "1234567890";
		var num  = "";
		
		for( var i = 0  ; i < uid.length ; i++ ){			
			var str = uid.charAt(i);
			if( nums.indexOf( str ) >= 0 ){
				num = num + str ;
			}
			
		}
		thisObj.val( num );
		
		
	}) 	
	$(".juminF").keyup(function(){
		var thisObj = $(this);
		var uid = thisObj.val();
		var nums = "1234567890";
		var num  = "";
		
		for( var i = 0  ; i < uid.length ; i++ ){			
			var str = uid.charAt(i);
			if( nums.indexOf( str ) >= 0 ){
				num = num + str ;
			}
			
		}
		thisObj.val( num );
		
		
	}) 	
	$(".juminB").keyup(function(){
		var thisObj = $(this);
		var uid = thisObj.val();
		var nums = "1234567890";
		var num  = "";
		
		for( var i = 0  ; i < uid.length ; i++ ){			
			var str = uid.charAt(i);
			if( nums.indexOf( str ) >= 0 ){
				num = num + str ;
			}
			
		}
		thisObj.val( num );
		
		
	})
	
	
})

function findId(){
	
	
	var pwd =  $(".pwd").val();	
	
	if( pwd == null  ){ pwd = ""; }
	pwd = $.trim( pwd );
	if( pwd == "" ){
		alert("비밀번호를 입력해주세요.");
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
	
	
	
	$.ajax(  
			{   
				
			    url:"/findIdProc.do"	
			    ,type:"post"
			    ,data:$("[name='popup2Form']").serialize()  
			    
			    ,success:function( json ){	
			    	
			    	var id = json["getId"];
			    	if( id == "zero" ){
			    		alert("존재하지 않는 회원정보 입니다.");
			    		$(".pwd").val("");
			    		$(".pwd").focus();
			    		return;
			    	}
			    	else{
			    		alert("귀하의 아이디는 ["+ id + "] 입니다.");
			    		

			    		if( confirm("현재 창을 닫을까요?") ){
			    			
			    			opener.document.getElementById("uid").value = id ;
			    			window.close();
			    		}
			    	
			    	}	
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);
	
}

function goFindPwd(){
	
    location.replace("/pwdFindForm.do");
}


</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/serve.css">
</head>
<body>

<form name="goLoginForm" method="post" action="/loginForm.do">

	<input type="hidden" name="uid" class="uid">

</form>


<form name="popup2Form" >
	
  
    <center><h2><b>아이디 찾기</b></h2><br>
    
    
<section id="section1"> 
	<article class="section1_information">
	아이디를 찾고자하는 비밀번호를 입력해주세요
	<table>		
		<tr>
			<th> <input type="password" name="pwd" class="pwd" maxlength="4"
			     placeholder="비밀번호 입력" onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호 입력'">		
		<tr>
			<th> <input type="text" name="juminF" class="juminF" maxlength="6" size="15"
			     placeholder="주민번호 앞자리" onfocus="this.placeholder=''" onblur="this.placeholder='주민 앞자리'"> -
			     <input type="password" name="juminB" class="juminB" maxlength="7" size="15"
			     placeholder="주민번호 뒷자리" onfocus="this.placeholder=''" onblur="this.placeholder='주민 뒷자리'">
	</table>	     
		<article class="section1_btn">	
			<input type="button" value="찾기" class="id_find_btn">
			<input type="button" value="닫기" class="close">
		</article>
	
	</article>
</section>		
	<br>
	<span style="cursor:pointer" onClick="goFindPwd()">[비밀번호 찾기]</span>	     
	
	

	

</form>


</body>
</html>
