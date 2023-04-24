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
<title>메뉴 조회</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/notice_list.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","4301")
	localStorage.setItem("eqIdx","4300")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
          	<h2 class="notice_main">메 뉴 조 회</h2>
         	<div class="sch_line">
         		<form method="post">
	           		<input type="text" name="menuName" id="title" value="${sch.menuName}" placeholder="메뉴명 검색">
					<button type="button" class="schBtn">검 색</button>
					<input type="hidden" name="curPage" value="${sch.curPage}"/>
				</form>
         	</div>
	  		<div class="row">
				<div class="thDiv" style="width: 25%;">메뉴명</div>
				<div class="thDiv" style="width: 45%;">메뉴설명</div>
				<div class="thDiv" style="width: 15%;">가격</div>
				<div class="thDiv" style="width: 20%;">카테고리</div>
			</div>
			<div>
				<c:forEach var="menu" items="${menu}">
					<div class="row p${menu.menuNum}">
						<div class="tdDiv" style="width: 25%;">${menu.menuName}</div>
						<div class="tdDiv" style="width: 45%; text-align: left;">${menu.info}</div>
						<div class="tdDiv" style="width: 15%; text-align: right; padding-right: 40px;">
							<fmt:formatNumber value="${menu.price}" type='currency'/>
						</div>
						<div class="tdDiv" style="width: 20%;">${menu.category}</div>
					</div>
					<img style="width: 120px; height: 120px;" src="${path}/resource/img/${menu.img}" class="p preview${menu.menuNum}"/>
					<style>
					.p${menu.menuNum}:hover ~ .preview${menu.menuNum}{
						position:absolute;
						display:block;
					}
					</style>
					<script type="text/javascript">
						$(".p${menu.menuNum}").mouseover(function(e){
							$(".preview${menu.menuNum}").css({
								left: e.pageX+50,
							    top: e.pageY
							 });
						})
	
					</script>
				</c:forEach>
			</div>       	
		
			<div class="page_wrap">
			   <div class="page_nation">
			   <c:if test="${sch.startBlock > 0}">
			      <a class="arrow prev" href="javascript:goPage(${sch.startBlock-1});"></a>
				      <c:forEach var="cnt" begin="${sch.startBlock}" end="${sch.endBlock}">
				      	<a href="#" class="${sch.curPage==cnt?'active':''}" onclick="goPage(${cnt})">${cnt}</a>
				      </c:forEach>
			      <a class="arrow next" href="javascript:goPage(${sch.endBlock+1});"></a>
			   </c:if>
			   </div>
			</div>
			
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
    var insMsg = "${insMsg}"
    if(insMsg != ""){
	  Swal.fire({
		  title: '등록 성공!',
		  icon: 'success',
		  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
		  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		}).then((result) => {
		  if (result.value) {
			//"확인" 버튼을 눌렀을 때 작업할 내용
		  }
		})	
    }
    
    $(".schBtn").click(function(){
    	$("form").submit()
    })
});
function goPage(cnt) {
	$("[name=curPage]").val(cnt);
	$("form").submit()
}
</script>
</html>