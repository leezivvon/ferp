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
<title>판매 메뉴 등록</title>
<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />

<!-- 아이콘 -->
<link rel="shortcut icon" type="image/x-icon" href="${path}/resource/img/favicon.ico" />


<style>
	.necessarySpan{
		color: red;
		font-weight: 600;
	}
	
	td{
		text-align: center;
	    line-height: 35px;
	}
	
	.infoText{
		text-align: left;
	}
	
	.h5text{
	    font-size: 19px;
	    color: #777;
	    font-weight: 500;
	    text-align: left;
	    padding-left: 20px;
	}
</style>
<script type="text/javascript">
	localStorage.setItem("pageIdx","2002")
	localStorage.setItem("eqIdx","2000")

	$(document).ready(function(){

	});

</script>
</head>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		<h2>판매 메뉴 삭제</h2><br>
<hr>
<br>
		<h5 class="h5text">현재 키오스크 화면에 노출 중인 상품들입니다.</h5><br>
			<table>
			<col width="20%">
			<col width="15%">
			<col width="45%">
			<col width="20%">
				<thead>
					<tr>
						<th>이름</th><th>가격</th><th>메뉴 설명</th><th>등록</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="mn" items="${showOnSale}">
						<tr>
								<td>${mn.menuName}</td>
								<td>
									<fmt:formatNumber value="${mn.price }" pattern="#,###" />￦
								</td>
								<td class="infoText">${mn.info}</td>
								<td>
									<input name="menuNum" type="hidden" value="${mn.menuNum}">
									<c:if test="${mn.necessary == 'N'}">
									<button class="delBtn btn-danger">삭제</button>
									</c:if>
									<c:if test="${mn.necessary == 'Y'}">
									<span class="necessarySpan">필수 판매 메뉴</span>
									</c:if>
								</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript">

$(document).ready(function() {
	
	var fn = ${login.frRegiNum};
	
	
	$(".delBtn").click(function () {
		var menuNum = $(this).closest('tr').find('input[name="menuNum"]').val();
		console.log(menuNum);
		  Swal.fire({
			  title: '메뉴를 삭제하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#2262F3',
			  cancelButtonColor: '#888',
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소'
			}).then((result) => {
				if(result.value){
					alert("삭제되었습니다.");
					location.href='${path}/delOnsale.do?menuNum='+menuNum;
				}
			});
	});
	
});
</script>
</html>