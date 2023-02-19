<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE HTML><html>
	<head>
	
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
	<script src="/ckeditor/ckeditor.js"></script>
	<script src="/ckeditor/ko.js"></script>
	<title>회의실 예약상세페이지</title>	
		<link rel="stylesheet" href="/css/main.css" />
	<!-- ******************************************************** -->
	<!--  JQuery 라이브러리 수입하기 -->
	<!-- ******************************************************** -->
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	
	
	<script>
            $(function(){
                
                defaultDate()

                
                //로그아웃
                $(".logoutBtn").click(
                function(){
                    if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
                    location.replace("/logout.do");
                });
                
                // 월 변경시 바뀐 월에 맞는 일수를 삽입하는 메소드 
                $(".min_month,.max_month").change(function(){

                    $(".min_day,.max_day").empty() ;
                    console.log( $(this).val() )
                    var min_date = $(".min_date")
                    var min_year = $(".min_year")
                    var min_month= $(".min_month")
                    var min_day = $(".min_day")
                    var date = new Date( min_year.val()   , $(this).val()  , 1-1 ) ; 
                    var lastDay = date.getDate();
                    
                    for(var i=1; i<=lastDay ; i++ ){
                     if( i<10){
                         $(".min_day").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                         $(".max_day").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                     }
                     else{
                         $(".min_day").append("<option value="+i+">"+i+"</option>")
                         $(".max_day").append("<option value="+i+">"+i+"</option>")
                     }
                 }

                    

                })
                 
             })
         
     
             // 예약 버튼 클릭시 비동기 방식으로 
             function reservBtnClick(){
                 
     
                 if( validCheck()==false ){ return ;} 
                 if( $(".room_code").val()=="" ){
                     alert("예약하실 회의실을 선택 해주세요.")
                     return ;
                 }
     
                 
                 $.ajax({
                     // 웹서버에 접속할 때 사용할 URL 주소 지정
                     url:"/meetingResProc.do"
                     ,type:"post"
                     ,data:$("[name='meetingResForm']").serialize() 
                     ,success:function(resCnt){
                         if(resCnt==1){
                             location.replace("/meetingBoardList.do")
                             return ;
                         }
                         
                     }
                     //----------------------------------------------------------
                     // 웹서버와 통신이 실패했을 경우 실행할 익명함수 설정.
                     //----------------------------------------------------------
                     ,error:function( ){
                         alert("웹서버 접속 실패! 관리자에게 문의 바람!");
                     }
                 })
                    
             }
     
             function getCanResRoom(){
                 
                  if( validCheck()==false ) { return ;}

                  
                  
                 
                     $.ajax({
                         // 웹서버에 접속할 때 사용할 URL 주소 지정
                         url:"/getCanResRoom.do"
                         ,type:"post"
                         ,data:$("[name='meetingResForm']").serialize() 
                         ,success:function(json){
                             if(json!=null){

                                $(".room_code").empty()

                                 for( var key in json){
                                     
                                     console.log( "키값 =>" +key +"// 데이터=>"+ json[key] )
                                     $(".room_code").append("<option value="+key+">"+json[key]+"</option>")
                                 }
                                 return ;
                                     
                             }
                             else{
                                 alert("예약 가능한 회의실이 없습니다. 날짜 또는 시간을 변경해주세요")
                                 return ;
                             }
                             
                         }
                         
                         
                         //----------------------------------------------------------
                         // 웹서버와 통신이 실패했을 경우 실행할 익명함수 설정.
                         //----------------------------------------------------------
                         ,error:function( ){
                             alert("웹서버 접속 실패! 관리자에게 문의 바람!");
                         }
                     })
                 
             }
     
             
     
             //취소 버튼 클릭시 회의실예약게시판으로 이동하는 함수
             function cancelBtnClick(){
                 location.replace("/meetingBoardList.do")
                 //document.meetingBoardList.submit();
             }
     
     
             function defaultDate(){
                 var dates = new Date( )
                 var year = dates.getFullYear() 
                 var month = dates.getMonth()+1
                 var day = dates.getDate()
                 var hour = dates.getHours() ;
                 $(".min_year").append("<option value="+year+">"+year+"</option>")
                 $(".max_year").append("<option value="+year+">"+year+"</option>")
                 $(".min_year").append("<option value="+(year+1)+">"+(year+1)+"</option>")
                 $(".max_year").append("<option value="+(year+1)+">"+(year+1)+"</option>")
                
                /*
                 if(month==12){ 
                     $(".min_year").append("<option value="+(year+1)+">"+(year+1)+"</option>")
                     $(".max_year").append("<option value="+(year+1)+">"+(year+1)+"</option>")
                 }
                */ 

                 $(".min_year").val(year)
                 $(".max_year").val(year)
                 
                 for(var i=1; i<=12 ; i++ ){
                     if(i<10){
                         $(".min_month").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                         $(".max_month").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                     }
                     else{
                         $(".min_month").append("<option value="+i+">"+i+"</option>")
                         $(".max_month").append("<option value="+i+">"+i+"</option>")
                     }
                 }
     
                 if( month<10 ){
                     $(".min_month").val("0"+month)
                     $(".max_month").val("0"+month)               
                 }
                 else{
                     $(".min_month").val(month)            
                     $(".max_month").val(month) 
                 }
     
                 var thisDay =  new Date( year, month , 1-1 )
                 var lastDay = thisDay.getDate() ;
                 for(var i=1; i<=lastDay ; i++ ){
                     if( i<10){
                         $(".min_day").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                         $(".max_day").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                     }
                     else{
                         $(".min_day").append("<option value="+i+">"+i+"</option>")
                         $(".max_day").append("<option value="+i+">"+i+"</option>")
                     }
                 }
     
                 if(day<10){
                     $(".min_day").val("0"+day)
                     $(".max_day").val("0"+day)
                 }
                 else{
                     $(".min_day").val(day)
                     $(".max_day").val(day)
                 }
     
                 
                 for(var i=9 ; i<=20 ; i++){
                     if(i==9){
                         $(".min_hour").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                         $(".max_hour").append("<option value="+"0"+i+">"+"0"+i+"</option>")
                     }
                     
                     else{
                         $(".min_hour").append("<option value="+i+">"+i+"</option>")
                         $(".max_hour").append("<option value="+i+">"+i+"</option>")
                     }
                 }
                 
                 
             }
     
             function changeDate1(){
                $(".room_code").empty()
                 //min_day,min_hour,max_day,max_hour
                 var min_year = $(".min_year")
                 var min_month = $(".min_month")
                 var min_day = $(".min_day")
                 var min_hour= $(".min_hour")
     
                 var max_year=$(".max_year")
                 var max_month=$(".max_month")
                 var max_day = $(".max_day")
                 var max_hour =$(".max_hour")
     
                 var min_yearVal = min_year.val()
                 var min_monthVal = min_month.val()
                 var min_dayVal = min_day.val()
                 var min_hourVal = min_hour.val()
     
                 var max_yearVal=max_year.val()
                 var max_monthVal=max_month.val()
                 var max_dayVal = max_day.val()
                 var max_hourVal =max_hour.val()
     
                 if(min_yearVal != max_yearVal){
                     max_year.val(min_yearVal)
                 }
                 if(min_monthVal != max_monthVal){
                     max_month.val(min_monthVal)
                 }
                 if(min_day != max_day){
                     max_day.val(min_dayVal)
                 }
                 
             }
             function changeDate2(){
                $(".room_code").empty()
                 //min_day,min_hour,max_day,max_hour
                 var min_year = $(".min_year")
                 var min_month = $(".min_month")
                 var min_day = $(".min_day")
                 var min_hour= $(".min_hour")
     
                 var max_year=$(".max_year")
                 var max_month=$(".max_month")
                 var max_day = $(".max_day")
                 var max_hour =$(".max_hour")
     
                 var min_yearVal = min_year.val()
                 var min_monthVal = min_month.val()
                 var min_dayVal = min_day.val()
                 var min_hourVal = min_hour.val()
     
                 var max_yearVal=max_year.val()
                 var max_monthVal=max_month.val()
                 var max_dayVal = max_day.val()
                 var max_hourVal =max_hour.val()
     
                 if(min_yearVal != max_yearVal){
                     min_year.val(min_yearVal)
                 }
                 if(min_monthVal != max_monthVal){
                     min_month.val(max_monthVal)
                 }
                 if(min_day != max_day){
                     min_day.val(max_dayVal)
                 }
                 
             }
     
             function validCheck(){
                 var emp_no = $(".emp_no")
                 var subject = $(".subject")
                 var content = $(".content")
                 
     
                 var min_year = $(".min_year")
                 var min_month = $(".min_month")
                 var min_day = $(".min_day")
                 var min_hour =$(".min_hour")
     
                 var max_year=$(".max_year")
                 var max_month=$(".max_month")
                 var max_day = $(".max_day")
                 var max_hour =$(".max_hour")
     
                 var min_yearVal = min_year.val() 
                 var min_monthVal = min_month.val() 
                 var min_dayVal = min_day.val()    
                 var min_hourVal = min_hour.val()
     
                 var max_yearVal=max_year.val()
                 var max_monthVal=max_month.val()
                 var max_dayVal = max_day.val()   
                 var max_hourVal =max_hour.val()
                 
                 var emp_noVal = emp_no.val() ;
                 var subjectVal = subject.val() ;
                 var contentVal = content.val() ;
                
                 var sysDate = new Date (  ) ;
                 var sysYear = sysDate.getFullYear() ;
                 var sysMonth = sysDate.getMonth()+1;
                 var sysDay = sysDate.getDate() ;
                 var minDate = new Date ( min_yearVal, min_monthVal-1 , min_dayVal , ) ;
                 var maxDate = new Date ( max_yearVal, max_monthVal-1 , max_dayVal , ) ;
                 
                // alert(sysMonth+1)
                //alert(min_monthVal)
                console.log("현재 달"+ sysMonth)
                console.log("입력된 달"+ min_monthVal )
     
                 var flag = true
     
                 
                 if( subjectVal.length==0 ){
                     alert("제목을 입력해주세요")
                     max_hour.val("")
                     flag = false ;
                 }
                 else if( contentVal==0 ){
                     alert("내용을 입력해주세요")
                     max_hour.val("")
                     flag = false ;
                 }
                 else if(min_yearVal=="" || min_monthVal=="" || min_dayVal=="" || min_hourVal==""){
                     alert("이용 시작 시간을 모두 입력해주세요")
                     min_hour.val("")
                     max_hour.val("")
                     flag= false ;
                 }
                 else if(max_yearVal=="" || max_monthVal=="" || max_dayVal=="" || max_hourVal==""){
                     alert("이용 종료 시간을 입력 해주세요 ")
                     max_hour.val("")
                     min_hour.val("")
                     flag =false ;
                 }
                 else if(min_hourVal >= max_hourVal){
                    alert("시간을 다시 입력 해주세요.");
                    max_hour.val("")
                    min_hour.val("")
                    flag =false ;
                 }
                
                 
                 else if( sysYear > min_yearVal 
                            ||
                         (sysYear == min_yearVal && sysMonth > min_monthVal)
                            ||
                         (sysYear == min_yearVal && sysMonth == min_monthVal && sysDay > min_dayVal) 
                      
                         ){
                    alert( "지난 날짜는 예약 하실 수 없습니다" )
                    
                    max_hour.val("")
                    min_hour.val("")
                    flag =false ;
                 }
                 
                 else if( (min_yearVal==sysYear ) 
                            &&
                          (min_monthVal==sysMonth )  
                            &&
                          (min_dayVal==sysDay )
                            &&
                  (sysDate.getHours() > min_hourVal || sysDate.getHours()>max_hourVal) ){
                     alert( "지난 시간대는 예약 하실 수 없습니다" )
                     max_hour.val("")
                     min_hour.val("")
                     flag=false ;
                }
                
                 
                 
     
     
                 return flag ;
                 
             }
             
             function setEndTime(){
                $(".room_code").empty()
                $(".max_hour").val( parseInt($(".min_hour").val())+2+"" )
                
             }
    
            </script>
            
    
        </head>
        <body class="is-preload">
    
            <!-- Wrapper -->
                <div id="wrapper">
    
                    <!-- Main -->
                        <div id="main">
                            <div class="inner">
    
                                <!-- Header -->
                                    <header id="header">
                                        <strong>회의실 예약</strong>
                                        <span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>
                                    </header>
    
                                <!-- Content -->
                               
                                    <form name="meetingResForm">
                                        <table border=1 cellpadding="5" cellspacing="1" >
                                            
                                            <tr>
                                                <th>예약자</th>
                                                <td>
                                                    <!--<input type="text" name="emp_no" class="emp_no" value="">  -->
                                                    ${sessionScope.emp_name}  
                                                    <input type="hidden" name="emp_no" value="${sessionScope.uid}">
                                                </td>
                                            </tr>
                                            
                                            
                                            
                                            <tr>
                                                <th>회의제목</th>
                                                <td>
                                                    <input type="text" name="subject" class="subject" value="">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>회의내용</th>
                                                <td>
                                                    <textarea name="content" class="content"></textarea>
                                                </td>
                                            </tr>
    
                                            <tr>
                                                <th>이용시간</th> 
                                                <td>				
                                                    <select name="min_year" class="min_year" onchange="changeDate1()">
                                                        <option value="">
                                                    </select>년
                                                    <select name="min_month" class="min_month" onchange="changeDate1()">
                                                        <option value="">
                                                    </select>월
                                                    <select name="min_day" class="min_day" onchange="changeDate1()">
                                                        <option value="">
                                                    </select>일
                                                    <select name="min_hour" class="min_hour" onchange="setEndTime()">
                                                        <option value=""> 
                                                    </select>시 부터
                                                    
                                                        <div style="height:10px"></div>			
                                                        
                                                    <select name="max_year" class="max_year" onchange="changeDate2()">
                                                        <option value="">   
                                                    </select>년
                                                    <select name="max_month" class="max_month" onchange="changeDate2()">
                                                        <option value="">
                                                    </select>월
                                                    <select name="max_day" class="max_day" onchange="changeDate2()">
                                                        <option value="">
                                                    </select>일
                                                    <select  name="max_hour" class="max_hour" >
                                                        <option value="">
                                                    </select>시 까지
                                                    &nbsp;&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>예약 가능 회의실</th>
                                                <td>
                                                    <select name="room_code" class="room_code">
                                                        <option value=""></option>  
                                                    </select>
                                                    <input type="button" value="회의실 조회" style="cursor:pointer" onclick="getCanResRoom()">
                                                </td>
                                                
                                            </tr>
                                            
                                            
                                        </table>
    
                                        </form>      


                  
    
    
                                <div align="center">
                                    <input type="button" value="예약" style="cursor:pointer" onclick="reservBtnClick()"> 
                                    
                                    <input type="button" value="취소" style="cursor:pointer" onclick="cancelBtnClick()"> 
                                </div>	
                               
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