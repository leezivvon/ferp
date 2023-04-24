package vo;

public class QAchecklist { //QA표항목들
	private String qaNum;
	private String qaItem;
	private String usable;
	
	//페이징
	private int count;
	private int pageSize;
	private int pageCount;
	private int curPage;
	private int start;
	private int end; 
	private int blockSize; 
	private int startBlock;
	private int endBlock; 
	private int cnt; 
	
	public String getQaNum() {
		return qaNum;
	}
	public void setQaNum(String qaNum) {
		this.qaNum = qaNum;
	}
	public String getQaItem() {
		return qaItem;
	}
	public void setQaItem(String qaItem) {
		this.qaItem = qaItem;
	}
	public String getUsable() {
		return usable;
	}
	public void setUsable(String usable) {
		this.usable = usable;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
	
	

}
