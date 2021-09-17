package com.project.vo;

public class IdfindVO {

    private String subject;
    private String content;
    private String reciver;
    private String sendername;
    private String sendermail;

    public String getSendername() {
		return sendername;
	}
	public void setSendername(String sendername) {
		this.sendername = sendername;
	}
    public String getSendermail() {
		return sendermail;
	}
	public void setSendermail(String sendermail) {
		this.sendermail = sendermail;
	}
    
     
    public String getReciver() {
        return reciver;
    }
    public void setReciver(String reciver) {
        this.reciver = reciver;
    }

    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
    	return "Email [subject=" + subject + ", content=" + content + ", reciver=" + reciver + ", sendername="
    			+ sendername + ", sendermail=" + sendermail + "]";
    } 
}