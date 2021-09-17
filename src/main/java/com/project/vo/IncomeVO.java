package com.project.vo;

import lombok.Data;

@Data
public class IncomeVO {

	private int profitno;
	private int profit;
	private String time;
	private String franchise; //franchisekey 참조
}
