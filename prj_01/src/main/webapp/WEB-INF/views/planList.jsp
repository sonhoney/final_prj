<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='/text/calender.css' rel='stylesheet' />
<script src='/text/main.js'></script>
<script src='/text/ko.js'></script>
<script src="/js/jquery-1.11.0.min.js"></script>
<style>

  .mouseOnTrBgC{background-color:pink;}

  body {
    margin: 40px 10px;
    padding: 0;    
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

</style>

<!-- 스타일 설정 -->

<style type="text/css">

.bgLayer {display:none;position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50); z-index:10;}  /* z-index가 10이다. 이보다 위에 보이기 위해선 팝을 이보다 크게 설정해야한다. */

</style>
	

<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.min.js"></script>

<script>

//var json = [  ];

// 무조건 이 형태로 줘야 함.
//json =  [{title:"야줘바!",start:"2022-11-29"}]

$(function(){
	$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
		});
	//=============================================
	// 알림창에 알림이 없다면 테이블 태그 숨기고 아래와 같은 문구 나타내기
	//=============================================
	if( ${empty requestScope.shareList} ){
		$("[name='messageTbl']").hide();
		$(".subject").text( "받은 알림이 없습니다..." );
	}
	

	//=============================================
	// 검색 버튼 클릭 시 검색 키워드 공백제거 후 웹서버에 
	// 접근 하는 함수 호출 .
	//=============================================	
	$(".boardSearchBtn").click(function(){
		goSearch();
	})
	
	// 검색한 키워드 흔적 남기기
	<c:if test="${!empty param.keyword}">
		$(".keyword").val( "${param.keyword}" );
	</c:if>
	
	
	// 검색한 페이지 흔적 남기기 
	<c:if test="${!empty param.selectPageNo}">
		$(".selectPageNo").val( "${param.selectPageNo}" );
	</c:if>	
	
	
	//=============================================
	// 알림창에서 페이징 시 알림창을 계속 보이게 하고 
	// , 배경을 어둡게 유지 하는 녀석들. 
	//=============================================
	var flag = true;	
	if( flag ){
		
			if( "${requestScope.alim}" == "yes" ){
				
				var list = document.getElementById("list");
				
				list.style.visibility = "visible";
			}
		
			if( "${requestScope.dark}" == "yes" ){
				
				bgLayerOpen();
			}
	
	}
	
	//=============================================
	// 알림창에서 보낸 사람/시각 헤더 클릭 시 sort
	//=============================================	
	// 솔트 쪽이 좀 애매하다 
	// 이름이 다양하게 없어서 그렁가 
	// 데이터 쭉쭉 넣어 보고 해보자! 
		
	$(".sortHeader").click(function(){
		var thisObj = $(this);
		var text = thisObj.text().trim();
		var sortObj =  $(".sort");
		//-----------------------------------------------
		if( text == "보낸사람" ){ sortObj.val( "3 asc" ); }
		else if( text == "보낸사람▲" ){ sortObj.val( "3 desc" ); }
		else if( text == "보낸사람▼" ){ sortObj.val( "" ); }
		//-----------------------------------------------
		if( text == "보낸시각" ){ sortObj.val( "5 asc" ); }
		else if( text == "보낸시각▲" ){ sortObj.val( "5 desc" ); }
		else if( text == "보낸시각▼" ){ sortObj.val( "" ); }
		//-----------------------------------------------
		goSearch();
	})	
		
	<c:if test="${!empty param.sort}">
		
		$(".sort").val( "${param.sort}" );
		
		$(".sortHeader").each(function(i){
			
			var thisObj = $(this);
			var text = thisObj.text().trim();
			text = text.replace("▲","").replace("▼","");
			thisObj.text( text );
			
			if( "${param.sort}" == "3 asc" && text == "보낸사람" ){
				thisObj.append("▲");
			}
			else if( "${param.sort}" == "3 desc" && text == "보낸사람" ){
				thisObj.append("▼");
			}
			else if( "${param.sort}" == "5 asc" && text == "보낸시각" ){
				thisObj.append("▲");
			}
			else if( "${param.sort}" == "5 desc" && text == "보낸시각" ){
				thisObj.append("▼");
			}
			
			
		})
		
		
	
	</c:if>
	
	
   
	
	$(".xxx").hover(
			
		function(){
			$(this).addClass("mouseOnTrBgC");
		}
		,	
		function(){
			$(this).removeClass("mouseOnTrBgC");
		}
	)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}) //  여가 바디태그 읽고 난 후 실행되는 자스 끝나는 블록지점@@@@@@@@@@@@@@@@@@@@@@@@@@

document.addEventListener('DOMContentLoaded', function() {
	  
	  
	  var arr = [];

	 
	  <c:forEach var="xxx" items="${requestScope.calendarList}" varStatus="loopTagStatus">
	  	        
	     arr.push( {  title:"${xxx.title}", start:"${xxx.start}", end:"${xxx.end}" , id : "${xxx.cal_no}" , color : "${xxx.youmoo == 1 ? 'red' : '' || xxx.youmoo == 0 ? 'skyblue' : '' || xxx.youmoo == 2 ? 'lightgray':'' }" } );                                     
	                                                                                           
	  
	  </c:forEach> 
	  
        // [cal_no: ]
	  
  var calendarEl = document.getElementById('calendar');
  var i = 0;
  var today = new Date();
  var list = new Array();
  console.log("list = ", list);
  var calendar = new FullCalendar.Calendar(calendarEl, {
  	locale : "ko",
    headerToolbar: {
      left: 'prev,next today', // 원래는 =>  'prev,next today'
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay' // 원래는 =>  'dayGridMonth 월, timeGridWeek 주 ,timeGridDay 일'
    },
    initialDate: today,
    navLinks: true, // can click day/week names to navigate views
    selectable: true,
    selectMirror: true,

    select: function(arg) {
  	  //console.log( arg );
  	
  	if( arg.startStr.indexOf("T") >= 0 ){
   		var start_hour = arg.startStr.substr(11,2);
  		var start_minute = arg.startStr.substr(14,2);
  		var end_hour = arg.endStr.substr(11,2);
  		var end_minute = arg.endStr.substr(14,2); 
  		
  		var start_date = arg.endStr.substr(0,10);
  		var end_date = arg.endStr.substr(0,10);
  		
  		
  		//★★★★★★★★★★★★12/10 새뱍 2:57 바꾼 거 
  		
   		$("[name='start_hour']").val( start_hour );
  		$("[name='start_minute']").val( start_minute );
  		$("[name='end_hour']").val( end_hour ); 
  		$("[name='end_minute']").val( end_minute ); 
  		
      	$("[name='select_start_date']").val( start_date );
      	$("[name='select_end_date']").val( end_date );
  	}
  	else{
          // 월에서 일정 날짜 클릭하면 하루 처음 부터 끝까지 시간이 계산이 되기에 
          // 월에서 일정 등록 시에는 00시 00분 넣기
      	$("[name='select_start_date']").val( arg.startStr );
      	$("[name='select_end_date']").val( arg.endStr );
      	
      	//★★★★★★★★★★★★12/10 새뱍 2:57 바꾼 거 
      	
   		$("[name='start_hour']").val( "" );
  		$("[name='start_minute']").val( "" );
  		$("[name='end_hour']").val( "" ); 
  		$("[name='end_minute']").val( "" ); 
      	
  	}
  	
  	
  	calInput( arg );
  	
      var title = false;        //prompt('일정 제목:');
      //console.log("arg.start = ",arg.start ,"arg.end = ",arg.end  );
      if (title) {
        calendar.addEvent({
           title: title,
          start: arg.start,
          end: arg.end,
          //allDay: arg.allDay
        })
      //▶▶▶▶▶▶▶▶▶▶▶▶Controller 호출구간
       console.log( "allDay = ", allDay );
      
        $(".subject").val( title );
        $(".startDay").val( arg.startStr );
        $(".endDay").val( arg.endStr );
      
        //xxx();
      
      
      
      
      //▶▶▶▶▶▶▶▶▶▶▶▶Controller 호출구간  
      } 
      calendar.unselect()
    },
    
    eventClick: function(arg) {
  	  console.log(arg);

	  
  	  
  	  // 자식창에 보낼 벨루 값을 지니고 있는 id=pTtitle 인 녀석의 메위주를 가져와서 
  	  var pkNum =  $("#pkNum");
  	  var pTitle = $("#pTitle");
  	  // 이 어두컴컴한 곳에서는 클릭할 때 이벤트에 박힌 정보에 테이블 pk 를 가지고 올수 없어서
  	  // 꼼수 부리기 
  	  var choiceScheduleNum = arg.event.id 
  	  var choiceScheduleStr = arg.event.title
  	  //alert( choiceScheduleNum + "/" + choiceScheduleStr ); return;
  	 
  	  pTitle.val( choiceScheduleStr );
  	  // 벨루 값을 현재 선택한 일정 제목을 박아주고 
  	  pkNum.val( choiceScheduleNum );
  	  // 함수호출 
  	  parentValThrow( arg );
  	  // arg.event.title  제목 

  	  //console.log( arg ); // arg == info
    }
    
    // 파란바 클릭 시 삭제 버튼
    /*
    eventClick: function(arg) {
      if (confirm('선택한 일정을 삭제하시겠습니까?')) {
        arg.event.remove()
        
        //---------------------------------------------------
        // 현재 지워버린 일정의 제목을 벨루값에 저장해서 비동기방식으로 
        // 웹서버에 접근할 때 던져줄꺼임.
        $("[name='takeForm']").find(".subject").val( arg.event.title );
        //---------------------------------------------------       
        yyy();
        //console.log( arg.event.title  );
      }
    }
    */
    
    
    ,
    editable: false,    // true 시 일정바를 옮길 수 있음. 
    dayMaxEvents: true, // allow "more" link when too many events
    
   
    // 이벤츠 자리에 내가 가져온 리스트를 JSON 형태로 변수에 담아서 던져주면 
    // 가능할 것 같다. 
    // 이벤트를 넣어주는 가장 중요한 내시키..!
    events: arr
  	  
  	  //arr
  	  
  	  
  	  //[{title:"hi",start:"2022-12-06T14:20:20",end:"2022-12-06T15:20:00"}]   
  	  
    // [{title:"hi",start:"2022-12-06T14:20:20",end:"2022-12-06T15:20:00"}] 
    // 이렇게 박으면 시간이 하루종일로 안박히고 쪼그만하게 찍힌다.
    
    
  });
  calendar.render();
});

//=================================================
//일정 등록 시 팝업창 띄우기 
//=================================================
function calInput( arg ){

	
	var screenX = arg.jsEvent.screenX ;
  var screenY = arg.jsEvent.screenY ; 
	
	// 잠시 재우고 
/* 	var ssd = $("[name='select_start_date']");
	var sed = $("[name='select_end_date']");
	
	openWin.document.getElementById("start_date").value = ssd.val();
	openWin.document.getElementById("end_date").value = sed.val(); */
	

	 // 테스트 용 좌표 => "width=400,height=550,top=250,left=800"
	// 테스트 끝나면 좌표 이걸로 => "width=400,height=550,top="+ screenY +",left="+ screenX
	var openWin = window.open("/calInputPop.do","일정등록 화면","width=500,height=550,top="+ screenY +",left="+ screenX);
	
  
}




//=================================================
//일정 관리 상세보기 팝업창 띄우기 
//================================================= 

function parentValThrow( arg ){
		
	  
	var screenX = arg.jsEvent.screenX ;
  var screenY = arg.jsEvent.screenY ; 
  
// 테스트 용 좌표 => "width=400,height=550,top=250,left=800"		
// 테스트 끝나면 좌표 이걸로 => "width=400,height=550,top="+ screenY +",left="+ screenX
	var openWin = window.open("/calPopup.do","일정관리 상세보기","width=500,height=550,top="+ screenY +",left="+ screenX );
                            


	// 부모창에서 자식창에 벨루 값을 박아주기.
	//openWin.document.getElementById("cTitle").value = document.getElementById("pTitle").value;
	console.log( document.getElementById("pTitle").value  );
		
	
		
}  

//============================================================================== 
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■	
//알림 클릭 시 이뤄지는 모든 함수들  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//==============================================================================  

function message(){
	
	var list = document.getElementById("list");
	
	list.style.visibility = "visible";
	
	bgLayerOpen();
		
}  

function msgClose(){ 
	
	var list = document.getElementById("list");
	
	list.style.visibility = "hidden";
	 	
	bgLayerClear();
	
	location.replace("/planList.do");
}


//알림창에 상세보기 화면으로 가는 
function goMessageDetailForm( num ){
	
	// 일단 여기서는 잘들어옴. 
	//alert( num ); return;
	
	var detailObj = $("[name='newsDetailForm']");
	
	detailObj.find(".share_no").val( num );
	
	//alert( $(".share_no").val() ); return;
	
	window.open("/newsDetailForm.do","일정관리 상세보기","width=800,height=550,top=200,left=820" );
	   
	//document.newsDetailForm.submit();
	
}

//선택한 페이지 번호로 이동 시키는 
function goPageNo( pageNum ){
	
	
	$(".selectPageNo").val( pageNum );
	
	// 페이지 이동 시에만 name = alim 의 벨루 값을 넘겨주어 
	// 다시 이 페이지로 올 때 알림창을 보이게 하기.
	$(".alim").val( "yes" );
	
	// 페이지 이동 시에만 name = dark 의 벨루 값을 넘겨주어 
	// 다시 이 페이지로 올 때 배경 어둡게 하기.
	$(".dark").val( "yes" );
	
	document.calShareForm.submit();
	
}




//검색한 결과물 가지고 다시 이페이지로 
function goSearch(  ){
	
	var keyword = $(".keyword").val( );
	if( typeof(keyword) != "string" ){ keyword = ""; }
	
	keyword = $.trim(keyword);
	
	/* if( keyword == "" ){
		alert( "검색할 키워드를 기입하십시오." );
		$(".keyword").focus();
		return;
	} */
	
	
	// 페이지 이동 시에만 name = alim 의 벨루 값을 넘겨주어 
	// 다시 이 페이지로 올 때 알림창을 보이게 하기.
	$(".alim").val( "yes" );
	
	// 페이지 이동 시에만 name = dark 의 벨루 값을 넘겨주어 
	// 다시 이 페이지로 올 때 배경 어둡게 하기.
	$(".dark").val( "yes" );
	

	// 선택 눌렀을 때 체크 란이 나오는걸 유지하게 하려고 
	// $(".c_box").val( "yes" );
	
	document.calShareForm.submit();
	
}

//검색한 결과물 가지고 다시 이페이지로 
function SearchInit(  ){
	
	$(".keyword").val("");
	$(".sort").val("");
	$(".selectPageNo").val("1");
	
	// 페이지 이동 시에만 name = alim 의 벨루 값을 넘겨주어 
	// 다시 이 페이지로 올 때 알림창을 보이게 하기.
	$(".alim").val( "yes" );
	
	// 페이지 이동 시에만 name = dark 의 벨루 값을 넘겨주어 
	// 다시 이 페이지로 올 때 배경 어둡게 하기.
	$(".dark").val( "yes" );
	
	document.calShareForm.submit();
	
}



function goThisDel( num ){
	
	var detailObj = $("[name='newsDetailForm']");
	
	detailObj.find(".share_no").val( num );
	
	if( confirm("해당 일정 알림을 삭제할까요?") ){
		
		
		$.ajax(   
				{   
					
				    url:"/calShareDelProc.do"	
				    ,type:"post"
				    ,data:$("[name='newsDetailForm']").serialize()  
				    
				    ,success:function( cnt ){	
				    	if( cnt == 1 ){
				    		// alert("일정알림 삭제 완료!!"); 
				    		
				    		// 페이지 이동 시에만 name = alim 의 벨루 값을 넘겨주어 
				    		// 다시 이 페이지로 올 때 알림창을 보이게 하기.
				    		$(".alim").val( "yes" );
				    		
				    		// 페이지 이동 시에만 name = dark 의 벨루 값을 넘겨주어 
				    		// 다시 이 페이지로 올 때 배경 어둡게 하기.
				    		$(".dark").val( "yes" );
				    		
				    		document.delToExistingScreen.submit();
				    		
				    	}	
				    }
					 
			        //----------------------------------------
				    // 웹서버와 통신한 후 웹서버의 응답을 실패할 경우 실행할 익명함수 설정.
				    //----------------------------------------
			        ,error:function(){ alert("웹서버 접속 실패! 관리자에게 문의 바람!"); }  
				}
		);
		
		
	}
		
}  



//============================================================================== 
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//==============================================================================  

<!-- 불투명 배경 생성 함수 -->

function bgLayerOpen() {
  if(!$('.bgLayer').length) {
      $('<div class="bgLayer"></div>').appendTo($('body'));
  }
  var object = $(".bgLayer");
  var w = $(document).width()+12;
  var h = $(document).height();

  object.css({'width':w,'height':h}); 
  object.fadeIn(0);   //생성되는 시간 설정
}

<!-- //불투명 배경 생성 함수 -->



<!-- 불투명 배경 제거 함수 -->

function bgLayerClear(){
  var object = $('.bgLayer');

	if(object.length) {
		    object.fadeOut(0, function() {
		    object.remove();
		
		    });
	
	    }

}
<!-- //불투명 배경 제거 함수 -->	
	
<% String emp_name = (String)session.getAttribute("emp_name");%> 
</script>


<!-- 스타일 설정 -->



<!-- //스타일 설정 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/css/main.css" >	
</head>
<body class="is-preload">
 	<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<header id="header">
									<strong>일정관리</strong><span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>
									
								</header>
 
 
  <!-- 일정 입력 시 자식창에서 입력하는데 자식창에서 가져다 쓸 현재 일정클릭한 데이터들 -->
  <form>
  
  		<input type="hidden" name="select_start_date" id="select_start_date" value="">
  		<input type="hidden" name="select_end_date" id="select_end_date" value="">
		
  	   	<input type="hidden" name="start_hour" id="start_hour" value="">
  		<input type="hidden" name="start_minute" id="start_minute" value="">
  		<input type="hidden" name="end_hour" id="end_hour" value="">
  		<input type="hidden" name="end_minute" id="end_minute" value="">
  
  </form>
  
 
  <!-- 수정 삭제시 팝업 열고 pk번호 를 박기 위해 만들어둠. -->
  <input type="hidden" name="pkNum" id="pkNum" value="">
  <input type="hidden" name="pTitle" id="pTitle" value="">

  <form name="takeForm" method="post" action="/scheduleDeleteProc.do">
        <input type="hidden" name="subject" class="subject">
  </form>
  
<!--


  <form name="giveForm" method="post" action="/scheduleInsertProc.do">
  
  		<input type="hidden" name="uid" class="uid" value="${sessionScope.uid}">
  		<input type="hidden" name="subject" class="subject">
  		<input type="hidden" name="startDay" class="startDay">
  		<input type="hidden" name="endDay" class="endDay">
  		
  	
  		<table>
  		<caption></caption>
              <tr><th>사원번호<th>제목<th>시작<th>끝
              
              <c:forEach var="hi" items="${requestScope.calendarList}" varStatus="loopTagStatus">
              		<tr>
              			<td>${loopTagStatus.index+1}
              			<td>${hi.title}
              			<td>${hi.start}
              			<td>${hi.end}
              </c:forEach>
                   		 SQL 구문에서 별칭을 주는 이유는 
                   		     자바에서 키값 || 속성변수 로 빼기위해 
                   		     
                   		     또는 JSP , JS 에서 자바문법 또는 EL문법으로 뺄 때
                   		 
  		</table>
  
  </form> -->


  <center>
  <font size="5" color="#000000">알림확인 &nbsp;&nbsp;</font>
        <span style="cursor:pointer" onClick="message()"><img src="/tresh/alim_img.ico" width="25"/><b style="color:red">${requestScope.ListCnt}</b></span>
        
  </center>
  
  
  <form name="newsDetailForm" method="post" action="/newsDetailForm.do">
		<input type="hidden" name="share_no" class="share_no" id="share_no">
		
  </form>
  
  
  
  <form name="delToExistingScreen" method="post" action="/planList.do">
        <input type="hidden" name="selectPageNo" class="selectPageNo" value="1" />
        <input type="hidden" name="alim" class="alim" value="">
		<input type="hidden" name="dark" class="dark" value="">
  
  </form>
  
  
  
  
  
  <div id="list" style="position:absolute; visibility:hidden;
   background-color:white; z-index:11; width:570px; top:250px; left:920px; ">  <!--  display:none; -->
  		                                     <!-- 현재 div  -->
  		
  		
  		
				  	<!-- 일정 공유 폼태그 -->
				    <form name="calShareForm" method="post" action="/planList.do">
				
				    <input type="hidden" name="alim" class="alim" value="">
		            <input type="hidden" name="dark" class="dark" value="">
				    
				   
				   <input type="hidden" name="uid" class="uid" id="uid"  value="${sessionScope.uid}">
				   
				   <!-- 이녀석으로 해당 일정 삭제 시 쓰일 거  -->
				   <input type="hidden" name="cal_no" class="cal_no" id="cal_no">
				   
				   
				   
				    
				    
				    <div class="alram"><span style="cursor:pointer" onclick="msgClose()"><b style="color:red"> [알람 접기] </b></span></div>
				    
				    <div style="height:10px;"></div>
				    <article class="search">
				    
				    [키워드] : <input type="text" name="keyword" class="keyword"  size="7"/> &nbsp;
				    <input type="button" value=" 검색 " class="boardSearchBtn"  />&nbsp;
				    <input type="button" value=" 초기화 " class="SearchInitBtn" onClick="SearchInit()" />
				    
				    <input type="hidden" name="selectPageNo" class="selectPageNo" value="1" />
				    <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="5" />
				    <input type="hidden" name="sort" class="sort" value="" />
				    
				    <!-- 검색된 결과물이 없을 경우 -->
				    <c:if test="${empty requestScope.shareList}">
				            
				    		<h4>검색된 결과물이 없습니다.</h4>
				    
				    </c:if>
				    </article>
				    <div style="height:7px;"></div>
				    
	               
				    
					<table name="messageTbl" border="0" cellpadding="30" cellspacing="0"   border="1" >
						<caption></caption>
						<!-- ================================================================== -->	
						<tr style="background-color:#f56a6a">
						
						    
						    
						    <th align="center">번호
							<th align="center"><span style="cursor:pointer;" class="sortHeader" >보낸사람</span> 
							<th align="center">메시지
							<th align="center"><span style="cursor:pointer;" class="sortHeader" >보낸시각</span>
							<th>
							
							
						 <c:forEach var="list" items="${requestScope.shareList}" varStatus="loopTagStatus">
						 
						 <tr class="trline">  
				        
				            
				            
				            <td align="center" style="cursor:pointer"
				             onClick="goMessageDetailForm(${list.share_no})">${ requestScope.pagingMap.serialNo_desc - loopTagStatus.index }
						 	
						 	<td align="center" style="cursor:pointer"
				             onClick="goMessageDetailForm(${list.share_no})">${list.emp_name}
						 	
						 	<td align="center" style="cursor:pointer"
				             onClick="goMessageDetailForm(${list.share_no})">${list.title}
						 	
						 	<td align="center" style="cursor:pointer"
				             onClick="goMessageDetailForm(${list.share_no})">${list.timesent}
				
				            <td align="center" style="cursor:pointer"
				             onClick="goThisDel(${list.share_no})"> <span><img src="/tresh/favicon.ico"  width="20" height="20"/></span>
				
						 </c:forEach>		
							
					</table>				
	
				
				     
				     <div style="height:10px;"></div>
				     
				     
				     <center>
				    <!----------------------------
				      검색된 게시판이 존재한다면
				     ----------------------------->
				    <c:if test="${requestScope.ListTotCnt>0}">
				           
					           <!------------------------------------------------------------------>
					           <span style="cursor:pointer" onClick="goPageNo(1)">◀</span>
					           <span style="cursor:pointer" onClick="goPageNo(${requestScope.pagingMap.selectPageNo}-1)">◁</span>
					                   
					           <!---------------------------------------------------------------------- 
					                 얘같은 경우는 EL문법으로 표현한 데이터가 키값이기에 (Array 포함)
					                 따로 키값안에 데이터를 담을 지역변수 var=no 를 선언하고 
					                 step 같은경우엔 안줘도 1 씩 증가 하지만 2,3,4,~ 도 가능하고 
					                 FM 대로 적은것 뿐이다.    
					           ----------------------------------------------------------------------->
					           <c:forEach var="no" begin="${requestScope.pagingMap.begin_pageNo_perPage}" end="${requestScope.pagingMap.end_pageNo_perPage}" step="1">
					         
					                 
					                 <c:if test="${requestScope.pagingMap.selectPageNo!=no}">
					                 <span class="pageNo${no}" style="cursor:pointer" onClick="goPageNo(${no})">
					                 
					                    [${no}]
					                                
					                 </span> &nbsp;&nbsp;
					                 </c:if>
					                 
					                 <c:if test="${requestScope.pagingMap.selectPageNo==no}">
					                 <span>
					                 
					                    ${no}
					                                
					                 </span> &nbsp;&nbsp;
					                 </c:if>             
					                 
					           </c:forEach>
					           
					           <span style="cursor:pointer" onClick="goPageNo(${requestScope.pagingMap.selectPageNo}+1)">▷</span>
					           <span style="cursor:pointer" onClick="goPageNo(${requestScope.pagingMap.last_pageNo})">▶</span>
					           
					           
					           <!------------------------------------------------------------------>
				            
				   </c:if>
				 
				
				 
				 
				  <div style="height:10px;"></div>
				 
				   
				<!-- 
				<td align="center"> ${ loopTagStatus.index + 1 }
				onClick="goBoardDetailForm(${list.calendar_no})" -->
				  
				
				</form>
  				
  </div>
   
  
 
  <br><br>

  
  
<center>
<div class="modal__background">
  <div id='calendar'></div>
</center>		
			</section>
						</div>
					</div>

				<!-- Sidebar -->
					<div id="sidebar">
						<div class="inner">

							

							<%@include file="/WEB-INF/views/sideBar.jsp" %>

							

						</div>
					</div>

			</div>

		<!-- Scripts -->
			<script src="/js/jquery.min.js"></script>
			<script src="/js/browser.min.js"></script>
			<script src="/js/breakpoints.min.js"></script>
			<script src="/js/util.js"></script>
			<script src="/js/main.js"></script>	
			
		


</body>
</html>
