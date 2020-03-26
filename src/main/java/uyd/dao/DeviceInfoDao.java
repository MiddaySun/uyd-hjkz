package uyd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import uyd.entity.DeviceInfo;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月24日,下午5:12:23
 * @version 1.0
 * @description
 */
@Repository("deviceInfoDao")
public interface DeviceInfoDao {
	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月24日,下午5:15:45
	 * @version 1.0
	 * @param map
	 * @return
	 * @description 分页查询设备信息
	 */
	List<DeviceInfo> findList(Map<String, Object> map);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月24日,下午5:20:03
	 * @version 1.0
	 * @param map
	 * @return
	 * @description 查询总数
	 */
	Integer getCount(Map<String, Object> map);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:52:35
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description 根据条件查询对应信息数量
	 */
	Integer findByDeviceInfo(DeviceInfo deviceInfo);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:54:10
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description 添加设备信息
	 */
	Integer addDeviceInfo(DeviceInfo deviceInfo);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:55:30
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description 删除设备信息
	 */
	Integer delteDeviceInfo(DeviceInfo deviceInfo);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:55:42
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description 保存设备信息
	 */
	Integer updateDeviceInfo(DeviceInfo deviceInfo);
}
