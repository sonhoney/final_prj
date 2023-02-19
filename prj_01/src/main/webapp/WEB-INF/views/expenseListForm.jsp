<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
		<script src="/ckeditor/ckeditor.js"></script>
		<script src="/ckeditor/ko.js"></script>
		<title>지출보고서</title>	
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
				$(".expenseRegForm").click(function(){
					location.replace("/expenseRegForm.do");
				})
				
				
				
				// 검색 조건 관련 입력양식에 흔적 남기기
				
				var formObj = $("[name='expenseSearchForm']");
				
				
				// 날짜 흔적남기기
				<c:if test="${!empty param.min_year}">
					formObj.find(".min_year").val("${param.min_year}");
				</c:if>
				
				<c:if test="${!empty param.min_month}">
					formObj.find(".min_month").val("${param.min_month}");
				</c:if>
				
				<c:if test="${!empty param.max_year}">
					formObj.find(".max_year").val("${param.max_year}");
				</c:if>

				<c:if test="${!empty param.max_month}">
					formObj.find(".max_month").val("${param.max_month}");
				</c:if>

				//결재여부
				<c:forEach var="sign_code" items="${paramValues.sign_code}">
					formObj.find(".sign_code").filter("[value='${sign_code}']").prop("checked",true);
				</c:forEach>
			
				//지출수단  
				<c:forEach var="expense_method_code" items="${paramValues.expense_method_code}">  
					formObj.find(".expense_method_code").filter("[value='${expense_method_code}']").prop("checked",true);
				</c:forEach>
				
				
				
				//지출분야  
				<c:forEach var="expense_field_code" items="${paramValues.expense_field_code}">
					formObj.find(".expense_field_code").filter("[value='${expense_field_code}']").prop("checked",true);
				</c:forEach>
				
				// 비용  
				formObj.find(".expense_min_price").val("${param.expense_min_price1}");
				formObj.find(".expense_max_price").val("${param.expense_max_price1}");
				
				//키워드
				formObj.find(".keyword").val("${param.keyword}");
				
				
				// "rowCntPerPage" 라는  파라미터명의 파라미터값이 비어있지 않으면
				<c:if test="${!empty param.rowCntPerPage}">
					formObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
				</c:if>
					
				// "selectPageNo" 라는  파라미터명의 파라미터값이 비어있지 않으면
				<c:if test="${!empty param.selectPageNo}">
					formObj.find(".selectPageNo").val("${param.selectPageNo}");
				</c:if> 


				
				
			})
				
			
			
			//-------------------------------------------------------------------밑에는 함수--------------------------------------------------------------------------------
			//-------------------------------------------------------------------밑에는 함수--------------------------------------------------------------------------------
			//-------------------------------------------------------------------밑에는 함수--------------------------------------------------------------------------------
			//-------------------------------------------------------------------밑에는 함수--------------------------------------------------------------------------------
			//-------------------------------------------------------------------밑에는 함수----------------------------------------------------------------------------------
				
			 
			
			function min_keyup(){
				var formObj = $("[name=expenseSearchForm]");
				
	    		var thisObj = formObj.find(".expense_min_price");
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
    		
    		
    		function max_keyup(){
				var formObj = $("[name=expenseSearchForm]");
				
	    		var thisObj = formObj.find(".expense_max_price");
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
			
			
			
			
			
			
			
			
			
			// [검색 버튼] 클릭했을때 호출되는 함수 선언
			function expenseSearch(){
				
				// 날짜 조합해서  min_year_month , max_year_month 에 넣어주기  
				var min_year = $(".min_year").val();
				var min_month = $(".min_month").val();
				var max_year = $(".max_year").val();
				var max_month = $(".max_month").val();

				if( min_year!="" && min_month!=""){
					$(".min_year_month").val( min_year +"-"+ min_month + "-01");
				}

				if( max_year!="" && max_month!=""){
					$(".max_year_month").val( max_year +"-"+ max_month +"-"+ new Date( parseInt(max_year,10) ,parseInt(max_month,10) ,0 ).getDate()  );
				}

				// 비용
				var formObj = $("[name=expenseSearchForm]");

				var expense_min_price = formObj.find("[name=expense_min_price]");	
				var expense_max_price = formObj.find("[name=expense_max_price]");
				
				var expense_min_priceVal = expense_min_price.val();
				var expense_max_priceVal = expense_max_price.val();
 
				var min_num = ""
				min_num = expense_min_priceVal
				var min_num_arr = min_num.split(",");
				expense_min_priceVal = min_num_arr.join("");
				$(".expense_min_price1").val(expense_min_priceVal); 


				var max_num = ""
				max_num = expense_max_priceVal
				var max_num_arr = max_num.split(",");
				expense_max_priceVal = max_num_arr.join("");
				$(".expense_max_price1").val(expense_max_priceVal);
 
				
				// 키워드 
				var keyword = $(".keyword").val();
				if(typeof(keyword)!="string"){ keyword = "";}
				keyword = $.trim(keyword); 
				$(".keyword").val(keyword);

				document.expenseSearchForm.submit();
				
			}
				
				
			
			// [모두검색] 버튼 클릭했을때 호출되는 함수 선언
			function expenseSearchAll(){
				
				$(".min_year").val("");
				$(".min_month").val("");
				$(".max_year").val("");
				$(".max_month").val("");

				$(".sign_code").prop("checked",false);
				$(".expense_method_code").prop("checked",false); // 지출수단
				$(".expense_field_code").prop("checked",false);
				

				$(".expense_min_price").val("");
				$(".expense_max_price").val("");
				$(".keyword").val("");
				
				$(".expenseSearchBtn").click();
				
			}
				
			//-------------------------------------------------------
			// 날짜 범위 관련 select 태그 4개의 유효성 체크하기
			function checkYMRange(){
				var formObj = $("[name='expenseSearchForm']");
				//---------------------------------------------
				var min_yearObj = formObj.find(".min_year");
				var min_monthObj = formObj.find(".min_month");
				var max_yearObj = formObj.find(".max_year");
				var max_monthObj = formObj.find(".max_month");
				//---------------------------------------------
				var min_yearVal = min_yearObj.val();
				var min_monthVal = min_monthObj.val();
				var max_yearVal = max_yearObj.val();
				var max_monthVal = max_monthObj.val();
				//---------------------------------------------
				if( min_yearVal=="" && min_monthVal!="" ){
					alert("년도가 없으면 월을 선택할 수 없습니다.");
					min_monthObj.val("");
					return;
				}
				
				if( max_yearVal=="" && max_monthVal!="" ){
					alert("년도가 없으면 월을 선택할 수 없습니다.");
					max_monthObj.val("");
					return;
				}
				//---------------------------------------------
				if( min_yearVal!="" && min_monthVal=="" ){
					min_monthObj.val("01");
					min_monthVal = "01";
				}
				if( max_yearVal!="" && max_monthVal=="" ){
					max_monthObj.val("12");
					max_monthVal = "12";
				}
				//---------------------------------------------
				if( min_yearVal!="" && min_monthVal!="" &&  max_yearVal!="" && max_monthVal!=""){
					if( min_yearVal+min_monthVal > max_yearVal+max_monthVal ){
						alert("최소 년월이 최대 년월 보다 크면 안됩니다!");
						max_yearObj.val("");
						max_monthObj.val("");
						return;
					}
				}
			}	
				

			//----------------------------------------------------
			// 날짜비움
			function emptyYMRange(){
				var formObj = $("[name='expenseSearchForm']");
				//---------------------------------------------
				formObj.find(".min_year").val("");
				formObj.find(".min_month").val("");
				formObj.find(".max_year").val("");
				formObj.find(".max_month").val("");
				//---------------------------------------------
			}

			//----------------------------------------------------
			// [오늘로] 클릭하면 실행되는 함수
			function now(){
				
				var now = new Date();
				
				var now_year = now.getFullYear();
				var now_month = now.getMonth()+1;
				if(now_month<10){now_month= "0"+now_month}

				
				var formObj = $("[name='expenseSearchForm']");

				var min_yearObj = formObj.find(".min_year");
				var min_monthObj = formObj.find(".min_month");
				var max_yearObj = formObj.find(".max_year");
				var max_monthObj = formObj.find(".max_month");

				min_yearObj.val(now_year);
				min_monthObj.val(now_month);
				max_yearObj.val(now_year);
				max_monthObj.val(now_month);
				
			}	
				
				

			//----------------------------------------------------
			// 지출분야 비움
			function emptyExpense_field_code(){
				$(".expense_field_code").prop("checked",false);			
			}
			//----------------------------------------------------
			// 결재여부 비움
			function emptySign_code(){
				$(".sign_code").prop("checked",false);				
			}

			//----------------------------------------------------
			// 지출수단 비움
			function emptyExpense_method_code(){
				$(".expense_method_code").prop("checked",false);			
			}
			
			
			//----------------------------------------------------
			// 비용 비움
			function emptyPrice(){
				$(".expense_min_price").val("");	
				$(".expense_max_price").val("");	
			}
			//----------------------------------------------------	
			
			//----------------------------------------------------
			// 키워드 비움
			function emptyKeyword(){
				$(".keyword").val("");		
			}
			//----------------------------------------------------	
				


			// [페이지 번호]를 클릭하면 호출되는 함수 선언
			function pageNoBtn(pageNo){
				// class=selectPageNo 를 가진 입력양식에
				// 클릭한(선택한) 페이지 번호를 value 값으로 삽입하기
				// 왜?? 서버로 보낼려고
				$(".selectPageNo").val(pageNo);
				// boardSearch함수 호출하기
				expenseSearch();
			}
			
 
    		
    		
    		
    		
			
			function goBoardDetailForm(report_no,report_code){
				var formObj = $("[name=boardDetailForm] [name=report_no]");
				var formObj2 = $("[name=boardDetailForm] [name=report_code]");
				var report_no = parseInt(report_no,10);
				var report_code = parseInt(report_code,10);
				formObj.val(report_no);
				formObj2.val(report_code);
				document.boardDetailForm.submit();
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
									<strong>지출보고서</strong>
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>			
									
								</header>

							<!-- Content -->
							<form name="expenseSearchForm" method="post" action="/expenseListForm.do">  
                                <table border=1 cellpadding="5" cellspacing="1" >
                                    <tr>
                                        <th>지출일</th>
                                        <td>
                                        <select name="min_year" class="min_year" onChange="checkYMRange()">     
                                                <option value="">--선택--
												<option value="2022">2022
												<option value="2021">2021
												<option value="2020">2020
												<option value="2019">2019
												<option value="2018">2018
                                            </select>년
                                            <select name="min_month" class="min_month" onChange="checkYMRange()">
                                                <option value="">--선택--
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
                                            </select>월
                                            -
                                            <select name="max_year" class="max_year" onChange="checkYMRange()">
                                                <option value="">--선택--
												<option value="2022">2022
												<option value="2021">2021
												<option value="2020">2020
												<option value="2019">2019
												<option value="2018">2018
                                            </select>년
                                            <select name="max_month" class="max_month" onChange="checkYMRange()">
                                                <option value="">--선택--
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
                                            </select>월

											<span style="cursor:pointer" onClick="emptyYMRange()">[날짜비움]</span>
											<span style="cursor:pointer" onClick="now()">[오늘날]</span>
                                        </td>
                                    </tr>
											<input type="hidden" name="min_year_month" class="min_year_month"> 
											<input type="hidden" name="max_year_month" class="max_year_month">
                                    <tr>
                                        <th>결재여부</th>
                                        <td>
                                            <input type="checkbox" name="sign_code" class="sign_code" value="0">결재완료
                                            <input type="checkbox" name="sign_code" class="sign_code" value="-1">미결재(or 결재진행중)
                                            <input type="checkbox" name="sign_code" class="sign_code" value="1">반려
											<span style="cursor:pointer" onClick="emptySign_code()">[비움]</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>지출수단</th>
                                        <td>
                                            <input type="checkbox" name="expense_method_code" class="expense_method_code" value="10">회사카드
                                            <input type="checkbox" name="expense_method_code" class="expense_method_code" value="20">회사현금
                                            <input type="checkbox" name="expense_method_code" class="expense_method_code" value="30">개인카드
                                            <input type="checkbox" name="expense_method_code" class="expense_method_code" value="40">개인현금
											<span style="cursor:pointer" onClick="emptyExpense_method_code()">[비움]</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>지출분야</th>
                                        <td>
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="10">식대
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="15">회식비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="20">접대비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="25">비품
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="30">기자재
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="35">사무기구
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="40">교통비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="45">경조사비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="50">숙박비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="55">의류비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="60">도서비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="65">홍보비
                                            <input type="checkbox" name="expense_field_code" class="expense_field_code" value="70">기타
											<span style="cursor:pointer" onClick="emptyExpense_field_code()">[비움]</span> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>비용</th>
                                        <td>
                                            <input type="text" name="expense_min_price" class="expense_min_price" onkeyup="min_keyup()"> 원      
                                            	~
                                            <input type="text" name="expense_max_price" class="expense_max_price" onkeyup="max_keyup()"> 원 
											<span style="cursor:pointer" onClick="emptyPrice()">[비움]</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>키워드</th>
                                        <td>
                                            <input type="text" name="keyword" class="keyword" size="10" value="">
											<span style="cursor:pointer" onClick="emptyKeyword()">[비움]</span> 
                                        </td>
                                    </tr>
                            
                                </table><br>
                                <center>
                                    	<input type="button" value="검색" class="expenseSearchBtn" onClick="expenseSearch();">
                                    	<input type="button" value="모두검색" class="expenseSerchAllBtn" onClick="expenseSearchAll();" >
                                    	<input type="reset" value="초기화">
                                </center>
                                <br>
                            
                                
                                     <table border=1 cellpadding="5" cellspacing="1" >
                                        <tr>
                                            <td>	
                                                <input type="button" value="지출보고서 등록" class="expenseRegForm"> 
                                            <td align="right">
												<!-- 검색된 게시판의 개수가 0개 보다 크면, 즉 검색된 게시판이 존재하면 -->
												<c:if test="${ requestScope.expenseTotCnt>0 }">
												
													
													<!-- [처음] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(1);">[처음]</span>&nbsp;
													<!-- [이전] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}-1);">[이전]</span>&nbsp;&nbsp;
													
													<!-- 선택한 페이지 대응하는 페이지 번호들을 출력 -->
													<c:forEach var="no" begin="${requestScope.pagingMap.begin_pageNo_perPage}" 
																		end="${requestScope.pagingMap.end_pageNo_perPage}" step="1">
														
														<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호가 다르면 -->
														<c:if test="${requestScope.pagingMap.selectPageNo !=no}">
															<span style="cursor:pointer" onclick="pageNoBtn(${no});">[${no}]</span>&nbsp;&nbsp;&nbsp;
														</c:if>
														
														
														<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호가 같으면 -->
														<c:if test="${requestScope.pagingMap.selectPageNo ==no}">
															<span>${no}</span>&nbsp;&nbsp;
														</c:if>
														
														
													</c:forEach>
												
													<!-- [다음] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}+1);">[다음]</span>&nbsp;
													<!-- [마지막] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.last_pageNo});">[마지막]</span>
												
												</c:if>		
                                                
                                               <td align="right">
												[검색 총개수] : ${requestScope.expenseTotCnt}/${requestScope.expenseAllTotCnt} &nbsp;&nbsp;&nbsp;&nbsp;
										
                                               <select name="rowCntPerPage" class="rowCntPerPage" onChange="expenseSearch()">
												<option value="10">10
												<option value="15">15
												<option value="20">20
												<option value="30">30
                                               </select>행보기                                             	
                                            </td>
                                        </tr>
                                    </table>
                            
                                <table border=1 cellpadding="5" cellspacing="1" >
                                    <tr>
                                        <td align="center"><b>번호</td>
                                        <td align="center"><b>작성자</td>
                                        <td align="center"><b>지출제목</td>
                                        <td align="center"><b>지출분야</td>
                                        <td align="center"><b>결재여부</td>
                                        <td align="center"><b>결재/반려일</td>
                                        <td align="center"><b>지출일</td>
                                        <td align="center"><b>비용</td>
                                        <td align="center"><b>지출수단</td>
                                    </tr>
	                            	<c:forEach var="xxx" items="${requestScope.expenseList}" varStatus="loopTagStatus">
												<tr 
													bgcolor="${loopTagStatus.index%2==0?'white':'lightgray'}"
													style="cursor:pointer"
														onClick="goBoardDetailForm(${xxx.report_no},${xxx.report_code})"
														class="trline"
												>
													<td align="center">${requestScope.pagingMap.serialNo_desc - loopTagStatus.index}
													<td align="center">${xxx.emp_name}					
													<td align="center">${xxx.report_name}
													<td align="center">${xxx.expense_field_name}			
													<td align="center"><c:if test="${xxx.sign_code==-1 && xxx.emp_no==sessionScope.uid}"><span style="color:#66CDAA">결재 진행중</span></c:if>										
														<c:if test="${xxx.sign_code==1}"><span style="color:#DC143C">반려</span></c:if><c:if test="${xxx.sign_code==1 && xxx.emp_no==sessionScope.uid}"><span style="color:#DC143C">처리요망</span></c:if>													
														<c:if test="${xxx.sign_code==-1 && xxx.emp_no!=sessionScope.uid}"><span style="color:#FFD700">미결재</span></c:if>		
														<c:if test="${xxx.sign_code==0}"><span style="color:#6B8E23">
														결재<c:if test="${xxx.emp_no==sessionScope.uid||xxx.sign_code==xxx.last_sign_code}">최종</c:if>완료</span>
														</c:if>			
													<td align="center">${xxx.next_app_getSign_date}
														<c:if test="${xxx.last_emp_no==sessionScope.uid && xxx.sign_code!=-1}">${xxx.last_sign_date}</c:if>
														<c:if test="${(xxx.last_emp_no==sessionScope.uid && xxx.last_sign_date==null) || (xxx.last_sign_date==null && xxx.sign_code==1)}">
														<span style="color:#DC143C">반려 처리중</span></c:if>
													<td align="center">${xxx.expense_date}
													<td align="center">${xxx.expense_price} 원
													<td align="center">${xxx.expense_method_name}
												</tr>
									</c:forEach>
                                </table>					
                                
							<input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> 
							<input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10">	
							<input type="hidden" name="expense_min_price1" class="expense_min_price1">		
							<input type="hidden" name="expense_max_price1" class="expense_max_price1">					 	
							 </form>
							 
							 
									
							 <form name="boardDetailForm" method="post" action="/expenseDetailForm.do">
								<input type="hidden" name="report_no"> 	
								<input type="hidden" name="report_code"> 								 	
				 			</form>

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