<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 확인</title>

<script src="/js/jquery-1.11.0.min.js"></script>
<script>

var id = opener.document.getElementById("uid").value;

$(function(){
	
	$("[name='emp_no']").val( id );
	
})


function goLoginForm(){
	
	opener.location.replace("/loginForm.do");
	window.close();
}


</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/serve.css">
</head>
<body>


<form name="idViewForm" >

<center>
  
    <h2><b>아이디 확인</b></h2>
  
	<table cellpadding="3" >
		<caption>귀하의 아이디는<br>아래와 같습니다.</caption>
	
		<tr>
			<th> <input type="text" name="emp_no" class="emp_no" readonly/>
		</table>
		
		<br>
		<span style="cursor:pointer" onClick="goLoginForm()">[ 로그인 화면으로 이동하기 ]</span>
	
	

	

</form>


</body>
</html>
