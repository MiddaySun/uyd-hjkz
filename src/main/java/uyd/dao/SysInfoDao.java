package uyd.dao;

import org.springframework.stereotype.Repository;

import uyd.entity.SysInfo;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月13日
 * @version 1.0
 * @description 系统信息DAO
 */
@Repository("sysInfoDao")
public interface SysInfoDao {
	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 获取系统信息
	 */
	public SysInfo getSysInfo();
}
