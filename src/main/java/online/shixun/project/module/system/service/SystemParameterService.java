package online.shixun.project.module.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.SystemParameterDTO;
import online.shixun.project.module.system.dao.SystemParameterDao;

@Service
@Transactional
public class SystemParameterService {
    @Autowired
    private SystemParameterDao systemParameterDao;

    public List<SystemParameterDTO> list() {
	return systemParameterDao.list();
    }

    public void save(SystemParameterDTO systemParameter) {
	systemParameterDao.save(systemParameter);
    }
}
