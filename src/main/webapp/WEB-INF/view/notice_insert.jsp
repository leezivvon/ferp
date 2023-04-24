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
<title>공지사항 등록</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/notice_insert.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","5002")
	localStorage.setItem("eqIdx","5000")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
	        <form enctype="multipart/form-data" method="post">
	        	<h2 class="insert_product">공지사항 등록</h2>	
	        	<div class="top_line">
			        <input type="hidden" name="important">
		        	<input type="checkbox" id="important">
		        	<span>중요공지사항</span>
	        	</div>
	    	    
	        	<div class="content">
	        		<input type="hidden" name="writer" value="본사">
					<div class="first_line">
						<h3 class="notice_title">제목</h3>
					</div>
					<div class="second_line">
						<input type="text" name="title" placeholder="공지사항 제목 입력">
					</div>
					<div class="third_line">
						<h3 class="notice_content">내용</h3>
					</div>
					<div class="fourth_line">
						<textarea name="content" rows="15" cols="70" placeholder="공지사항 내용 입력"></textarea>
					</div>
					<div class="fifth_line">
						<h3 class="notice_file">파일</h3>
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
		if($('#important').is(':checked')){
			$("input[name=important]").attr('value','o');
		}
		if(!$('#important').is(':checked')){
			$("input[name=important]").attr('value','x');
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
				  if($("[name=title]").val() == ""){
					  Swal.fire({
						  title: '공지사항 제목을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=title]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=content]").val() == ""){
					  Swal.fire({
						  title: '공지사항 내용을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=content]").focus()
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