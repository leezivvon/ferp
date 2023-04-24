<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>담당 매장 점검</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<head>
<script type="text/javascript">
	$(document).ready(function(){
		// 현재 날짜 정보 가져오기
		var currentDate = new Date();
		// 현재 날짜가 마지막 주 월요일인지 확인
		if (currentDate.getDay() == 1 && (currentDate.getDate() + 7) > (new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate())) {
			// 버튼 활성화
			$("button").prop("disabled", false);
		} else {
			// 버튼 비활성화
			$("button").prop("disabled", true);
		}   
	});
</script>
</head>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			
			<h2>직원별 점검일 배정</h2><br><hr><br>
			<div>
				<div class="searchtab">
					<table>
					<thead>
						<tr><th>매장</th><th>담당직원</th><th>자재명</th><th>일자</th>
							<th>단가</th><th>변동수량</th><th>전체수량</th><th>비고</th><th>수정/삭제</th></tr>
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
				    	    	<td style="text-align:center">${prod.remainAmount}</td>
				    	    	<td>${prod.remark}</td>
						        <td style="text-align:center">
					            <button class="btn-secondary uptbtn" type="button"><span>수정</span></button>
								<button class="btn-danger delBtn" type="button">삭제</button></td>
				    	    </tr>
				    	</c:forEach>
					</tbody>
					</table>
					<form action="">
						
						<button class="btn-primary">점검일 배정하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>