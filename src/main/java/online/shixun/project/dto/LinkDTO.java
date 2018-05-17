package online.shixun.project.dto;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_link")
public class LinkDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    // 链接id
    private Integer id;
    // 链接名称
    private String linkName;
    // 链接url
    private String linksUrl;
    // 链接描述

    private String linksDesc;
    // 创建时间
    private Date createTime = DateUtils.getSysTimestamp();;

    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public String getLinkName() {
	return linkName;
    }

    public void setLinkName(String linkName) {
	this.linkName = linkName;
    }

    public String getLinksUrl() {
	return linksUrl;
    }

    public void setLinksUrl(String linksUrl) {
	this.linksUrl = linksUrl;
    }

    public String getLinksDesc() {
	return linksDesc;
    }

    public void setLinksDesc(String linksDesc) {
	this.linksDesc = linksDesc;
    }

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getCreateTime() {
	return createTime;
    }

    public void setCreateTime(Date createTime) {
	this.createTime = createTime;
    }

    @Override
    public String toString() {
	return "LinkDTO [id=" + id + ", linkName=" + linkName + ", linksUrl=" + linksUrl + ", linksDesc=" + linksDesc
		+ ", createTime=" + createTime + "]";
    }

}
