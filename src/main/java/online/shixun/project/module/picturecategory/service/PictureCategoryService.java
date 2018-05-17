package online.shixun.project.module.picturecategory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.PictureCategoryDTO;
import online.shixun.project.module.picturecategory.dao.PictureCategoryDao;

@Service("pictureCategoryService")
@Transactional
public class PictureCategoryService {
    @Autowired
    private PictureCategoryDao pictureCategoryDao;

    public void add(PictureCategoryDTO pictureCategory) {
	pictureCategoryDao.add(pictureCategory);
    }

    public List<PictureCategoryDTO> categoryList() {
	return pictureCategoryDao.categoryList();
    }
}
