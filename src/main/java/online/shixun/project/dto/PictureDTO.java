package online.shixun.project.dto;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_picture")
public class PictureDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String srcpath;
    private String description;
    private Date createTime = DateUtils.getSysTimestamp();
    private String imageFileName;
    @Transient
    private MultipartFile file;
    // 图片分类
    @ManyToOne(cascade = { CascadeType.PERSIST })
    @JoinColumn(name = "category_id")
    @JsonIgnore
    private PictureCategoryDTO pictureCategory;

    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public String getSrcpath() {
	return srcpath;
    }

    public void setSrcpath(String srcpath) {
	this.srcpath = srcpath;
    }

    public String getDescription() {
	return description;
    }

    public void setDescription(String description) {
	this.description = description;
    }

    public Date getCreateTime() {
	return createTime;
    }

    public void setCreateTime(Date createTime) {
	this.createTime = createTime;
    }

    public String getImageFileName() {
	return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
	this.imageFileName = imageFileName;
    }

    public MultipartFile getFile() {
	return file;
    }

    public void setFile(MultipartFile file) {
	this.file = file;
    }

    public PictureCategoryDTO getPictureCategory() {
	return pictureCategory;
    }

    public void setPictureCategory(PictureCategoryDTO pictureCategory) {
	this.pictureCategory = pictureCategory;
    }

}
