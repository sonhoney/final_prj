<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<div class="searchCondition">
   	<input type="text" name="keyword" class="keyword"  value="${param.keyword}">
   	<input type="text" name="depSearch" class="depSearch"  value="${param.depSearch}">
	<input type="text" name="jikupSearch" class="jikupSearch"  value="${param.jikupSearch}">
	<input type="text" name="selectPageNo" class="selectPageNo"  value="${param.selectPageNo}">
	<input type="text" name="rowCntPerPage" class="rowCntPerPage"  value="${param.rowCntPerPage}">
	
</div>
<script>

	$(".searchCondition").hide();

</script>