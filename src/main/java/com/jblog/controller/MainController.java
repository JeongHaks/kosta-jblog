package com.jblog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//메인화면
@Controller
public class MainController {

	//실행 시 메인화면 출력
	@RequestMapping({"/","main"})
	public String main() {
	  System.out.println("jblog(main)....");
		return "main/index";
	}
	
}
