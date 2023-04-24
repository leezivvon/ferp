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
<title>오픈 시간 점검</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

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
	#frs_salesInfo_table>h3{
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
			<h2>오픈 시간 점검</h2><br><hr><br>
			
			<!-- 검색 시작 -->
			<div class="hdq_search">
				<form method="post">
					<input class="infoSch" name="frName" value="${sch.frName}"  type="text" placeholder=" 매장명 입력"/>
					<input class="infoSch" name="frRepName" value="${sch.frRepName}"  type="text" placeholder=" 점주명 입력"/>
					<input class="infoSch" name="ename"  value="${sch.ename}" type="text" placeholder=" 담당직원 입력"/>
					<button class="frsalesSchBtn" type="submit">검색</button>
				</form>
			</div>
			<!-- 검색칸 끝 -->
			
			<!-- 정보출력표 시작-->
			<div id="frs_salesInfo_table">
			<h3>오픈 시간 조회</h3>
				<table>
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<thead>
						<tr><th>매장명</th><th>오픈시간</th><th>매장전화번호</th><th>점주명</th><th>담당직원</th></tr>
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
	localStorage.setItem("pageIdx","6202"); //id값
	localStorage.setItem("eqIdx","6000");
	
	
	var frName = $("[name=frName]").val();
	var frRepName = $("[name=frRepName]").val();
	var ename = $("[name=ename]").val();
	
	//ajax fetch사용
	function search(){
		let url="${path}/strOpenInfoJson.do?frName="+frName+"&frRepName="+frRepName+"&ename="+ename  //검색값 넘기기
		console.log(url);
		
		fetch(url).then(function(response){return response.json()}).then(function(json){
			console.log(json);
			var optimelist=json.optimelist;
			var trtd='';
		
			optimelist.forEach(function(each){
				trtd+="<tr onclick='goDetail("+each.frRegiNum+")'><td class='leftdata'>"+each.frName+"</td><td>"+each.frOperTime+"</td><td>"+each.frTel+"</td><td>"+each.frRepName+"</td><td>"+each.ename+"</td></tr>"
			})
			$("table tbody").html(trtd);
			console.log(trtd);
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

	
			
	function goDetail(frRegiNum){
		location.href="${path}/openTimeCalendar.do?writer="+frRegiNum
	}

</script>
</html>