<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 상세보기</title>
<style>
    .font_test1 { text-decoration:line-through }
</style>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

var pkNum = opener.document.getElementById("pkNum").value;
// var setVal = opener.document.getElementById("pTitle").value;



$(function(){
	
 // 자식창에서 부모창에 있는 벨루값 가져오기 	  
 //document.getElementById("cTitle").value = opener.document.getElementById("pTitle").value;
 // 아래처럼 변수에 바로 박아줄 수도 있다. 개꿀이네 이거.
 

 
 
 
 
 //  , 수정 유효성 체크 빠르게 다시 잡고 
 
 // 상세보기 화면에서 [ 일정완료 ] 버튼을 만들어 완료 시 
 
 // 내용에 ----------- 찍 선을 그어서 완료한 일정 표시 하기 ! 
 
 

 
     
 
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
    
     // 내일 할 것 . 날짜 유효성 때리고 테스도 좀더 ㄱ ㄱ 
 
 
 
 
    // 0분 ~ 59 분 넣어주는 반복문인데 달력 컨셉상 15분 씩이 맞는 듯
/*     for( var i = 0 ; i < 60 ; i++ ){
    	
    	if( i < 10 ){
    		$(".start_minute,.end_minute").append("<option value=0"+ i +">0" + (i) +" 분");   		
    	}
    	else{
    		$(".start_minute,.end_minute").append("<option value="+ i +">" + (i) +" 분");
    	}
    } */
 
 
 
 
 //=======================================
 // 팝업열고 부모창에 pk 번호 가지고 온걸루 
 // 그 새키 정보 여기에 쫘라락 펼치기 
 //=======================================
 
 $(".cal_no").val( pkNum );
 // $(".subject").val( setVal );	 
 $.ajax(  
		{   
			
		    url:"/getCalInfo.do"	
		    ,type:"post"
		    ,data:$("[name='get_cal_info']").serialize()  
		    
		    ,success:function( json ){	
		    	var s_day = json["cal_start"] ;
		    	var e_day = json["cal_end"] ;
		    	var c_title = json["cal_title"] ;
		    	
		    	
		    	$(".start_date").val( s_day.substr(0,4)+"-"+s_day.substr(4,2)+"-"+s_day.substr(6,2)  );
		    	$(".start_hour").val( s_day.substr(8,2) );
		    	$(".start_minute").val( s_day.substr(10,2) );
		    	
		    	$(".end_date").val( e_day.substr(0,4)+"-"+e_day.substr(4,2)+"-"+e_day.substr(6,2) );
		    	$(".end_hour").val( e_day.substr(8,2) );
		    	$(".end_minute").val( e_day.substr(10,2) );
		    	
		    	$(".subject").val( c_title );
		    	
			    $(".origiVal").val( c_title );
			   	
	 			$(".origi_s_date").val( s_day.substr(0,4)+"-"+s_day.substr(4,2)+"-"+s_day.substr(6,2) );
				$(".origi_s_hour").val( s_day.substr(8,2) );
				$(".origi_s_minute").val( s_day.substr(10,2) );
				$(".origi_e_date").val( e_day.substr(0,4)+"-"+e_day.substr(4,2)+"-"+e_day.substr(6,2) );
				$(".origi_e_hour").val( e_day.substr(8,2) );
				$(".origi_e_minute").val( e_day.substr(10,2) ); 
		    	
		    	/* alert( 
		    			$(".start_date").val() + "/" + $(".start_hour").val() + "/"
		    			+ $(".start_minute").val() + "/" + $(".end_date").val() + "/" 
		    			+ $(".end_hour").val() + "/" + $(".end_minute").val() 
		    			
		    	);  */
		    	
		    }
			 
	        //----------------------------------------
		    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
		    //----------------------------------------
	        ,error:function(){ alert("와이파이 웹서버 접속 실패! 관리자에게 문의 바람!"); }  
		}
 );	 
	 
	 
 // 일정완료 , 수정 , 삭제 , 닫기 , 공유  버튼 클릭 시 	 
 //========================================	 

	 
 $(".update").click(function(){
	 scheduleUpdat();
 })
 
 $(".delete").click(function(){
	 scheduleDeldat();
 })
 
 $(".close").click(function(){
	 parentReload();
 })
 
  $(".cal_sharing").click(function(){
	 sharingSchedule();
 })
 
 $(".cal_complet").click(function(){
	 
	 completSchedule();
 })
 
 //========================================
 

 
 
 
 
 
})

function completSchedule(){
	
	 var subject = $(".subject"); 
	 subject.addClass("font_test1");
	
	
	$.ajax(  
			{   
				
			    url:"/calCompletProc.do"	
			    ,type:"post"
			    ,data:$("[name='calDetailForm']").serialize()  
			    
			    ,success:function( cnt ){	
			    	if( cnt == 1 ){
			    		alert("일정이 완료되었습니다!!!"); 
			    		opener.location.reload();
			    		self.close();
			    		return;
			    	}	
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("[ calUpProc.do ] 웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);
	
	
}


// 일정 공유 할 팝업 띄워서 구현
function sharingSchedule(){
	
	window.open("/calSharing.do","일정관리 공유","width=500,height=650,top=250,left=800" );
	
}



// 닫기 버튼 클릭 시 부모창 새로고침 후 팝업 닫기
function parentReload(){
	
	opener.location.reload();
	window.close();
}

function scheduleUpdat(){
	

	
	//====================================
	// 이전에 입력한 데이터 가져오기 
	//====================================
	 var oriVal = $(".origiVal").val(  );
	 var oriSDate = $(".origi_s_date").val(  );
	 var oriSHour = $(".origi_s_hour").val(  );
	 var oriSMinute = $(".origi_s_minute").val(  );
	 var oriEDate = $(".origi_e_date").val(  );
	 var oriEHour = $(".origi_e_hour").val(  );
	 var oriEMinute = $(".origi_e_minute").val(  );
	
	//====================================
	// 수정 시 입력한 데이터 가져오기 
	//====================================
	var titleVal = $(".subject").val();
	var start_date = $(".start_date").val();
	var start_hour = $(".start_hour").val();
	var start_minute = $(".start_minute").val();
	var end_date = $(".end_date").val();
	var end_hour = $(".end_hour").val();
	var end_minute = $(".end_minute").val();
	//alert(  titleVal  ); return;
	
	//====================================
	// 이전에 입력한 일정제목과 현재 수정할 일정제목이 동일한 경우 
	//====================================
	if( oriVal == titleVal && oriSDate == start_date && oriSHour == start_hour && oriSMinute == start_minute &&
			oriEDate == end_date && oriEHour == end_hour && oriEMinute == end_minute 	
	  ){
		 	alert("일정 내용이 이전과 동일합니다..!!");
			return;
		
	}
	
/* 
	
	//====================================
	// 날짜 수정 시 유효성 체크 
	//====================================	
	  var sdv = $(".start_date").val();
	  var edv = $(".end_date").val();
	
	  var sh = $(".start_hour").val( );
	  var sm = $(".start_minute").val( );
	  var eh = $(".end_hour").val( );
	  var em = $(".end_minute").val( ); */

	  //====================================
	  // 일정 제목 , 날짜선택이 모두 입력됬다면 
	  //====================================
	  if( titleVal != "" && start_date != "" && end_date != ""  ){
	      
		  if( (  start_hour =="" && start_minute =="" && end_hour =="" && end_minute =="" ) || 
			  (   start_hour !="" && start_minute !="" && end_hour !="" && end_minute !="" ) 
			){
			  
		  
			  if( start_date+start_hour+start_minute > end_date+end_hour+end_minute ){
				alert("시작 날짜가 더 큽니다..!!"); return;
			  }
		
		
		
		
		
		
			$.ajax(  
					{   
						
					    url:"/calUpProc.do"	
					    ,type:"post"
					    ,data:$("[name='calDetailForm']").serialize()  
					    
					    ,success:function( cnt ){	
					    	if( cnt == 1 ){
					    		alert("해당일정 수정 완료!"); 
					    		opener.location.reload();
					    		self.close();
					    		return;
					    	}	
					    }
						 
				        //----------------------------------------
					    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
					    //----------------------------------------
				        ,error:function(){ alert("[ calUpProc.do ] 웹서버 접속 실패! 관리자에게 문의 바람!"); }  
					}
			);
	
		 }
		  else{ alert("시간 설정을 정확히 기입해주세요!!!"); return; }	
			
			
			
	  } else{ alert("일정제목 또는 날짜 선택을 확인해주세요."); }
	
	
}

function scheduleDeldat(){
	
	if(confirm("해당 일정을 삭제하시겠습니까?") == false ){
		return;
	}
	
	$.ajax(   
			{   
				
			    url:"/calDelProc.do"	
			    ,type:"post"
			    ,data:$("[name='calDetailForm']").serialize()  
			    
			    ,success:function( cnt ){	
			    	if( cnt == 1 ){
			    		alert("해당일정 삭제 완료!"); opener.location.reload();
			    		self.close();
			    		return;
			    	}	
			    	else if( cnt ==  2 ){
			    		alert("공유한 일정은 삭제할 수 없습니다.");
			    		// 받는 사람이 알림에서 거절 시  삭제 가능! 
			    		
			    		// 공유한 일정도 바의 색깔을 바꾸게 하면 더 좋을텐데~
			    	}
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);
}

</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/serve.css">
</head>
<body>

<section id="section2"> 
	<article class="section2_information">
	
<form name="get_cal_info">
     <input type="hidden" name="cal_no" class="cal_no">
</form>



<form name="calDetailForm" method="post" action="">
<center>
   
   <!-- 얘 두개는 공유하기 할때도 쓰일 거 그래서 id값 줌. -->
   <input type="hidden" name="uid" class="uid" id="uid"  value="${sessionScope.uid}">
   <input type="hidden" name="cal_no" class="cal_no" id="cal_no">
   
   <!-- 기존에 내용과 같을 경우 경고 띄워주기 위한 기존데이터 보관용 -->
   <input type="hidden" name="origiVal" class="origiVal" value="">
   <input type="hidden" name="origi_s_date" class="origi_s_date" value="">
   <input type="hidden" name="origi_s_hour" class="origi_s_hour" value="">
   <input type="hidden" name="origi_s_minute" class="origi_s_minute" value="">
   <input type="hidden" name="origi_e_date" class="origi_e_date" value="">
   <input type="hidden" name="origi_e_hour" class="origi_e_hour" value="">
   <input type="hidden" name="origi_e_minute" class="origi_e_minute" value="">
   
    <h3><b>일정 상세보기</b></h3>
 
	<table border="0" cellpadding="5" cellspacing="0">
		<!-- ================================================================== -->	
		<tr>
			<td> 일정
		<tr>
			<td> <textarea  name="subject" id="subject" class="subject"  value="" placeholder="일정 입력" 
			      onfocus="this.placeholder=''" onblur="this.placeholder='일정 입력'"></textarea>
		<!-- ================================================================== -->	
		<tr>
			<td> 시작 날짜
		<tr>
			<td> <input type="date" name="start_date" class="start_date">
			     <select name="start_hour" id="start_hour" class="start_hour">
			     	<option value="" />-시간-
			     </select> 
			     
			     <select name="start_minute" id="start_minute" class="start_minute">
			     	<option value="" />-분-
			     	<option value="00" />00분
			     	<option value="15" />15분
			     	<option value="30" />30분
			     	<option value="45" />45분
			     </select>
		<!-- ================================================================== -->	
		<tr>
			<td> 끝 날짜
		<tr>
			<td> <input type="date" name="end_date" class="end_date">
			     <select name="end_hour" id="end_hour" class="end_hour">
			     	<option value="" />-시간-
			     </select> 
			     
			     <select name="end_minute" id="end_minute" class="end_minute">
			     	<option value="" />-분-
			     	<option value="00" />00분
			     	<option value="15" />15분
			     	<option value="30" />30분
			     	<option value="45" />45분
			     </select>
		
		<tr>
			<td>일정 공유/완료
		
	</table>
</article> 	
    <div style="height:7px;"></div>
    
   	<article class="section22_btn"> 
   		<input type="button" value="일정공유" class="cal_sharing">
   		<input type="button" value="일정완료" class="cal_complet">
	</article>
	   	<article class="section2_btn"> 
	    <input type="button" value="수정" class="update">
	    <input type="button" value="삭제" class="delete">
	    <input type="button" value="닫기" class="close">
	</article>
	
	
</center>


</section>


</form>

</body>
</html>