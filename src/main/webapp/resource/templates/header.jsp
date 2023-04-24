<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css" />
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css" />

<script type="text/javascript">
	var login = '${login.frRegiNum}'
	if (login == "") {
		location.href = "${path}/index.jsp"
	}
</script>
<style>
.headerTop {
	justify-content: space-between;
	padding-bottom: 20px;
}

.logout {
	font-size: 18px;
}

.nameText {
	font-size: 20px;
	line-height: 33px;
    padding-top: 20px;
}

.logoutBtn:hover {
	color: #fff;
	background-color: #0069d9;
	border-color: #0062cc
}

.logoutBtn.focus, .logoutBtn:focus {
	box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .5)
}

.logoutBtn.disabled, .logoutBtn:disabled {
	color: #fff;
	background-color: #007bff;
	border-color: #007bff
}

.logoutBtn:not(:disabled):not(.disabled).active, .logoutBtn:not(:disabled):not(.disabled):active,
	.show>.btn-primary.dropdown-toggle {
	color: #fff;
	background-color: #0062cc;
	border-color: #005cbf
}

.logoutBtn:not(:disabled):not(.disabled).active:focus, .logoutBtn:not(:disabled):not(.disabled):active:focus,
	.show>.logoutBtn.dropdown-toggle:focus {
	box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .5)
}
.logoutBtn {
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
	display: inline-block;
	font-weight: 400;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	border: 1px solid transparent;
	padding: .375rem .75rem;
	font-size: 1rem;
	line-height: 1.5;
	border-radius: 10px;
	transition: color .15s ease-in-out, background-color .15s ease-in-out,
		border-color .15s ease-in-out, box-shadow .15s ease-in-out
}
header{
	display: flex;
	justify-content: end;
}


</style>
<header>
	<div class="logo">
		<a href="${path}/index.jsp"><img src="${path }/resource/img/F.ERP.png" alt=""></a>
	</div>
	<c:if test="${login.frRegiNum != '9999999999'}">
		<div class="headerTop">
			<h2 class="nameText">${login.frName }</h2>
			<button class="logout logoutBtn" onclick="location.href='${path}/logoutStore.do'">로그아웃</button>
		</div>
	</c:if>
	<c:if test="${login.frRegiNum == '9999999999'}">
		<div class="headerTop">
			<h2 class="nameText">${login.ename } 담당자</h2>
			<button class="logout logoutBtn" onclick="location.href='${path}/logoutEmp.do'">로그아웃</button>
		</div>
	</c:if>
</header>