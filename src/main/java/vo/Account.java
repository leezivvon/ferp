package vo;

public class Account {

	private String acntNum;
	private String acntGroup;
	private String acntTitle;
	private boolean acntUsing;
	
	public Account() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Account(boolean acntUsing) {
		super();
		this.acntUsing = acntUsing;
	}

	public Account(String acntNum, String acntGroup, String acntTitle) {
		super();
		this.acntNum = acntNum;
		this.acntGroup = acntGroup;
		this.acntTitle = acntTitle;
	}
	
	
	public Account(String acntNum, String acntGroup, String acntTitle, boolean acntUsing) {
		super();
		this.acntNum = acntNum;
		this.acntGroup = acntGroup;
		this.acntTitle = acntTitle;
		this.acntUsing = acntUsing;
	}

	
	public boolean getAcntUsing() {
		return acntUsing;
	}

	public void setAcntUsing(boolean acntUsing) {
		this.acntUsing = acntUsing;
	}

	public String getAcntNum() {
		return acntNum;
	}
	public void setAcntNum(String acntNum) {
		this.acntNum = acntNum;
	}
	public String getAcntGroup() {
		return acntGroup;
	}
	public void setAcntGroup(String acntGroup) {
		this.acntGroup = acntGroup;
	}
	public String getAcntTitle() {
		return acntTitle;
	}
	public void setAcntTitle(String acntTitle) {
		this.acntTitle = acntTitle;
	}
	
	
}
