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
<title>비밀번호 찾기</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css" />
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style>
header{
	padding:1em;
	display: flex;
	justify-content: center;
	border-bottom: 1px lightgray solid;
}
form>div{
	align-items: center;
	display: flex;	
	flex-direction:column;
	justify-content:space-between;
	margin:1.5em;
}
form>div>div{
	align-items: center;
	display: flex;	
	flex-direction:row;
	justify-content:space-between;
	min-width:50%; 
	padding:0.5em;
	
}
input{
	width:70%;
}
#info{
	font-size: 0.9em;
	color:navy;
}
.btn-primary{
	padding:1em;
	padding-left: 5em;
	padding-right: 5em;
}
</style>

</head>

<body class="container">
<header>
<div class="logo">
		<a href="${path }/index.jsp"><img src="${path }/resource/img/F.ERP.png" alt=""></a>
	</div>
</header>
<form>
<div>
	<div><label>사업자등록번호</label><input name="frRegiNum" autocomplete="off" required></div>
	<div><label>사업주명</label><input name="frRepName" autocomplete="off" required></div>
	<div><label>등록한 이메일 주소</label><input name="email" autocomplete="off" required></div>
</div>
<div>
	<span id="info">입력한 정보가 일치할 경우 비밀번호가 재설정 됩니다.</span>
	<button class="btn-primary">임시비밀번호 발급</button>
</div>
</form>

<script>
const form1= document.querySelector('form')
form1.addEventListener('submit', function(e){
    e.preventDefault();	//submit 방지
    var json= {"frRegiNum":$("[name=frRegiNum]").val(),"frRepName":$("[name=frRepName]").val(),"email":$("[name=email]").val()}
    console.log(json)
    fetch('${path}/tempPassword.do', {
    	  method: 'POST',
    	  body: JSON.stringify(json),
    	  headers: {
    	    'Content-Type': 'application/json'
    	  }
    	})
    	.then(response => response.text()) // 응답 데이터를 JSON 형식으로 파싱하여 반환
    	.then(data => alert(data)) // 파싱된 데이터를 처리
    	.catch(error => console.error(error)) // 에러 처리
})
</script>
</body>
</html>