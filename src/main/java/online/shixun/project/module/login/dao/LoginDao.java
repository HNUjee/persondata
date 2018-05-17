package online.shixun.project.module.login.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.util.MD5;

@Repository("loginDao")
public class LoginDao {
    @Autowired
    private static SessionFactory sessionFactory;

    /**
     * 用户登录
     * 
     * @param username
     * @param password
     * @return
     */
    public boolean login(String name, String password) {
	String hql = "select name,password from SysuserDTO where name=? and password=?";
	Query query = (Query) sessionFactory.getCurrentSession().createQuery(hql);
	query.setParameter(0, name);
	query.setParameter(1, password);
	List pList = query.list();
	if (pList.size() > 0) {
	    return true;
	}
	return false;
    }

    public static void main(String[] args) {
	String sql = "update t_sysuser set name='admin' ,password='" + MD5.md5("111111") + "' where id=1";
	sessionFactory.getCurrentSession().createSQLQuery(sql);
    }
}
