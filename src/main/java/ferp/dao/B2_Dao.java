package ferp.dao;

import java.util.List;

import vo.Emp;
import vo.Menu;
import vo.MenuSch;
import vo.Notice;
import vo.NoticeSch;
import vo.OnTime;
import vo.Onsale;
import vo.Sales;
import vo.Store;

public interface B2_Dao {
	// 메뉴 조회
	public List<Menu> searchMenu(MenuSch sch);
	// 메뉴 등록
	public void insertMenu(Menu ins);
	// 메뉴 등록 시 필수 메뉴라면 모든 매장에 자동으로 등록하기 위한 모든 매장번호 가져오기
	public List<String> getfrRegiNum();
	// 메뉴 등록 시 모든 매장에 등록
	public void insertNesMenu(Onsale ins);
	
	// 매장 정보 등록
	public void insertStore(Store ins);
	// 필수 메뉴 출력
	public List<String> getnecessaryMenuNum();
	// 매장등록 후 필수 메뉴 등록
	public void necessaryMenu(Onsale ins);
	// 매장 정보 수정
	public void updateStore(Store upt);
	// 해당 매장 정보 조회
	public Store detailStore(String frRegiNum);
	// 해당 매장 비활성화
	public void deleteStore(String frRegiNum);
	
	// 본사 직원 등록
	public void insertEmp(Emp ins);
	// 등록한 직원정보 출력
	public Emp getEmpInfo(Emp sch);
	// 본사 직원 비밀번호 변경
	public void updateEmpPass(Emp upt);
	
	
	public int totCntNotice(NoticeSch sch);
	public int totCntQnA(NoticeSch sch);
	public int totCntMenu(MenuSch sch);
	// 중요 공지사항
	public Notice importantNotice();
	// 공지사항 조회
	public List<Notice> searchNotice(NoticeSch sch);
	// 공지사항 상세 페이지
	public Notice detailNotice(String noticeNum);
	// 조회수 증가
	public void plusCnt(String noticeNum);
	// 공지사항 등록
	public void insertNotice(Notice ins);
	// 공지사항 수정
	public void updateNotice(Notice upt);
	// 공지사항 삭제
	public void deleteNotice(String noticeNum);
	
	// 직원 콤보
	public List<Emp> getHOemp();
	// 문의글 카테고리 콤보
	public List<String> getNoticeCategory();
	// 메뉴 카테고리 콤보
	public List<String> getMenuCategory();
	// 부서 콤보
	public List<String> getDname();
	// 가맹점 번호 콤보
	public List<String> getStoreNum();
	
	// 문의글 등록
	public void insertQnA(Notice ins);
	// 문의글 조회
	public List<Notice> searchQnA(NoticeSch sch);
	// 문의글 상세페이지
	public Notice detailQnA(String noticeNum);
	// 문의글 수정
	public void updateQnA(Notice upt);
	// 문의글 삭제
	public void deleteQnA(String noticeNum);
	
	// 메인 페이지 공지사항
	public List<Notice> getNotice();
	// 전체 매장 매출 조회
	public List<Sales> getSales();
	// 담당매장 출근시간 조회
	public List<OnTime> getOnTime(String empnum);
	
}
