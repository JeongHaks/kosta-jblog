package com.jblog.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.BlogVo;

//basic

@Repository
public class AdminDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public AdminDao() {
		System.out.println("BlogDao 생성");
	}
	
	public Boolean update(BlogVo blogvo) {
		int count = sqlSession.update("admin.update",blogvo);
		return 1==count;
	}

}
