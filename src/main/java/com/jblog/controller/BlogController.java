package com.jblog.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jblog.service.BlogService;
import com.jblog.vo.CommentsVo;
import com.jblog.vo.PostVo;
import com.jblog.vo.UsersVo;




//blog-main
@Controller
@RequestMapping("/")
public class BlogController {
	
	@Autowired
	private BlogService blogservice;
	
		//주소창에 아이디 입력시 관련된 블로그 정보 띄우기
		@RequestMapping(value="{userId}",method=RequestMethod.GET)
		public String userId(@PathVariable("userId") String userId ,Model model, HttpSession session ) {
			UsersVo usersvo = (UsersVo)session.getAttribute("authUser"); //회원정보를 가져다가 쓰기 위한 객체선언
			long userNo = usersvo.getUserNo();
			//각각의 필요한 정보를 DB에서 가져와서 사용하기위한 행동?객체? model... " A " , B  B의 값을 A에 담기
			model.addAttribute("blogvo", blogservice.getBlog(userId)); 
			model.addAttribute("cateNo",blogservice.getCateNo(userNo));
			model.addAttribute("postvo",blogservice.getPostNo(userNo));
			model.addAttribute("userId",userId);
			model.addAttribute("postcontent",blogservice.getPoContent(userNo));
			return "blog/blog-main"; 
		}
	
		//답변 등록
		@ResponseBody
		@RequestMapping(value="{userId}/addReply",method=RequestMethod.GET)
		public CommentsVo addReply(@PathVariable("userNo") long userNo,
						@RequestParam("postNum") String postNum,
						@RequestParam("name") String name,
						@RequestParam("replyContent") String replyContent) {
				
			int postNo = Integer.parseInt(postNum); //형변환
			System.out.println("postNum" + postNum);
			System.out.println("userNo"+userNo);
			CommentsVo commentsvo = new CommentsVo();
			commentsvo.setUserNo(userNo);
			commentsvo.setConame(name);
			commentsvo.setCmtContent(replyContent);
			commentsvo.setPostNo(postNo);
				
			return blogservice.addReply(commentsvo);
				
		}
			
		//답변 리스트 
		@ResponseBody
		@RequestMapping(value="{userId}/getCommentsList",method=RequestMethod.GET)
		public List<CommentsVo> getCommentsList(
							@PathVariable("userId") String userId 
							,@RequestParam("postNum") String postNum, Model model){
				System.out.println("getCommentsList : " + postNum);
				int postNo = Integer.parseInt(postNum);
				System.out.println("getComment"+ blogservice.getCommentsList(postNo));
				System.out.println("getCommentsList" + postNo);
				return blogservice.getCommentsList(postNo);
		}
			
		//기본설정화면에서 카테고리 클릭 시 cate.jsp로 이동
		@RequestMapping(value="{id}/admin/cate",method=RequestMethod.GET)
		public String cate(@PathVariable("id") String id,Model model) {	
			model.addAttribute("blogvo", blogservice.getBlog(id));
			return "blog/admin/cate";
		}
	
		
		//메인 카테고리 클릭 시 리스트 뿌려주기 그 값안에 저장된 값들
		@ResponseBody 
		@RequestMapping(value = "{userId}/categoryNo", method=RequestMethod.GET)
		// https://sh77113.tistory.com/243 ==> HttpSession Session 참고자료
		public List<PostVo> getPostlist(HttpSession session, @PathVariable("userId") String userId ,@RequestParam("cateNum") String cateNum){
			int cateNo = Integer.parseInt(cateNum);
			
			return blogservice.getPostlist(cateNo); 
		}
	

		//4번의 postTitle 선택시 관련 content 내용값 불러 메인에 띄우기
		@ResponseBody
		@RequestMapping(value = "{userId}/postNum", method=RequestMethod.GET)
		public List<PostVo> postContent(Model model,@RequestParam("postNum") String postNum) {
			int postNo = Integer.parseInt(postNum);
			System.out.println("컨트롤러 : " + blogservice.getPostContent(postNo));
			return blogservice.getPostContent(postNo);
		}
		


		  
}
