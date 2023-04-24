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
<title>점검결과조회</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style>
	.hdq_search{
		display:flex;
	 	background-color: rgba( 204, 204, 204, 0.2 );
	 	height:70px;
	    border-radius: 5px;
	    align-items: center; 
	    margin: 20px 0;
	    justify-content: center;
	}
	.hdq_search>form{
		 display: inline-flex;
		 width: 80%;
		 justify-content: space-between;
		 align-items: center;
	}	
	input[type=text]{
		height:30px;
		width: 25%;
	}
	/*검색버튼*/
	.frsalesSchBtn {
		font-size: 15px;
    	font-weight: 500;
		margin-left: 10px;
   		width: 65px;
   	 	border-radius: 5px;
   	 	border:0px;
	}
	
	
	#h3title{
		margin: 35px 0px 8px 5px;
	}
		   
	tbody tr{
		cursor:pointer;
	}
	tbody tr td{
		text-align: center;
	}
	.leftdata{
		text-align: left;
	}
	
</style>
</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			
			<h2>이달의 점검결과 조회</h2><br><hr><br>
			
			<!-- 검색 시작 -->
			<div class="hdq_search">
				<form method="post">
					<input class="infoSch" name="frname" value="${sch.frname}"  type="text" placeholder=" 매장명 입력"/>
					<input class="infoSch" name="frRepName" value="${sch.frRepName}"  type="text" placeholder=" 점주명 입력"/>
					<input class="infoSch" name="ename"  value="${sch.ename}" type="text" placeholder=" 담당직원 입력"/>
					<button class="frsalesSchBtn" type="submit">검색</button>
				</form>
			</div>
			<!-- 검색칸 끝 -->
			
			<!-- 정보출력표 시작-->
			<div>
			<h3 id="h3title">이번 달 매장점검 결과</h3>
				<table>
					<col width="21%">
					<col width="13%">
					<col width="13%">
					<col width="13%">
					<col width="20%">
					<col width="20%">
					<thead>
						<tr><th>매장명</th><th>매장번호</th><th>점주명</th><th>담당직원</th><th>점검예정일자</th><th>점검등록일자</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<!-- 정보출력표 끝 -->
			
			
			
			
		</div>
	</div>
</body>
<script>

	//사이드바에 번호 매긴 것 
	localStorage.setItem("pageIdx","6104") //id값
	localStorage.setItem("eqIdx","6000")
	
	
	var frname = $("[name=frname]").val();
	var frRepName = $("[name=frRepName]").val();
	var ename = $("[name=ename]").val();
	
	//ajax fetch사용
	function search(){
		let url="${path}/qaStoreJson.do?frname="+frname+"&frRepName="+frRepName+"&ename="+ename //검색값 넘기기
		//console.log(url);
		
		fetch(url).then(function(response){return response.json()}).then(function(json){
			//console.log(json);
			var qaStrlist=json.qaStrlist;
			var trtd='';
			var tdclick='';
			var tdDte='';
			
			qaStrlist.forEach(function(each){
				if(each.regDte!=null){
					tdclick="<tr onclick='goDetail("+each.frRegiNum+","+each.inspectDte.replace(/\-/g, '')+")'>"
					tdDte="<td>"+each.inspectDte+"</td><td>"+each.regDte+"</td></tr>"
				}else{
					tdclick="<tr onclick='goAlert()'>"
					tdDte="<td></td><td></td></tr>"
				}
				trtd+=tdclick+"<td class='leftdata'>"+each.frname+"</td><td>"+each.frRegiNum+"</td><td>"+each.frRepName+"</td><td>"+each.ename+"</td>"+tdDte
			})
			
			$("table tbody").html(trtd);
			//console.log(trtd);
		}).catch(function(err){console.log(err)})	

	}

	$(document).ready(function(){
	
		search();
	
	})
	
		//엔터검색
	$("input").on({
		keyup:function(){
			if(event.keyCode==13){
				search();
			}
		}
	});
	
	
	function goDetail(frRegiNum ,inspectDte){
		
		//var splitDte= inspectDte.split("-");
		//var inspectDte = inspectDte.replace(/\-/g, "");
		console.log(inspectDte)
		location.href="${path}/qaDetailInfo.do?frRegiNum="+frRegiNum+"&inspectDte="+inspectDte
		
		
	}
	function goAlert(){
		
	  Swal.fire({
		  title: '점검이 시행되지 않은 매장입니다.\n\n점검이 완료된 후 점검배정일과\n점검등록일이 출력됩니다.',
		  icon: 'warning',
		  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
		  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		  confirmButtonText: '확인' // confirm 버튼 텍스트 지정
		}).then((result) => {
		  if (result.value) {
		  }
		})
	}
	
</script>
</html>