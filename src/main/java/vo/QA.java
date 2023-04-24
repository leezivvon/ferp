package vo;

import java.util.List;

public class QA { //실제 실행한 QA
	
	private String inspectionNum;
	private String frRegiNum; 
	private String qaNum;
	private String results;
	private String empnum;
	private String inspectDte; 
	private String regDte;
	private String comments;
	
	//점검결과 전매장 조회
	private String frname;
	private String frRepName;
	private String ename;
	private String frtel;
	
	//qa결과출력
	private String qaItem;
	
	//담당매장 목록
	private int qncnt;
	private int ycnt;
	private String score;
	
	//qa등록
	private List<String> nlist;
	private List<String> ylist;
	private List<String> clist;
	
	
	public String getInspectionNum() {
		return inspectionNum;
	}
	public void setInspectionNum(String inspectionNum) {
		this.inspectionNum = inspectionNum;
	}
	public String getFrRegiNum() {
		return frRegiNum;
	}
	public void setFrRegiNum(String frRegiNum) {
		this.frRegiNum = frRegiNum;
	}
	public String getQaNum() {
		return qaNum;
	}
	public void setQaNum(String qaNum) {
		this.qaNum = qaNum;
	}
	public String getResults() {
		return results;
	}
	public void setResults(String results) {
		this.results = results;
	}
	public String getEmpnum() {
		return empnum;
	}
	public void setEmpnum(String empnum) {
		this.empnum = empnum;
	}
	public String getInspectDte() {
		return inspectDte;
	}
	public void setInspectDte(String inspectDte) {
		this.inspectDte = inspectDte;
	}
	public String getRegDte() {
		return regDte;
	}
	public void setRegDte(String regDte) {
		this.regDte = regDte;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	
	public String getFrname() {
		return frname;
	}
	public void setFrname(String frname) {
		this.frname = frname;
	}
	public String getFrRepName() {
		return frRepName;
	}
	public void setFrRepName(String frRepName) {
		this.frRepName = frRepName;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getFrtel() {
		return frtel;
	}
	public void setFrtel(String frtel) {
		this.frtel = frtel;
	}
	public String getQaItem() {
		return qaItem;
	}
	public void setQaItem(String qaItem) {
		this.qaItem = qaItem;
	}

	public int getQncnt() {
		return qncnt;
	}
	public void setQncnt(int qncnt) {
		this.qncnt = qncnt;
	}
	public int getYcnt() {
		return ycnt;
	}
	public void setYcnt(int ycnt) {
		this.ycnt = ycnt;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	
	
	public List<String> getNlist() {
		return nlist;
	}
	public void setNlist(List<String> nlist) {
		this.nlist = nlist;
	}
	public List<String> getYlist() {
		return ylist;
	}
	public void setYlist(List<String> ylist) {
		this.ylist = ylist;
	}
	public List<String> getClist() {
		return clist;
	}
	public void setClist(List<String> clist) {
		this.clist = clist;
	}
	
	

	
	


	
	
	
	
}
