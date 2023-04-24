<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*" 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>

<!-- remixicon cdn -->
<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>

<!-- 알럿창 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style type="text/css">
.wrap_container{
			max-width: 1200px;
			width: 100%;
			margin: 0 auto;
		}
		.con_wrap{
			display: flex;
		}
		.large_con{
			width: 66.6666%;
			padding: 0 15px 30px;
		}
		.small_con{
			width: 33.3333%;
			padding: 0 15px;
		}
		.half_con{
			width: 50%;
			padding: 0 15px;
		}
		.tab_wrap{
			display: flex;
			gap: 20px;
			background-color: #2262f3;
			padding-top: 20px;
			padding: 20px 20px 0;
		}
		.tab_wrap > .tab_list{
			width: 140px;
			height: 70px;
			display: flex;
			align-items: center;
			justify-content: center;
			border-radius: 10px 10px 0 0;
			background-color: #fff;
			font-size: 26px;
			border-bottom: 5px solid #2262f3;
			cursor: pointer;
		}
		.tab_wrap > .tab_list.on{
			border-bottom: 2px solid transparent;
			color: #2262f3;
		}
		
		.tab_content_wrap{
			display: none;
			gap: 30px;
			flex-wrap: wrap;
			margin-top: 20px;
		}
		.tab_content_wrap.on{
			display: flex;
		}
		.tab_content_wrap .tab_con{
			width: calc(33.3333% - 20px);
			padding: 20px;
			background-color: #f8f8f8;
			border-radius: 10px;
			box-shadow: 0 0 15px 4px rgba(0,0,0,0.1);
		}
		.tab_content_wrap .tab_con .con_img{
			width: 100%;
			height: 200px;
			background-color: #e0e0e0;
			margin-bottom: 20px;
		}
		
		.tab_content_wrap .tab_con .con_img img{
			width: 100%;
			height: 100%;
		}
		
		.tab_content_wrap .tab_con .con_info{
			text-align: center;
		}
		.tab_content_wrap .tab_con .con_info .con_name{
			font-size: 20px;
			margin-bottom: 10px;
		}
		.tab_content_wrap .tab_con .con_info .con_price{
			font-size: 20px;
			font-weight: 700;
		}
		.result_btn_wrap{
			display: flex;
			gap: 20px;
			align-items: center;
			margin-top: 20px;
		}
		.result_btn_wrap .result_btn{
			width: 50%;
			height: 70px;
			background-color: #2262f3;
			display: flex;
			align-items: center;
			justify-content: center;
			font-size: 32px;
			font-weight: 700;
			color: #fff;
			border: 0;
			border-radius: 10px;
			cursor: pointer;
			transition: 0.3s;
			font-family: 'Pretendard-Regular';
		}
		.result_btn_wrap .result_btn:hover{
			background-color: #0a38a3;
		}
		.result_list_wrap{
			width: 100%;
			margin-top: 30px;
			background-color: #e0e0e0;
			border-radius: 10px;
			padding: 10px;
		}
		.result_list_wrap li.list_item{
			padding: 15px 0;
			border-bottom: 1px solid #fff;
		}
		.result_list_wrap li.list_item:last-child{
			border-bottom: 0;
		}
		.result_list_wrap li.list_item .list_item_info{
			display: flex;
			flex-direction: column;
			gap: 10px;
			font-size: 20px;
		}
		.result_list_wrap li.list_item .list_item_info .list_item_name{
			font-size: 24px;
			font-weight: 700;
		}
		.result_list_wrap li.list_item .list_item_info .list_item_option{
			padding-left: 20px;
			font-weight: 400;
			color: #666;
		}
		.result_list_wrap li.list_item .list_item_price{
			text-align: right;
			font-size: 24px;
			font-weight: 700;
			margin-top: 15px;
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
		.modal_container{
			max-width: 900px;
			width: 100%;
			background-color: #fff;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			padding: 50px;
			z-index: -1;
			opacity: 0;
			pointer-events: none;
		}
		.modal_container.on{
			z-index: 100;
			opacity: 1;
			pointer-events: all;
		}
		.modal_container .modal_close{
			position: absolute;
			top: 10px;
			right: 10px;
			width: 40px;
			height: 40px;
			display: flex;
			align-items: center;
			justify-content: center;
			color: #2262f3;
			font-size: 24px;
			font-weight: 700;
			border: 1px solid #2262f3;
			border-radius: 10px;
		}
		.modal_product_con .product_img{
			width: 100%;
			height: auto;
			aspect-ratio: 1 / 1;
			overflow: hidden;
			background-color: #f5f5f5;
			margin-bottom: 30px;
		}
		.modal_product_con .product_img > img{
			width: 100%;
			height: 100%;
			object-fit: cover;
		}
		.modal_product_con .product_num_wrap{
			display: flex;
			align-items: center;
			gap: 10px;
			flex-wrap: nowrap;
		}
		.modal_product_con .product_num_wrap .product_btn{
			width: 50px;
			height: 50px;
			border-radius: 10px;
			background-color: #2262f3;
			flex-shrink: 0;
			display: flex;
			align-items: center;
			justify-content: center;
			line-height: 1;
			color: #fff;
			text-align: center;
			font-size: 24px;
			font-weight: 700;
		}
		.modal_product_con .product_num_wrap .product_number{
			width: 100%;
			height: 50px;
			border: 2px solid #2262f3;
			border-radius: 10px;
			font-size: 24px;
			text-align: center;
		}
		.modal_product_con .product_num_wrap .product_number::-webkit-outer-spin-button,
		.modal_product_con .product_num_wrap .product_number::-webkit-inner-spin-button{
			display: none;
		}
		.modal_container .modal_product_name{
			font-size: 32px;
			font-weight: 700;
		}
		.modal_container .modal_product_infoText{
		    line-height: 30px;
		    font-size: 20px;
		    border-bottom: 1px solid #999;
		    padding-bottom: 10px;
		    color: #999;
		}
		.modal_product_option_wrap{
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			height: 100%;
		}
		.modal_product_option_wrap .modal_btn_wrap{
			text-align: center;
		}
		.modal_product_option_wrap .modal_btn_wrap .modal_btn_add{
			display: flex;
			align-items: center;
			justify-content: center;
			width: 200px;
			height: 50px;
			margin: 0 auto;
			border-radius: 10px;
			background-color: #2262f3;
			color: #fff;
			font-size: 24px;
			font-weight: 700;
			cursor: pointer;
		}
		.modal_product_option .option_name{
			font-size: 24px;
			font-weight: 700;
			margin-bottom: 10px;
			color: #2262f3;
			line-height: 70px;
		}
		.modal_product_option .option_radio{
			width: 100%;
			margin-bottom: 15px;
			display: flex;
		}
		.modal_product_option .option_radio > label{
			display: flex;
			align-items: center;
			gap: 10px;
			width: 100%;
		}
		.modal_product_option .option_checkbox > label{
			display: flex;
			align-items: center;
			gap: 10px;
			width: 100%;
			margin-bottom: 15px;
		}
		.modal_product_option .option_radio > label > input,
		.modal_product_option .option_checkbox > label > input{
			display: none;
		}
		.modal_product_option .option_radio > label > span.menu_opt,
		.modal_product_option .option_checkbox > label > span.menu_opt{
			font-size: 20px;
		}
		.modal_product_option .option_radio > label > span.custom_checkbox,
		.modal_product_option .option_checkbox > label > span.custom_checkbox{
			display: flex;
			align-items: center;
			justify-content: center;
			width: 25px;
			height: 25px;
			border: 1px solid #999;
			box-shadow: 0px 4px 4px 0px rgba(0,0,0,0.25);
			color: transparent;
			font-weight: 700;
			font-size: 20px;
		}
		.modal_product_option .option_radio > label > input:checked + span.custom_checkbox,
		.modal_product_option .option_checkbox > label > input:checked + span.custom_checkbox{
			background-color: #2262f3;
			color: #fff;
		}
		
		.modal_product_price{
		    display: none;
		}
		
		.listdefalut{
		    font-size: 29px;
		    text-align: center;
		    padding: 20px;
		}
</style>
</head>

<body>
<div class="dimmed"></div>
	<div class="modal_container">
		<a href="#" class="modal_close"><i class="ri-close-line"></i></a>
		<div class="con_wrap">
			<div class="half_con">
				<div class="modal_product_con">
					<div class="product_img"></div>
					<div class="product_num_wrap">
						<a class="product_btn btn_minus" href="#">-</a>
						<input type="number" class="product_number" value="1" min="1">
						<a class="product_btn btn_plus" href="#">+</a>
					</div>
				</div>
			</div>
			<div class="half_con">
				<div class="modal_product_option_wrap">
					<div class="modal_option_wrap">
						<p class="modal_product_name">음료 이름</p>
						<p class="modal_product_Num" style="display: none;">음료 번호</p>
						<p class="modal_product_infoText">음료 상세</p>
						<form class="modal_product_option">
							<p class="option_name">옵션 선택</p>
							<div class="option_radio">
								<label for="menu_opt_1">
									<input checked="checked" type="radio" name="option_1" id="menu_opt_1" value="option_ice">
									<span class="custom_checkbox"><i class="ri-check-line"></i></span>
									<span class="menu_opt radio01">아이스</span>
								</label>
								<label for="menu_opt_2">
									<input type="radio" name="option_1" id="menu_opt_2" value="option_hot">
									<span class="custom_checkbox"><i class="ri-check-line"></i></span>
									<span class="menu_opt radio02">따뜻하게</span>
								</label>
							</div>
							<div class="option_checkbox">
								<label for="menu_opt_3" class="addS">
									<input type="checkbox" name="option_2" id="menu_opt_3">
									<span class="custom_checkbox"><i class="ri-check-line"></i></span>
									<span class="menu_opt">샷추가(+500￦)</span>
								</label>
								<label for="menu_opt_4" class="sizeUp">
									<input type="checkbox" name="option_3" id="menu_opt_4">
									<span class="custom_checkbox"><i class="ri-check-line"></i></span>
									<span class="menu_opt">사이즈업(+500￦)</span>
								</label>
								<label for="menu_opt_5" class="delS">
									<input type="checkbox" name="option_4" id="menu_opt_5">
									<span class="custom_checkbox"><i class="ri-check-line"></i></span>
									<span class="menu_opt">연하게</span>
								</label>
								<label for="menu_opt_6" class="pojang">
									<input type="checkbox" name="option_5" id="menu_opt_6">
									<span class="custom_checkbox"><i class="ri-check-line"></i></span>
									<span class="menu_opt">포장</span>
								</label>
							</div>
						</form>
					</div>
					
					<div class="modal_btn_wrap">
						<p class="modal_product_price">음료 가격</p>
						<a href="#" class="modal_btn_add">추가하기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="wrap_container">
		<ul class="tab_wrap">
			<li name="tab_list_1" class="tab_list list_1 on">전체</li>
			<li name="tab_list_2" class="tab_list list_2">커피</li>
			<li name="tab_list_3" class="tab_list list_3">only Ice</li>
			<li name="tab_list_4" class="tab_list list_4">음료</li>
			<li name="tab_list_5" class="tab_list list_5">샌드위치</li>
			<li name="tab_list_6" class="tab_list list_6">케이크</li>
		</ul>
		<div class="con_wrap">
			<div class="large_con">
				<div name="tab_list_1" class="tab_content_wrap con_1 on">
					<c:forEach var="mn" items="${Allmenu}">
					<a name="${mn.menuNum}" href="#" class="tab_con">
						<div class="con_img">
							<img alt="${mn.menuName }의 이미지" src="${path }/resource/img/${mn.img}">
							<p class="con_infoText" style="display: none">${mn.info }</p>
							<p class="con_category" style="display: none">${mn.category}</p>
						</div>
						<div class="con_info">
							<p class="con_name">${mn.menuName }</p>
							<p class="con_price">
								<fmt:formatNumber value="${mn.price }" pattern="#,###" />￦
							</p>
						</div>
					</a>
					</c:forEach>
				</div>
				<div name="tab_list_2" class="tab_content_wrap con_2">
					<c:forEach var="mncf" items="${coffeeMenu}">
					<a name="${mncf.menuNum}" href="#" class="tab_con">
						<div class="con_img">
							<img alt="${mncf.menuName }의 이미지" src="${path }/resource/img/${mncf.img}">
							<p class="con_infoText" style="display: none">${mncf.info }</p>
							<p class="con_category" style="display: none">${mncf.category}</p>
						</div>
						<div class="con_info">
							<p class="con_name">${mncf.menuName }</p>
							<p class="con_price">
								<fmt:formatNumber value="${mncf.price }" pattern="#,###" />￦
							</p>
						</div>
					</a>
					</c:forEach>
				</div>
				<div name="tab_list_3" class="tab_content_wrap con_3">
					<c:forEach var="mnsm" items="${smoMenu}">
					<a name="${mnsm.menuNum}" href="#" class="tab_con">
						<div class="con_img">
							<img alt="${mnsm.menuName }의 이미지" src="${path }/resource/img/${mnsm.img}">
							<p class="con_infoText" style="display: none">${mnsm.info }</p>
							<p class="con_category" style="display: none">${mnsm.category}</p>
						</div>
						<div class="con_info">
							<p class="con_name">${mnsm.menuName }</p>
							<p class="con_price">
								<fmt:formatNumber value="${mnsm.price }" pattern="#,###" />￦
							</p>
						</div>
					</a>
					</c:forEach>
				</div>
				<div name="tab_list_4" class="tab_content_wrap con_4">
					<c:forEach var="mnetc" items="${etcMenu}">
					<a name="${mnetc.menuNum}" href="#" class="tab_con">
						<div class="con_img">
							<img alt="${mnetc.menuName }의 이미지" src="${path }/resource/img/${mnetc.img}">
							<p class="con_infoText" style="display: none">${mnetc.info }</p>
							<p class="con_category" style="display: none">${mnetc.category}</p>
						</div>
						<div class="con_info">
							<p class="con_name">${mnetc.menuName }</p>
							<p class="con_price">
								<fmt:formatNumber value="${mnetc.price }" pattern="#,###" />￦
							</p>
						</div>
					</a>
					</c:forEach>
				</div>
				<div name="tab_list_5" class="tab_content_wrap con_5">
					<c:forEach var="sw" items="${sandMenu}">
					<a name="${sw.menuNum}" href="#" class="tab_con">
						<div class="con_img">
							<img alt="${sw.menuName }의 이미지" src="${path }/resource/img/${sw.img}">
							<p class="con_infoText" style="display: none">${sw.info }</p>
							<p class="con_category" style="display: none">${sw.category}</p>
						</div>
						<div class="con_info">
							<p class="con_name">${sw.menuName }</p>
							<p class="con_price">
								<fmt:formatNumber value="${sw.price }" pattern="#,###" />￦
							</p>
						</div>
					</a>
					</c:forEach>
				</div>
				<div name="tab_list_6" class="tab_content_wrap con_6">
					<c:forEach var="ck" items="${cakeMenu}">
					<a name="${ck.menuNum}" href="#" class="tab_con">
						<div class="con_img">
							<img alt="${ck.menuName }의 이미지" src="${path }/resource/img/${ck.img}">
							<p class="con_infoText" style="display: none">${ck.info }</p>
							<p class="con_category" style="display: none">${ck.category}</p>
						</div>
						<div class="con_info">
							<p class="con_name">${ck.menuName }</p>
							<p class="con_price">
								<fmt:formatNumber value="${ck.price }" pattern="#,###" />￦
							</p>
						</div>
					</a>
					</c:forEach>
				</div>
			</div>
			<div class="small_con">
				<div class="result_btn_wrap">
					<button class="result_btn delOrderBtn">취소하기</button>
					<button class="result_btn addOrderBtn">주문하기</button>
				</div>
				<ul class="result_list_wrap">
					<li class="listdefalut">주문하실 메뉴를<br> 선택해주세요.</li>
				</ul>
			</div>
		</div>
	</div>	
</body>
<script type="text/javascript">
'use strict';
//	orders json 생성
	var orders = [];
// modal
var tabContent = $('.tab_con'),
	dimmed = $('.dimmed'),
	modalContainer = $('.modal_container'),
	modalClose = $('.modal_close');
var conName = $('.con_info > .con_name'),
	modalName = $('.modal_product_name');
	
tabContent.click(function () {
		dimmed.addClass('on');
		modalContainer.addClass('on');
		var MenuName = $(this).find(".con_name").text();
		$(".modal_product_name").text(MenuName);
		var MenuImg = $(this).find(".con_img").html();
		$(".product_img").html(MenuImg);
		var MenuInfoText = $(this).find(".con_infoText").text();
		$(".modal_product_infoText").text(MenuInfoText);
		var MenuPrice = $(this).find(".con_price").text();
		$(".modal_product_price").text(MenuPrice);
		var MenuCategory = $(this).find(".con_category").text();
		var MunuNum = $(this).attr('name');
		$(".modal_product_Num").text(MunuNum);
		if(MenuCategory == "onlyIce"){
			$(".option_radio").css('display','none');
			$(".delS").css('display','none');
			$(".addS").css('display','none');
			$(".pojang").css('display','flex');
			$(".sizeUp").css('display','flex');
			$(".radio01").text("Ice");
			$(".radio02").text("Hot");
			$('.radio01').prop('checked', true);
		}else if(MenuCategory == "coffee"){
			$(".option_radio").css('display','flex');
			$(".delS").css('display','flex');
			$(".addS").css('display','flex');
			$(".pojang").css('display','flex');
			$(".sizeUp").css('display','flex');
			$(".radio01").text("Ice");
			$(".radio02").text("Hot");
			$('.radio01').prop('checked', true);
		}else if(MenuCategory == "sandwich" || MenuCategory == "cake" ){
			$(".option_radio").css('display','flex');
			$(".delS").css('display','none');
			$(".addS").css('display','none');
			$(".sizeUp").css('display','none');
			$(".pojang").css('display','none');
			$(".radio01").text("매장");
			$(".radio02").text("포장");
			$('.radio01').prop('checked', true);
		}else{
			$(".option_radio").css('display','flex');
			$(".delS").css('display','none');
			$(".addS").css('display','none');
			$(".sizeUp").css('display','flex');
			$(".pojang").css('display','none');
			$(".radio01").text("Ice");
			$(".radio02").text("Hot");
			$('.radio01').prop('checked', true);
		}
});


dimmed.on('click', ()=>{
	dimmed.removeClass('on');
	modalContainer.removeClass('on');
});

modalClose.click(function () {
	dimmed.removeClass('on');
	modalContainer.removeClass('on');
	$(".product_number").val(1);
	$('.modal_product_option input[type="checkbox"]').prop('checked', false);
})


// tab
var tabList = $('.tab_wrap > .tab_list');
var tabCon = $('.tab_content_wrap');
tabList.click(function(){
	var name = $(this).attr('name');
	var tabCon = $('.tab_content_wrap');
	var thisCon = $('.tab_content_wrap[name='+ name +']');
	tabList.removeClass('on');
	$(this).addClass('on');
	tabCon.removeClass('on');
	thisCon.addClass('on');
});

// 수량 추가,제거
$(".btn_plus").click(function () {
	var cnt = Number($(".product_number").val());
	if(cnt<10){		
		cnt++;
	}
	$(".product_number").val(cnt);
});
$(".btn_minus").click(function () {
	var cnt = Number($(".product_number").val());
	if(cnt>1){
		cnt--;
	}
	$(".product_number").val(cnt);
});

// 추가하기 버튼
var od = "";
var resultAddString = "";
var modal_btn_add = $(".modal_btn_add");

	modal_btn_add.click(function () {
	var name = $(".modal_product_name").text();
	var cnt = $(".product_number").val();
	var price = $(".modal_product_price").text();
	var price = $(".modal_product_price").text();
	var menuNum = $(".modal_product_Num").text();
	var option="";
	price = price.replace("￦", "");
	price = Number(price.replace(",", ""));
	
	if ($("#menu_opt_3").is(":checked")) {
		price+=500;
		option+="/샷추가";
	}
	
	if ($("#menu_opt_4").is(":checked")) {
		price+=500;
		option+="/사이즈업";
	}
	
	if ($("#menu_opt_5").is(":checked")) {
		option+="/연하게";
	}
	
	if ($("#menu_opt_6").is(":checked")) {
		option+="/포장";
	}
	
	if ($("#menu_opt_1").is(":checked") || $("#menu_opt_2").is(":checked") ) {

	// 선택된 라디오 버튼 요소를 식별
	const selectedRadioButton = $('input[name="option_1"]:checked');
	// 선택된 라디오 버튼의 value 속성 값
	const selectedValue = selectedRadioButton.val();
	// 선택된 라디오 버튼의 label 요소의 text 값
	const selectedText = selectedRadioButton.parent().text().trim();

		option+="/"+selectedText;
	}
	
	price = price*cnt;
	
	price = price.toLocaleString();
	price += "￦";
	
	resultAddString += "<li class='list_item'><p class='list_item_info'><span class='list_item_name'><span class='menuNum' style='display:none;'>"
	+menuNum+"</span><span class='listItemName'>"
	+name+"</span>x<span class='listItemCnt'>"
	+cnt+"</span>"+"</span><span class='list_item_option'>"+option+"</span></p><p class='list_item_price'>"+price+"</p></li>";
	
	$(".result_list_wrap").html(resultAddString);
	
    // JSON 객체 생성 및 orders 배열에 추가
    if(od!=""){
    	od += "&menuNum="+$(".menuNum").last().text()
    }else{
    	od += "menuNum="+$(".menuNum").last().text()
    }
    od += "&amount="+Number($(".listItemCnt").last().text())
    od += "&payprice="+Number($(".list_item_price").last().text().replace("￦","").replace(",",""))
    od += "&orderOption="+$(".list_item_option").last().text()
    od += "&frRegiNum=${login.frRegiNum}"
    <%-- var order = {
        "menuNum": $(".menuNum").last().text(),
        "amount": Number($(".listItemCnt").last().text()),
        "payprice": Number($(".list_item_price").last().text().replace("￦","").replace(",","")),
        "orderOption": $(".list_item_option").last().text(),
        "frRegiNum":"${login.frRegiNum}"
    }; --%>
    // orders.push(order);
	modalClose.trigger('click');
	
	console.log(orders);
	
});

// 취소하기 버튼
$(".delOrderBtn").click(function () {
	var insHtml = "<li class='listdefalut'>주문하실 메뉴를<br> 선택해주세요.</li>"
	$(".result_list_wrap").html(insHtml);
	resultAddString = "";
	od = "";
});

$(".addOrderBtn").click(function () {
	Swal.fire({
			  title: '결제하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#2262F3',
			  cancelButtonColor: '#888',
			  confirmButtonText: '결제',
			  cancelButtonText: '취소'
			}).then((result) => {
				 if (result.value) {					 
					if(od == ""){
						  Swal.fire({
							  title: '주문하실 메뉴를 추가해주세요',
							  icon: 'warning',
							  showCancelButton: false,
							  confirmButtonColor: '#2262F3',
							  confirmButtonText: '확인'
							}).then((result) => {
							  if (result.value) {
								  $(".listdefalut").css('color','red');
							      return;
							  }
						  })
					}else{
						location.href="${path}/addOrder.do?"+od
						// addAjax("/addOrder.do");					
					}
				 }
			})
});

	function addAjax(url) {
		$.ajax({
			type : "post",
			url : "/ferp" + url,
			dataType:'json',
			data : od,
			traditional: true,
			success : function(data) {
				alert('DB저장 성공');
			},
			error : function(err) {
				console.log(err)
			}
		})
	}


</script>
</html>