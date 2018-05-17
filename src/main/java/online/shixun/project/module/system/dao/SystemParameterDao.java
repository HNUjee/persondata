package online.shixun.project.module.system.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.SystemParameterDTO;

@Repository("systemParameterDao")
public class SystemParameterDao {
    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<SystemParameterDTO> list() {
	return sessionFactory.getCurrentSession().createQuery("from SystemParameterDTO").list();
    }

    public void save(SystemParameterDTO systemParameter) {
	sessionFactory.getCurrentSession().saveOrUpdate(systemParameter);
    }
}
