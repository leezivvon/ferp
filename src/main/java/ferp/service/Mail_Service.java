package ferp.service;

import java.io.File;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import ferp.dao.C1_Dao;
import vo.Mail;
import vo.Store;

@Service
public class Mail_Service {
	@Autowired(required = false)
	private JavaMailSender mailSender;
	@Autowired(required = false)
	C1_Dao dao;
	
	public String sendMail(Mail mail) {
		String msg="발송 성공";
		MimeMessage message = mailSender.createMimeMessage();
		try {
		
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			message.setSubject(mail.getTitle());	//제목
			message.setRecipient(RecipientType.TO, new InternetAddress(mail.getReceiver()));	//수신자
			message.setText(mail.getContent());
			helper.addAttachment("파일 이름", new File("파일 경로"));
			
			mailSender.send(message);	//발송
			
		} catch (MessagingException e) {
			System.out.println(e.getMessage());
			msg="발송 실패 원인 : "+e.getMessage();
			e.printStackTrace();
		}catch (Exception e) {
			msg="기타 에러 : "+e.getMessage();
			System.out.println(msg);
		}
		
		return msg;
	}
	
	public String r1003tempPassword(Store store) {
		String msg="일치하는 계정을 찾을 수 없습니다. 관리자에게 문의하세요.";
		if(dao.r1003tempPassword(store)!=null) {
			//발급메일 세팅
			Mail mail = new Mail();
			mail.setTitle("FERP-투썸플레이스 비밀번호 분실:임시비밀번호가 발급되었습니다");
			mail.setSender("dearseng@gmail.com");
			mail.setReceiver(store.getEmail());
			//새 비밀번호 만들기
			   StringBuilder builder = new StringBuilder();
		        while (builder.length() < 8) {
		            double randomValue = Math.random();
		            char code = 0;
		            if (randomValue < 0.33) {
		                code = (char) (Math.random() * 10 + 48); // 0-9
		            } else if (randomValue < 0.66) {
		                code = (char) (Math.random() * 26 + 65); // A-Z
		            } else {
		                code = (char) (Math.random() * 26 + 97); // a-z
		            }
		            builder.append(code);
		        }
		    String password=builder.toString();
		    store.setFrPass(password);
		    dao.r1003updatePassword(store);	//비번 변경
		    mail.setContent("임시 비밀번호는 "+password +" 입니다.");
			sendMail(mail);
			msg="비밀번호가 변경되었습니다. 메일을 확인하세요.";
		}
		return msg;
	}
	
}
