package com.project.vo;

import lombok.Data;

@Data
public class InventoryVO {
	private String iuid; //franchisekey를 참조하고있음...
	private int fk_pid;//product id (int)를 참조하고있음
	private int count; //남은재고...
	private int available;// 혹시모를변수...
}
