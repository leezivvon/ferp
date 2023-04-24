package ferp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ferp.service.C2_Service;
import vo.ClerkSchedule;
import vo.Emp;
import vo.Product;
import vo.ProductProdOrder;
import vo.ProductStock;
import vo.Stock;
import vo.Store;
import vo.StoreClerk;

@Controller
public class C2_Controller {
	// http://localhost:6080/ferp/storeLogin.do
	// http://localhost:6080/ferp/empLogin.do
	
	@Autowired
	private C2_Service service;
	
	// 매장 재고 조회
	// http://localhost:6080/ferp/sproductList.do
	@RequestMapping("/sproductList.do")
	public String r8101ProductList(@ModelAttribute("sch") ProductProdOrder sch, Model d, HttpSession session){
		Store st = (Store)session.getAttribute("login");
		sch.setFrRegiNum(st.getFrRegiNum());
		d.addAttribute("plist", service.r8101ProductList(sch));
		return "WEB-INF\\store\\pg8101_productList.jsp";
	}
	
	// 매장 재고 상세 페이지
	@RequestMapping("/sproductInfo.do")
	public String r8101ProductInfo(@RequestParam String productNum, Model d){
		d.addAttribute("product",service.r8101ProductInfo(productNum));
		return "WEB-INF\\store\\pg8101_productInfo.jsp";
	}	
	
	// 매장 재고 입출고 조회
	// http://localhost:6080/ferp/sInoutList.do
	@RequestMapping("/sInoutList.do")
	public String r8102InoutList(@ModelAttribute("sch") ProductProdOrder sch, Model d, HttpSession session){
		Store st = (Store)session.getAttribute("login");
		sch.setFrRegiNum(st.getFrRegiNum());
		d.addAttribute("list", service.r8204InoutList(sch));
		d.addAttribute("remainlist", service.r8101ProductList(sch));
		return "WEB-INF\\store\\pg8102_inoutList.jsp";
	}
	
	// 매장 재고 입출고 등록
	@RequestMapping("/sinoutIns.do")
	public String r8103InoutIns(Stock ins, Model d, HttpSession session){
		Store st = (Store)session.getAttribute("login");
		ins.setFrRegiNum(st.getFrRegiNum());
		service.r8103InoutIns(ins);
		return "redirect:/sInoutList.do";
	}
	
	// 매장 재고 입출고 수정
	@RequestMapping("/sinoutUpt.do")
	public String r8104InoutUpt(@RequestParam("productNum") String productNum,
								@RequestParam("applyAmount") int applyAmount,
								@RequestParam("remainAmount") int remainAmount, HttpSession session){
		Store st = (Store)session.getAttribute("login");
		String frRegiNum = st.getFrRegiNum();
	    service.r8104InoutUpt(productNum, applyAmount, remainAmount, frRegiNum);
	    return "redirect:/sInoutList.do"; 
	}
	
	// 매장 재고 입출고 삭제
	@RequestMapping("/sinoutDel.do")
	public String r8105InoutDel(@RequestParam("productNum") String productNum,
								@RequestParam("applyAmount") int applyAmount,
								@RequestParam("remainAmount") int remainAmount, HttpSession session){
		Store st = (Store)session.getAttribute("login");
		String frRegiNum = st.getFrRegiNum();
	    service.r8105InoutDel(productNum, applyAmount, remainAmount, frRegiNum);
	    return "redirect:/sInoutList.do"; 
	}
	
	// 본사 재고 조회
	// http://localhost:6080/ferp/hproductList.do
	@RequestMapping("/hproductList.do")
	public String r8201ProductList(@ModelAttribute("sch") ProductProdOrder sch, Model d, HttpSession session) {
		Emp st = (Emp)session.getAttribute("login");
		sch.setFrRegiNum(st.getFrRegiNum());
		d.addAttribute("plist", service.r8101ProductList(sch));
		return "WEB-INF\\headquarter\\pg8201_productList.jsp";
	}
	
	// 본사 재고 상세 페이지
	@RequestMapping("/hproductInfo.do")
	public String r8201ProductInfo(@RequestParam String productNum, Model d){
		d.addAttribute("product",service.r8101ProductInfo(productNum));
		return "WEB-INF\\headquarter\\pg8201_productInfo.jsp";
	}
	
	// 본사 재고 등록
	@RequestMapping("/hproductInsFrm.do")
	public String r8202ProductInsFrm(){
		return "WEB-INF\\headquarter\\pg8202_productIns.jsp";
	}
	@PostMapping("/hproductIns.do")
	public String r8202ProductIns(ProductStock ins, RedirectAttributes redirect){
		if( service.r8202ProductIns(ins) != null ) {
			redirect.addFlashAttribute("msg", "등록 성공");
		}
		return "redirect:/hproductList.do";
	}
	
	// 본사 재고 수정
	@PostMapping("/hproductUpt.do")
	public String r8203ProductUpt(Product upt, RedirectAttributes redirect) {
		if( service.r8203ProductUpt(upt) != null) {
			redirect.addFlashAttribute("msg", "수정 성공");
		}
		return "redirect:/hproductList.do";
	}
	
	// 본사 재고 입출고 조회
	// http://localhost:6080/ferp/hInoutList.do
	@RequestMapping("/hInoutList.do")
	public String r8204InoutList(@ModelAttribute("sch") ProductProdOrder sch, Model d, HttpSession session) {
		Emp st = (Emp)session.getAttribute("login");
		sch.setFrRegiNum(st.getFrRegiNum());
		d.addAttribute("list", service.r8204InoutList(sch));
		return "WEB-INF\\headquarter\\pg8204_inoutList.jsp";
	}
	
	// 자재 코드 콤보
	@ModelAttribute("productNumCom")
	public List<Stock> productNumCom() {
		return service.productNumCom();
	}
	
	// 직원 번호 콤보
	@ModelAttribute("clerkNumCom")
	public List<StoreClerk> clerkNumCom() {
		return service.clerkNumCom();
	}
	
	// 직원스케줄 캘린더 등록
	@RequestMapping("/sclerkschdIns.do")
	public String sclerkschdIns(ClerkSchedule ins, Model d, HttpSession session){
		Store st = (Store)session.getAttribute("login");
		ins.setFrRegiNum(st.getFrRegiNum());
		service.sclerkschdIns(ins);
		return "redirect:/sclerkschd.do";
	}
	
	// 직원스케줄 캘린더 삭제
	@RequestMapping("/sclerkschdDel.do")
	public String sclerkschdDel(@RequestParam("clerkName") String clerkName,
	                            @RequestParam("onDay") String onDay){
	    service.sclerkschdDel(clerkName, onDay);
	    return "redirect:/sclerkschd.do";
	}
	
	// 직원스케줄 캘린더
	// http://localhost:6080/ferp/sclerkschd.do
	@GetMapping("/sclerkschd.do")
	public String sclerkschd() {
		return "WEB-INF\\store\\clerkschd.jsp";
	}
	@RequestMapping("schdajax.do")
	public String schdajax(Model d, HttpSession session){
		Store st = (Store)session.getAttribute("login");
		d.addAttribute("list",service.sclerkschd(st.getFrRegiNum()));
		return "pageJsonReport";
	}
	
	// 본사 직원 점검일 배정 
	// http://localhost:6080/ferp/hQAinspectdte.do
	@RequestMapping("/hQAinspectdte.do")
	public String r6101QAinspectdte(){
		return "WEB-INF\\headquarter\\pg6101_QAinspectdteIns.jsp";
	}
	
}
