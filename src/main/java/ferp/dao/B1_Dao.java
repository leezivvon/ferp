package ferp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.OpenTimeCalender;
import vo.Orders;
import vo.QA;
import vo.QAchecklist;
import vo.Store;

public interface B1_Dao {
	
	//매장정보조회
	public int lastmonthAllSales(); //본사:지난달전체매장매출총액
	public List<Orders> salesByStoreList(Orders sbsl);	//본사:전매장매출-전체조회
	
	public Orders storeDetailInfo(String frRegiNum); //본사:매장정보상세조회
	public List<Orders> detailSalesList(Orders dinfo); //본사:매장정보상세조회-매매액
	public List<Orders> detailMenuList(Orders dinfo); //본사:매장정보상세조회-메뉴
	
	
	//QA점검
	public List<QAchecklist> qaList(QAchecklist ql); //qa표항목전체출력
	public int totNum();//페이징처리
	
	public void qaListIns(String qaItem); //qa표항목추가등록
	public void qaListUpt(QAchecklist upt); //qa표항목활성.비활성화
	
	public List<QA> qaStoresList(QA qa); //이달qa 전매장 조회
	public QA qaDetailStrinfo(String frRegiNum); //이달qa 상세조회-매장정보
	public List<QA> qaDetailList(QA qa);  //이달qa 상세조회-결과표
	public QA qaDetailScore(QA qa); //이달qa 상세조회-점수
	
	//담당 매장 점검
	public List<QA> inchargeStore(String empNum); //담당매장 목록
	public List<QA> inchargeStrQA(QA qa); //담당매장 중 특정매장 점검목록
	public List<QA> inchargeStrPastQA(QA qa); //특정매장 과거점검결과
	
	
	public List<QA> inspectQAclmn(QA qa); //특정매장 점검등록-항목출력
	public void updateQA(QA qa); //특정매장 점검등록-체크하면 y로 변경, comments변경
	public void updateQAregdte(QA qa); //특정매장 점검등록-등록일넣기

	/*
	public void updateQAresultsY(QA qa); //특정매장 점검등록-y로체크
	//@Param은 MyBatis에서 사용되는 어노테이션 중 하나입니다.
	//MyBatis에서 SQL 쿼리를 작성할 때 파라미터 매핑을 지원
	// DAO에서 파라미터의 이름과 SQL 쿼리에서 사용되는 파라미터 이름이 다르다면, MyBatis는 이를 인식하지 못하고 오류가 발생할 수 있으므로, 
	//이 경우에는 @Param 어노테이션을 사용하여 파라미터의 이름을 지정
	//public void regQanumList(@Param("qanumList") List<String> ylist);//특정매장 점검등록-y로체크하는 항목들
	
	//public void updateQAcomnt(QA qa); //특정매장 점검등록-comment달기
	public void updateQAregdte(QA qa); //특정매장 점검등록-등록일넣기
	*/

	
	//매장오픈점검
	public List<Store> storeOpenList(Store otl); //본사:전매장오픈시간-전체조회
	
	public OpenTimeCalender storeDetailOpenTime(String writer); //본사:매장오픈상세조회
	public List<OpenTimeCalender> openTimeDetailCalendar(OpenTimeCalender otcd); //본사:매장오픈상세조회-캘린더
}
