package online.shixun.project.module.sysuser.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.SysuserDTO;
import online.shixun.project.module.sysuser.dao.SysuserDao;

@Service("sysuserService")
@Transactional
public class SysuserService {
    @Autowired
    private SysuserDao sysuserDao;

    public void save(SysuserDTO sysuser) {
	sysuserDao.save(sysuser);
    }

    public List<SysuserDTO> getSysusers() {
	return sysuserDao.sysusers();
    }

    public SysuserDTO getSysUserById(int id) {
	return sysuserDao.getSysUserById(id);
    }

    public void saveFace(String face) {
	sysuserDao.saveFace(face);
    }

    public void updatePwd(String pwd) {
	sysuserDao.updatePwd(pwd);
    }

    public SysuserDTO getUser(String loginName) {
	return sysuserDao.getUser(loginName);
    }

}
