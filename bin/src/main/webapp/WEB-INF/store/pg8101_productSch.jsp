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
<title>계정과목 생성</title>
</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			<h2>매장 재고 조회</h2>
			<form>
				<div style="margin-top: 15px;">
					<div>
						<span style="font-size: 18px; font-weight: bold;">입고일자</span>
						<input name="stockdate" value="${sch.stockDate}" type="text" size="10" />
					</div>
					<div>
						<span style="font-size: 18px; font-weight: bold;">자재코드</span>
						<input name="productnum" value="${sch.productNum}" type="text" size="10" />
					</div>
					<div>
						<span style="font-size: 18px; font-weight: bold;">카테고리명</span>
						<input name="category" value="${sch.category}" type="text" size="10" />
					</div>
					<div>
						<span style="font-size: 18px; font-weight: bold;">자재명</span>
						<input name="productname" value="${sch.productName}" type="text" size="10" />
					</div>
					<div>
						<span style="font-size: 18px; font-weight: bold;">거래처</span>
						<input name="opposite" value="${sch.opposite}" type="text" size="10" />
					</div>
					<div>
						<span style="font-size: 18px; font-weight: bold;">발주상태</span>
						<select name="auth">
							<option value="">발주상태선택</option>
							<c:forEach var="auth" items="${authCom}">
								<option>${auth}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>