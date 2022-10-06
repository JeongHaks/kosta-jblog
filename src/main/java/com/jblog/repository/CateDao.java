package com.jblog.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.CategoryVo;


//category
@Repository
public class CateDao {
	
	
	@Autowired
	private SqlSession sqlSession;
	
	//카테고리 리스트 출력
	public List<CategoryVo> getList(long userNo){		
		return sqlSession.selectList("cate.getList",userNo);
	}
	
	//카테고리 삭제 
	public boolean delete(CategoryVo catevo) {
		int count = sqlSession.delete("cate.delete", catevo);
		return 1==count;
	}
	
	//카테고리 등록
	public List<CategoryVo> cateinsert(CategoryVo catevo){
		sqlSession.insert("cate.cateinsert",catevo); //값이 추가된다.
		return sqlSession.selectList("cate.catelist"); //max로 cateNo 값 받아오기때문에 전달값이 필요없다.
	}
	
}
	