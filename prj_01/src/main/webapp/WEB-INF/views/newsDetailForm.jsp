<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이지에서 사용할 [사용자 정의 태그]의 한 종류인 [JSTL의 C 코어 태그]를 사용하겠다고 선언-->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
    <!-- 
         --------------------------------------
         [ 사용자 정의 태그 = Custom tag ] ?
         --------------------------------------
             사용자가 자바로 원하는 기능을 구현하고 [HTML 태그 형태]로 
             표현하여 사용할 수 있는 [사용자 정의 태그]를 말한다. 
     -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 상세보기</title>

<style>
    .font_test1 { text-decoration:line-through }
</style>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

 var s_no = opener.document.getElementById("share_no").value;
 


 
 
 
 
$(function(){
	

	
	  var num = $("[name='startDataForm']").find(".share_no");
	  num.val( s_no );
	    
	  if( true ){
	
		    //=============================
		    // 클릭한 행의 pk넘으로 데이터 가져오기	
			//=============================
			$.ajax(   
					{   
						
					    url:"/newsDetailProc.do"	
					    ,type:"post"
					    ,data:$("[name='startDataForm']").serialize()  
					    
					    ,success:function( json ){	
					    		
					    	var cal_no = json["calendar_no"];
					    	var share_no = json["share_no"];
					    	var name = json["emp_name"];
					    	var subject = json["subject"];
					    	var sendTime = json["timesent"];
					    	var jikup = json["jikup"];
					    	
					    	$(".cal_no").val( cal_no );
					    	$(".share_no").val( share_no );
					    	$(".theSender").val( name + " " +  jikup + " 님" );
					    	$(".subject").val( subject );
					    	$(".timeSent").val( sendTime );
					    }
						 
				        //----------------------------------------
					    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
					    //----------------------------------------
				        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
					}
		    );
	
	  }
	
	
	// 텍스트에어리어 에 바로 안박혀서 여기서 박아둠.
	$("[name='newsDetailForm']").find(".subject").val( "${requestScope.shareOneList.subject}" );
	
	
    // 수락 클릭 시 
    $(".yes").click(function(){
    	acceptSchedule();
    })
    
    // 거절 클릭 시 
    $(".no").click(function(){
    	rejectSchedule();
    })
    
    // 닫기 클릭 시 
    $(".back").click(function(){
    	goNewsList();
    }) 
})

// 수락 시 받은 일정 번호를 가지고 내일정에 인설트 때리기
function acceptSchedule(){
	
	
	//=============================
	// 1. 먼저 cal_no 으로 해당 데이터 끌어온다.	
	//=============================
	$.ajax(   
			{   
				
			    url:"/getCalInfo.do"	
			    ,type:"post"
			    ,data:$("[name='newsDetailForm']").serialize()  
			    
			    ,success:function( json ){	
			    	var subject = json["cal_title"];
			    	var start_date = json["cal_start"];
			    	var end_date = json["cal_end"];
			    	
			    	var obj = $("[name='rowDateForm']");
			    	obj.find(".subject").val( subject );
			    	obj.find(".start_date").val( start_date );
			    	obj.find(".end_date").val( end_date );
			    	
					    	//=============================
					    	// 2. 끌어온 데이터 가지고 인설트 때린다.	
					    	//=============================
					    	$.ajax(   
					    			{   
					    				
					    			    url:"/calInsert2.do"	
					    			    ,type:"post"
					    			    ,data:$("[name='rowDateForm']").serialize()  
					    			    
					    			    ,success:function( cnt ){	
					    			    	if( cnt == 1 ){
					    			    		alert("일정이 등록되었습니다."); 
					    			    		        //======================================
							    			    		// 카고 바로 삭제해서 알림 수 줄이기 
					    			    		        //======================================
							    			    		$.ajax(   
							    			    				{   
							    			    					
							    			    				    url:"/calShareDelProc.do"	
							    			    				    ,type:"post"
							    			    				    ,data:$("[name='newsDetailForm']").serialize()  
							    			    				    
							    			    				    ,success:function( cnt ){	
							    			    				    	if( cnt == 1 ){
							    			    				    		opener.location.reload();
							    			    				    		goNewsList();
							    			    				    		
							    			    				    	}	
							    			    				    }
							    			    					 
							    			    			        //----------------------------------------
							    			    				    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
							    			    				    //----------------------------------------
							    			    			        ,error:function(){ alert("수락 후 일정 등록 후 삭제 시 웹서버 접속 실패! 관리자에게 문의 바람!"); }  
							    			    				}
							    			    		);
					    			    	}	
					    			    }
					    				 
					    		        //----------------------------------------
					    			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
					    			    //----------------------------------------
					    		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
					    			}
					    	);
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);
	
     
	

	
	
	
	
	
	
}

// 거절 시 받은 메시지를 삭제 하는 델리트 때리기 
function rejectSchedule(){
	
	$.ajax(   
			{   
				
			    url:"/calShareDelProc.do"	
			    ,type:"post"
			    ,data:$("[name='newsDetailForm']").serialize()  
			    
			    ,success:function( cnt ){	
			    	if( cnt == 1 ){
			    		alert("일정 공유 거절 완료!!"); 
			    		opener.location.reload();
			    		goNewsList();
			    		
			    	}	
			    }
				 
		        //----------------------------------------
			    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
			    //----------------------------------------
		        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
			}
	);
}


function goNewsList(){
	
	// 지금은 로케이션으로 가지만 
	// 알림에 검색 또는 솔트 추가 시에는 도큐먼트로 ㄱ 
	self.close();
	
}


</script>     

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/serve.css">
</head>
<body>

<form name="startDataForm" >

	<input type="hidden" name="share_no" class="share_no" >	

</form>



<!-- 수락 시 인풋때릴 때 가져갈 데이터  -->
<form name="rowDateForm">

     <input type="hidden" name="subject" class="subject">
     <input type="hidden" name="start_date" class="start_date">
     <input type="hidden" name="end_date" class="end_date">
		

</form>

<section id="section2"> 

<!-- 일정 공유 폼태그 -->
<form name="newsDetailForm" method="post" action="">
	<article class="section2_information">
<center>
   
   <!-- 일정 수락 시 인풋 할 달력 번호   -->
   <input type="hidden" name="cal_no" class="cal_no" value="">
   
   <!-- 일정 거절 시 공유테이블에 메시지 보낸 행 제거  -->
   <input type="hidden" name="share_no" class="share_no" value="">
   
   
    <h3><b>알림</b></span></h3>
 
	<table name="messageTbl" border="0" cellpadding="5" cellspacing="0"  width="10%">
		<caption></caption>
		<!-- ================================================================== -->	
		<tr>		    
			<td> 보낸이
		<tr>	
			<td><input type="text" name="theSender" class="theSender" value="" readonly>
		<tr>
		    
			<td> 메시지
		<tr>
		    <td><textarea name="subject" class="subject" style="width:266px;height:126px;" readonly>
		        </textarea>
		<tr>    
			<td> 보낸 시각
		<tr>
			<td><input type="text" name="timeSent" class="timeSent" value="" readonly>
	
			
	</table>
    </article> 
 
    <div style="height:7px;"></div>
    
   <article class="section2_btn">
	    <input type="button" value="수락" class="yes">
	    <input type="button" value="거절" class="no">
	    <input type="button" value="닫기" class="back">
   </article>
   
   </center>
</section>

</form>

</body>
</html>