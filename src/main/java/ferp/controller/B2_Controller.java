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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ferp.download.ChatHandler;
import ferp.service.B2_Service;
import vo.Emp;
import vo.Menu;
import vo.MenuSch;
import vo.Notice;
import vo.NoticeSch;
import vo.OnTime;
import vo.Sales;
import vo.Store;

@Controller
@SessionAttributes({"totSales", "onTimeCombo"})
public class B2_Controller {
	@Autowired(required = false)
	private B2_Service service;
	
	@ModelAttribute("empCombo")
	public List<Emp> getHOemp(){
		return service.getHOemp();
	}
	@ModelAttribute("noticeCategoryCombo")
	public List<String> getNoticeCategory(){
		return service.getNoticeCategory();
	}
	@ModelAttribute("menuCategoryCombo")
	public List<String> getMenuCategory(){
		return service.getMenuCategory();
	}
	@ModelAttribute("dnameCombo")
	public List<String> getDname(){
		return service.getDname();
	}
	@ModelAttribute("totSales")
	public List<Sales> totSales(){
		return service.getSales();
	}
	@ModelAttribute("storeNum")
	public List<String> storeNum(){
		return service.getStoreNum();
	}
	// 본사 메인페이지
	@RequestMapping("/goHqPage.do")
	public String goHqPage(HttpSession session, Model d) {
		Emp e = (Emp)session.getAttribute("login");
		// 공지사항
		d.addAttribute("noticeCombo", service.getNotice());
		
		// 담당매장 오픈시간
		List<OnTime> ontime = service.getOnTime(e.getEmpnum());
		d.addAttribute("onTimeCombo", ontime);
		
		// 중요공지사항
		d.addAttribute("important", service.importantNotice());
		return "/pg0001.jsp";
	}
	@RequestMapping("/empSet.do")
	public String asda(HttpSession session, Model d) {
		Emp e = (Emp)session.getAttribute("login");
		
		// 공지사항
		d.addAttribute("noticeCombo", service.getNotice());
		
		// 매출
		List<Sales> totSales = service.getSales();
		d.addAttribute("totSales", totSales);
		
		// 담당매장 오픈시간
		List<OnTime> ontime = service.getOnTime(e.getEmpnum());
		d.addAttribute("onTimeCombo", ontime);
		
		// 중요공지사항
		d.addAttribute("important", service.importantNotice());
		
		return "forward:pg0001.jsp";
	}
	
	
	// 메뉴 조회 controller
	@RequestMapping("/menuList.do")
	public String menuList(@ModelAttribute("sch") MenuSch sch, Model d) {
		d.addAttribute("menu", service.searchMenu(sch));
		 
		return "WEB-INF\\view\\menu_list.jsp";
	}
	
	// 메뉴 등록 controller
	@GetMapping("/menuInsert.do")
	public String menuInsert() {
		return "WEB-INF\\view\\menu_insert.jsp";
	}
	@PostMapping("/menuInsert.do")
	public String menuInsert(Menu ins, RedirectAttributes redirect) {
		if( service.insertMenu(ins) != null ) {
			redirect.addFlashAttribute("insMsg", "메뉴 등록 성공!");
		}
		return "redirect:/menuList.do";
	}
	
	// 매장정보등록
	@GetMapping("/storeInsert.do")
	public String storeInsert() {
		return "WEB-INF\\view\\store_insert.jsp";
	}
	@PostMapping("/storeInsert.do")
	public String storeInsert(Store ins, RedirectAttributes redirect) {
		if( service.insertStore(ins) != null ) {
			redirect.addFlashAttribute("msg", "매장정보등록 성공!!");
		}
		return "redirect:/salesInfo.do";
	}
	
	// 매장 정보 수정
	@GetMapping("/storeUpdate.do")
	public String storeUpdate(@RequestParam String frRegiNum, Model d) {
		d.addAttribute("store", service.detailStore(frRegiNum));
		
		return "WEB-INF\\view\\store_update.jsp";
	}
	@PostMapping("/storeUpdate.do")
	public String storeUpdate(Store upt, RedirectAttributes redirect) {
		if( service.updateStore(upt) != null) {
			redirect.addFlashAttribute("uptMsg", "매장 정보 수정 완료");
		}
		
		return "redirect:/salesInfo.do";
	}
	// 매장 정보 비활성화
	@RequestMapping("/storeDelete.do")
	public String storeDelete(@RequestParam String frRegiNum, RedirectAttributes redirect) {
		if( service.deleteStore(frRegiNum) != null ) {
			redirect.addFlashAttribute("delMsg", "매장 정보 비활성화 완료");
		}
		return "redirect:/salesInfo.do";
	}
	
	
	// 본사 직원 등록
	@GetMapping("/insertEmp.do")
	public String insertEmp() {
		return "WEB-INF\\view\\emp_insert.jsp";
	}
	@PostMapping("/insertEmp.do")
	public String insertEmp(Emp ins, RedirectAttributes redirect) {
		if( service.insertEmp(ins)!=null ) {
			redirect.addFlashAttribute("isgMsg", "등록 성공");
		}
		
		Emp emp = service.getEmpInfo(ins);
		redirect.addFlashAttribute("emp", emp);
		
		return "redirect:/insertEmp.do";
	}
	
	
	// http://localhost:7080/ferp/updateEmpPass.do
	
	// 본사 직원 비밀번호 변경
	@GetMapping("/updateEmpPass.do")
	public String updateEmpPass() {
		
		return "WEB-INF\\view\\emp_passUpdate.jsp";
	}
	@PostMapping("/updateEmpPass.do")
	public String updateEmpPass(Emp upt, RedirectAttributes redirect) {
		if( service.updateEmpPass(upt)!= null) {
			redirect.addFlashAttribute("passupt", "수정 완료");
		}
		
		return "redirect:/updateEmpPass.do";
	}
	
	// 공지사항 조회
	@RequestMapping("/noticeList.do")
	public String noticeList(@ModelAttribute("sch") NoticeSch sch, Model d) {
		d.addAttribute("list", service.searchNotice(sch));
		
		return "WEB-INF\\view\\notice_list.jsp";
	}
	// 공지사항 상세 페이지
	@RequestMapping("noticeDetail.do")
	public String noticeDetail(@RequestParam String noticeNum, Model d) {
		d.addAttribute("notice", service.detailNotice(noticeNum));
		
		return "WEB-INF\\view\\notice_detail.jsp";
	}
	// 파일 다운로드
	@GetMapping("/download.do")
	public String download(@RequestParam String fname, Model d) {
		d.addAttribute("downloadFile", fname);
		
		return "downloadViewer";
	}
	// 공지사항 등록
	@GetMapping("/noticeInsert.do")
	public String noticeInsert() {
		return "WEB-INF\\view\\notice_insert.jsp";
	}
	@PostMapping("/noticeInsert.do")
	public String noticeInsert(Notice ins, RedirectAttributes redirect) {
		if( service.insertNotice(ins) != null ) {
			redirect.addFlashAttribute("insMsg", "공지사항 등록 성공");
		}
		return "redirect:/noticeList.do";
	}
	// 공지사항 수정
	@GetMapping("/noticeUpdate.do")
	public String noticeUpdate(@RequestParam String noticeNum, Model d) {
		d.addAttribute("notice", service.detailNotice(noticeNum));
		
		return "WEB-INF\\view\\notice_update.jsp";
	}
	@PostMapping("/noticeUpdate.do")
	public String noticeUpdate(Notice upt, RedirectAttributes redirect) {
		if( service.updateNotice(upt) != null) {
			redirect.addFlashAttribute("uptMsg", "공지사항 수정 성공");
		}
		
		return "redirect:/noticeList.do";
	}
	// 공지사항 삭제
	@RequestMapping("/noticeDelete.do")
	public String noticeDelete(@RequestParam String noticeNum, RedirectAttributes redirect) {
		if( service.deleteNotice(noticeNum) != null ) {
			redirect.addFlashAttribute("delMsg", "공지사항 삭제 완료");
		}
		
		return "redirect:/noticeList.do";
	}
	
	
	// 문의글 조회
	// http://localhost:7080/ferp/qnaList.do
	@RequestMapping("/qnaList.do")
	public String qnaList(@ModelAttribute("sch") NoticeSch sch, Model d) {
		d.addAttribute("qna", service.searchQnA(sch));
		
		return "WEB-INF\\view\\qna_list.jsp";
	}
	// 문의글 상세페이지
	@RequestMapping("/qnaDetail.do")
	public String qnaDetail(@RequestParam String noticeNum, Model d) {
		d.addAttribute("qna", service.detailQnA(noticeNum));
		
		return "WEB-INF\\view\\qna_detail.jsp";
	}
	// 문의글 등록폼
	// http://localhost:7080/ferp/qnaInsert.do
	@GetMapping("/qnaInsert.do")
	public String qnaInsert() {
		return "WEB-INF\\view\\qna_insert.jsp";
	}
	// 문의글 등록 & 답변
	@PostMapping("/qnaInsert.do")
	public String qnaInsert(Notice ins, RedirectAttributes redirect) {
		if( service.insertQnA(ins)!=null ) {
			redirect.addFlashAttribute("insMsg", "등록 성공");
		}
		
		return "redirect:/qnaList.do";
	}
	// 답글 등록 페이지
	@RequestMapping("/qnaReply.do")
	public String qnaReply() {
		return "WEB-INF\\view\\qna_reply.jsp";
	}
	// 문의글 수정
	@GetMapping("/qnaUpdate.do")
	public String qnaUpdate(@RequestParam String noticeNum, Model d) {
		d.addAttribute("qna", service.detailQnA(noticeNum));
		
		return "WEB-INF\\view\\qna_update.jsp";
	}
	@PostMapping("/qnaUpdate.do")
	public String qnaUpdate(Notice upt, RedirectAttributes redirect) {
		if( service.updateQnA(upt)!=null ) {
			redirect.addFlashAttribute("uptMsg", "수정 성공");
		}
		return "redirect:/qnaList.do";
	}
	// 문의글 삭제
	@RequestMapping("/qnaDelete.do")
	public String qnaDelete(@RequestParam String noticeNum, RedirectAttributes redirect) {
		if( service.deleteQnA(noticeNum) != null ) {
			redirect.addFlashAttribute("delMsg", "문의글 삭제 완료");
		}
		
		return "redirect:/qnaList.do";
	}	
	
	
	@Autowired(required = false)
	private ChatHandler chHandl;
	
	// http://localhost:7080/ferp/chatting.do
	// 채팅
	@RequestMapping("/chatting.do")
	public String chatting() {
		
		return "WEB-INF\\view\\chatting.jsp";
	}
	@GetMapping("/chGroup.do")
	public String chGroup(Model d) {
		d.addAttribute("group", chHandl.getIdx());
		return "pageJsonReport";
	}
	
}
