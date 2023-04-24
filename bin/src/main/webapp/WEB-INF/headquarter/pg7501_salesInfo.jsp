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
<title>본사-매장정보출력</title>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		
		
				<!-- 전체매장총매출출력칸 시작-->
				<div class="hdq_totalSalesPrt">
				
				</div>
				<!-- 전체매장총매출출력칸 끝-->
				
				
				<!-- 검색 시작 -->
				<div class="hdq_search">
				
				</div>
				<!-- 검색칸 끝 -->
				
				
				<!-- 검색기준 시작 -->
				<div class="hdq_searchStandard">
					<div class="sort">
						<h3>정렬기준</h3>
						<ul>
							<li>매장명</li>
							<li>매출높은 순</li>
							<li>매출낮은 순</li>
						</ul>
					</div>
					<div class="period">
						<h3>매출조회 기간</h3>
						<form>
							<input name="strperiod" type="date"/>
							~
							<input name="endperiod" type="date"/>
							<!-- <button type="hidden" />  -->
						</form>
					</div>
				</div>
				<!-- 검색기준 끝 -->
				
				
				<!-- 정보출력표 시작 -->
				<div class="frs_salesInfo_print">
					<table>
						<thead>
							<tr><td>매장명</td><td>매장매출액</td><td>매장매입액</td><td>매장전화번호</td><td>점주명</td><td>담당직원</td><td>매장정보수정</td></tr>
						</thead>
						<tbody>
							<tr>
								<td>매장명</td><td>매장매출액</td><td>매장매입액</td><td>매장전화번호</td><td>점주명</td><td>담당직원</td>
								<td><span class="fr_uptBtn">수정</span><span class="fr_delBtn">삭제</span></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 정보출력표 끝 -->
			

		
		</div>
	</div>
</body>
</html>