package online.shixun.project.module.picture.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.PictureDTO;
import online.shixun.project.module.picture.dao.PictureDao;

@Service("pictureService")
@Transactional
public class PictureService {
    @Autowired
    private PictureDao pictureDao;

    public List<PictureDTO> picList() {
	return pictureDao.picturelist();
    }

    public void addpicture(PictureDTO pictureDTO) {
	pictureDao.addPicture(pictureDTO);
    }

    public List<PictureDTO> selectList(int id) {
	return pictureDao.selectPicture(id);
    }

    public int queryAllcount() {
	return pictureDao.queryAllcount();
    }
}
