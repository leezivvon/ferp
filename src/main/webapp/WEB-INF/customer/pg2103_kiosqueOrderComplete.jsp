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
<title>주문하기</title>

<!-- remixicon cdn -->
<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>

<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>

<!-- 알럿창 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style type="text/css">
	.wrap_container{
				max-width: 1200px;
				width: 100%;
				margin: 0 auto;
			}
		
	.headerTop{
		width: 100%;
		height: 90px;
		text-align: center;
		color: #fff;
		background: #2262F3;
		line-height: 90px;
	    font-size: 35px;
    	font-weight: 600;
	}
	
	
	p{
	    text-align: center;
	    font-size: 30px;
	    color: #2262F3;
	    font-weight: 500;
	    line-height: 55px;
	    padding: 100px 0 0;
	}
	
	.timeP{
		color: #666;
		font-size: 25px;
		padding: 20px 0 100px;
	}
	
	.orderNum{
		font-size: 45px;
		font-weight: 600;
	}
	
	.mainBtn{
		cursor: pointer;
	}
	
	.goMain{
		font-size: 25px;
	    color: #333;
	    text-align: center;
        line-height: 56px;
	}
	button {
		font-size: 20px;
	}
	
	.timeText{
		font-weight: 700;
		color: #333;
		font-size: 35px;
	}
	
	
</style>
</head>

<body>
	<div class="wrap_container">
		<div class="headerTop">
			결제 완료
		</div>
		<p>
		
			감사합니다.<br>
			결제가 완료되었습니다.<br>
			주문번호 : <span class="orderNum">${orderNum}</span><br>
		</p>
		<p class="timeP">
			예상 소요 시간은 <span class="timeText">${time}분</span>입니다.<br>
			매장 상황에 따라 소요시간이 변경될 수 있습니다.
		</p>
		<div class="goMain">
			<span class="goMainS">10</span>초 후에 메인으로 돌아갑니다.<br>
			<button class="mainBtn" onclick="location.href='${path}/kiosqueMainForCustomer.do'">메인으로</button>
		</div>
	</div>
	
</body>
<script type="text/javascript">
'use strict';

$(document).ready(function() {
	  var count = 10; // 타이머 초기값
	  var timer = setInterval(function() {
	    count--;
	    $('.goMainS').text(count); // 타이머 값 변경
	    if (count === 0) {
	      clearInterval(timer); // 타이머 종료
	      location.href = "${path}/kiosqueMainForCustomer.do"; // 메인 페이지로 이동
	    }
	  }, 1000); // 1초마다 타이머 실행
	});

var orderNum = $(".orderNum").text();
orderNum = orderNum.substr(-4);

$(".orderNum").text(orderNum);
</script>
</html>