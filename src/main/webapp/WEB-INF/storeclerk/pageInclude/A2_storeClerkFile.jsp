<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<link rel="stylesheet" href="${path}/resource/css/reset.css">
<link rel="stylesheet" href="${path}/resource/css/A2_jhCSS.css">
<link rel="stylesheet" href="${path}/resource/css/A2_storeclerkJH.css">
<link rel="stylesheet" href="${path}/resource/css/A2_fileCss.css">
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>
</head>
<body>
	<h2 class="h2Title"><span id="clerkname"></span><span class="clerknum">(#ID : <span id="clerknum"></span>)</span></h2>
	<br>
	<div>
		<div>
			<form id="fileUpl"  action="${path}/clerkfilemanage.do" enctype="multipart/form-data" method="post">
				<div class="toolbox">
					<div class="filebox">
						<div class="margin-sm fileInput">
						    <input class="upload-name" value="첨부파일" placeholder="첨부파일" readOnly><label for="file">파일찾기</label> 
						    <input type="file" id="file" name="multiFileList" onchange="filename()" multiple>
						    <button type="button" class="addFile">등록</button>
						</div>
						<div>
							<input name="clerkNum" class="fileip" type="hidden">
							<input name="frRegiNum" type="hidden" value="${login.frRegiNum }">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	function filename(){
		var fileInput = document.getElementById("file");
		var files = fileInput.files;
		var i = files.length
		if(i == 1){
			$('.upload-name').val($("#file").val())			
		}else{
			$('.upload-name').val($("#file").val()+" 외 "+parseInt(i-1) + "개")			
		}
	}
	function fileUpt(i){
		if(confirm("수정하시겠습니까?")){
			$("#fileFrm"+i).attr("action","${path}/uptClerkFile.do").submit();
		}
	}
	function fileDel(i){
		if(confirm("삭제하시겠습니까?")){
			$("#fileFrm"+i).attr("action","${path}/delClerkFile.do").submit();
		}
	}
	$(".addFile").click(function(){
		if($(".upload-name").val() == '첨부파일'){
			alert("등록파일을 선택해주세요")
		}else{
			alert("등록되었습니다")
			$("#fileUpl").submit()
		}
	})
		
	
</script>
</html>