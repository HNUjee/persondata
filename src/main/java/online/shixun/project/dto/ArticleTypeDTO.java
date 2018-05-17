package online.shixun.project.dto;

import java.util.Date;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_articletype")
public class ArticleTypeDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String typeName;
    private Date createTime = DateUtils.getSysTimestamp();

    @OneToMany(mappedBy = "articletype", cascade = { CascadeType.ALL }, fetch = FetchType.EAGER)
    // 根据ID进行排序
    @OrderBy("id asc")
    @JsonIgnore
    private Set<ArticleDTO> articles = new TreeSet<ArticleDTO>();

    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public String getTypeName() {
	return typeName;
    }

    public void setTypeName(String typeName) {
	this.typeName = typeName;
    }

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getCreateTime() {
	return createTime;
    }

    public void setCreateTime(Date createTime) {
	this.createTime = createTime;
    }

    public Set<ArticleDTO> getArticles() {
	return articles;
    }

    public void setArticles(Set<ArticleDTO> articles) {
	this.articles = articles;
    }

    @Override
    public String toString() {
	return "ArticleTypeDTO [id=" + id + ", typeName=" + typeName + ", createTime=" + createTime + "]";
    }

}
