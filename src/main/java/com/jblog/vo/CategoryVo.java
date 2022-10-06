package com.jblog.vo;

import lombok.Data;

@Data
public class CategoryVo {
   private int cateNo;
   private long userNo;
   private String cateName;
   private String description;
   private String regDate;
   private int countPost;
   
}