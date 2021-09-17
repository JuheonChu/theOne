package com.project.vo;

import lombok.Data;

@Data
public class Message {
	private int idx;
    private String fromId;
    private String receiver;
    private String messagecontent;
    private String topic;
    private String regist_date;
    private int contractno;
}