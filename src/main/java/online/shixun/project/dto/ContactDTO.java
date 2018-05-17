package online.shixun.project.dto;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_contact")
public class ContactDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Integer id;

    // 性别(枚举值)
    public enum Gender {
	男, 女;
    }

    // 联系人姓名
    @Column(length = 100)
    private String name;

    // 联系人性别
    @Column(nullable = false)
    @Enumerated(EnumType.ORDINAL)
    private Gender gender = Gender.男;

    // 联系人手机
    @Column(length = 15)
    private String mobile;

    // 联系人地址
    @Column(length = 255)
    private String address;

    // 联系人邮箱
    @Column(length = 255)
    private String email;

    // 联系人职位
    @Column(length = 255)
    private String position;

    @Transient
    private MultipartFile file;
    // 头像
    @Column(length = 255)
    private String avatar;
    // 是否为常用联系人
    @Column
    private boolean isFrequent = false;
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime = DateUtils.getSysTimestamp();
    // 联系人分类
    @ManyToOne(cascade = { CascadeType.PERSIST }, fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    // @JsonIgnore
    private ContactCategoryDTO category;

    public ContactDTO() {
    }

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

    public Gender getGender() {
	return gender;
    }

    public void setGender(Gender gender) {
	this.gender = gender;
    }

    public String getMobile() {
	return mobile;
    }

    public void setMobile(String mobile) {
	this.mobile = mobile;
    }

    public String getAddress() {
	return address;
    }

    public void setAddress(String address) {
	this.address = address;
    }

    public String getEmail() {
	return email;
    }

    public void setEmail(String email) {
	this.email = email;
    }

    public String getPosition() {
	return position;
    }

    public void setPosition(String position) {
	this.position = position;
    }

    public ContactCategoryDTO getCategory() {
	return category;
    }

    public void setCategory(ContactCategoryDTO category) {
	this.category = category;
    }

    public boolean getIsFrequent() {
	return isFrequent;
    }

    public void setIsFrequent(boolean isFrequent) {
	this.isFrequent = isFrequent;
    }

    public String getAvatar() {
	return avatar;
    }

    public void setAvatar(String avatar) {
	this.avatar = avatar;
    }

    public void setFrequent(boolean isFrequent) {
	this.isFrequent = isFrequent;
    }

    public MultipartFile getFile() {
	return file;
    }

    public void setFile(MultipartFile file) {
	this.file = file;
    }

    public Date getCreateTime() {
	return createTime;
    }

    public void setCreateTime(Date createTime) {
	this.createTime = createTime;
    }

    @Override
    public String toString() {
	return "ContactDTO [id=" + id + ", name=" + name + ", gender=" + gender + ", mobile=" + mobile + ", address="
		+ address + ", email=" + email + ", position=" + position + ", avatar=" + avatar + ", category="
		+ category + "]";
    }

}
