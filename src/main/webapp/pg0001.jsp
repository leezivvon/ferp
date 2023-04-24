<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DASHBOARD</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<link rel="stylesheet" href="/ferp/resource/css/popup.css"/>
<script type="text/javascript" src="${path }/resource/js/sy_fetchs.js"></script>

<style type="text/css">
.notice_top{
	display: flex;
	align-items: center;
}
.refreshBtn {
    font-size: xx-large;
    padding: 0;
    height: 30px;
    width: 30px;
    margin: 11px 0px 0px 5px;
}
.refreshText {
	position: absolute;
    margin-top: -17px;
    margin-left: -11px;
    color: white;
    font-size: 22px;
}
p{
    padding: 5px 0px 5px 0px;
}
.popup_bottom > a{
	text-decoration:none; 
}
.pull-right{float:right}
.main_popup{
	width:350px;
	height:350px;
	border:3px solid #3E4156;
	border-radius: 30px;
	background-color: white;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	padding: 30px 25px 10px 25px;
}

.popup_bottom{
    color: black;
	padding: 9px 30px 3px 20px;
    width: 100%;
    font-weight: bold;
    font-size: 14px;
}
pre{
	white-space: pre-line;
    font-size: 15px;
    font-family: inherit;
    height: 220px;
    overflow: auto;
    margin-top: 14px;
}

.dimmed{
	position: fixed;
	width: 100vw;
	height: 100vh;
	top: 0;
	left: 0;
	background-color: rgba(0,0,0,0.5);
	z-index: -1;
	opacity: 0;
	pointer-events: none;
}
.dimmed.on{
	z-index: 99;
	opacity: 1;
	pointer-events: all;
}

</style>
</head>

<body class="container">
<div class="dimmed"></div>
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			<div class="notice_content">
			<div class="notice_top">
				<h3 style="font-weight: bold;">공지사항</h3>
				<a href="${path}/noticeList.do" style="padding-top: 16px;cursor: pointer;">more ></a>
			</div>
				<div class="main_banner">
				<table>
			   	<col width="55%">
			   	<col width="10%">
				    <tbody>
				    	<c:forEach var="notice" items="${noticeCombo}">
				    	<tr>
				    		<td style="cursor: pointer;" onclick="goDetail('${notice.noticeNum}')">${notice.title}</td>
				    		<td style="text-align: center;"><fmt:formatDate value="${notice.regdte}"/></td>
				    	</tr>
						</c:forEach>
				    </tbody>	
				</table>
				</div>
			</div>
			<div class="btm_content" style="padding: 0">
				<div class="notice">
					<div style="display: flex;">
						<h3 style="font-weight: bold;">매출</h3>
						<button onclick="location.href='${path}/empSet.do'" class="refreshBtn"><span class="refreshText">⟲</span></button>
					</div>
					<div class="boxes">
						<canvas id="myChart" style="display: block; height: 345px;width: 422px; margin: auto;"></canvas>
					</div>
				</div>
				<div class="schedule">
					<div class="boxes">
						<div>
							<h3 style="font-weight: bold;letter-spacing: 2px;"><span class="todayDate"></span> 오픈시간</h3>
							<c:forEach var="item" items="${onTimeCombo}">
								<c:if test="${not empty item.onTime}">
									<p>▶ ${item.frName} - <span style="color: blue;">${item.onTime}</span></p>
								</c:if>
								<c:if test="${empty item.onTime}">
									<p>▶ ${item.frName} - <span style="color: red;">오픈 전</span></p>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<c:if test="${important.title ne null}">
		<div id="main_popup" class="main_popup" style="position: absolute; z-index:10000; display: none;">
			<div style="height: 280px; border-bottom: 1px solid;">
				<h3 style="border-bottom: 1px solid;padding-bottom: 10px;">
    				${important.title}
    			</h3>
				<pre>
${important.content}
				</pre>
			</div>
			<div class="popup_bottom">
				<a href="javascript:closePopupNotToday()" class="white">오늘 하루동안 보지 않기</a>
				<a class="pull-right white" href="javascript:closeMainPopup();">닫기</a>
			</div>
		</div>
	</c:if>
</body>
<script type="text/javascript">
//상세페이지로 이동
function goDetail(noticeNum) {
	  location.href="${path}/noticeDetail.do?noticeNum="+noticeNum;
}

var week = ['일', '월', '화', '수', '목', '금', '토'];
var todayDate = new Date();
$(".todayDate").text((todayDate.getMonth()+1)+"/"+todayDate.getDate()+"("+week[todayDate.getDay()]+")")

// chart
var arr = []
<c:forEach var="sg" items="${totSales}">
	arr.push({tot:"${sg.tot}", orderdate:"${sg.orderdate}"})
</c:forEach>
console.log(arr)
console.log(arr[0].tot)
console.log(arr[0].orderdate)
console.log(new Date(arr[0].orderdate).getMonth()+1)
console.log(new Date(arr[0].orderdate).getDate())

const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [
        	(new Date(arr[6].orderdate).getMonth()+1)+"/"+new Date(arr[6].orderdate).getDate(),
        	(new Date(arr[5].orderdate).getMonth()+1)+"/"+new Date(arr[5].orderdate).getDate(),
        	(new Date(arr[4].orderdate).getMonth()+1)+"/"+new Date(arr[4].orderdate).getDate(),
        	(new Date(arr[3].orderdate).getMonth()+1)+"/"+new Date(arr[3].orderdate).getDate(),
        	(new Date(arr[2].orderdate).getMonth()+1)+"/"+new Date(arr[2].orderdate).getDate(),
        	(new Date(arr[1].orderdate).getMonth()+1)+"/"+new Date(arr[1].orderdate).getDate(),
        	(new Date(arr[0].orderdate).getMonth()+1)+"/"+new Date(arr[0].orderdate).getDate()
        	],
        datasets: [{
            data: [
            	arr[6].tot,
            	arr[5].tot,
            	arr[4].tot,
            	arr[3].tot,
            	arr[2].tot,
            	arr[1].tot,
            	arr[0].tot
            ],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(205, 69, 102, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(205, 69, 102, 1)'
            ],
            borderWidth: 2
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        },
        plugins: {
            title: {
                display: true,
                text: '<전체 매장 매출>',
                font: {
                    size: 18
                }
            },
        	legend:{
        		display: false
        	},

        }

    }
});

//레이어 팝업
var dimmed = $('.dimmed');

if(getCookie("notToday")!="Y"){
	$("#main_popup").show('fade');
	dimmed.addClass('on');
}


function closePopupNotToday(){	             
	setCookie('notToday','Y', 1);
	$("#main_popup").hide('fade');
	dimmed.removeClass('on');
}

function setCookie(name, value, expiredays) {
	var today = new Date();
    today.setDate(today.getDate() + expiredays);

    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
}

function getCookie(name) { 
var cName = name + "="; 
var x = 0; 
while ( x <= document.cookie.length ) 
{ 
    var y = (x+cName.length); 
    if ( document.cookie.substring( x, y ) == cName ) 
    { 
        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
            endOfCookie = document.cookie.length;
        return unescape( document.cookie.substring( y, endOfCookie ) ); 
    } 
    x = document.cookie.indexOf( " ", x ) + 1; 
    if ( x == 0 ) 
        break; 
} 
return ""; 
}
function closeMainPopup(){
$("#main_popup").hide('fade');
dimmed.removeClass('on');
}
</script>
</html>