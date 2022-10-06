package com.jblog.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jblog.service.AdminService;
import com.jblog.service.BlogService;
import com.jblog.vo.BlogVo;

//basic
//파일 업로드
@Controller
@RequestMapping("/")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	@Autowired	
	private BlogService blogservice;
	//basic.jsp에서 입력 후 넘어온다.
	@RequestMapping(value="{userId}/admin/update",method=RequestMethod.POST) 
	public String userId(@PathVariable("userId") String userId ,Model model, MultipartFile[] file, @RequestParam("blogTitle") String blogTitle) {
		  BlogVo blogvo = new BlogVo(); //BlogVo 객체 선언
		  blogvo = blogservice.getBlog(userId); //service의 getBlog메소드로 간다.
		  
		  //파일 경로 설정 후 변수에 담기.
	      String uploadFolder = "C:\\Users\\chall\\eclipse-workspace\\jblog\\jblog\\src\\main\\webapp\\assets\\images";
	      

	      for (MultipartFile multipartFile : file) {
	          blogvo.setLogoFile(multipartFile.getOriginalFilename()); //원래 파일 이름을 가져온다 (확장자 포함) 
	    	  File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
	         try {
	            multipartFile.transferTo(saveFile);
	         } catch (Exception e) {
	         
	         } // end catch
	      } // end for
	      
	      //데이터베이스 blogtitle, logofile 저장 
	      blogvo.setBlogTitle(blogTitle);
	      
	      adminService.update(blogvo);//adminservice에 update메서드로 간다.
	      
	      model.addAttribute("blogvo",blogvo); //모델을 써서 "A" , B B가 가져온 값을 A에 담는다.
		return "blog/admin/basic";
	}
	
	//블로그 관리 클릭 시 basic 화면으로 이동
		@RequestMapping(value="{id}/admin/basic",method=RequestMethod.GET)
		public String basic(@PathVariable("id") String id ,Model model) {
			model.addAttribute("blogvo",blogservice.getBlog(id));
			return "blog/admin/basic"; 
		}	
}
