package online.shixun.project.dto;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import online.shixun.project.util.DateUtils;

@Entity
@Table(name = "t_role")
public class RoleDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // 角色名称（长度：100，不允许为空）
    @Column(length = 100, nullable = false)
    private String name;
    // 创建时间
    @Column(nullable = true, length = 19)
    protected Timestamp createTime = DateUtils.getSysTimestamp();

    // 更新时间
    @Column(nullable = true, length = 19)
    protected Timestamp updateTime = DateUtils.getSysTimestamp();

}
