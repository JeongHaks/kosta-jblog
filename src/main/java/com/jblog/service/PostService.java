package com.jblog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.PostDao;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.PostVo;

@Service
public class PostService {
	
	@Autowired
	private PostDao postDao;
	//selectbox에 카테코리 명 가져오기 
	public List<CategoryVo> getCateList(long userNo){
		
		return postDao.getCateList(userNo);
	}

	
	//글 작성하기 
	public void pwrite(PostVo postvo) {
		postDao.getPwrite(postvo);
	}
	
}
