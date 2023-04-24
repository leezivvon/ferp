/**
 * 
 */
var tabContent = $('.tab_con'),
	dimmed = $('.dimmed'),
	modalContainer = $('.modal_container'),
	modalClose = $('.modal_close');
var conName = $('.con_info > .con_name'),
	modalName = $('.modal_product_name')
tabContent.on('click', ()=>{
	dimmed.addClass('on');
	modalContainer.addClass('on');
});
dimmed.on('click', ()=>{
	dimmed.removeClass('on');
	modalContainer.removeClass('on');
});
modalClose.on('click', ()=>{
	dimmed.removeClass('on');
	modalContainer.removeClass('on');
});