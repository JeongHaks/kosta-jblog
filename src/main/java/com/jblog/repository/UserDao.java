package com.jblog.repository;


import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.CategoryVo;
import com.jblog.vo.UsersVo;

//로그인 ,회원가입

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession sqlSession;
	
//	@Autowired
//	private DataSource dataSource;
	
	public UserDao() {
		System.out.println("userDao 생성");
	}
	public Boolean update(UsersVo vo) {
		int count  = sqlSession.update("users.update",vo);
		return 1 == count;
	}

	public UsersVo get(long no) {
		return sqlSession.selectOne("users.getByuserNo", no);
	}
	
	public UsersVo get(String id) {
		return sqlSession.selectOne("users.getById", id);
	}

	public UsersVo get(String id, String password) {
		Map<String,String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", password);
		//selectOne(한가지의 결과를 가지고오기 위한 값?방벙?)
		UsersVo userVo = sqlSession.selectOne("users.getByIdAndPassword",map);
		return userVo;
	}

	public boolean insert(UsersVo vo) {
		//회원가입 값 등록
		int count = sqlSession.insert("users.insert",vo);
		//blogTitle, blogLogo 기본값 넣기 위한 sql
		sqlSession.insert("users.inblog",vo);
		//userNo를 받아오기 위한 sql
		long userNo = sqlSession.selectOne("users.getUserNo",vo);
		
		CategoryVo categoryvo = new CategoryVo(); //categoryVo 객체 선언
		categoryvo.setUserNo(userNo); //userNo 받아와서 카테고리의 userNo변수에 담아준다.ㅂ
		sqlSession.insert("users.defaultCategory",categoryvo);
		
		
		return 1==count;
	}
//	
	public boolean inblog(UsersVo vo) {
		//int count = sqlSession.insert("users.inblog",vo);
		return 1==1;
	}

}
