package ferp.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ferp.service.A2_Service;
import ferp.service.C1_Service;
import vo.ACStatement;
import vo.Account;
import vo.DefectOrder;
import vo.ProdOrder;
import vo.Stock;

@Controller
public class C1_Controller {

	@Autowired
	C1_Service service;
	@Autowired
	A2_Service service2;

	// http://localhost:6080/ferp/selectAccount.do
	@RequestMapping("selectAccount.do")
	public String r7101SelectAccount(Account account, Model model) {
		account.setAcntUsing(false);
		model.addAttribute("accountListfalse", service.r7100SelectAccount(account));
		account.setAcntUsing(true);
		model.addAttribute("accountListtrue", service.r7100SelectAccount(account));
		return "WEB-INF\\headquarter\\pg7201_addAccount.jsp";
	}
	
	@RequestMapping("updateAccountUsing.do")
	@ResponseBody
	public String r7102updateAccountUsing(Account account){
		int done=service.r7102updateAccountUsing(account);
		return done+"";
	}

	@RequestMapping("insertAccount.do")
	public String r7101insertAccount(Account account) {
		service.r7101insertAccount(account);
		return "redirect:/selectAccount.do";
	}

	//전표 페이지
	// http://localhost:6080/ferp/ACstatement.do
	@GetMapping("ACstatement.do")
	public String r7210() {
		return "WEB-INF\\headquarter\\pg7210_ACstatement.jsp";
	}
	
	//전표 입력
	// http://localhost:6080/ferp/insertACstatement.do
	@PostMapping("insertACstatement.do")
	public String r7210insertStatement(ACStatement acstmt) {
		service.r7210insertStatement(acstmt.getStatementNum(), acstmt.getStmtDate(),acstmt.getFrRegiNum(), acstmt.getStmtlist());
		return "redirect:/selectACstatement.do?stmtDate="+acstmt.getStmtDate()+"&frRegiNum="+acstmt.getFrRegiNum();	//날짜만 적용.
	}

	@RequestMapping("selectACstatement.do")
	public String r7211selectACStatement(ACStatement acstmt,Model model) {
		model.addAttribute("stmtList",service.r7211selectACStatement(acstmt));
		return "WEB-INF\\headquarter\\pg7210_ACstatement.jsp";
	}
	//http://localhost:6080/ferp/selectACstatementJson.do
	@RequestMapping("selectACstatementJson.do")
	public String r7211selectACStatementJson(ACStatement acstmt,Model model) {
		model.addAttribute("stmtList",service.r7211selectACStatement(acstmt));
		return "pageJsonReport";
	}
	
	@RequestMapping("updateACstatement.do")
	public String r7212updateACStatement(ACStatement acstmt) {
		service.r7212updateACStatement(acstmt.getStatementNum(), acstmt.getStmtDate(),acstmt.getFrRegiNum(), acstmt.getStmtlist());
		return "redirect:/selectACstatement.do?stmtDate="+acstmt.getStmtDate()+"&statementNum="+acstmt.getStatementNum()+"&frRegiNum="+acstmt.getFrRegiNum();	
	}
	
	@RequestMapping("deleteACstatement.do")
	public String r7213deleteACStatement(ACStatement acstmt) {
		service.r7213deleteACStatement(acstmt);
		return "redirect:/selectACstatement.do?stmtDate="+acstmt.getStmtDate()+"&frRegiNum="+acstmt.getFrRegiNum();	//날짜만 적용.
	}
	
	@GetMapping("statementList.do")
	public String r7204(Model model) {
		model.addAttribute("accountList", service.r7100SelectAccount(new Account(true)));
		
		return "WEB-INF\\headquarter\\pg7204_statementList.jsp";	
	}
	
	//거래내역 조회, 건별 조회
	@PostMapping("statementList.do")
	public String r7204selectStatementList(@ModelAttribute("stmt") ACStatement aCStatement,@RequestParam(value="howtosearch",required = false) int howtosearch,Model model) {
		model.addAttribute("accountList", service.r7100SelectAccount(new Account(true)));
		model.addAttribute("stmtList",service.r7204selectStatementList(aCStatement,howtosearch));
		aCStatement.setTotalPage(service.r7204getTotalPages(aCStatement,howtosearch));

		return "WEB-INF\\headquarter\\pg7204_statementList.jsp";	
	}

	// http://localhost:6080/ferp/productOrderList.do
	@GetMapping("productOrderList.do")
	public String r9201() {
		return "WEB-INF\\headquarter\\pg9201_prodOrderList.jsp";
	}
	
	// http://localhost:6080/ferp/productOrderListJson.do
	@GetMapping("productOrderListJson.do")
	public String r9201selectProdOrder(Model model,ProdOrder prodOrder) {
		model.addAttribute("list",service.r9201select(prodOrder));
		return "pageJsonReport";
	}
	
	@RequestMapping("productOrderList999.do")
	public String r9201select999(Model model,ProdOrder prodOrder) {
		model.addAttribute("list",service.r9201select999(prodOrder));
		return "pageJsonReport";
	}
	
	@RequestMapping("updateOrderState.do")
	@ResponseBody
	public String r9203updateOrderState(Model model,ProdOrder prodOrder) {
		int a=service.r9203updateOrderState(prodOrder);
		return a+"";
	}
	
	// http://localhost:6080/ferp/prodOrderPayState.do
	@GetMapping("prodOrderPayState.do")
	public String r9310prodOrderPayState() {
		return "WEB-INF\\headquarter\\pg9310_prodOrderPayState.jsp";
	}

	@CrossOrigin(origins = "*",allowedHeaders = "*")
	@RequestMapping("selectProdOrderPayState.do")
	public String r9310selectProdOrderPayState(Model model,ProdOrder prodOrder) {
		model.addAttribute("list",service.r9310selectProdOrderPayState(prodOrder));
		return "pageJsonReport";
	}
	

	@RequestMapping("updateProdOrderPayState.do")
	@ResponseBody
	public String r9311updateProdOrderPayState(Model model,ProdOrder prodOrder,
								@RequestParam(value = "price",required = false,defaultValue = "0") int price,
								@RequestParam(value = "tax",required = false,defaultValue = "0") int tax) {
		int a=service.r9311updateProdOrderPayState(prodOrder,price,tax);
		return a+"";
	}


	//http://localhost:6080/ferp/prodOrderPayDetail.do
	@GetMapping("prodOrderPayDetail.do")
	public String r9301() {
		return "WEB-INF\\headquarter\\pg9301_prodOrderPayDetail.jsp";
	}
		
	@PostMapping("prodOrderPayDetail.do")
	public String r9301prodOrderPayDetail(Model model,ProdOrder prodOrder) {
		model.addAttribute("list",service.r9301prodOrderPayDetail(prodOrder));
		return "WEB-INF\\headquarter\\pg9301_prodOrderPayDetail.jsp";
	}
	
	//http://localhost:6080/ferp/defectOrderHandler.do
	@GetMapping("defectOrderHandler.do")
	public String r9403() {
		return "WEB-INF\\headquarter\\pg9403_defectOrderHandler.jsp";
	}
	
	@RequestMapping("selectDefectOrderJSON.do")
	public String r9402selectDefectOrder(Model model,DefectOrder dfo) {
		model.addAttribute("list",service.r9402selectDefectOrder(dfo));
		return "pageJsonReport";
	}
	
	@RequestMapping("updateDefectOrder.do")
	public String r9403updateDefectOrder(Model model,DefectOrder dfo,Stock stock,ProdOrder po) {
		model.addAttribute("apply",service.r9403updateDefectOrder(dfo,stock,po));
		return "redirect:/defectOrderHandler.do";
	}
	
	//http://localhost:6080/ferp/pnl.do
	@GetMapping("pnl.do")
	public String r7205() {
		return "WEB-INF\\headquarter\\pg7205_PnL.jsp";
	}
	

}