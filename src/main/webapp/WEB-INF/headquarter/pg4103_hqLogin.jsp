<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*" 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ferp 매장 관리</title>


<!-- 아이콘 -->
<link rel="shortcut icon" type="image/x-icon" href="${path}/resource/img/favicon.ico" />


<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
<style type="text/css">
	header h2{
		text-align: center;
	    font-size: 25px;
	    line-height: 74px;
    }
    
    .logo{
		padding: 70px 0 10px;
    }
    
    .main_wrapper{
    	display: block;
    }
    
    input[name=frRegiNum]{
   	    width: 250px;
	    padding-left: 15px;
	    font-size: 15px;
	    height: 40px;
    }
    
    input[name=frPass]{
    	width: 250px;
    	font-size: 15px;
    	padding-left: 15px;
    	height: 40px;
    }
    
    .idBox{
   	    padding: 100px 0 10px;
	    text-align: center;
	    font-size: 20px;
	    display: flex;
	    justify-content: center;
    }
    
    .passBox{
    	text-align: center;
    	padding: 10px 0 70px;
    	font-size: 20px;
    	display: flex;
	    justify-content: center;
    }
    
    .loginBtn{
		display: block;
	    font-size: 18px;
	    font-family: inherit;
	    width: 120px;
	    height: 40px;
	    margin: auto;
	    background: #fff;
	    border: 1px solid #000;
	    border-radius: 5px;
	    cursor: pointer;
    }
    
    .loginBox{
    	margin: auto;
    }
    
    span{
    	width: 200px;
    	text-align: left;
    	display: block;
   	    line-height: 40px;
    }
    
        
    .pwText{
    	text-align: center;
	    padding: 60px;
	    line-height: 30px;
	    font-size: 17px;
	    color: #666;
    }
	
</style>
</head>

<body>
    <div class="container">
        <header>  
            <div class="logo">
                <h1><a href="#"><img src="${path}/resource/img/F.ERP.png" alt=""></a></h1>
            </div>
           	<h2>프랜차이즈 매장 관리 시스템</h1>
        </header>
        <div class="main_wrapper">
        <div class="loginBox">
        	<form method="post" id="loginForm">
        		<div class="idBox">
      				<span>사원 번호</span>
					<input type="text" name="empnum">
        		</div>
        		<div class="passBox">
        			<span>비밀번호</span>
					<input type="password" name="pass">
				</div>
				<button type="submit" class="loginBtn">로그인</button>
        	</form>
        </div>
        <p class="pwText">
        비밀번호 분실 시, 회사 인사팀 직원에게 직접 문의 부탁 드립니다.
        </p>
		</div>
    </div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		var loginState = "${loginState}";
		if(loginState == "틀림"){
			alert("아이디 혹은 비밀번호를 확인하세요.")
		}
	})
</script>
</html>