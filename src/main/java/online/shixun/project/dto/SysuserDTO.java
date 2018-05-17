package online.shixun.project.dto;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Type;
import org.springframework.web.multipart.MultipartFile;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_sysuser")

public class SysuserDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;
    // 更新部分字段
    @Column(updatable = false)
    private String password;
    private String gender;
    private String mobile;
    private String birthday;
    private String province;
    private String city;
    private String area;
    private String userGrade;
    @Column(updatable = false)
    private String userFace;
    @Transient
    private MultipartFile file;
    private String email;
    @Type(type = "text")
    private String myself;
    private Date createTime = DateUtils.getSysTimestamp();

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

    public String getPassword() {
	return password;
    }

    public void setPassword(String password) {
	this.password = password;
    }

    public String getGender() {
	return gender;
    }

    public void setGender(String gender) {
	this.gender = gender;
    }

    public String getMobile() {
	return mobile;
    }

    public void setMobile(String mobile) {
	this.mobile = mobile;
    }

    public String getBirthday() {
	return birthday;
    }

    public void setBirthday(String birthday) {
	this.birthday = birthday;
    }

    public String getProvince() {
	return province;
    }

    public void setProvince(String province) {
	this.province = province;
    }

    public String getCity() {
	return city;
    }

    public void setCity(String city) {
	this.city = city;
    }

    public String getArea() {
	return area;
    }

    public void setArea(String area) {
	this.area = area;
    }

    public String getUserFace() {
	return userFace;
    }

    public void setUserFace(String userFace) {
	this.userFace = userFace;
    }

    public String getUserGrade() {
	return userGrade;
    }

    public void setUserGrade(String userGrade) {
	this.userGrade = userGrade;
    }

    public String getEmail() {
	return email;
    }

    public void setEmail(String email) {
	this.email = email;
    }

    public String getMyself() {
	return myself;
    }

    public void setMyself(String myself) {
	this.myself = myself;
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
	return "SysuserDTO [id=" + id + ", name=" + name + ", password=" + password + ", gender=" + gender + ", mobile="
		+ mobile + ", birthday=" + birthday + ", province=" + province + ", city=" + city + ", area=" + area
		+ ", userFace=" + userFace + ", file=" + file + ", email=" + email + ", myself=" + myself
		+ ", createTime=" + createTime + "]";
    }

}
