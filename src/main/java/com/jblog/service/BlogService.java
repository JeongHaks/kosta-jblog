package com.jblog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.BlogDao;
import com.jblog.vo.BlogVo;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.PostVo;


@Service
public class BlogService {
	
	@Autowired
	private BlogDao blogDao;
	
	//
	public BlogVo getBlog(String userId) {
		
		return blogDao.getBlog(userId);
	}
	
	//
	public List<CategoryVo> getCateNo(long userNo){
		
		return blogDao.getCateNo(userNo);
	}
	//카테고리에 리시트 뿌리기
	public List<PostVo> getPostlist(int cateNo){
		return blogDao.getPostlist(cateNo);
	}

	//제목을 클릭하였을 때 등록된 리스트들
	public List<PostVo> getPostContent(int postNo) {
		return blogDao.getPostContent(postNo);
	}
	
	//카테고리의 선택시 4번에 리스트 띄워주기
	public List<PostVo> getPostNo(long userNo){
		return blogDao.getPostNo(userNo);
	}
	
	public PostVo getPoContent(long userNo){
		return blogDao.getPoContent(userNo);
	}
}

