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
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>
</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			<input placeholder="계정코드"> <select><option>자산</option></select>
			<input placeholder="계정명"> <input type="submit" value="계정검색" class="btn-primary">

			<table>
				<thead>
					<tr>
						<th>계정코드</th>
						<th>구분</th>
						<th>계정명</th>
						<th>사용여부</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<form action="${path }/insertAccount.do">
						<td><input name="acntNum"></td>
						<td><select name="acntGroup">
							<option>자산</option>
							<option>자본</option>
							<option>부채</option>
							<option>비용</option>
							<option>수익</option>
							</select></td>
						<td><input name="acntTitle"></td>
						<td><input value="1" type="hidden" name="acntUsing"><button>계정등록</button></td>
					</form>
					</tr>
					<c:forEach items="${accountList }" var="each">
						<tr>
							<td>${each.acntNum }</td>
							<td>${each.acntGroup }</td>
							<td>${each.acntTitle }</td>
							<td><input type="checkbox" checked="${each.acntUsing }"></td>
						</tr>
					</c:forEach>

					<tr>
						<td>testing</td>
						<td>자산</td>
						<td>testing</td>
						<td><input type="checkbox"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<button class="btn-primary">hiasdnl</button>
	<button class="btn-secondary">hiasdnl</button>
	<button class="btn-success">hiasdnl</button>
</body>
</html>