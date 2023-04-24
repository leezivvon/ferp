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
<title>매장 상세 조회</title>

<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />

<style type="text/css">
	#backBtn{
		color: #fff;
		background-color: #007bff;
		width:140px;
		height:33px;
		border-radius:50px;
		text-align: center;/*가로정렬*/
    	line-height: 33px;/*세로정렬*/
	}
	#backBtn:hover {
		background-color: #0069d9;
		cursor:pointer;
	}
	#backBtn.focus, #backBtn:focus {
		box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .5)
	}


	.storePrint{
		margin:30px 0px 40px 5px;
	}
	.storePrint>div{
	    margin: 10px 3px;
	    font-size: 18px;
	    font-weight: 500;
	    display:flex;
	    gap: 10px;
	}.storePrint>h1{
		margin-bottom:15px;
	}
	span.strifo_header {
    	font-weight: 600;
    	width:100px;
	}	
	span.strifo_rslt{
		width:400px;
	}
	
	.period{
		display: flex;
	    margin: 0px 0px 15px 5px;
	    align-items: center;
	    gap: 30px;
	}
	#detail{
		display: inline-block;
    	margin: 30px 0px 15px 5px;
	}

	
	
	.salesResult{
		text-align: end;
    	display: inline-block;
    	width:100%;
    	font-size: 19px;
    	font-weight: 600;
    	float: right;
    	margin: 10px 0;
	}
	.salesResult>div{
		float:right;
	}
	.salesResult>div>div{
		display: flex;
		justify-content: space-between;
		margin: 2px 5px 2px 20px;
		gap:30px;
	}
	.salesResult>div>div>hr{
		margin: 3px 0px;
	}

	.numdata{
		text-align: end;
	}
	#lastResult{
		justify-content: end;
	}
	
</style>

</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		
			<h2>매장 상세 조회</h2><br><hr><br>
			
			<!-- 이전페이지가기 버튼-->
			<div onclick="back()" id="backBtn">
			 &lt; 전체조회페이지
			</div>
			
			<!-- 그냥 불러오기 -->
			<!-- 매장정보출력 시작 -->
			<div class="storePrint">
				<h1>${dinfo.frname }</h1>
				<div><span class="strifo_header">사업자번호</span><span>${dinfo.frRegiNum }</span></div>
				<div><span class="strifo_header">개업일자</span><span>${dinfo.frOpen }</span></div>
				<div><span class="strifo_header">매장주소</span><span class="strifo_rslt">${dinfo.frAddress }</span>&nbsp;<span class="strifo_header">전화번호</span><span>${dinfo.frtel }</span></div>
				<div><span class="strifo_header">점주</span><span class="strifo_rslt">${dinfo.frRepname }</span>&nbsp;<span class="strifo_header">담당직원</span><span>${dinfo.ename }</span></div>
			</div>
			<!-- 매장정보출력 끝-->
			
			<!-- json으로 불러오기 -->
			<!-- 매출조회 시작 -->
			<% 
			request.setCharacterEncoding("UTF-8");
			String frSchOrderdt =request.getParameter("frSchOrderdt");
			String toSchOrderdt =request.getParameter("toSchOrderdt");
			%>
			<div class="period">
				<h2>매매액 조회 기간</h2>
				<form method="post">
					<input id="strperiod" name="frSchOrderdt" value="<%=frSchOrderdt %>" type="month"/>
					~
					<input id="endperiod" name="toSchOrderdt" value="<%=toSchOrderdt %>" type="month"/>
				</form>
			</div>
			<table class="storeSales_table">
					<col width="15%">
					<col width="30%">
					<col width="30%">
					<col width="25%">
				<thead>
					<tr><th>날짜</th><th>매장 매출액</th><th>매장 매입액</th><th>순수익</th></tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<!-- 매출조회 끝 -->
			
			
			<!-- 결과값출력 시작 -->
			<div class="salesResult">
			<div>
				<div><span>총 매출액</span><span id="fsales"> </span></div>
				<div><span>총 매입액</span><span id="fpurchase"> </span></div>
				<hr>
				<div id="lastResult"><span></span></div>
			</div>
			</div>
			<!-- 결과값출력 끝 -->
			
			
			<!-- 매출상세내역 시작 -->
			<h2 id="detail">조회기간 내 판매내역</h2>
			<table class="storeDetailSales_table">
					<col width="30%">
					<col width="20%">
					<col width="20%">
					<col width="30%">
				<thead>
					<tr><th>판매메뉴</th><th>가격</th><th>판매개수</th><th>총 판매액</th></tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			
			<!-- 매출상세내역 끝 -->
			
			

			
		</div>
	</div>
</body>

<script type="text/javascript">
	//사이드바에 번호 매긴 것 
	localStorage.setItem("pageIdx","4201"); //id값
	localStorage.setItem("eqIdx","4000");

	
	frSchOrderdt = $("[name=frSchOrderdt]").val();
	toSchOrderdt = $("[name=toSchOrderdt]").val();
	console.log("1"+"<%=frSchOrderdt %>")
	//ajax fetch사용
	function print(){
		let url="${path}/detailInfoJson.do?frRegiNum="+${dinfo.frRegiNum}+"&frSchOrderdt="+frSchOrderdt+"&toSchOrderdt="+toSchOrderdt  //검색값 넘기기
		
		console.log(url);
		
		fetch(url).then(function(response){return response.json()}).then(function(json){
			console.log(json);
			
			var dInfoList=json.dInfoList;
			var trtdst='';
			var trtdnd='';
			var sumfrsales=0;
			var sumfrpurchase=0;
		
			dInfoList.detailSales.forEach(function(seach){
				trtdst+="<tr><td>"+seach.orderDate+"</td><td class='numdata'>"+seach.frsales.toLocaleString()+"</td><td class='numdata'>"+seach.frpurchase.toLocaleString()+"</td><td class='numdata'>"+seach.profit.toLocaleString()+"</td></tr>"
				
				sumfrsales+=seach.frsales;
				sumfrpurchase+=seach.frpurchase;
			})
			dInfoList.detailMenu.forEach(function(meach){
				trtdnd+="<tr><td>"+meach.menuName+"</td><td class='numdata'>"+meach.price.toLocaleString()+"</td><td class='numdata'>"+meach.mcnt.toLocaleString()+"</td><td class='numdata'>"+meach.msales.toLocaleString()+"</td></tr>"
			})
			
			$(".storeSales_table tbody").html(trtdst);
			
			$("#fsales").html(sumfrsales.toLocaleString()+"&nbsp;원");
			$("#fpurchase").html(sumfrpurchase.toLocaleString()+"&nbsp;원");
			$("#lastResult span").html("총 수익&nbsp;&nbsp;"+(sumfrsales-sumfrpurchase).toLocaleString()+"&nbsp;원");
			
			$(".storeDetailSales_table tbody").html(trtdnd);
					
		}).catch(function(err){console.log(err)})	
	
	}
	
	
	$(document).ready(function(){
		print();
		
		//날짜를 검색
		$("[type=month]").change(function(){
			frSchOrderdt = $("[name=frSchOrderdt]").val();
			toSchOrderdt = $("[name=toSchOrderdt]").val();
			
			if(frSchOrderdt<=toSchOrderdt){
				print();
			}else{
				
			  Swal.fire({
				  title: '검색날짜에 유의하세요',
				  icon: 'warning',
				  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
				  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				  confirmButtonText: '확인' // confirm 버튼 텍스트 지정
				}).then((result) => {
				  if (result.value) {
					$("[name=frSchOrderdt]").val(toSchOrderdt);

				  }
				})
				
			}
		})
	})
	
	//이전페이지가기 클릭
	function back(){
		history.back();
	}

</script>
</html>