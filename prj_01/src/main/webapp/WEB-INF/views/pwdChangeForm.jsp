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
	
	var pwdConfirm = $(".pwdConfirm");
	pwdConfirm.hide();
	
	$(".pwd_change").click(function(){
		changePwd();
		
	})
	
	// 팝업 닫기 
	$(".close").click(function(){
		self.close();
	})
	
    //===========================================
    // 새로 설정하는 비번과 그 비번 재입력 시 	
    //===========================================
	var new_pwd =  $(".new_pwd");
	var new_pwd_confirm =  $(".new_pwd_confirm");
	
	new_pwd_confirm.keyup(function(){
		
		var pwd1 = new_pwd.val();
		var pwd2 = new_pwd_confirm.val();
		
		if( pwd1 == null ){ pwd1 = ""; }	
		if( pwd2 == null ){ pwd2 = ""; }
	
		if( pwd1 !=  pwd2 ){ pwdConfirm.show();}
		else{ pwdConfirm.hide();}
		
		
	})
	
	new_pwd.keyup(function(){
		
		var pwd1 = new_pwd.val();
		var pwd2 = new_pwd_confirm.val();
		
		if( pwd1 == null ){ pwd1 = ""; }	
		if( pwd2 == null ){ pwd2 = ""; }
	
		if( pwd1 !=  pwd2 ){ pwdConfirm.show();}
		else{ pwdConfirm.hide();}
		
		
	})
	
	
    //===========================================
    // 기존 비번 ,  새로 설정하는 비번과 그 비번 재입력 시 	
    //===========================================  	
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
	$(".new_pwd").keyup(function(){
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
	$(".new_pwd_confirm").keyup(function(){
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

function changePwd(){
	
	//alert("hi"); return;
	var uid = $(".uid");
	var pwd =  $(".pwd");
	var new_pwd =  $(".new_pwd");
	var new_pwd_confirm =  $(".new_pwd_confirm");	
	
	// 입력양식에서 가져온 녀석들이 널이라면 길이가 없는 문자 ㄱ 
	if( pwd == null  ){ pwd = ""; }
	if( new_pwd == null  ){ new_pwd = ""; }
	if( new_pwd_confirm == null  ){ new_pwd_confirm = ""; }
	
	// 널이 아닐 경우 벨루 값 가져와서 
	var pwd1 = pwd.val();
	var pwd2 = new_pwd.val();
	var pwd3 = new_pwd_confirm.val();
	var uidVal = uid.val();
	
	// 앞뒤 공백 없애기.
	pwd1 = $.trim( pwd1 );
	pwd2 = $.trim( pwd2 );
	pwd3 = $.trim( pwd3 );
	uidVal = $.trim( uidVal );
	
	uid.val( uidVal );
	pwd.val( pwd1 );
	new_pwd.val( pwd2 );
	new_pwd_confirm.val( pwd3 );
	
	if( uid.val() == "" ){ alert("아이디를 입력바랍니다."); return; }  
	
	// 입력양식에 값을 넣지 않을 경우 || 널 값이 였을 경우 
	if( pwd1 == "" ||  pwd2 == "" || pwd3 == "" ){
		alert("변경할 비밀번호를 정확히 기재해 주세요.");
		return;
	}
	
	// 위에서 새로운 비번 확인 유효성 체크는 간단히 했지만 여기서 한번 더 
	if( pwd2 != pwd3 ){
		alert("비밀번호가 일치하지 않습니다! 다시 기재해 주세요.");
		return;
	}
	
	// 기존에 비번과 일치한다면 경고 하기 
	// umm... 근데 이걸 비동기도 할까 말까.. 일단 킵!
	if( pwd2 == pwd3 && pwd1 == pwd2 ){		
		alert("기존의 비밀번호와 일치합니다..!!!");
	    return;
	}
	
	
	
	
	// 비동기 방식으로 웹서버에 접근 
	$.ajax(  
			{   
				
			    url:"/changePwdProc.do"	
			    ,type:"post"
			    ,data:$("[name='popup3Form']").serialize()  
			    
			    ,success:function( cnt ){	
			    	
			    	if( cnt == 1 ){
			    		alert("비밀번호가 변경되었습니다.");
			    		if( confirm("현재 창을 닫을까요?") ){
			    			self.close(); 
			    		}
			    		return;
			    	}
			    	else{
			    		alert("기존의 아이디와 암호를 다시한번 확인해주세요.");
		    	        return;
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


<form name="popup3Form" >  


    <h2><center><b>비밀번호 변경</b></center></h2>
    <br>
<section id="section1">  
  <article class="section1_information"> 
	<table cellpadding="20"  border="1" cellspacing="0" width="80%">
	
	    <tr>
			<td>  
			아이디를 입력하세요<br>
			<input type="text" name="uid" class="uid" maxlength="10"
			     placeholder="아이디 입력" onfocus="this.placeholder=''" onblur="this.placeholder='아이디 입력'">
		<tr>
			<td>  
			기존에 비밀번호를 입력하세요<br>
			<input type="password" name="pwd" class="pwd" maxlength="10"
			     placeholder="기존 비밀번호" onfocus="this.placeholder=''" onblur="this.placeholder='기존 비밀번호'">
		<tr>
			<td>
			변경할 비밀번호를 입력하세요<br>
			 <input type="password" name="new_pwd" class="new_pwd" maxlength="10"
			     placeholder="새 비밀번호" onfocus="this.placeholder=''" onblur="this.placeholder='새 비밀번호'">
		<tr>
		    <td>
			변경할 비밀번호를 재입력 하세요<br>
		     <input type="password" name="new_pwd_confirm" class="new_pwd_confirm" maxlength="10"
			     placeholder="새 비밀번호 재입력" onfocus="this.placeholder=''" onblur="this.placeholder='새 비번 재입력'">
		     <span class="pwdConfirm">비밀번호가 일치하지 않습니다.</span>
		      
	</table>
	</article> 
    	<div style="height:5px"></div>
  			<article class="section1_btn">
                 <input type="button" value="변경" class="pwd_change">
			     <input type="button" value="닫기" class="close">
			</article>
			     <br><br>
		   <center><span style="cursor:pointer" onClick="goFindPwd()">[비밀번호 찾기]</span></center>    
	
	
		
</section>
</form>


</body>
</html>
