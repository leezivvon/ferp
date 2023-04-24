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
<title>자재 상세 정보</title>
<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<style>
#insform {
	position: absolute;
	display: block;
	text-align: center;
	margin: auto;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width : 500px;
	padding: 25px;
	border: 1px solid #FFFFFF;
	border-radius: 5px;
	background-color: #FFFFFF;
}
body{
	background-color: #f5f5f5;
}
.prodimg{
	width: 250px;
	height: 250px;
}
label{
	font-size: 15pt;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#uptBtn").click(function(){
			Swal.fire({
				title: '수정하시겠습니까?',
				icon: 'warning',
				showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				confirmButtonText: '확인', // confirm 버튼 텍스트 지정
				cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
				if (result.value) {
					$("form").submit()
				}
			})
		})
		$("#returnBtn").click(function(){
			location.href = "${path}/hproductList.do"
		})
	});
</script>
</head>
<body>
	<div>
		<div id="insform">
			<h2>자재 정보</h2>
			<form method="post" action="${path}/hproductUpt.do">
				<div><img class="prodimg" src="${path}/resource/img/${product.img}"></div><br>
				<table>
					<tr><th>자재코드</th><td>${product.productNum}
					<input name="productNum" type="hidden" value="${product.productNum}" id="productNum"></td></tr>
					<tr><th>카테고리명</th><td>${product.category}</td></tr>
					<tr><th>자재명</th><td>${product.productName}</td></tr>
					<tr><th>거래처</th><td>${product.opposite}</td></tr>
					<tr><th>단가</th><td><fmt:formatNumber value="${product.price}" type='currency'/></td></tr>
					<tr><th><label for="remark">비고</label></th>
						<td><input type="text" name="remark" value="${product.remark}" 
							class="ckValid" id="remark" placeholder="비고 입력" required></td></tr>
				</table>
				<button id="uptBtn" class="btn-secondary" type="button">수정</button>
				<button id="returnBtn" class="btn-submit" type="button">닫기</button>
			</form>
		</div>
	</div>
</body>
</html>