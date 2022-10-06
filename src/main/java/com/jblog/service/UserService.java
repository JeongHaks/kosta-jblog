package com.jblog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.UserDao;
import com.jblog.vo.UsersVo;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	public Boolean existId(String id) {
		UsersVo usersVo = userDao.get(id);
		return usersVo != null;
	}
	
	public UserService() {
		System.out.println("userService 생성");
	}

	//회원가입을 위한 service
	public Boolean join(UsersVo usersVo) {
		return userDao.insert(usersVo);
	}
	
//	//blog에 기본값 넣기 위한 service
	public Boolean inblog(UsersVo usersVo) {
		return userDao.inblog(usersVo);
	}
	
	//로그인을 위한 service
	public UsersVo getUser(UsersVo usersVo) {
		return userDao.get(usersVo.getId(), usersVo.getPassword());
	}
	
	public UsersVo getId(String id) {
		return userDao.get(id);
	}
	
	public UsersVo getUser(long no) {
		
		return userDao.get(no);
	}

	public Boolean update(UsersVo updateUserVo) {
		return userDao.update(updateUserVo);
	}

}
