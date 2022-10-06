package com.jblog.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.CategoryVo;
import com.jblog.vo.PostVo;

//write
@Repository
public class PostDao {

	@Autowired
	private SqlSession sqlSession;
	
	public List<CategoryVo> getCateList(long userNo){
		return sqlSession.selectList("post.getCateList",userNo);
	}
	//insert는 void로 쓴다 return값이 없어서
	public void getPwrite(PostVo postvo) {
		sqlSession.insert("post.getPwrite",postvo);	
	}
}
