package com.jblog.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jblog.service.BlogService;
import com.jblog.service.PostService;
import com.jblog.vo.PostVo;
import com.jblog.vo.UsersVo;

//write부분 
@Controller
@RequestMapping("/")
public class PostController {
	
	@Autowired
	private PostService postService;
	@Autowired
	private BlogService blogservice;
	
		//리스트 가져오기 카테고리 명 ! 
		@RequestMapping(value="{userId}/admin/write",method=RequestMethod.GET)
		public String write(@PathVariable("userId") String userId , Model model, HttpSession session) {
			model.addAttribute("blogvo", blogservice.getBlog(userId));
			UsersVo usersvo = (UsersVo)session.getAttribute("authUser");
			long userNo = usersvo.getUserNo();
			//catelist에 값을 담을 거다. jsp로 보내기 위해 
			model.addAttribute("catelist",postService.getCateList(userNo));
			
			return "blog/admin/write";
		}	
		
	
		//글 작성하기
		@RequestMapping(value="{userId}/admin/pwrite",method=RequestMethod.GET)
		public String pwrite(@ModelAttribute PostVo postvo , @PathVariable("userId") String userId,Model model, HttpSession session) {
			model.addAttribute("blogvo", blogservice.getBlog(userId));
			postService.pwrite(postvo);
			return "redirect:/"+userId+"/admin/write";
		}
		

}
