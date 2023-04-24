package ferp.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ferp.dao.B2_Dao;
import vo.Emp;
import vo.Menu;
import vo.MenuSch;
import vo.Notice;
import vo.NoticeSch;
import vo.OnTime;
import vo.Onsale;
import vo.Sales;
import vo.Store;

@Service
public class B2_Service {
	@Autowired(required = false)
	private B2_Dao dao;
	
	// 업로드할 경로 지정
	@Value("${upload}")
	private String upload;
	
	// 메뉴 조회
	public List<Menu> searchMenu(MenuSch sch){
		if(sch.getMenuName()==null) sch.setMenuName("");
		
		sch.setCount(dao.totCntMenu(sch));
		
		if(sch.getCurPage()==0) sch.setCurPage(1);
		
		if(sch.getPageSize()==0) sch.setPageSize(7);
		
		sch.setPageCount( (int)Math.ceil(sch.getCount()/(double)sch.getPageSize()) );
		
		if(sch.getCurPage()>sch.getPageCount()) sch.setCurPage(sch.getPageCount());
		
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getPageSize()*sch.getCurPage());
		sch.setBlockSize(5);
		
		int blocknum = (int)Math.ceil((double)sch.getCurPage()/sch.getBlockSize());
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock > sch.getPageCount()) endBlock = sch.getPageCount();
		sch.setEndBlock(endBlock);

		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		return dao.searchMenu(sch);
	}
	
	// 메뉴등록 시 사진 업로드
	public String upload(MultipartFile multipartfile) {
		String img = multipartfile.getOriginalFilename();
		if( img!=null && !img.equals("")) {
			File imgObj = new File(upload+img);
			
			try {
				multipartfile.transferTo(imgObj);
			} catch (IllegalStateException e) {
				System.out.println("파일업로드 예외1:"+e.getMessage());
			} catch (IOException e) {
				System.out.println("파일업로드 예외2:"+e.getMessage());
			}
		}
		
		return img;
	}
	
	// 메뉴 등록
	public String insertMenu(Menu ins) {
		String img = upload(ins.getMultipartfile());
		ins.setImg(img);
		dao.insertMenu(ins);
		
		if(ins.getNecessary().equals("N")) {
			List<String> frRegiNum = dao.getfrRegiNum();
			for(String num : frRegiNum) {
				Onsale onsale = new Onsale();
				onsale.setFrRegiNum(num);
				dao.insertNesMenu(onsale);
			}
		}

		return img;
	}
	
	// 매장 정보 등록
	public String insertStore(Store ins) {
		if(ins.getEmpNum()==null) ins.setEmpNum("");
		
		dao.insertStore(ins);
		List<String> menuNum = dao.getnecessaryMenuNum();
		for(String num : menuNum) {
			// 필수 메뉴 등록
			Onsale onsale = new Onsale();
			onsale.setMenuNum(num);
			onsale.setFrRegiNum(ins.getFrRegiNum());
			dao.necessaryMenu(onsale);
		}

		return ins.getFrName();
	}
	// 매장 정보 수정
	public String updateStore(Store upt) {
		
		dao.updateStore(upt);
		
		return upt.getFrRepName();
	}
	// 해당 매장 정보 조회
	public Store detailStore(String frRegiNum) {
		
		return dao.detailStore(frRegiNum);
	}
	// 해당 매장 정보 비활성화
	public String deleteStore(String frRegiNum) {
		dao.deleteStore(frRegiNum);
		
		return frRegiNum;
	}
	
	
	// 본사 직원 등록
	public String insertEmp(Emp ins) {
		
		dao.insertEmp(ins);
		
		return ins.getEname();
	}
	
	// 등록한 직원정보 출력
	public Emp getEmpInfo(Emp sch) {
		
		return dao.getEmpInfo(sch);
	}
	// 본사 직원 비밀번호 변경
	public String updateEmpPass(Emp upt) {
		dao.updateEmpPass(upt);
		
		return upt.getEmpnum();
	}
	
	// 중요 공지사항
	public Notice importantNotice() {
		return dao.importantNotice();
	}
	// 공지사항 조회
	public List<Notice> searchNotice(NoticeSch sch){
		if(sch.getTitle()==null) sch.setTitle("");
		
		sch.setCount(dao.totCntNotice(sch));
		if(sch.getCurPage()==0) sch.setCurPage(1);
		if(sch.getPageSize()==0) sch.setPageSize(10);
		sch.setPageCount( (int)Math.ceil(sch.getCount()/(double)sch.getPageSize()) );
		if(sch.getCurPage()>sch.getPageCount()) sch.setCurPage(sch.getPageCount());
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getPageSize()*sch.getCurPage());
		sch.setBlockSize(5);
		
		int blocknum = (int)Math.ceil((double)sch.getCurPage()/sch.getBlockSize());
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock > sch.getPageCount()) endBlock = sch.getPageCount();
		sch.setEndBlock(endBlock);

		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		return dao.searchNotice(sch);
	}
	// 공지사항 상세 페이지
	public Notice detailNotice(String noticeNum) {
		// 조회수 증가
		dao.plusCnt(noticeNum);
		
		return dao.detailNotice(noticeNum);
	}
	// 공지사항 등록
	public String insertNotice(Notice ins) {
		if( ins.getMultipartfile() != null) {
			String fname = upload(ins.getMultipartfile());
			ins.setFname(fname);
		}
		if( ins.getMultipartfile() == null ) {
			ins.setFname("");
		}
		dao.insertNotice(ins);
		
		return ins.getTitle();
	}
	// 공지사항 수정
	public String updateNotice(Notice upt) {
		if( upload(upt.getMultipartfile())!=null && !upload(upt.getMultipartfile()).equals("")){
			String fname = upload(upt.getMultipartfile());
			upt.setFname(fname);
		}
		
		if(upt.getFname()==null) upt.setFname("");
		
		dao.updateNotice(upt);
		
		return upt.getNoticeNum();
	}
	// 공지사항 삭제
	public String deleteNotice(String noticeNum) {
		
		dao.deleteNotice(noticeNum);
		
		return noticeNum;
	}
	
	// 직원 콤보박스
	public List<Emp> getHOemp(){
		return dao.getHOemp();
	}
	// 문의글 카테고리 콤보
	public List<String> getNoticeCategory(){
		return dao.getNoticeCategory();
	}
	// 메뉴 카테고리 콤보
	public List<String> getMenuCategory(){
		return dao.getMenuCategory();
	}	
	// 부서 콤보
	public List<String> getDname(){
		return dao.getDname();
	}
	// 가맹점 번호 콤보
	public List<String> getStoreNum(){
		return dao.getStoreNum();
	}
	
	
	// 문의글 조회
	public List<Notice> searchQnA(NoticeSch sch){
		if(sch.getTitle()==null) sch.setTitle("");
		
		sch.setCount(dao.totCntQnA(sch));
		if(sch.getCurPage()==0) sch.setCurPage(1);
		if(sch.getPageSize()==0) sch.setPageSize(10);
		sch.setPageCount( (int)Math.ceil(sch.getCount()/(double)sch.getPageSize()) );
		if(sch.getCurPage()>sch.getPageCount()) sch.setCurPage(sch.getPageCount());
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getPageSize()*sch.getCurPage());
		sch.setBlockSize(5);
		int blocknum = (int)Math.ceil((double)sch.getCurPage()/sch.getBlockSize());
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock > sch.getPageCount()) endBlock = sch.getPageCount();
		sch.setEndBlock(endBlock);
		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		
		return dao.searchQnA(sch);
	}
	// 문의글 상세페이지
	public Notice detailQnA(String noticeNum) {
		dao.plusCnt(noticeNum);
		
		return dao.detailQnA(noticeNum);
	}
	// 문의글 등록 & 답변
	public String insertQnA(Notice ins) {
		if( ins.getMultipartfile() != null) {
			String fname = upload(ins.getMultipartfile());
			ins.setFname(fname);
		}
		if( ins.getMultipartfile() == null ) {
			ins.setFname("");
		}
		dao.insertQnA(ins);
		
		return ins.getTitle();
	}
	// 문의글 수정
	public String updateQnA(Notice upt) {
		if( upload(upt.getMultipartfile())!=null && !upload(upt.getMultipartfile()).equals("")){
			String fname = upload(upt.getMultipartfile());
			upt.setFname(fname);
		}
		if(upt.getFname()==null) upt.setFname("");
		
		dao.updateQnA(upt);
		
		return upt.getNoticeNum();
	}
	// 문의글 삭제
	public String deleteQnA(String noticeNum) {
		dao.deleteQnA(noticeNum);
		
		return noticeNum;
	}
	
	// 메인 페이지에서 최근 6개 공지사항 combo
	public List<Notice> getNotice(){
		return dao.getNotice();
	}
	// 전체 매장 매출 조회
	public List<Sales> getSales(){
		return dao.getSales();
	}
	// 담당매장 출근시간 조회
	public List<OnTime> getOnTime(String empnum){
		return dao.getOnTime(empnum);
	}
}

