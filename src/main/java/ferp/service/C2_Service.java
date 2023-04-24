package ferp.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ferp.dao.C2_Dao;
import vo.ClerkSchedule;
import vo.Product;
import vo.ProductProdOrder;
import vo.ProductStock;
import vo.Stock;
import vo.StoreClerk;

@Service
public class C2_Service {
	
	@Autowired(required=false)
	private C2_Dao dao;
	
	// 업로드할 경로 지정
	@Value("${upload}")
	private String upload;
	
	// 자재 이미지 업로드
//	public String upload(MultipartFile multipartfile) {
//		String img = multipartfile.getOriginalFilename();
//		if( img!=null && !img.equals("")) {
//			File imgObj = new File(upload+img);
//			try {
//				multipartfile.transferTo(imgObj);
//			} catch (IllegalStateException e) {
//				System.out.println("파일업로드 예외1:"+e.getMessage());
//			} catch (IOException e) {
//				System.out.println("파일업로드 예외2:"+e.getMessage());
//			}
//		}
//		return img;
//	}
	private String upload(MultipartFile multipartfile) {
	    String originalFilename = multipartfile.getOriginalFilename();
	    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
	    String filename = dao.getNextval() + extension; // 'PD'와 시퀀스 번호로 파일 이름 생성
	    if( originalFilename!=null && !originalFilename.equals("")) {
			File imgObj = new File(upload+filename);
			try {
				multipartfile.transferTo(imgObj);
			} catch (IllegalStateException e) {
				System.out.println("파일업로드 예외1:"+e.getMessage());
			} catch (IOException e) {
				System.out.println("파일업로드 예외2:"+e.getMessage());
			}
		}
	    return filename;
	}
	
	// 본사/매장 재고 조회
	public List<ProductProdOrder> r8101ProductList(ProductProdOrder sch){
		if(sch.getStockDate()==null) sch.setStockDate("");
		if(sch.getProductNum()==null) sch.setProductNum("");
		if(sch.getCategory()==null) sch.setCategory("");
		if(sch.getProductName()==null) sch.setProductName("");
		if(sch.getOpposite()==null) sch.setOpposite("");
		return dao.r8101ProductList(sch);
	}
	
	// 본사/매장 재고 상세 페이지 
	public Product r8101ProductInfo(String productNum) {
		return dao.r8101ProductInfo(productNum);
	}
	
	// 본사/매장 재고 입출고 조회
	public List<ProductProdOrder> r8204InoutList(ProductProdOrder sch){
		if(sch.getProductNum()==null) sch.setProductNum("");
		if(sch.getPageSize()==0) {
			sch.setPageSize(10);
		}
		sch.setCount(dao.inoutListTot(sch));
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
		return dao.r8204InoutList(sch);
	}
	
	// 매장 재고 입출고 등록
	public void r8103InoutIns(Stock ins) {
		dao.r8103InoutIns(ins);
	}
	
	// 매장 재고 입출고 수정
	public void r8104InoutUpt(String productNum, int applyAmount, int remainAmount, String frRegiNum) {
		Stock upt = new Stock();
		upt.setProductNum(productNum);
		upt.setApplyAmount(applyAmount);
		upt.setRemainAmount(remainAmount);
		upt.setFrRegiNum(frRegiNum);
	    dao.r8104InoutUpt(upt);
	}
	
	// 매장 재고 입출고 삭제
	public void r8105InoutDel(String productNum, int applyAmount, int remainAmount, String frRegiNum) {
	    Stock del = new Stock();
	    del.setProductNum(productNum);
	    del.setApplyAmount(applyAmount);
	    del.setRemainAmount(remainAmount);
	    del.setFrRegiNum(frRegiNum);
	    dao.r8105InoutDel(del);
	    Stock del2 = new Stock();
	    del2.setProductNum(del.getProductNum());
	    //del2.setApplyAmount(del.getApplyAmount());
	    del2.setFrRegiNum(del.getFrRegiNum());
	    dao.r8105InoutDel2(del2);
	}
	
	// 본사 재고 등록
	public String r8202ProductIns(ProductStock ins) {
		if( ins.getMultipartfile() != null) {
			String img = upload(ins.getMultipartfile());
			ins.setImg(img);
		}
		if( ins.getMultipartfile() == null ) {
			ins.setImg("");
		}
		dao.r8202ProductIns(ins);
		return ins.getProductNum();
	}
	
	// 본사 재고 수정
	public String r8203ProductUpt(Product upt) {
		dao.r8203ProductUpt(upt);	
		return upt.getProductNum();
	}
	
	// 자재 코드 콤보
	public List<Stock> productNumCom(){
		return dao.productNumCom();
	}
	
	// 직원 번호 콤보
	public List<StoreClerk> clerkNumCom(){
		return dao.clerkNumCom();
	}
	
	// 직원스케줄 캘린더 등록	
	public void sclerkschdIns(ClerkSchedule ins) {
		dao.sclerkschdIns(ins);
	}
	
	// 직원스케줄 캘린더 삭제	
	public void sclerkschdDel(String clerkName, String onDay) {
	    ClerkSchedule del = new ClerkSchedule();
	    del.setClerkName(clerkName);
	    del.setOnDay(onDay);
	    dao.sclerkschdDel(del);
	}
	
	// 직원스케줄 캘린더
	public List<HashMap<String, Object>> sclerkschd(String writer){
		return dao.sclerkschd(writer);
	}
	
	// 본사 직원 점검일 배정 
	
}
