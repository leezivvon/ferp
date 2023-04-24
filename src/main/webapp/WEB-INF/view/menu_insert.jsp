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
<title>메뉴등록</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/insertPage.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","4302")
	localStorage.setItem("eqIdx","4300")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
        	<form enctype="multipart/form-data" method="post">
     	        <h2 class="insert_product">메 뉴 등 록</h2>
     	        <div class="top_line">
	     	        <input type="hidden" name="necessary">
		        	<input type="checkbox" id="necessary" >
		        	<span>선택가능여부</span>
	        	</div>

        	<div class="content">
				<div class="first_line">
					<h3 class="menu_name">메뉴명</h3>
					<h3 class="menu_price">가격</h3>
				</div>
				<div class="second_line">
					<input type="text" name="menuName" placeholder="메뉴명 입력">
					<input type="number" name="price" placeholder="판매가 입력">
				</div>
				<div class="third_line">
					<h3 class="menu_info">메뉴설명</h3>
					<h3 class="menu_category">카테고리</h3>
				</div>
				<div class="fourth_line">
					<input type="text" name="info" placeholder="메뉴설명 입력">
					<select name="category">
						<option disabled="disabled" selected="selected">카테고리 선택</option>
						<c:forEach var="category" items="${menuCategoryCombo}">
							<option>${category}</option>
						</c:forEach>
					</select>
				</div>
				<div class="fifth_line">
					<h3 class="menu_img">메뉴사진</h3>
				</div>
				<div class="sixth_line">
					<div class="block">
						<div class="img_block">
							<input class="upload-name" type="text" value="파일선택" disabled="disabled" style="width: 290px;">
							
			              	<label for="input_file">업로드</label> 
             				<input type="file" name="multipartfile" id="input_file" class="upload-hidden" > 
						</div>
					</div>
				</div>
				<div class="submit_line">
					<button type="button" class="insBtn">등 록</button>
				</div>
			</div>	
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){

	
    $(".insBtn").click(function(){
		if($('#necessary').is(':checked')){
			$("input[name=necessary]").attr('value','Y');
		}
		if(!$('#necessary').is(':checked')){
			$("input[name=necessary]").attr('value','N');
		}
		var isPass = false;
		var imgFile = $('.upload-name').val();
		var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;

	    if(imgFile.match(fileForm)) {
	    	isPass = true;
	    }
		
		  Swal.fire({
			  title: '등록하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				  if($("[name=menuName]").val() == ""){
					  Swal.fire({
						  title: '메뉴명을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=menuName]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=price]").val() == ""){
					  Swal.fire({
						  title: '판매가를 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=price]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=info]").val() == ""){
					  Swal.fire({
						  title: '메뉴설명을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=info]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=category]").val() == ""){
					  Swal.fire({
						  title: '카테고리를 선택해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=category]").focus()
						      return;
						  }
					  })
				  }
				  else if($(".upload-name").val() == "파일선택"){
					  Swal.fire({
						  title: '메뉴사진을 등록해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
						      return;
						  }
					  })
				  }
				  else if(!isPass){
					  Swal.fire({
						  title: '이미지 파일만 업로드 가능합니다.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
						      return;
						  }
					  })					  
				  }
				  else{
					  $("form").submit();
				  }
				  
			  }
			})	    	
  	})

   var fileTarget = $('.img_block .upload-hidden');

    fileTarget.on('change', function(){
        if(window.FileReader){
            // 파일명 추출
            var filename = $(this)[0].files[0].name;
        } 

        else {
            // Old IE 파일명 추출
            var filename = $(this).val().split('/').pop().split('\\').pop();
        };

        $(this).siblings('.upload-name').val(filename);
    });

    //preview image 
    var imgTarget = $('.img_block .upload-hidden');

    imgTarget.on('change', function(){
        var parent = $(this).parent();
        parent.children('.upload-display').remove();

        if(window.FileReader){
            //image 파일만
            if (!$(this)[0].files[0].type.match(/image\//)) return;
            
            var reader = new FileReader();
            reader.onload = function(e){
                var src = e.target.result;
                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }

        else {
            $(this)[0].select();
            $(this)[0].blur();
            var imgSrc = document.selection.createRange().text;
            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

            var img = $(this).siblings('.upload-display').find('img');
            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
        }
    });
    
    

});
</script>
</html>