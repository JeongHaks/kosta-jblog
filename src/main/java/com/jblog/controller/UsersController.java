package com.jblog.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jblog.service.UserService;
import com.jblog.vo.UsersVo;

//회원가입 및 로그인
@Controller
@RequestMapping("/user")
public class UsersController {
	
	//콘솔에 출력
	public UsersController() {
		System.out.println("usersController 생성....");
	}
	
	@Autowired
	private UserService userService; //service 객체생성 
	
	//메인화면에서 로그인을 클릭시 loginForm.jsp로 이동
	@RequestMapping(value="/loginForm",method = RequestMethod.GET)
	public String loginForm(@ModelAttribute UsersVo usersVo) {
		return "user/loginForm";
	}
	
	
	//메인화면에서 회원가입을 누르면 회원가입form으로 이동
	@RequestMapping(value="/joinForm",method= RequestMethod.GET)
	public String joinForm(@ModelAttribute UsersVo usersVo) {
		return "user/joinForm"; 
	}
	
	//회원가입 동작 메소드 joinForm.jsp에서 입력 후 넘어온다.
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute @Valid UsersVo usersVo, BindingResult result, Model model) {
		//Valid 체크가 틀릴 시 joinform으로 넘김
		if(result.hasErrors()) {
			List<ObjectError> list = result.getAllErrors();
			for(ObjectError error : list) {
				System.out.println(error);
			}
			//Map으로 보내준다.
			model.addAllAttributes(result.getModel());
			return "user/join";
		}
		//dispatcher가 컨텍스트 패스를 붙이고 다시 리다이렉트를 보낸다.
		userService.join(usersVo);
		userService.inblog(usersVo);
		return "redirect:/user/joinsuccess"; 
		
	}
	
	//회원가입 성공시 클릭하면 joinSuccess.jsp 이동
	@RequestMapping("/joinsuccess")
	public String joinSuccess() {
		return "user/joinSuccess";
	}
	
//	//로그인을 위해 id,password 값을 받아 전달 userService.getUser로 이동
	@RequestMapping(value="/auth", method= RequestMethod.POST)
	public String login(@RequestParam(value="id",required=true, defaultValue="") String id,
						@RequestParam(value="password", required=true, defaultValue="") String password,
						HttpSession session, Model model) {
			//loginform에서 입력된 id,password 값을 authUser에 담아준다.
			UsersVo authUser = userService.getUser(new UsersVo(id,password));
			if(authUser == null) { //값이 null이라면~
				model.addAttribute("result", "fail"); //실패라는 문자를 result에 담아라
				return "user/loginForm";
			}
			
			session.setAttribute("authUser", authUser);			
			return "redirect:/";
	}
	
	//로그아웃 클릭 시 id , password 값 삭제 
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("authUser");
		return "redirect:/";
	}
	
}
