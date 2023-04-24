<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>    
<style type="text/css">
	
	.lnb>ul>li>a:after{
	width: 18px;
	height: 16px;
	background: url(${path}/resource/img/menu_icon_down.png);
	position: absolute;
	top: 11px;
	right: 14px;
	content: "";
	}
	
	.lnb>ul>li.active>a:after{
	    background: url(${path}/resource/img/menu_icon_up.png);
	}
	
</style>
 <div class="lnb">
                <ul>
                    <li>
                        <a href="#">공지 및 문의</a>
                        <ul>
                            <li><a href="#">- 공지사항 조회</a></li>
                            <li><a href="#">- 문의글 등록</a></li>
                            <li><a href="#">- 1:1 채팅</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">직원 관리</a>
                        <ul>
                            <li><a href="#">- 직원 정보 조회</a></li>
                            <li><a href="#">- 근태 조회</a></li>
                            <li><a href="#">- 스케쥴 관리</a></li>
                            <li><a href="#">- 급여액 조회</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">재무 관리</a>
                        <ul>
                            <li><a href="#">- 전표 수기 입력</a></li>
                            <li><a href="#">- 거래 내역 조회</a></li>
                            <li><a href="#">- 손익 계산서 조회</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">물류 관리</a>
                        <ul>
                            <li><a href="#">- 발주 신청</a></li>
                            <li><a href="#">- 배송 불량 신청</a></li>
                            <li><a href="#">- 배송 불량 신청 현황</a></li>
                            <li><a href="#">- 발주 계산서 조회</a></li>
                            <li><a href="#">- 재고 관리</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">매장 관리</a>
                        <ul>
                            <li><a href="#">- 비밀번호 변경</a></li>
                            <li><a href="#">- 매출 조회</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
<script type="text/javascript">
$('.lnb > ul > li').click(function() {
    if ( $(this).hasClass('active') ) {
        $(this).find('> ul').stop().slideUp(300);
        $(this).removeClass('active');
    }
    else {
        $(this).find('> ul').stop().slideDown(300);
        $(this).addClass('active');
    }
});

<!-- eq(n) 열려 있는 사이드바 n 숫자로 조정하세요.  -->
$('.lnb > ul > li').eq(0).trigger("click");
</script>         