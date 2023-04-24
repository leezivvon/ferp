package ferp.controller;

import java.io.IOException;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import ferp.service.Mail_Service;
import vo.Mail;
import vo.Store;

@Controller
public class Mail_Controller {
	
	@Autowired(required = false)
	Mail_Service service;

	@PostMapping("mailSend.do")
	public String mailSend(Mail mail,Model d) {
		d.addAttribute("msg",service.sendMail(mail));
		return "SY_lab.jsp";
	}
	
	@GetMapping("tempPassword.do")
	public String r1003(Store store,Model d) {
		return "/WEB-INF/store/p1003tempPassword.jsp";
	}
	
	@ResponseBody
	@PostMapping(value="tempPassword.do",produces="application/json; charset=UTF-8")
	public String r1003tempPassword(@RequestBody String json,Model d) {
		String msg="";
		 ObjectMapper mapper = new ObjectMapper();
		    try {
		        Store store = mapper.readValue(json, Store.class);
		        msg = service.r1003tempPassword(store);
		    } catch (IOException e) {
		    	msg=e.getMessage();
		    }
		return msg;
	}
		

}
