package com.project.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ProductVO implements Serializable {
	private int idx;
	private String brand;
	private String type;
	private String menu;
	private String temp;
	private String detailExplain;
	private int price;
	private int salaryprice;
	private String image;
}
