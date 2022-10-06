package com.jblog.vo;

import lombok.Data;

@Data
public class UsersVo {
   private Long userNo;
   private String id;
   private String userName;
   private String password;
   private String joinDate;

 //로그인을 위해 id, password 생성자 만든다.(어노테이션 가능하면 어노테이션으로 변경)
   public UsersVo(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}
//롬북을 사용할 때 생성자 만들 시 반드시 같이 만들어줘야한다.
	public UsersVo() {
		super();
	}
		      
   
   
   
}