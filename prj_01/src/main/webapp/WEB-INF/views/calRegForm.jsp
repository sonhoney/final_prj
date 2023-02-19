<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정등록</title>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

var psd = opener.document.getElementById("select_start_date").value;
var ped = opener.document.getElementById("select_end_date").value;

if( true ){
var sh = opener.document.getElementById("start_hour").value;
var sm = opener.document.getElementById("start_minute").value;
var eh = opener.document.getElementById("end_hour").value;
var em = opener.document.getElementById("end_minute").value;
} 
	
		
$(function(){
	
 // 자식창에서 부모창에 있는 벨루값 가져오기 	  
 //document.getElementById("cTitle").value = opener.document.getElementById("pTitle").value;
 // 아래처럼 변수에 바로 박아줄 수도 있다. 개꿀이네 이거.
 
 
    //===========================================
    // 닫기 버튼 클릭 시 함수 호출 
    //===========================================
    $(".close").click(function(){
	    parentReload();
    })
    //===========================================
  	// 부모창에서 가져온 데이터를 여서 때려넣기
    //===========================================
 	$(".start_date").val( psd );
 	$(".end_date").val( ped );
 	

    //===========================================
    // 등록 버튼 클릭 시 일정 등록 
    //=========================================== 	
 	$(".regBtn").click(function(){
 		regFormCheck();
    })
 

     
     
    //===========================================
    // 시간 선택 자스로 넣어주기  
    //===========================================   
    
    var firstStr = 24; 	
	
    for( var i = 0 ; i < firstStr ; i++ ){
    	
    	if( i < 10 ){
    		$(".start_hour,.end_hour").append("<option value=0"+ i +">오전 0" + i + "시</option>");
    	}
    	else if( i == 10 || i == 11 ){
    		$(".start_hour,.end_hour").append("<option value="+ i +">오전 " + i + "시</option>");
    	}
    	else if( i == 12 ){
    		$(".start_hour,.end_hour").append("<option value="+ i +">오후 " + i + "시</option>");
    	}
    	else{
    		if( i >= 13 && i < 22 ){
    			$(".start_hour,.end_hour").append("<option value="+ i +">오후 0" + (i-12) + "시</option>");
    		}
    		else{
    			$(".start_hour,.end_hour").append("<option value="+ i +">오후 " + (i-12) + "시</option>");
    		}
    	
    	}
    }   
    
    //===========================================
    // 위에서 옵션 값을 넣고 난 다음 부모창에서 가져온 데이터 박기.     
    //===========================================
  	if( true ){
  	 	
  	 	$(".start_hour").val( sh );  //$(".start_hour").append("<option value="+ sh +">" + sh)
  	 	$(".start_minute").val( sm );
  	 	$(".end_hour").val( eh );
  	 	$(".end_minute").val( em );

  	 	} 
    
    //*******************************
    // 시작 끝 날짜 같이 ㄱ ㄱ 
    //*******************************
  	$(".start_min_str").hide();
    //===========================================   
    // 조건식을 이따가 주 , 일 로 체크하며 시,분 이 넘어오면 이것은 false 가 되게 ㄱ      
    //===========================================
    if( $(".start_hour").val() == "" ){
	    // 처음엔 숨기기
	    $(".start_hour,.start_minute,.end_hour,.end_minute").hide();
	    $(".allDay").hide();
	 	
	    //===========================================
	    // 시간 설정 버튼 클릭 시 텍스트 보이기 
	    //===========================================
	    $(".timeSet").click(function(){
	
	     	$(".start_hour,.start_minute,.end_hour,.end_minute").show();
	        $(".timeSet").hide();
	        $(".allDay").show();
	        
	    })	
	    
	    //===========================================
	    // 하루 종일 버튼 클릭 시 년 월 일 만 체크할 date 입력양식 보이기  
	    //===========================================  
	     $(".allDay").click(function(){	
	 	    $(".start_hour,.start_minute,.end_hour,.end_minute").hide();
	 	    $(".start_hour,.start_minute,.end_hour,.end_minute").val("");
	 	    $(".allDay").hide();
	        $(".timeSet").show(); 
	        $(".start_min_str").hide();
	        $(".directlyWrite").hide();
	        $(".sub_start_minute").val("");
	        $(".sub_start_minute").hide();
	        $(".end_min_str").hide();
	        $(".directlyWrite1").hide();
	        $(".sub_end_minute").val("");
	        $(".sub_end_minute").hide();
	        
	        
	     })
  
    }
    else{
    	$(".allDay").hide();
    	$(".timeSet").hide();
    }
    

    
    
    
    
    
    // 분  직접입력은 일단 냅두고 나중에 다 활성화 되면 그때 
    // 해보기로 하자!! 
    //*******************************
    // 시작 시간설정 직접입력 시 
    //*******************************
    //===========================================
    // 분 직접 입력 시  
    //=========================================== 
    $(".directlyWrite").hide();	
    $(".sub_start_minute").hide();	
    $(".start_minute").change(function(){
    	
    	//alert("hi"); return;
    	
    	var thisObj = $(this);
    	var val = thisObj.val();
    	
    	if( val == "직접입력" ){
    		$(".start_minute").hide();
    		$(".start_minute").val("");
    		$(".sub_start_minute").show();
    		$(".directlyWrite").show();
    		$(".start_min_str").show();
    	}
    	
    })
    
    
    //===========================================
    // 분 직접 입력 시 문구 사라지게 하기 
    // 유효성도 겸사 겸사 
    //===========================================   
    $(".sub_start_minute").keyup(function(){
    	//alert("a"); return;
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
		if( thisObj.val().length == 2 ){

    		$(".directlyWrite").hide();
		}
		else{ $(".directlyWrite").show(); }
    	
    })
    
    //*******************************
    // 끝 시간설정 직접입력 시 
    //*******************************   
    //===========================================
    // 분 직접 입력 시  
    //=========================================== 
    $(".directlyWrite1").hide();	
    $(".sub_end_minute").hide();	
    $(".end_minute").change(function(){
    	
    	//alert("hi"); return;
    	
    	var thisObj = $(this);
    	var val = thisObj.val();
    	
    	if( val == "직접입력" ){
    		$(".end_minute").hide();
    		$(".end_minute").val("");
    		$(".sub_end_minute").show();
    		$(".directlyWrite1").show();
    		$(".end_min_str").show();
    	}
    	
    })
    
    //sub_end_minute end_min_str  directlyWrite1  end_hour
    
    //===========================================
    // 분 직접 입력 시 문구 사라지게 하기 
    // 유효성도 겸사 겸사 
    //===========================================   
    $(".sub_end_minute").keyup(function(){
    	//alert("a"); return;
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
		if( thisObj.val().length == 2 ){

    		$(".directlyWrite1").hide();
		}
		else{ $(".directlyWrite1").show(); }
    	
    })
    
    
    
    
    /*
       시간설정 시 직접 입력을 넣어보았지만 좀 난잡하고 깔쌈하지 않아서 뺌.
     
       
       
       
       로그인  아이디 찾기 기능 추가 
       
       회원가입  가입 성공 시 팝업 열어서 아이디 알려주기 
       
       그리고 CSS 입히고 테스트 후 유효성 가다듬기 . 
    
    
    */
    
    
  
    
     
})

function regFormCheck(){
			
	  var a = $(".subject").val(); 
	  var b = $(".start_date").val();    
	  var c = $(".end_date").val();  
	
	  var sh = $(".start_hour").val( );
	  var sm = $(".start_minute").val( );
	  var eh = $(".end_hour").val( );
	  var em = $(".end_minute").val( );
	  
	/*   var ssm = $(".sub_start_minute").val( );
      var sem =	$(".sub_end_minute").val( ); */	  
  	
	  if( a != "" && b != "" && c != "" ){
	  
			  if( (  sh =="" && sm =="" && eh =="" && em =="" ) || (   sh !="" && sm !="" && eh !="" && em !="" )	 ){
				 
				  // 시작 끝 날짜 간단한 유효성 체크 
				  if( ( b + sh + sm > c + eh + em )  ){
					  
					  alert("시작 날짜가 더 큽니다...!"); return;
					  
				  }
					  
					  
						  $.ajax(  
									{   
										
									    url:"/scheduleInsertProc.do"	
									    ,type:"post"
									    ,data:$("[name='scheduleRegForm']").serialize()  
									    
									    ,success:function( cnt ){	
									    	
									    	if(cnt == 1){
									    		opener.location.reload();
									    		if( confirm("일정이 등록되었습니다. 현재 창을 닫을까요?")  ){
									    			self.close();
									    		}
									    	}
									    	else{ alert("at...ddo...?");  }
									    	
									    }
										 
								        //----------------------------------------
									    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
									    //----------------------------------------
								        ,error:function(){ alert("와이파이 웹서버 접속 실패! 관리자에게 문의 바람!"); }  
									}
							);
					 
					 
			  
			  }
			  else{ alert("시간설정을 정확히 기입해주세요!"); }
	  }
	  else{ alert("일정제목 또는 날짜 선택을 확인해주세요."); }
	  
}//xxx()함수 끝 블록



function parentReload(){
	
	opener.location.reload();
	window.close();
}





</script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/serve.css">
</head>
<body>
<section id="section2"> 
	<article class="section2_information">

<form name="scheduleRegForm" method="post" action="">
<center>

   <input type="hidden" name="uid" class="uid" value="${sessionScope.uid}">
   
   
   
    <h3><b>일정 등록</b></h3>
 	<br>
	<table border="0" cellpadding="5" cellspacing="0"width=80%>
		<caption></caption>
		<!-- ================================================================== -->	
		<tr>
			<td> 일정
		<tr>
			<td> <textarea  name="subject" class="subject" value="" placeholder="일정 입력" 
			      onfocus="this.placeholder=''" onblur="this.placeholder='일정 입력'"
			      ></textarea>
		<!-- ================================================================== -->	
		<tr>
			<td> 시작 날짜
		<tr>
			<td> <input type="date" name="start_date" id="start_date" class="start_date" value="">
			     
			     <!-- 
	                    <input type="text" name="start_hour" id="start_hour" class="start_hour" size="1">
			            <input type="text" name="start_minute" id="start_minute" class="start_minute" size="1">		     
			            <input type="text" name="end_hour" id="end_hour" class="end_hour" size="1">
			            <input type="text" name="end_minute" id="end_minute" class="end_minute" size="1"> 
			      -->
			     
			     <input type="button" value="시간설정" class="timeSet"> 
			     <input type="button" value="하루종일" class="allDay"> <br>
			     
			     <select name="start_hour" id="start_hour" class="start_hour">
			     	<option value="" />-시간-
			     </select>
			     
			     <select name="start_minute" id="start_minute" class="start_minute">
			     	<option value="" />-분-
			     	<option value="00" />00 분
			     	<option value="15" />15 분
			     	<option value="30" />30 분
			     	<option value="45" />45 분
			     </select>
			     
			     <input type="text" name="sub_start_minute" class="sub_start_minute" size="1" 
			     maxlength="2" placeholder="분" 
			      onfocus="this.placeholder=''" onblur="this.placeholder='분'">
			     <span class="directlyWrite">&nbsp;&nbsp;&nbsp; ← 직접 입력하세요.</span>
			     
		<!-- ================================================================== -->	
		<tr>
			<td> 끝 날짜    
		<tr>
			<td> <input type="date" name="end_date" id="end_date"  class="end_date" value="">
			     
			    
			     <input type="button" value="시간설정" class="timeSet"> 
			      <input type="button" value="하루종일" class="allDay">
			      <br>
			     
			     <select name="end_hour" id="end_hour" class="end_hour">
			     	<option value="" />-시간-
			     </select> 
			     
			     <select name="end_minute" id="end_minute" class="end_minute">
			     	<option value="" />-분-
			     	<option value="00" />00 분
			     	<option value="15" />15 분
			     	<option value="30" />30 분
			     	<option value="45" />45 분
			     </select>
			     
			     <input type="text" name="sub_end_minute" class="sub_end_minute" size="1" 
			     maxlength="2" placeholder="분" 
			      onfocus="this.placeholder=''" onblur="this.placeholder='분'">
			     <span class="directlyWrite1">&nbsp;&nbsp;&nbsp; ← 직접 입력하세요.</span>
		<!-- ================================================================== -->	
		<!-- 첨부파일 때려보자! -->
		<!-- ================================================================== -->	
	</table>
 	</article>
 	<br>
    <div style="height:7px;"></div>
    <article class="section2_btn"> 
	    <input type="button" value="등록" class="regBtn">
	    <input type="button" value="닫기" class="close">
  	</article>

</form>
</section>
</body>
</html>