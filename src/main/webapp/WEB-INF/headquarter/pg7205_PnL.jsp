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
<title>타이틀</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />

</head>

<body class="container">
	%@ include file="/resource/templates/header.jsp"%
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			
<table>
<tr><td>과목</td><td>당기(수익)</td><td>당기</td></tr>
<tr><th>1 매출액</th><td> )</td><td>당기</td></tr>
<tr><th>1 매출원가</th><td> </td><td>당기</td></tr>
<tr><th>1 매출총이익</th><td>공백</td><td>위에 두개 뺀거</td></tr>
<tr><th>1 판관비</th><td>총 얼마</td><td>공백</td></tr>
<tr><td>무슨판관비인지</td><td>얼마얼마</td><td></td></tr>
<tr><td>무슨판관비인지</td><td>얼마얼마</td><td></td></tr>
<tr><th>1영업이익</th><td>공백</td><td>매출총이익-판관비</td></tr>
<tr><td>기타수익</td><td>공백</td><td>위에 두개 뺀거</td></tr>
<tr><td>금융수익</td><td>공백</td><td>위에 두개 뺀거</td></tr>
<tr><th>1 법인세비용차감전순이익</th><td>공백</td><td>위에 두개 뺀거</td></tr>
<tr><th>1 당기순이익</th><td>공백</td><td>법인세 어쩌고 빼기ㅣ 법인세</td></tr>

</table>

		</div>
	</div>
</body>
</html>