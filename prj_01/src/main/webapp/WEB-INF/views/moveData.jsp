<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
        
        
        
<div class="searchCondition">

	
	
	<input type="text" name="keyword1" class="keyword1"  value="${param.keyword1}">
	<input type="text" name="keyword2" class="keyword2" value="${param.keyword2}">
	<input type="text" name="selectPageNo" class="selectPageNo"  value="${param.selectPageNo}">
	<input type="text" name="rowCntPerPage" class="rowCntPerPage"  value="${param.rowCntPerPage}">
	
	<c:forEach var="xxx" items="${paramValues.date}">
		<input type="checkbox" name="date" class="date"  value="${xxx}" checked>오늘
		<input type="checkbox" name="date" class="date"  value="${xxx}" checked>어제
	</c:forEach>
	
	
	<input type="text" name="orAnd" class="orAnd"  value="${param.orAnd}">
	
	<input type="text" name="sort" class="sort"  value="${param.sort}">
</div>

<script>
	$(".searchCondition").hide();
</script>