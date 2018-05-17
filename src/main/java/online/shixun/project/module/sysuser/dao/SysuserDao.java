package online.shixun.project.module.sysuser.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.SysuserDTO;

@Repository("sysuserDao")
public class SysuserDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void save(SysuserDTO sysuser) {
	sessionFactory.getCurrentSession().saveOrUpdate(sysuser);
    }

    /**
     * 修改管理员头像
     * 
     * @param face
     */
    public void saveFace(String face) {
	String hql = "update t_sysuser s set s.userFace = '" + face + "' where s.id=1";
	sessionFactory.getCurrentSession().createSQLQuery(hql).executeUpdate();
    }

    @SuppressWarnings("unchecked")
    public List<SysuserDTO> sysusers() {
	return sessionFactory.getCurrentSession().createQuery("from SysuserDTO").list();
    }

    public SysuserDTO getSysUserById(int id) {
	return (SysuserDTO) sessionFactory.getCurrentSession().get(SysuserDTO.class, id);
    }

    /**
     * 修改密码
     * 
     * @param pwd
     */
    public void updatePwd(String pwd) {
	String hql = "update t_sysuser s set" + " s.password = '" + pwd + "' where s.name=admin";
	sessionFactory.getCurrentSession().createSQLQuery(hql).executeUpdate();
    }

    public SysuserDTO getUser(String loginName) {
	String hql = "SELECT NAME FROM t_sysuser where name='" + loginName + "'";
	return (SysuserDTO) sessionFactory.getCurrentSession().get(SysuserDTO.class, 1);
    }
}
