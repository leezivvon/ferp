<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 입출고</title>
<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style>
.inputbox{
	width: 200px;
}
.searchtab{
	border: 1px solid lightgray;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("[name=productNum]").val("${sch.productNum}");
	});
	
</script>
</head>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		<h2>재고 입출고 내역</h2><br><hr><br>
		<div class="toolbox">
		<h3>재고 입출고 검색</h3><br>
			<form class="toolbar" method="post" id="reqSchFrm">
				<select name="productNum" required>
					<option value="">자재코드선택</option>
			        <c:forEach var="pn" items="${productNumCom}">
				        <c:if test="${pn.frRegiNum == login.frRegiNum}">
							<option>${pn.productNum}</option>
						</c:if>
					</c:forEach>
				</select>
				<button class="btn-secondary" type="submit">검색</button>
				<input type="hidden" name="curPage" value="${sch.curPage}" />
			</form>
		</div>
			<div class="searchtab">
				<table>
				<thead>
					<tr><th>자재코드</th><th>카테고리명</th><th>자재명</th><th>일자</th><th>단가</th><th>수량</th></tr>
				</thead>
				<tbody>
					<c:forEach var="prod" items="${list}">
			    	    <tr>
			    	    	<td style="text-align:center">${prod.productNum}</td>
			    	    	<td style="text-align:center">${prod.category}</td>
			    	    	<td>${prod.productName}</td>
			    	    	<td style="text-align:center">${prod.stockDate}</td>
			    	    	<td style="text-align:right"><fmt:formatNumber value="${prod.price}" type='currency'/></td>
			    	    	<td style="text-align:center">${prod.applyAmount}</td>
			    	    </tr>
			    	</c:forEach>
				</tbody>
				</table>
				<c:if test="${sch.startBlock > 0}">
					<div style="text-align:center;">
						<button name="prev" class="pgBtnPrev" onclick="location.href='javascript:goPage(${sch.startBlock-1});'">
							&lt;
						</button>
							<c:forEach var="cnt" begin="${sch.startBlock }" end="${sch.endBlock}">
						  		<button class="pgBtn pg${cnt}" onclick="location.href='javascript:goPage(${cnt});'">
									${cnt}
								</button>
						  	</c:forEach>
					  	<button name="next" class="pgBtnNext" onclick="location.href='javascript:goPage(${sch.startBlock+1});'">
							&gt;
						</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<!-- 
	<form id="reqSchFrm">
	<input type="hidden" name="curPage" value="${sch.curPage}" />
	</form> -->
</body>
<script type="text/javascript">
function goPage(cnt){
	$("[name=curPage]").val(cnt);
	$("#reqSchFrm").submit()
}
if(${sch.curPage==1}){
	$("[name=prev]").attr("disabled",true)
}
if(${sch.curPage==sch.endBlock}){
	$("[name=next]").attr("disabled",true)
}

$(".pg"+${sch.curPage}).css({
	'background' : '#a4a4a4',
	'color' : 'white'
})
</script>
</html>