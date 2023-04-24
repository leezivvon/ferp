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
<title>담당 매장 점검</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />

<style>
	
	.contents{
		position: relative;
	}
	
	
	/*매장사이드바*/
	ul#storeSideBar{
		list-style-type:none;
		width:300px;
		padding:0;
		margin:0;
		position: absolute;
		height:100%;
		overflow:auto;
		border-top: 2px solid #525252;
	}
	.inchrgStore{
		display:block;
		background-color:#DDD;
		padding:17px 15px;
		font-weight:600;
		font-size:20px;
		border: 2px solid #525252;
		border-top: none;
		border-right: none;
	}
	.inchrgStore:hover{
		background-color:#BDBDBD;
		cursor:pointer;
	}
	.inchrgStore:focus{
		box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .5)
	}
	
	
	div#thatStrInspctList{
		border: 2px solid #525252;
		margin-left: 298.5px;
		padding:30px 20px;
		height: 450px;
    	width: 67%;
    	max-width: 1200px;
    	min-width:800px;
		position: absolute;
	}
	
	
	/* 이번달배정일 */
	#thisMonthInspect{
		background-color:#fff;
		font-size:25px;
		font-weight: 600;
		display:flex;
		justify-content: space-between;
		text-align: center;
		vertical-align: middle;
		height: 70px;
		line-height:70px;
   		border-radius: 10px;
    	width: 75%;
    	min-width:600px;
    	padding: 10px 60px;
    	margin: 0 auto;

	}
	#thisMonthInspect>div{
		align-self: center;
	}
	.assignDt{
		margin-left:20px;
		font-weight:800;
		font-size:35px;
	}
	/* 등록버튼 */
	.btn-primary{
		width:80px;
		height:40px;
		line-height: 40px;
		border-radius:10px;
		margin-left:10px;
	}
	
	#thisMnthPrint{
		width:80px;
		height:40px;
		line-height: 40px;
		border-radius:10px;
		margin-left:10px;
		font-size:25px;
	}

	
	
	/* 과거점검기록목록 */
	#pastInsepctList{
		margin: 30px 20px;
    	font-size: 23px;
    	font-weight: 600;
	}
	#pastInsepctList>h3{
		text-align: center;
	}
	
	.pastInsepctRecord{
		display:flex;
		justify-content: space-between;
		text-align: center;
		width:95%;
		align-items:center;
		margin:0 auto;
		padding-bottom:20px;
	}
	.pIspctDt{
		padding-right:15px;
	}
	.pIspctRslt{
		color:#DB5461;
		font-size: 23px;
	}
	
	/* 조회버튼 */
	.btn-secondary{
		border-radius:10px;
		height:35px;
		line-height:35px;
		width:60px;
		font-size:23px;
	}
	
	
	
	
	/* 과거QA결과 */
	/* 모달 창 */
	.modal {
	  position:fixed;
	  left:0; right: 0; 
	  top:0; bottom:0;
	  background:rgba(0,0,0,0.8);
	  z-index:100;
	  padding: 120px 110px 0;
	}
	.modal_content{
	  position:relative; 
	  background:#fff; 
	  min-width: 1000px;
	  width: 70%;
	  border-radius:20px;
	  padding: 40px;
	  margin:0 auto;
	}
	.modal_title{
		font-size:20px;
		margin-bottom:30px;
		text-align:center;
		vertical-align: middle;
	}
	.modal_title>span{
		font-size:23px;
		font-weight:600;
	}
	.modal_body{
		display:block;
    	width: 100%;
	}
	.modal-footer{
		display:flex;
		jsutify-content:end;
	}
	button.close{
		margin-left: auto;
		margin-top:20px;
	}
	table td{
		vertical-align: middle;
		pointer-events: none;
	}
	
	.ctrdata{
		text-align: center;
	}
	
	#noFrnum{
		display:none;
		position: relative;
		width:100%;
		height: 450px;
		background-color:#fff;
		font-size:25px;
		font-weight:900;
		text-align:center;
		z-index:99999;
		line-height:450px;
	}
	
	

</style>


</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			
			
			<h2>담당매장 QA</h2><br><hr><br>
			

			<div id="noFrnum">
				<h2>${ename}님이 담당하고 있는 매장이 없습니다</h2>
			</div>			
			
		
			<!-- 왼쪽 사이드 바 시작 -->
			<ul id="storeSideBar">
				<c:forEach var="ics" items="${icStrlist}">
					<li onclick="strQAInfo('${ics.frRegiNum}')" ><div class="inchrgStore"> ${ics.frName } </div></li>	
				</c:forEach>								
			</ul>
			<!-- 왼쪽 사이드 바 끝 -->
			
			
			<!-- 해당 매장점검일 목록 시작  -->
			<div id="thatStrInspctList">			
				
				<!-- 이번달점검일안내 -->
				<div id="thisMonthInspect"></div>
				
				<!-- 지난점검일조회 -->
				<div id="pastInsepctList">
					<h3>조회하려는 담당매장을 선택하세요</h3>
				</div>
					
			</div>
			<!-- 해당 매장점검일 목록 끝 -->
			
			<!-- 과거점검결과 시작 -->
			<div class="modal" id="pastQA" role="dialog" >
				<div class="modal_content">		    
			      
			      <div class="modal_header">
			        <h3 class="modal_title"></h3>
			      </div>
			      
			      <div class="modal_body">
			        <table>
			        	<col width="10%">
						<col width="60%">
						<col width="10%">
						<col width="20%">
			        	<thead>
			        		<tr><th>항목번호</th><th>항목</th><th>이상없음</th><th>비고</th></tr>
			        	</thead>
			        	<tbody></tbody>
			        </table>
				    <div class="modal-footer">
				        <button type="button" class="close" >창닫기</button>
				    </div>
			      </div>		    
			    
			    </div>
			</div>	
			<!-- 과거점검결과 끝 -->

			
			
		</div>
	</div>
	
</body>

<script>
	//사이드바에 번호 매긴 것 
	localStorage.setItem("pageIdx","6101"); //id값
	localStorage.setItem("eqIdx","6000");
	
	//특정매장 점검목록
	function strQAInfo(frRegiNum){
		
		let url="${path}/inchargeStrQA.do?frRegiNum="+frRegiNum
		
		fetch(url).then(function(response){return response.json()}).then(function(json){
			
			
			//첫째행만 따로 출력	
			var firstJs=json.sQAinfo[0]; 
	
			var inspectDate = new Date(firstJs.inspectDte); //점검날짜
			var today = new Date(); //오늘날짜

			var compareRslt = today.getTime()-inspectDate.getTime();
			
			//테스트
			/*
			today.setHours(today.getHours() +21);
			today.setMinutes(today.getMinutes() +43);
			console.log(today.toLocaleString());
			*/
			
			//등록일전까지 버튼클릭 불가능
			//등록하면 조회버튼으로 변경
			if(firstJs.regDte=='-'&&compareRslt<0){
				var thisDiv="<div>이번 달 점검일</div><div class='assignDt'>"+firstJs.inspectDte+"</div><div onclick='goAlert()' class='btn-primary' style='background-color:#003B7A;color:#86929F'>등록</div>"
			}else if(firstJs.regDte=='-'&&compareRslt>=0){
				var thisDiv="<div>이번 달 점검일</div><div class='assignDt'>"+firstJs.inspectDte+"</div><div onclick='goInspect("+frRegiNum+")' class='btn-primary'>등록</div>"
			}else{
				var thisDiv="<div>이번 달 점검일</div><div class='assignDt'>"+firstJs.inspectDte+"</div><div onclick='thatMonthResult(\""+firstJs.inspectionNum+"\", \""+frRegiNum+"\")' class='btn-secondary' id='thisMnthPrint'>조회</div></div>"
			}
			
			$("#thisMonthInspect").html(thisDiv);
			
			
			
			//남은 행 출력
			var sQAinfo=json.sQAinfo.slice(1);
			var divs='';		
			sQAinfo.forEach(function(each){		
				divs+="<div class='pastInsepctRecord'>"
					+"<div class='pIspctDt'>"+each.inspectDte.substring(0,4)+"년 "+each.inspectDte.substring(5,7)+"월"+"</div>"
					+"<div class='pIspctAssignDt'>배정일&nbsp;&nbsp;"+each.inspectDte+"</div>"
					+"<div class='pIspctRegDt'>등록일&nbsp;&nbsp;"+each.regDte+"</div>"
					+"<div class='pIspctRslt'>"+each.ycnt+"/"+each.qncnt+"</div>"
					+"<div onclick='thatMonthResult(\""+each.inspectionNum+"\", \""+frRegiNum+"\")' class='btn-secondary'>조회</div></div>"				
			})		
			$("#pastInsepctList").html(divs);
			
		}).catch(function(err){console.log(err)});
		
		$("#thisMonthInspect").css("background-color","#BEDCFE");
	}

	// 모달
	// 과거점검결과 조회  
	function thatMonthResult(inspectionNum, frRegiNum){
		$(".modal").fadeIn();
		let url="${path}/inchargeStrPastQA.do?frRegiNum="+frRegiNum+"&inspectionNum="+inspectionNum
		
		fetch(url).then(function(response){return response.json()}).then(function(json){
			
			//inspectDte 이것만 출력하고
			var inspectDtJ=json.sPasteQA[0];
			var inspectDt=inspectDtJ.inspectDte  //2023.02.22
			var inspectYear=inspectDt.substring(0,4);
			var inspectMonth=inspectDt.substring(5,7);
			

			//결과표출력
			var sPasteQA=json.sPasteQA;
			var trtd='';
			var tdRslt='';
			sPasteQA.forEach(function(each){
				if(each.results=="Y"){
					tdRslt="○"
				}else if(each.results=="N"){
					tdRslt="-"
				}
				trtd+="<tr><td class='ctrdata'>"+each.qaNum+"</td><td>"+each.qaItem+"</td><td class='ctrdata'>"+tdRslt+"</td><td>"+each.comments+"</td></tr>"
			})
			
			//inspectDte
			$(".modal_title").html("<span>"+inspectYear+"년 "+inspectMonth+"월</span>"+" 점검결과");
			//결과표출력
			$("table tbody").html(trtd);
			
		}).catch(function(err){console.log(err)})	

	}
	
	
	$(function(){
		
		//담당매장아니면 숨김처리	
		if( "${icStrlist}".length==2 ){ // 이게 맞아..?ㅋㅋㅋ빈배열 []이거 두 개란 뜻이야.,,ㅋㅋㅋㅋ어이없어
			$("#noFrnum").css("display", "block");
			$("#storeSideBar").css("display", "none");
			$("#thatStrInspctList").css("display", "none");
		}else{
			$("#noFrnum").css("display", "none");
		}
		
		
		
		//취소버튼
		$(".close").click(function(){
			$(".modal").fadeOut();
		});
		
		
	})
	

	
	// 페이지이동
	// 등록
	function goInspect(frRegiNum){
		location.href="${path}/inspectQAPrint.do?frRegiNum="+frRegiNum
	}
	
	function goAlert(){
		
	  Swal.fire({
		  title: '아직 점검일이 아닙니다',
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