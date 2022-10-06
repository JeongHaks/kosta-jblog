package com.jblog.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jblog.service.BlogService;
import com.jblog.service.CateService;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.UsersVo;

//category
@Controller
@RequestMapping("/")
public class CateController {
	
	
	@Autowired
	private CateService cateService;
	@Autowired
	private BlogService blogservice;
	//카테고리(방명록) 리스트 띄우기
	//ajax에 있는 url을 통해서 여기로 넘어온다
	@ResponseBody 
	@RequestMapping(value = "/catelist", method=RequestMethod.GET)
	public List<CategoryVo> getCateList(HttpSession session){
		UsersVo uservo = (UsersVo)session.getAttribute("authUser");
		long userNo = uservo.getUserNo();
		return cateService.getList(userNo); 
	}
	

	//카테고리(방명록) 삭제할 번호 가져오기  
	@RequestMapping(value="{userId}/delete/{cateNo}", method = RequestMethod.GET)
	public String delete(Model model,@PathVariable(value="cateNo")int cateNo,@PathVariable(value="userId")String userId  ) {
		System.out.println("들어오나요 여기로");
		model.addAttribute("cateNo", cateNo);
		return "redirect:/"+userId+"/deletee"; 
	}

	//카테고리(방명록) 삭제 처리
	@RequestMapping(value="{userId}/deletee", method = RequestMethod.GET)
	public String delete(@ModelAttribute CategoryVo categoryvo,Model model,@PathVariable(value="userId")String userId ) {
		System.out.println("들어오나요");
		boolean result =cateService.delete(categoryvo);
		if(result) {
			return "redirect:/"+userId+"/admin/cate";
		}else {
			model.addAttribute("result", "fail");
			return "redirect:/delete/"+categoryvo.getCateNo();
		}
		
	}
	
	//카테고리 등록!
	@ResponseBody
	@PostMapping(value="{userid}/admin/cateinsert")
	public List<CategoryVo> cateinsert(Model model, @PathVariable(value="userid") String userid, HttpSession session, String catename, String description){
		UsersVo usersvo = (UsersVo)session.getAttribute("authUser"); //로그인 한 이용자들의 번호를 가져오기 위한 객체 선언
		CategoryVo categoryvo = new CategoryVo();
		categoryvo.setUserNo(usersvo.getUserNo());
		categoryvo.setCateName(catename);
		categoryvo.setDescription(description);
		
		return cateService.cateinsert(categoryvo);
	}
	
	
	

}
