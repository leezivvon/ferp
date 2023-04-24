package ferp.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ferp.dao.A2_Dao;
import vo.ClerkFile;
import vo.DefectOrder;
import vo.Prod_ProdOrder;
import vo.Rq_Product;
import vo.SCPage;
import vo.Sales;
import vo.Store;
import vo.StoreClerk;

@Service
public class A2_Service {
	
	@Autowired(required=false)
	private A2_Dao dao;
	
	@Value("${defectPic}")
	private String defectFupload;
	
	private void pagination(SCPage sch) {
		sch.setCount(dao.totNum(sch));
		if(sch.getCurPage()==0) {
			sch.setCurPage(1);
		}
		sch.setPageCount(
				(int)Math.ceil(
				sch.getCount()/(double)sch.getPageSize())
				);
		if(sch.getCurPage()>sch.getPageCount()) {
			sch.setCurPage(sch.getPageCount());
		}
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		sch.setBlockSize(5);
		int blocknum = (int)Math.ceil(sch.getCurPage()/
					(double)sch.getBlockSize());
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock>sch.getPageCount()) {
			endBlock = sch.getPageCount();
		}
		sch.setEndBlock(endBlock);
		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
	}
	
	public List<StoreClerk> storeClerkList(SCPage sch){
		if(sch.getClerkName() == null) sch.setClerkName("");
		if(sch.getFrRegiNum() == null) sch.setFrRegiNum("");
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		pagination(sch);
		return dao.storeClerkList(sch);
	}
	
	public void insStoreclerk(StoreClerk ins) {
		dao.insStoreclerk(ins);
	}
	
	public void uptStoreClerk(StoreClerk upt) {
		upt.setHourlyPay(upt.getHourlyPay().replace(",", ""));
		System.out.println((upt.getHourlyPay()));
		dao.uptStoreClerk(upt);
	}
	
	public void delStoreClerk(String clerkNum) {
		dao.delStoreClerk(clerkNum);
	}
	
	public List<StoreClerk> storeClerkPayList(SCPage sch){
		if(sch.getFrRegiNum() == null) sch.setFrRegiNum("");
		if(sch.getClerkName() == null) sch.setClerkName("");
		if(sch.getOrderDateMonth() == null) sch.setOrderDateMonth("");
		if(sch.getOrderDateYear() == null) sch.setOrderDateYear(String.valueOf(LocalDate.now().getYear()));
		sch.setCount(dao.totNum(sch));
		if(sch.getPageSize()==0) {
			sch.setPageSize(10);
		}
		pagination(sch);
		return dao.storeClerkPayList(sch);
	}
	
	public List<Rq_Product> availProd(Rq_Product plist){
		if(plist.getProductName() == null) plist.setProductName("");
		return dao.availProd(plist);
	}
	public int clerkTot(String frRegiNum) {
		return dao.clerkTot(frRegiNum);
	}
	public void prodOrderReq(Prod_ProdOrder ins) {
		dao.prodOrderReq(ins);
	}
	public List<Prod_ProdOrder> reqList(Prod_ProdOrder sch){
		if(sch.getProductName() == null) sch.setProductName("");
		if(sch.getCategory() == null) sch.setCategory("");
		if(sch.getDemander() == null) sch.setDemander("");
		if(sch.getOrderDateMonth() == null) sch.setOrderDateMonth("");
		if(sch.getOrderDateYear() == null) sch.setOrderDateYear(String.valueOf(LocalDate.now().getYear()));
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		sch.setCount(dao.totNumProdOrder(sch));
		if(sch.getCurPage()==0) {
			sch.setCurPage(1);
		}
		sch.setPageCount(
				(int)Math.ceil(
				sch.getCount()/(double)sch.getPageSize())
				);
		if(sch.getCurPage()>sch.getPageCount()) {
			sch.setCurPage(sch.getPageCount());
		}
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		sch.setBlockSize(10);
		int blocknum = (int)Math.ceil(sch.getCurPage()/
					(double)sch.getBlockSize());
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock>sch.getPageCount()) {
			endBlock = sch.getPageCount();
		}
		sch.setEndBlock(endBlock);
		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		return dao.reqList(sch);
	}
	public void uptReqList(Prod_ProdOrder upt) {
		dao.uptReqList(upt);
	}
	public void delReqList(Prod_ProdOrder del) {
		dao.delReqList(del);
	}
	public List<Rq_Product> cateCombo() {
		return dao.cateCombo();
	}
	public void clerkfileupl(ClerkFile upl) {
		if(upl.getFname() == null) upl.setFname("");
		if(upl.getClerkNum() == null) upl.setClerkNum("");
		if(upl.getFrRegiNum() == null) upl.setFrRegiNum("");
		dao.clerkfileupl(upl);
	}
	public List<ClerkFile> viewClerkFileInfo(ClerkFile sch){
		if(sch.getClerkNum() == null) sch.setClerkNum("");
		if(sch.getFrRegiNum() == null) sch.setFrRegiNum("");
		return dao.viewClerkFileInfo(sch);
	}
	public void clerkFileUpt(ClerkFile upt) {
		if(upt.getFname() == null) upt.setFname("");
		if(upt.getClerkNum() == null) upt.setClerkNum("");
		if(upt.getFrRegiNum() == null) upt.setFrRegiNum("");
		dao.clerkFileUpt(upt);
	}
	public void clerkFileDel(ClerkFile del) {
		dao.clerkFileDel(del);
	}
	public List<DefectOrder> viewDefectorder(DefectOrder sch){
		if(sch.getProductName() == null) sch.setProductName("");
		if(sch.getFrRegiNum() == null) sch.setFrRegiNum("");
		if(sch.getOrderDateMonth() == null) sch.setOrderDateMonth("");
		if(sch.getCategory() == null) sch.setCategory("");
		if(sch.getOrderDateYear() == null) sch.setOrderDateYear(String.valueOf(LocalDate.now().getYear()));
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		sch.setCount(dao.totDefectOrder(sch));
		if(sch.getCurPage()==0) {
			sch.setCurPage(1);
		}
		sch.setPageCount(
				(int)Math.ceil(
				sch.getCount()/(double)sch.getPageSize())
				);
		if(sch.getCurPage()>sch.getPageCount()) {
			sch.setCurPage(sch.getPageCount());
		}
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		sch.setBlockSize(5);
		int blocknum = (int)Math.ceil(sch.getCurPage()/
					(double)sch.getBlockSize());
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock>sch.getPageCount()) {
			endBlock = sch.getPageCount();
		}
		sch.setEndBlock(endBlock);
		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		return dao.viewDefectorder(sch);
	}
	public List<Sales> salesGraph(Sales sch, HttpSession session){
		String a = String.valueOf(session.getAttribute("login"));
		int i = a.indexOf("@");
		String vo = a.substring(0, i);
		if(vo.equals("vo.Store")) {
			Store s = (Store)session.getAttribute("login");
			sch.setFrRegiNum(s.getFrRegiNum());
		}else {
			sch.setFrRegiNum("");
		}
		return dao.salesGraph(sch);
	}
	public List<StoreClerk> storeclerkSchedule(StoreClerk sch, HttpSession session){
		String a = String.valueOf(session.getAttribute("login"));
		int i = a.indexOf("@");
		String vo = a.substring(0, i);
		if(vo.equals("vo.Store")) {
			Store s = (Store)session.getAttribute("login");
			sch.setFrRegiNum(s.getFrRegiNum());
		}else {
			sch.setFrRegiNum("");
		}
		if(sch.getMonthDate() == null) sch.setMonthDate("");
		return dao.storeclerkSchedule(sch);
	}
	public void insertDefectOrder(DefectOrder ins) {
		String tot = String.valueOf(dao.defectOrderTot(ins.getFrRegiNum()));
		ins.setDefNum(tot);
		ins.setImg(uploadFile(ins.getFile()));
		dao.insertDefectOrder(ins);
	}
	public String uploadFile(MultipartFile file) {
		String img = file.getOriginalFilename();
		if(img!=null && !img.equals("")) {
			File fObj = new File(defectFupload+img);	
			try {
				file.transferTo(fObj); 
			} catch (IllegalStateException e) {
				System.out.println("파일업로드 예외1:"+e.getMessage());
			} catch (IOException e) {
				System.out.println("파일업로드 예외2:"+e.getMessage());
			}
		}
		return img;
	}
	public void prodOrderToDefected(DefectOrder upt) {
		if(upt.getFrRegiNum() == null) upt.setFrRegiNum("");
		if(upt.getOrderNum() == null) upt.setOrderNum("");
		if(upt.getProductNum() == null) upt.setProductNum("");
		if(upt.getOrderDate() == null) upt.setOrderDate("");
		dao.prodOrderToDefected(upt);
	}
	public List<StoreClerk> past5years() {
		for(int i = 0;i<dao.past5years().size();i++) {
			System.out.println(dao.past5years().get(i));
		}
		return dao.past5years();
	}
//	public void deleteDefectOrder(DefectOrder del) {
//		File file = new File(defectFupload+del.getImg());
//		System.out.println(del.getImg());
//		System.out.println(file);
//		System.out.println(file.exists());
//		if(file.exists()) {
//			file.delete();
//			dao.deleteDefectOrder(del);
//			System.out.println("file exist");
//		}else {
//			dao.deleteDefectOrder(del);
//			System.out.println("file not exist");
//		}
//	}
}