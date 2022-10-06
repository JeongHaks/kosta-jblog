package com.jblog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.AdminDao;
import com.jblog.vo.BlogVo;


@Service
public class AdminService {
	
	@Autowired
	private AdminDao adminDao;
	
	//아무값이 반환되지 않아서 사용 (true false만 반환됨) 
	public Boolean update(BlogVo blogvo) {
		return adminDao.update(blogvo); 
	}
	
	

}
