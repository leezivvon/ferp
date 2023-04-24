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
<title>주문 확인</title>

<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>
<style type="text/css">
	.container{
		padding: 60px 0;
	}
	.topText, .btmText{
		display: flex;
		justify-content: center;
		gap: 50px;
	}
	
	
	.topCom, .btmCom{
		line-height: 100px;
	    width: 500px;
	    height: 100px;
	    background: #2262F3;
	    color: #fff;
	    font-size: 42px;
	    text-align: center;
	}
	
	.btmText ul{
	    width: 500px;
	    border: 5px solid #2262F3;
	    padding: 40px 0;
	}
	
	.btmText li{
	    font-size: 50px;
	    text-align: center;
	}
	
	.nameText{
		font-size: 30px;
		text-align: center;
		padding: 50px;
		font-weight: 600;
	}

</style>
</head>

<body>
    <div class="container">
    <p class="nameText">
    고객님 주문하신 메뉴 나왔습니다!<br>
    오늘도 ${login.frName}을 찾아주셔서 감사합니다.
    </p>
		<div class="topText">
			<div class="topCom">제조 완료</div>
			<div class="btmCom">제조 중</div>
		</div>
		<div class="btmText">
			<div class="com">
				<ul id="com-order-list">
				    <c:forEach var="co" items="${com}" begin="0" end="6">
				      <li>${co.orderNum}</li>
				    </c:forEach>
				  </ul>
			</div>
			<div class="ing">
			  <ul id="load-order-list">
			    <c:forEach var="lo" items="${load}">
			      <li>${lo.orderNum}</li>
			    </c:forEach>
			  </ul>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
//com 리스트 아이템에 대한 처리
$('.com li').each(function() {
  var orderNum = $(this).text().trim(); // 현재 li 태그의 텍스트 값을 가져옵니다.
  var lastFourDigits = orderNum.substr(orderNum.length - 4); // 마지막 4자리 숫자를 추출합니다.
  $(this).text(lastFourDigits); // li 태그의 텍스트 값을 마지막 4자리 숫자로 변경합니다.
});

// ing 리스트 아이템에 대한 처리
$('.ing li').each(function() {
  var orderNum = $(this).text().trim(); // 현재 li 태그의 텍스트 값을 가져옵니다.
  var lastFourDigits = orderNum.substr(orderNum.length - 4); // 마지막 4자리 숫자를 추출합니다.
  $(this).text(lastFourDigits); // li 태그의 텍스트 값을 마지막 4자리 숫자로 변경합니다.
});


$(document).ready(function() {
    setInterval(function() {
        location.reload();
    }, 5000);
});
</script>
</html>