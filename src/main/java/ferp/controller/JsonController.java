package ferp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import ferp.service.B2_Service;
import ferp.service.C1_Service;
import ferp.service.C2_Service;
import vo.ACStatement;
import vo.Account;
import vo.NoticeSch;
import vo.ProductProdOrder;

@Controller
public class JsonController {

	@Autowired
	C1_Service serviceC1;
	@Autowired
	C2_Service serviceC2;
	@Autowired
	B2_Service serviceB2;
	
	// http://localhost:6080/ferp/selectAccountJson.do
	@CrossOrigin(origins = "*",allowedHeaders = "*")
	@GetMapping("selectAccountJson.do")
	public String r7100SelectAccountJson(Account account, Model model) {
		account.setAcntUsing(true);
		List<Account> list= serviceC1.r7100SelectAccount(account);
		model.addAttribute("list",list);
		return "pageJsonReport";
	}
	
	@CrossOrigin(origins = "*",allowedHeaders = "*")
	@GetMapping("selectEmpListJson.do")
	public String selectEmpListJson(Model model) {
		//model.addAttribute(); 추가예정
		return "pageJsonReport";
	}

	// http://localhost:6080/ferp/selectProdListJson.do
	@CrossOrigin(origins = "*",allowedHeaders = "*")
	@GetMapping("selectProdListJson.do")
	public String selectProdListJson(Model model) {
		ProductProdOrder ppo =new ProductProdOrder();
		ppo.setFrRegiNum("9999999999");
		model.addAttribute("productList",serviceC2.r8101ProductList(ppo));
		return "pageJsonReport";
	}
	
	@RequestMapping("noticeListJson.do")
	public String noticeList(@ModelAttribute("sch") NoticeSch sch, Model d) {
		d.addAttribute("noticeList", serviceB2.searchNotice(sch));
		return "pageJsonReport";
	}
	
	@CrossOrigin(origins = "*",allowedHeaders = "*")
	@GetMapping("selectActiveStoreJson.do")
	public String selectActiveStore(Model model) {
		model.addAttribute("storeList",serviceC1.selectActiveStore());
		//한번에 가게,직원,상품 리스트 다 넣기
		return "pageJsonReport";
	}
	
	@CrossOrigin(origins = "*",allowedHeaders = "*")
	@GetMapping("selectActiveDatalist.do")
	public String selectActiveDatalist(Model model) {
		model.addAttribute("storeList",serviceC1.selectActiveDatalist().get("storelist"));
		model.addAttribute("empList",serviceC1.selectActiveDatalist().get("emplist"));
		model.addAttribute("productList",serviceC1.selectActiveDatalist().get("productlist"));
		//한번에 가게,직원,상품 리스트 다 넣기
		return "pageJsonReport";
	}


}
