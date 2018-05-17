package online.shixun.project.module.article.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.ArticleDTO;
import online.shixun.project.dto.ArticleTypeDTO;

@Repository("articleDao")
public class ArticleDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void add(ArticleDTO articleDTO) {
	sessionFactory.getCurrentSession().saveOrUpdate(articleDTO);
    }

    @SuppressWarnings("unchecked")
    public List<ArticleDTO> selectNews() {
	return sessionFactory.getCurrentSession().createQuery("from ArticleDTO a inner join fetch a.articletype")
		.list();
    }

    @SuppressWarnings("unchecked")
    public List<ArticleTypeDTO> selectType() {
	return sessionFactory.getCurrentSession().createQuery("from ArticleTypeDTO").list();
    }

    public void delete(ArticleDTO articleDTO) {
	sessionFactory.getCurrentSession().delete(articleDTO);
    }

    /**
     * 批量删除文章
     * 
     * @param nums
     */
    public void deletes(int nums) {
	String hql = "delete from ArticleDTO where id in(:ids)";
	Query query = sessionFactory.getCurrentSession().createQuery(hql);
	query.setParameter("ids", nums);
	query.executeUpdate();
    }

    public ArticleDTO getArticlebyId(int id) {
	return (ArticleDTO) sessionFactory.getCurrentSession().get(ArticleDTO.class, id);
    }

    public void changeLook(int id, int islook) {
	String hql = "update t_article a set a.look = '" + islook + "' where a.id='" + id + "'";
	sessionFactory.getCurrentSession().createSQLQuery(hql).executeUpdate();
    }

}
