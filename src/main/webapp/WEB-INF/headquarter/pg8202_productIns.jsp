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
<title>자재 등록</title>
<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<style>
#insform {
	position: absolute;
	display: block;
	text-align: center;
	margin: auto;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width : 500px;
	padding: 25px;
	border: 1px solid #FFFFFF;
	border-radius: 5px;
	background-color: #FFFFFF;
}
body{
	background-color: #f5f5f5;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#insBtn").click(function(){
			var isInValid = false
			for(var idx=0;idx<$(".ckValid").length;idx++){
				if($(".ckValid").eq(idx).val()==""){
					alert("입력하여야 등록 가능합니다.")
					$(".ckValid").eq(idx).focus()
					isInValid = true
					break;
				}
			}
			if(isInValid){
				return
			}
			Swal.fire({
				title: '등록하시겠습니까?',
				icon: 'warning',
				showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				confirmButtonText: '확인', // confirm 버튼 텍스트 지정
				cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
				if (result.value) {
					$("form").submit()
				}
			})
		})
		$("#returnBtn").click(function(){
			location.href = "${path}/hproductList.do"
		})
	});
</script>
</head>
<body>
	<div>
		<div id="insform">
			<h2>자재 등록</h2>
			<form method="post" enctype="multipart/form-data"
				action="${path}/hproductIns.do" novalidate>
				<table>
					<tr><th><label for="category">카테고리명</label></th>
						<!-- <td><input type="text" name="category" value="${param.category}" 
							class="ckValid" id="category" placeholder="카테고리명 입력" required></td></tr> -->
						<td><select name="category" class="ckValid" id="category" required>
								<option value="">카테고리를 선택하세요</option>
								<option value="유제품" ${param.category == '유제품' ? 'selected' : ''}>유제품</option>
								<option value="면세_과일" ${param.category == '원두' ? 'selected' : ''}>면세_과일</option>
								<option value="원두 및 커피" ${param.category == '원두 및 커피' ? 'selected' : ''}>원두 및 커피</option>
								<option value="차 및 티" ${param.category == '차 및 티' ? 'selected' : ''}>차 및 티</option>
								<option value="시럽 및 음료재료" ${param.category == '시럽 및 음료재료' ? 'selected' : ''}>시럽 및 음료재료</option>
								<option value="디저트 및 빵" ${param.category == '디저트 및 빵' ? 'selected' : ''}>디저트 및 빵</option>
								<option value="MD 상품" ${param.category == 'MD 상품' ? 'selected' : ''}>MD 상품</option>
								<option value="식기류" ${param.category == '식기류' ? 'selected' : ''}>식기류</option>
								<option value="일회용품" ${param.category == '일회용품' ? 'selected' : ''}>일회용품</option>
								<option value="서비스용품" ${param.category == '서비스용품' ? 'selected' : ''}>서비스용품</option>
								<option value="청소용품" ${param.category == '청소용품' ? 'selected' : ''}>청소용품</option>
								<option value="기타 용품" ${param.category == '기타 용품' ? 'selected' : ''}>기타 용품</option>
							</select></td></tr>
					<tr><th><label for="productName">자재명</label></th>
						<td><input type="text" name="productName" value="${param.productName}" 
							class="ckValid" id="productName" placeholder="자재명 입력" 
							max="50" required></td></tr>
					<tr><th><label for="opposite">거래처</label></th>
						<td><input type="text" name="opposite" value="${param.opposite}"
							class="ckValid"	id="opposite" placeholder="거래처 입력" required></td></tr>
					<tr><th><label for="price">단가</label></th>
						<td><input type="text" name="price" value="${param.price}"
							class="ckValid" id="price" placeholder="단가 입력" required></td></tr>
					<tr><th><label for="remark">비고</label></th>
						<td><input type="text" name="remark" value="${param.remark}" 
							id="remark" placeholder="비고 입력"></td></tr>
					<tr><th><label class="custom-file-label" for="file01">이미지</label></th>
						<td><input type="file" name="multipartfile" id="file01"></td></tr>
				</table>
				<button id="insBtn" class="btn-primary" type="button">등록</button>
				<button id="returnBtn" class="btn-submit" type="button">닫기</button>
			</form>
		</div>
	</div>
</body>
</html>