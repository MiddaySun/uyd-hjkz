package uyd.service.imp;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import uyd.dao.SysInfoDao;
import uyd.entity.SysInfo;
import uyd.service.SysInfoService;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月13日
 * @version 1.0
 * @description 系统信息业务实现层
 */
@Service("sysInfoService")
public class SysInfoServiceImp implements SysInfoService {

	@Resource
	private SysInfoDao sysInfoDao;

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @return
	 * @description
	 */
	@Override
	public SysInfo getSysInfo() {
		return sysInfoDao.getSysInfo();
	}

}
