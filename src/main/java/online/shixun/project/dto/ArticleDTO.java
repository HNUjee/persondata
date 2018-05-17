package online.shixun.project.dto;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonFormat;

import online.shixun.project.util.DateUtils;

/**
 * 
 * @author
 *
 */
@Entity
@Table(name = "t_article")
public class ArticleDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    // 文章id
    private Integer id;
    // 文章标题
    private String title;
    // 文章作者
    private String author;
    // 创建时间
    private Date createTime = DateUtils.getSysTimestamp();
    // 是否显示
    @Column(updatable = false)
    private boolean look = true;
    // 文章类型
    private String type;
    // 关键字
    private String keywords;
    // 内容
    @Type(type = "text")
    private String content;
    // 分类
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "article_type_id")
    private ArticleTypeDTO articletype;

    public ArticleDTO() {
    }

    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public String getTitle() {
	return title;
    }

    public void setTitle(String title) {
	this.title = title;
    }

    public String getAuthor() {
	return author;
    }

    public void setAuth(String author) {
	this.author = author;
    }

    /**
     * 使用json返回时间格式，进行格式化
     * 
     */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getCreateTime() {
	return createTime;
    }

    public void setCreateTime(Date createTime) {
	this.createTime = createTime;
    }

    public void setLook(boolean look) {
	this.look = look;
    }

    public boolean getLook() {
	return look;
    }

    public void setAuthor(String author) {
	this.author = author;
    }

    public String getKeywords() {
	return keywords;
    }

    public void setKeywords(String keywords) {
	this.keywords = keywords;
    }

    public String getContent() {
	return content;
    }

    public void setContent(String content) {
	this.content = content;
    }

    public ArticleTypeDTO getArticletype() {
	return articletype;
    }

    public void setArticletype(ArticleTypeDTO articletype) {
	this.articletype = articletype;
    }

    public String getType() {
	return type;
    }

    public void setType(String type) {
	this.type = type;
    }

    @Override
    public String toString() {
	return "ArticleDTO [id=" + id + ", title=" + title + ", author=" + author + ", createTime=" + createTime
		+ ", look=" + look + ", keywords=" + keywords + ",  content=" + content + "]";
    }

}
