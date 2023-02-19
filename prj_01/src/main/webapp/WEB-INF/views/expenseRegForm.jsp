<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    
<%@ page import="com.naver.erp.Next_App_Emp_List" %>    
<%@ page import="java.util.*" %>    


<%ArrayList<Next_App_Emp_List> next_app_list = (ArrayList<Next_App_Emp_List>)request.getAttribute("next_app_list"); %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
		<script src="/ckeditor/ckeditor.js"></script>
		<script src="/ckeditor/ko.js"></script>
		<title>지출보고서 등록</title>	
		<link rel="stylesheet" href="/css/main.css" />
		<!-- ******************************************************** -->
		<!--  JQuery 라이브러리 수입하기 -->
		<!-- ******************************************************** -->
		<script src="/js/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>


    	<script>
    	$(function(){

			//로그아웃
			$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
			});

			$(".dailyListForm").click(function(){
				location.replace("/dailyListForm.do");
			})
			$(".dashboard").click(function(){
				location.replace("/dashboard.do");
			})
			$(".salesListForm").click(function(){
				location.replace("/salesListForm.do");
			})
			$(".expenseListForm").click(function(){
				location.replace("/expenseListForm.do");
			})
			$(".RegFormBtn").click(function(){
				expenseRegFormCheck();
			})
			
			
		})
    	
		//--------------------------------------------------------------------------------함수 시작--------------------------------------------------
		//--------------------------------------------------------------------------------함수 시작--------------------------------------------------
		//--------------------------------------------------------------------------------함수 시작--------------------------------------------------
		//--------------------------------------------------------------------------------함수 시작--------------------------------------------------
		function keyup(){
			var formObj = $("[name=expenseReg]");
			
    		var thisObj = formObj.find(".expense_price");
            var money = thisObj.val();

            //숫자만 골라서 저장할 변수 선언
            var num ="";
            var nums ="0123456789";
            // money 변수 안에 데이터중 숫자만 골라 num 변수에 누적 시킴
            for( var i=0; i<money.length; i++){
                var str = money.charAt(i);
                if(nums.indexOf(str)>=0){
                    num += str;
                }
            }
            // num 변수 안에 첫글자가 0으로 시작한다면 제거하기
            while(num.length>=2 && num.indexOf("0")==0){
                num = num.substring(1);
            }

            // 콤마를 포함한 최종 숫자 문자열을 저장할 변수 선언
            var result="";
            var num_arr = num.split("");
            var cnt =0;
            for(var i=num_arr.length-1; i>=0; i--){
                cnt++;
                if( (cnt%3)==0 && i!=0 ){
                    num_arr[i] = "," +  num_arr[i];
                }
            }
            result =num_arr.join("");
            thisObj.val(result);
    	}
		
		
		
		function expenseRegFormCheck(){
			var formObj = $("[name=expenseReg]");

			
			var report_nameObj = formObj.find("[name=report_name]"); // 제목
			var expense_field_codeObj = formObj.find("[name=expense_field_code]"); // 지출분야   
			var expense_price = formObj.find("[name=expense_price]");		// 비용
			var expense_method_code = formObj.find("[name=expense_method_code]"); // 지출수단 
			var receipt_no = formObj.find("[name=receipt_no]"); // 영수증 번호
			var remarks = formObj.find("[name=remarks]"); // 비고 
			
			var next_app_emp_no = formObj.find("[name=next_app_emp_no]"); // 다음결재자
			
			
			var expense_yearVal = formObj.find(".expense_year").val();
			var expense_monthVal = formObj.find(".expense_month").val();
			var expense_dateVal = formObj.find(".expense_day").val();
			var expenseDateObj = formObj.find("[name=expense_date]");
			
			expenseDateObj.val(expense_yearVal + "-" + expense_monthVal + "-"  + expense_dateVal);
						
			
			//-------------------------------------------------------------
			// 제목 유효성 검사
			var report_nametVal = report_nameObj.val();
			if( typeof(report_nametVal)!="string" ){report_nametVal="";}
			report_nametVal = report_nametVal.trim();
			report_nameObj.val(report_nametVal);
			
			if( report_nametVal.length==0 ){
				alert("제목을 입력해야 합니다.");
				report_nameObj.val("");
				report_nameObj.focus();
				return;
			}
			//-------------------------------------------------------------
			// 지출분야 유효성 검사
			var expense_field_codeVal = expense_field_codeObj.val();
			if( expense_field_codeVal == "" ){
				alert("지출분야를 선택해야 합니다.");
				expense_field_codeObj.focus();
				return;
			}
			//-------------------------------------------------------------
			// 지출수단 유효성 검사
			var expense_method_codeVal = expense_method_code.val();
			if( expense_method_codeVal == "" ){
				alert("지출수단을 선택해야 합니다.");
				expense_method_code.focus();
				return;
			}
			//-------------------------------------------------------------
			// 비용 유효성 검사
			var expense_priceVal = expense_price.val();

			if( expense_priceVal.length==0 ){
				alert("비용을 입력해야 합니다.");
				expense_price.val("");
				expense_price.focus();
				return;
			}
			var num = ""
			num = expense_priceVal
			var num_arr = num.split(",");
			expense_priceVal = num_arr.join("");
			expense_price.val(expense_priceVal);
			
			
			//-------------------------------------------------------------
			// 영수증번호 유효성 검사
			var receipt_noVal = receipt_no.val();
			if( typeof(receipt_noVal)!="string" ){receipt_noVal="";}
			receipt_noVal = receipt_noVal.trim();
			receipt_no.val(receipt_noVal);
			if( receipt_noVal.length==0 ){
				alert("영수증 번호를 입력해야 합니다.");
				receipt_no.val("");
				receipt_no.focus();
				return;
			}
			if(new RegExp(/^[0-9]{6,9}$/).test(receipt_no.val())==false){
            alert("영수증 번호는 7~10자리의 숫자만 입력 가능합니다.");
            receipt_no.val("");
            receipt_no.focus();
            return;
			}
			
			//-------------------------------------------------------------
			// 날짜 유효성 검사	
			if( expense_yearVal=="" || expense_monthVal=="" || expense_dateVal==""){
				alert("지출한 날짜를 모두 작성해주십시오.");
				return;
			}

			//-------------------------------------------------------------
			// 비고 유효성 검사
			var remarksVal = remarks.val();
			if( typeof(remarksVal)!="string" ){remarksVal="";}
			remarksVal = remarksVal.trim();
			remarks.val(remarksVal);
			
			if( remarksVal.length==0 ){
				alert("비고을 입력해야 합니다.");
				remarks.val("");
				remarks.focus();
				return;
			}
			//-------------------------------------------------------------
			// 결재자 유효성 검사
			var next_app_emp_noVal = next_app_emp_no.val();
			if( next_app_emp_noVal == "" ){
				alert("다음결재자를 선택해야 합니다.");
				next_app_emp_no.focus();
				return;
			}
			
			
			$.ajax({
				url:"/expenseRegProc.do"	
				,type:"post"
				,data:$("[name='expenseReg']").serialize()
				,success:function(regCnt){
					if(regCnt==1){
						alert("지출일지 등록 성공");
						location.replace("/expenseListForm.do")
					}
				}
				,error:function(){
					alert("웹서버 접속 실패! 관리자에게 문의 바람");
				}
			})
    		
    	}
    	
		
		
		//-----------------------------------------------------------------------
    	// 유효한 날짜 세팅 함수
		 function setYMD( formName,yearName,monthName,dateName){
                try{
                    var formObj = $("[name='"+formName+"']");
                    if(formObj.length==0){
                        alert("setYMD 함수 호출 시 1번째 매개변수로 들어온 form 태그의 name 값이 없습니다.");
                        return;
                    }
                    var yearObj = formObj.find("[name='"+yearName+"']");
                    var monthObj = formObj.find("[name='"+monthName+"']");
                    var dateObj = formObj.find("[name='"+dateName+"']");

                    var year = yearObj.val();
                    var month = monthObj.val();
                    var date = dateObj.val();

                    if( year!="" && month!=""){
                        year = parseInt(year,10);
                        month = parseInt(month,10);

                        var last_date = new Date(year,month,0).getDate();

                        dateObj.empty();
                        dateObj.append("<option value=''>");
                        for(var i=1; i<=last_date; i++){
                            if(i<10){
                                dateObj.append("<option value='0"+i+"'>0"+i);
                            }
                            else{
                                dateObj.append("<option value='"+i+"'>"+i);
                            }
                        }
                        if(date!=""){
                            dateObj.val(date);
                        }
                    }
                }
                catch(e){
                    alert("setYMD 함수 호출 시 예외발생!!"+e.message);
                }
            }
    	
		// 날짜가 변경되는 실행되는 함수   expenseReg    expense_year expense_month  expense_day
		function checkYMRange(){
			setYMD( "expenseReg","expense_year","expense_month","expense_day");
			
			var now = new Date();

			var now_year = now.getFullYear();
			var now_month = now.getMonth()+1;
			if(now_month<10){now_month= "0"+now_month}
			var now_day = now.getDate();
			if(now_day<10){now_day= "0"+now_day}

			
			
			var formObj = $("[name='expenseReg']");
			//---------------------------------------------
			var expense_yearObj = formObj.find(".expense_year");
			var expense_monthObj = formObj.find(".expense_month");
			var expense_dayObj = formObj.find(".expense_day");
			//---------------------------------------------
			var expense_yearVal = expense_yearObj.val();
			var expense_monthVal = expense_monthObj.val();
			var expense_dayVal = expense_dayObj.val();
			//-------------------------------------------------
			if( expense_yearVal=="" && expense_monthVal!="" ){
				alert("년도가 없으면 월을 선택할 수 없습니다.");
				expense_monthObj.val("");
				return;
			}
			if( expense_monthVal=="" && expense_dayVal!="" ){
				alert("월이 없으면 일을 선택할 수 없습니다.");
				expense_dayObj.val("");
				return;
			}
    	
    	
    	
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
									<strong>지출보고서등록</strong>
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>			
									
								</header>

							<!-- Content -->
							
                            <form  name="expenseReg" action="/expenseRegProc.do" method="post">                                
                                <table border=1 cellpadding="5" cellspacing="1" >                      
									<tr>
										<th>지출 제목</th>
										<td><input type="text" style=" width:300px;" name="report_name" class="report_name"></td>
									</tr>	                      
									<tr>
										<th>결재 내역</th>
										<td>
											<table>
												<tr>
													<th>분야</th>
													<th>수단</th>
													<th>비용</th>
													<th>영수증번호</th>  
												</tr>
												<tr>
													<td>
														<select name="expense_field_code" class="expense_field_code">
															<option value="">
															<option value="10">식대
															<option value="15">회식비
															<option value="20">접대비
															<option value="25">비품
															<option value="30">기자재
															<option value="35">사무기구
															<option value="40">교통비
															<option value="45">경조사비
															<option value="50">숙박비
															<option value="55">의류비
															<option value="60">도서비
															<option value="65">홍보비
															<option value="70">기타
														</select>
													</td>
													<td>
														<select name="expense_method_code" class="expense_method_code">
															<option value="">
															<option value="10">회사카드
															<option value="20">회사현금
															<option value="30">개인카드
															<option value="40">개인현금
														</select>
													</td>
													<td>
														<input type="text" style="width:150px;" name="expense_price" class="expense_price" onkeyup="keyup()">&nbsp;원
													</td>
													<td>
														<input type="text" style="width:200px;" name="receipt_no" class="receipt_no">
													</td>
												<tr>
													
													<th colspan='2'>지출일</th>
													<th colspan='2'>비고</th>
												</tr>
													<td colspan='2'>
														<select name="expense_year" class="expense_year" onChange="checkYMRange()">
															<option value="">
															<option value="2022">2022
															<option value="2021">2021
															<option value="2020">2020
														</select>&nbsp;년 &nbsp;&nbsp;&nbsp;
														<select  name="expense_month" class="expense_month" onChange="checkYMRange()">
															<option value="">
															<option value="01">01
															<option value="02">02
															<option value="03">03
															<option value="04">04
															<option value="05">05
															<option value="06">06
															<option value="07">07
															<option value="08">08
															<option value="09">09
															<option value="10">10
															<option value="11">11
															<option value="12">12
														</select>&nbsp;월&nbsp;&nbsp;&nbsp;
														<select  name="expense_day" class="expense_day" onChange="checkYMRange()"> 
															<option value="">
															<%for( int i=1; i<32; i++) {%>
																<%if(i<10){ %>
																	<option value="0<%= i %>">0<%= i %>
																<% } %>
																<% if(i>=10){ %>
																	<option value="<%= i %>"><%= i %>
																<% } %>
																		
															<% } %>		
														</select>&nbsp;일&nbsp;&nbsp;&nbsp;
														<input type="hidden" name="emp_no" value="${sessionScope.uid}">
														<input type="hidden" name="expense_date">
														<input type="hidden" name="report_code" value="3">
													</td>
													<td colspan='2'>
														<input type="text" style="border:solid;width:400px;" name="remarks" class="remarks">
													</td>
												</tr>
											</table>
										</td>
									</tr>                      
									<tr>
										<th>다음 결재자</th>
											<td>
												<select name="next_app_emp_no" class="next_app_emp_no" id="next_app_emp_no">
													<option value="">
													<% for (int i=0; i<next_app_list.size(); i++){ %>	
														<option value="<%= next_app_list.get(i).getEmp_no()  %>">
												   <%= next_app_list.get(i).getDep_name()%>부
												   <%= next_app_list.get(i).getEmp_name()%>
												   <%= next_app_list.get(i).getJikup_name()%>
												<% } %>												
												</select> 
											</td>									
									</tr>									
                                </table>
                            <center>
                            <br>
								<div align="center">
								<input type="button"value="등록" class="RegFormBtn">
								<input type="button"value="화면닫기" class="expenseListForm">
								<input type="reset" value="초기화">
								</div>                            
                            </form>
                            </body>


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