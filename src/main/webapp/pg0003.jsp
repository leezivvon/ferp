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

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
	.btns{
		display: flex;
	    gap: 50px;
	    width: 100%;
	    flex-direction: row; /*수직 정렬*/
    	align-items: center;
      justify-content: center;
        padding: 60px;
	}
	
	.btn{
	display: flex;
	align-items:center;
	justify-content:center;
		width: 200px;
	    height: 200px;
	    background: #2262F3;
	    border-radius: 10px;
	    color: #fff;
	    font-weight: 600;
	    font-size: 29px;
	    text-align: center;
	    cursor: pointer;
	}
	
    .main_wrapper{
    	display: block;
    }
    
   
</style>
<script>
localStorage.setItem("pageIdx","0")
localStorage.setItem("eqIdx","0")
</script>
</head>

<body class="container">

  <div class="main_wrapper">
        <div class="btns">
        	<div class="btn" onclick="location.href='${path}/storeLogin.do'">가맹점<br>로그인</div>
        	<div class="btn" onclick="location.href='${path}/empLogin.do'">본사 직원<br>로그인</div>
        </div>
	</div>


</body>
</html>