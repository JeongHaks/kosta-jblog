package com.jblog.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.CateDao;
import com.jblog.vo.CategoryVo;

@Service
public class CateService {

	@Autowired
	private CateDao cateDao;
	
	//카테고리 리스트 Dao로 이동
	public ArrayList<CategoryVo> getList(long userNo){
		ArrayList<CategoryVo> obj = (ArrayList<CategoryVo>) cateDao.getList(userNo);
		for(int i=0; i<obj.size(); i++) {
		//	System.out.println(obj.get(i) + "list"); 
		}
		return obj;
	}
	
	//카테고리 삭제 Dao로 이동
	public Boolean delete(CategoryVo categoryvo) {
		return cateDao.delete(categoryvo);
	}
	
	
	//카테고리 추가 Dao로 이동
	public ArrayList<CategoryVo> cateinsert(CategoryVo categoryvo) {
		ArrayList<CategoryVo> obj = (ArrayList<CategoryVo>) cateDao.cateinsert(categoryvo);
		return obj;
		
	}
}
