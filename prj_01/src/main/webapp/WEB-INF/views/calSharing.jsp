<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정공유</title>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

// 부모창에서 가져온 일정관리 번호 
var cal_no = opener.document.getElementById("cal_no").value;



$(function(){
	
	// 일정관리 번호를 박기.
	$(".cal_no").val( cal_no );
	
	$(".close").click(function(){
		popupClose();
	})
	
	$(".sharing").click(function(){
		calShareCheck();
	})
	
	// 공유할 사람 비동기로 가져오기 
	//================================================
	$.ajax(   
			{   
				
			    url:"/getShareOne.do"	
			    ,type:"post"
			    ,data:$("[name='getSomeOneToShare']").serialize()  
			    
			    ,success:function( arr ){	
			    	
			    	for(var i = 0 ; i < arr.length ; i++ ){
			    		var json = arr[i];
			    		var emp_no = json["emp_no"];
			    		var emp_name = json["emp_name"];
			    		var jikup_name = json["jikup_name"];
			    		$(".someone_to_share").append("<option value="+ emp_no +">" + emp_name + " " + jikup_name + " 님" );
			    	}
			    	
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);	
	//================================================
});
	
	
	
function popupClose(){ window.close(); } 

function calShareCheck(){
	
	
	var selector = $(".someone_to_share").val();
	if( selector == null ){ selector = ""; }
	
	
	// 테이블 설계 시 굳이 안넣어도 되게끔 길이가 없는 디폴트 값을 넣어서 
	// 유효성 체크는 따로 안해도 되지만 이게 알람창의 게시판 형태로 슥 
	// 나타낼꺼라 내용에 <script> 가 안들어가게만 유효성 체크 ㄱ
	var subject = $(".subject").val();
	if( subject == null ){ subject = ""; }
	subject = $.trim(subject);
	
	if( selector == "" ){
		alert("공유할 대상을 선택해주세요."); 
		return;
	}
	
	if( subject.indexOf("<script>") >= 0 || subject.indexOf("<SCRIPT>") >= 0 ){
		alert("해당 메시지는 보낼 수 없습니다!!!");
		$(".subject").val("");
		$(".subject").focus();
		return;
		
	}
	if( subject == "" ){
		
		alert("메시지를 입력하세요.");
		$(".subject").val("");
		$(".subject").focus();
		return;
	}
	
	// 일정 공유 하기  
	//================================================
	$.ajax(   
			{   
				
			    url:"/calShareProc.do"	
			    ,type:"post"
			    ,data:$("[name='calShareForm']").serialize()  
			    
			    ,success:function( cnt ){	
			    	
			    	if( cnt == 1 ){  
			    		
			    		//================================================
			    		$.ajax(   
			    				{   
			    					
			    				    url:"/getNameForm.do"	
			    				    ,type:"post"
			    				    ,data:$("[name='calShareForm']").serialize()  			    		    
			    				    ,success:function( json ){	
			    				    	
			    				    	var name = json["getName"];
			    			    		alert( name + " 님 에게 일정이 공유되었습니다." ); 
			    			    		opener.location.reload();
			    			    		self.close();
			    				    }
			    					 
			    			        //----------------------------------------
			    				    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    				    //----------------------------------------
			    			        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			    				}
			    		);
			    		//================================================
			    		
			    	}
			    	else{ alert("일정을 공유하지 못했습니다."); }
			    	
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);	
	//================================================
	
} 




</script>     
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/serve.css">
</head>
<body>
<section id="section2"> 
	<article class="section2_information">

<!-- 공유자 셀렉박스에 가져올 때 쓸 폼태그 -->
<form name="getSomeOneToShare">
	<input type="hidden" name="uid" class="uid" id="uid"  value="${sessionScope.uid}">
</form>

<!-- 일정 공유 폼태그 -->
<form name="calShareForm" method="post" action="">
<center>
   
   
   <input type="hidden" name="uid" class="uid" id="uid"  value="${sessionScope.uid}">
   
   <!-- 이녀석으로 해당 일정 삭제 시 쓰일 거  -->
   <input type="hidden" name="cal_no" class="cal_no" id="cal_no">
   
   
    <h3><b>일정 공유</b></h3>
 
	<table border="0" cellpadding="5" cellspacing="0" width="80%">
		<caption></caption>
		<!-- ================================================================== -->	
		<tr>
			<td> 공유자 선택 <br>		
			
				<select name="someone_to_share" class="someone_to_share">
						<option value="">선택
			    </select>
		<!-- ================================================================== -->	
		<tr>
			<td> 메시지 <br>
				<textarea name="subject" class="subject"></textarea>
		<!-- ================================================================== -->	
	</table>
 	</article>
 	
    <div style="height:7px;"></div>
    <article class="section2_btn"> 
	    <input type="button" value="공유" class="sharing">
	    <input type="button" value="닫기" class="close">
  	</article>

</form>
</section>
</body>
</html>