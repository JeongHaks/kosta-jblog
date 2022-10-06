package com.jblog.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.BlogVo;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.PostVo;

//blog-main

@Repository
public class BlogDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public BlogDao() {
		System.out.println("BlogDao 생성");
	}
	
	public BlogVo getBlog(String id) {
		return sqlSession.selectOne("blog.getBlog",id);
	}
	
	public List<CategoryVo> getCateNo(long userNo){
		return sqlSession.selectList("blog.getCateNo",userNo);
	}
//카테고리 리스트 뿌려주기.
	public List<PostVo> getPostlist(int cateNo){
		return sqlSession.selectList("blog.getPostlist",cateNo);
	}
//제목을 클릭하였을 때 등록된 리스트들	
	public List<PostVo> getPostContent(int postNo) {
		return sqlSession.selectList("blog.getPostContent",postNo);
	}
	
	public List<PostVo> getPostNo(long userNo){
		return sqlSession.selectList("blog.getPostNo",userNo);
	}
	
	public PostVo getPoContent(long userNo){
		return sqlSession.selectOne("blog.getPoContent",userNo);
	}
}
