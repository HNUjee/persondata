package online.shixun.project.module.picturecategory.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.PictureCategoryDTO;

@Repository("pictureCategoryDao")
public class PictureCategoryDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void add(PictureCategoryDTO pictureCategory) {
	sessionFactory.getCurrentSession().saveOrUpdate(pictureCategory);
    }

    @SuppressWarnings("unchecked")
    public List<PictureCategoryDTO> categoryList() {
	return sessionFactory.getCurrentSession().createQuery("from PictureCategoryDTO").list();
    }
}
