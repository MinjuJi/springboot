package com.sample.vo;

import java.util.Date;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Emp {

	private int no;
	private String name;
	private String tel;
	private String email;
	private int salary;
	private Date hiredDate;
	private Dept dept;
	private Date createdDate;
	private Date updatedDate;
	
	@Builder
	public Emp(int no, String name, String tel, String email, int salary, Date hiredDate, Dept dept, Date createdDate,
			Date updatedDate) {
		super();
		this.no = no;
		this.name = name;
		this.tel = tel;
		this.email = email;
		this.salary = salary;
		this.hiredDate = hiredDate;
		this.dept = dept;
		this.createdDate = createdDate;
		this.updatedDate = updatedDate;
	}
	
}
