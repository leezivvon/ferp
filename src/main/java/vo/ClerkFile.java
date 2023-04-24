package vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ClerkFile {
	private int cnt;
	private String fname;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date regDte;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date uptDte;
	private String clerkNum;
	private String frRegiNum;
	private String fileInfo;
	private MultipartFile file;
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public Date getRegDte() {
		return regDte;
	}
	public void setRegDte(Date regDte) {
		this.regDte = regDte;
	}
	public Date getUptDte() {
		return uptDte;
	}
	public void setUptDte(Date uptDte) {
		this.uptDte = uptDte;
	}
	public String getClerkNum() {
		return clerkNum;
	}
	public void setClerkNum(String clerkNum) {
		this.clerkNum = clerkNum;
	}
	public String getFrRegiNum() {
		return frRegiNum;
	}
	public void setFrRegiNum(String frRegiNum) {
		this.frRegiNum = frRegiNum;
	}
	public String getFileInfo() {
		return fileInfo;
	}
	public void setFileInfo(String fileInfo) {
		this.fileInfo = fileInfo;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
}
