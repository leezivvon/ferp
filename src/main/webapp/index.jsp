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
<title>FERP</title>

</head>

<body class="container">
<c:if test="${login == null }">
	<c:redirect url="pg0003.jsp"/>
</c:if>


<c:if test="${login != null }">
	<c:if test="${login.frRegiNum == '9999999999' }">
	본사메인으로 이동
	<c:redirect url="/goHqPage.do"/>
	</c:if>
	<c:if test="${login.frRegiNum != '9999999999' }">
	<c:redirect url="/storeMainMenu.do" />
	</c:if>
</c:if>
</body>
</html>
