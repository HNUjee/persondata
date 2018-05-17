package online.shixun.project.dto;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_picturecategory")
public class PictureCategoryDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;
    private String description;
    private Date createTime = DateUtils.getSysTimestamp();
    @OneToMany(mappedBy = "pictureCategory", cascade = { CascadeType.ALL }, fetch = FetchType.LAZY)
    private Set<PictureDTO> pictures = new HashSet<PictureDTO>();

    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public String getName() {
	return name;
    }

    public void setName(String name) {
	this.name = name;
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

    public Set<PictureDTO> getPictures() {
	return pictures;
    }

    public void setPictures(Set<PictureDTO> pictures) {
	this.pictures = pictures;
    }

    @Override
    public String toString() {
	return "PictureCategoryDTO [id=" + id + ", name=" + name + ", description=" + description + ", createTime="
		+ createTime + "]";
    }

}
