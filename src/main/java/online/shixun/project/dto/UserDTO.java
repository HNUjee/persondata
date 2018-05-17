package online.shixun.project.dto;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_user")
public class UserDTO {
    // 用户状态：正常
    public static final String USER_STATUS_ACTIVE = "active";

    // 用户状态：禁用
    public static final String USER_STATUS_DISABLE = "disable";
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(length = 255)
    private String email;
    @Column(length = 100)
    private String loginName;
    @Column(length = 4)
    private String gender;
    @Column(length = 50)
    private String password;
    // 创建时间
    @Column(nullable = true, length = 19)
    protected Timestamp createTime = DateUtils.getSysTimestamp();

    // 更新时间
    @Column(nullable = true, length = 19)
    protected Timestamp updateTime = DateUtils.getSysTimestamp();
    // 用户状态（默认为：正常）
    @Column(length = 10, nullable = false)
    private String status = USER_STATUS_ACTIVE;
    // 用户所拥有的角色（一个用户可以拥有多个角色）
    // @ManyToMany(cascade = { CascadeType.PERSIST }, fetch = FetchType.EAGER)
    // @JoinTable(name = "t_user_role", joinColumns = @JoinColumn(name =
    // "userId", referencedColumnName = "id"), inverseJoinColumns =
    // @JoinColumn(name = "roleId", referencedColumnName = "id"))
    // private Set<RoleDTO> roles = new HashSet<RoleDTO>();

    public String getGender() {
	return gender;
    }

    public void setGender(String gender) {
	this.gender = gender;
    }

    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public String getEmail() {
	return email;
    }

    public void setEmail(String email) {
	this.email = email;
    }

    public String getLoginName() {
	return loginName;
    }

    public void setLoginName(String loginName) {
	this.loginName = loginName;
    }

    public Timestamp getCreateTime() {
	return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
	this.createTime = createTime;
    }

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Timestamp getUpdateTime() {
	return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
	this.updateTime = updateTime;
    }

    public String getStatus() {
	return status;
    }

    public void setStatus(String status) {
	this.status = status;
    }

    public boolean isDisabled() {
	return this.status.equals(USER_STATUS_DISABLE) ? true : false;
    }

    /*
     * public Set<RoleDTO> getRoles() { return roles; }
     * 
     * public void setRoles(Set<RoleDTO> roles) { this.roles = roles; }
     */

    public String getPassword() {
	return password;
    }

    public void setPassword(String password) {
	this.password = password;
    }

}
