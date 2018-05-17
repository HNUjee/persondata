package online.shixun.project.dto;

import java.util.Date;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_contactCategory")
public class ContactCategoryDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    // 联系人分类名称（长度：100，不允许为空）
    @Column(length = 100)
    private String name;
    
    private Date createTime = DateUtils.getSysTimestamp();
    // 联系人分类下的所有相关联系
    @OneToMany(mappedBy = "category", cascade = { CascadeType.ALL }, fetch = FetchType.EAGER)
    // 根据联系人ID进行排序
    @OrderBy("id asc")
    @JsonIgnore
    private Set<ContactDTO> contacts = new TreeSet<ContactDTO>();

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

    public Set<ContactDTO> getContacts() {
	return contacts;
    }

    public void setContacts(Set<ContactDTO> contacts) {
	this.contacts = contacts;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
	return "ContactCategoryDTO [id=" + id + ", name=" + name + "]";
    }

}
