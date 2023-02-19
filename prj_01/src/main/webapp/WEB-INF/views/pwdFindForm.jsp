<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

$(function(){

	$(".pwd_find_btn").click(function(){
		findPwd();
		
		// 계속 웹서버 응답 실패 뜨길래 DB문제인것 같았는데 
		// 왜인진 모르겠지만 이 닫기 코드 때문에 작동이 안됬었다...
		// 스스로 팝업창 닫기 
		//self.close();
	})
	
	// 팝업 닫기 
	$(".close").click(function(){
		self.close();
	})
	
	
	// 아이디 입력란에 숫자만 입력되게 	
	$(".uid").keyup(function(){
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

function findPwd(){
	
	
	var uid =  $(".uid").val();	
	
	if( uid == null  ){ uid = ""; }
	uid = $.trim( uid );
	if( uid == "" ){
		alert("해당 아이디를 입력해주세요.");
	}
	
	$.ajax(  
			{   
				
			    url:"/findPwdProc.do"	
			    ,type:"post"
			    ,data:$("[name='popupForm']").serialize()  
			    
			    ,success:function( json ){	
			    	
			    	var pwd = json["getPwd"];
			    	if( pwd == "zero" ){
			    		alert("존재하지 않는 아이디 입니다.");
			    		$(".uid").val("");
			    		$(".uid").focus();
			    		return;
			    	}
			    	else{
			    		alert("귀하의 패스워드 ["+ pwd + "] 입니다.");
                           if( confirm("현재 창을 닫을까요?") ){
			    			
			    			opener.document.getElementById("pwd").value = pwd ;
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

function goFindId(){
	
    location.replace("/idFindForm.do");
}

function changePwd(){
	
    location.replace("/pwdChangeForm.do");
}



</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/serve.css">
</head>
<body>

 	<center><h2><b>비밀번호 찾기</b></h2></center><br>
<form name="popupForm" >
<section id="section1"> 
	<article class="section1_information"> 
  
   
  비밀번호를 찾고자하는 아이디를 입력해주세요
	
		
	
		 <input type="text" name="uid" class="uid" maxlength="4"
			     placeholder="아이디 입력" onfocus="this.placeholder=''" onblur="this.placeholder='아이디 입력'">
			     
	</article>		     
	<article class="section1_btn">		     
		 <input type="button" value="찾기" class="pwd_find_btn">
		 <input type="button" value="암호변경" onClick="changePwd()" class="changPwd">
	     <input type="button" value="닫기" class="close">
	</article>	
		
		
</section>
	<br>	
		<center><span style="cursor:pointer" onClick="goFindId()">[아이디 찾기]</span></center>	     
	
	

	

</form>


</body>
</html>
