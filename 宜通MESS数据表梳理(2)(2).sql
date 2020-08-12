
/*
* 节拍时间未考虑

* 系统设置部分 system_***
* 设备管理部分 device_***
* 生产管理部分 produce_***


* produce 生产
* product 产品
* process 工序
* 
*/

/*机构设置*/
DROP TABLE IF EXISTS `system_org`;
CREATE TABLE `system_org` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
	`pid` BIGINT(20) NOT NULL COMMENT '-1 根分组',
	`name` VARCHAR(255) NOT NULL,			 		#名称
	`link` VARCHAR(2000) DEFAULT NULL,	 	 		#分组管理
	`leader` VARCHAR(255) DEFAULT NULL, 	 			#负责人 
	`adddress` VARCHAR(255) DEFAULT NULL,  	 			#地址
	`phone` VARCHAR(16) DEFAULT NULL,   	 			#电话
	`face_url` VARCHAR(128) DEFAULT NULL,  	 			#头像
	`remarks` VARCHAR(100) DEFAULT NULL,       	 		#描述
	`modify_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,		 			 #修改时间
	`create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP									 #创建时间
) ENGINE=INNODB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

INSERT INTO `system_org` (`id`, `pid`, `name`, `link`) VALUES('1','-1','武汉工厂',',1,');
INSERT INTO `system_org` (`id`, `pid`, `name`, `link`) VALUES('2','-1','上海工厂',',2,');
INSERT INTO `system_org` (`id`, `pid`, `name`, `link`) VALUES('40','1','武汉实验室',',2,40');
INSERT INTO `system_org` (`id`, `pid`, `name`, `link`) VALUES('41','40','测试组1',',2,40,41');
INSERT INTO `system_org` (`id`, `pid`, `name`, `link`) VALUES('42','40','测试组2',',2,40,42');

/*岗位设置*/
DROP TABLE IF EXISTS `system_jobs`;
CREATE TABLE `system_jobs` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR (300) NOT NULL
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `system_jobs` (`name`) VALUES('组长');
INSERT INTO `system_jobs` (`name`) VALUES('车工');
INSERT INTO `system_jobs` (`name`) VALUES('机修');
INSERT INTO `system_jobs` (`name`) VALUES('质检');

/*员工管理*/
DROP TABLE IF EXISTS `system_workers`;
CREATE TABLE `system_workers` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,#ID
	`user_num` VARCHAR(32) NOT NULL UNIQUE,   	 					#工号
	`org_id` BIGINT(20),                   	 						#所属机构      
	`name` VARCHAR(128) DEFAULT NULL,            						#姓名
	`pwd` VARCHAR(32) DEFAULT NULL COMMENT 'md5(pwd+20tvb15)',    				#密码
	`sex` VARCHAR(2) DEFAULT NULL,                						#性别
	`job_id` BIGINT(20) DEFAULT NULL,            						#岗位
	`age` INT(2),                   		  	 				#年龄 
	`create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,		 			#创建时间
	`modify_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	#修改时间
	CONSTRAINT `sex` CHECK (sex IN('男','女')),
	FOREIGN KEY (`org_id`) REFERENCES `system_org` (`id`),
	FOREIGN KEY (`job_id`) REFERENCES `system_jobs` (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `system_workers` (`id`, `user_num`, `org_id`, `name`, `pwd`, `sex`, `job_id`, `age`) VALUES('1','2020070001','41','豆豆','d31f03e337e8910def90eef02f95ea29','男','1','18');
INSERT INTO `system_workers` (`id`, `user_num`, `org_id`, `name`, `pwd`, `sex`, `job_id`, `age`) VALUES('2','2020070002','41','毛毛','d31f03e337e8910def90eef02f95ea29','男','2','21');
INSERT INTO `system_workers` (`id`, `user_num`, `org_id`, `name`, `pwd`, `sex`, `job_id`, `age`) VALUES('3','2020070003','41','球球','d31f03e337e8910def90eef02f95ea29','女','2','16');
INSERT INTO `system_workers` (`id`, `user_num`, `org_id`, `name`, `pwd`, `sex`, `job_id`, `age`) VALUES('4','2020070004','41','叮当','d31f03e337e8910def90eef02f95ea29','女','3','26');


/*角色*/
DROP TABLE IF EXISTS `system_roles`;
CREATE TABLE `system_roles` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR (300) NOT NULL,
	`pid` BIGINT(20) NOT NULL COMMENT '-1 大boss',
	`level` INT(11) DEFAULT '0' COMMENT '1:全部数据权限 2:自定义权限',    				
	`link` VARCHAR(2000) DEFAULT NULL,	
	`create_by` BIGINT(20) COMMENT '创建者',
	`create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	`modify_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`remark` VARCHAR(64)
)ENGINE=INNODB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
INSERT INTO `system_roles` (`id`, `pid`, `name`, `link`) VALUES('1','-1','集团领导',',1,');
INSERT INTO `system_roles` (`id`, `pid`, `name`, `link`) VALUES('21','1','厂长',',1,');
INSERT INTO `system_roles` (`id`, `pid`, `name`, `link`) VALUES('41','21','车间主任',',1,21,');
INSERT INTO `system_roles` (`id`, `pid`, `name`, `link`) VALUES('61','41','线长',',1,21,41,');

/*管理员  org_id 建立中间表*/
DROP TABLE IF EXISTS `system_admin`;
CREATE TABLE `system_admin` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,#ID
	#`user_num` VARCHAR(32) UNIQUE,   	 				#工号     
	`name` VARCHAR(128) DEFAULT NULL,            				#姓名
	#`org_id` BIGINT(20),                   	 			#所属机构 
	`pwd` VARCHAR(32) DEFAULT NULL COMMENT 'md5(pwd+20tvb15)',    		#密码
	#`sex` VARCHAR(2) DEFAULT NULL,                				#性别
	#`age` INT(2),                   		  	 		#年龄 
	`create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,		 	#创建时间
	`create_by` BIGINT(20) DEFAULT NULL COMMENT '创建者',	 		#创建人
	`login_ip` VARCHAR(50) DEFAULT NULL,    				#上次登录IP
	`login_time` DATETIME DEFAULT NULL     					#上次登录时间
	#CONSTRAINT `sex` CHECK (sex in('男','女')),
	#FOREIGN KEY (`org_id`) REFERENCES `system_org` (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#INSERT INTO `system_workers` (`id`, `user_num`, `org_id`, `name`, `pwd`, `sex`, `age` ,`login_ip`) VALUES('1','2020070001','1','羊羊村长','d31f03e337e8910def90eef02f95ea29','男','18','172.16.15.103');
#INSERT INTO `system_workers` (`id`, `user_num`, `org_id`, `name`, `pwd`, `sex`, `age` ,`login_ip`) VALUES('2','2020070002','40','喜羊羊车间主任','d31f03e337e8910def90eef02f95ea29','男','21','172.16.15.104');
#INSERT INTO `system_workers` (`id`, `user_num`, `org_id`, `name`, `pwd`, `sex`, `age` ,`login_ip`) VALUES('2','2020070002','41','美羊羊线长','d31f03e337e8910def90eef02f95ea29','男','21','172.16.15.105');

INSERT INTO `system_admin` (`id`, `name`, `pwd`,`login_ip`) VALUES('1','羊羊村长','d31f03e337e8910def90eef02f95ea29','172.16.15.103');
INSERT INTO `system_admin` (`id`, `name`, `pwd`,`login_ip`) VALUES('2','喜羊羊车间主任','d31f03e337e8910def90eef02f95ea29','172.16.15.104');
INSERT INTO `system_admin` (`id`, `name`, `pwd`,`login_ip`) VALUES('3','美羊羊线长','d31f03e337e8910def90eef02f95ea29','172.16.15.105');

/*管理员和角色中间表  org_id 建立中间表*/
DROP TABLE IF EXISTS `system_admin_groups`;
CREATE TABLE `system_admin_groups` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT, #ID
	`admin_id` BIGINT(20),
	`org_id` BIGINT(20),
	FOREIGN KEY (`admin_id`) REFERENCES `system_admin` (`id`),
	FOREIGN KEY (`org_id`) REFERENCES `system_org` (`id`)
)ENGINE=INNODB  DEFAULT CHARSET=utf8;

INSERT INTO `system_admin_groups` (`admin_id`, `org_id`) VALUES('1','1');
INSERT INTO `system_admin_groups` (`admin_id`, `org_id`) VALUES('1','2');
INSERT INTO `system_admin_groups` (`admin_id`, `org_id`) VALUES('2','41');
INSERT INTO `system_admin_groups` (`admin_id`, `org_id`) VALUES('2','42');

/*管理员角色表 一个用户可以有多个角色
*/
DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role`(
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT, #ID
	`user_id` BIGINT(20) NOT NULL,          	#用户工号
	`role_id` BIGINT(20) NOT NULL,          	#角色编号
	#PRIMARY KEY (`user_id`,`role_id`),
	FOREIGN KEY (`user_id`) REFERENCES `system_workers` (`id`),
	FOREIGN KEY (`role_id`) REFERENCES `system_roles` (`id`)
);
INSERT INTO `system_user_role` (`user_id` , `role_id`)  VALUES('1' ,'21');
INSERT INTO `system_user_role` (`user_id` , `role_id`)  VALUES('2' ,'41');
INSERT INTO `system_user_role` (`user_id` , `role_id`)  VALUES('3' ,'61');


/*厂家：生产厂家名*/
DROP TABLE IF EXISTS `device_manufacturer`;
CREATE TABLE `device_manufacturer`(
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(64)  NOT NULL UNIQUE
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `device_manufacturer` (`name`) VALUES('杰克');
INSERT INTO `device_manufacturer` (`name`) VALUES('标准');
INSERT INTO `device_manufacturer` (`name`) VALUES('JUKI');
INSERT INTO `device_manufacturer` (`name`) VALUES('中捷');
INSERT INTO `device_manufacturer` (`name`) VALUES('飞马');
INSERT INTO `device_manufacturer` (`name`) VALUES('富山');

/*设备类型：平包绷等*/
DROP TABLE IF EXISTS `device_machine_type`;
CREATE TABLE `device_machine_type`(
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(64) NOT NULL UNIQUE
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `device_machine_type` (`name`) VALUES('平车');
INSERT INTO `device_machine_type` (`name`) VALUES('包缝');
INSERT INTO `device_machine_type` (`name`) VALUES('绷缝');
INSERT INTO `device_machine_type` (`name`) VALUES('套结');
INSERT INTO `device_machine_type` (`name`) VALUES('双针');
INSERT INTO `device_machine_type` (`name`) VALUES('多针');

/*设备系列*/
DROP TABLE IF EXISTS `device_series`;
CREATE TABLE `device_series`(
   `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
   `manufacturer_id` INT(11) NOT NULL,
   `machine_type_id` INT(11) NOT NULL,
   `series_name` VARCHAR(32) NOT NULL,
   `ecuFault_group_id` BIGINT(20) DEFAULT NULL,
   FOREIGN KEY (`manufacturer_id`) REFERENCES `device_manufacturer` (`id`),
   FOREIGN KEY (`machine_type_id`) REFERENCES `device_machine_type` (`id`) 
   #FOREIGN KEY (`ecuFault_group_id`) REFERENCES `device_ecufault`   (`ecuFault_group_id`)	
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('1','1','A4');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('1','1','A4-X');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('1','1','A5');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('1','1','A4E');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('1','1','A5E');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('1','3','K4');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('1','3','K6');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('2','2','GN9100-4H');
INSERT INTO `device_series` (`manufacturer_id` , `machine_type_id` ,`series_name`)  VALUES('3','1','9000C');

/*菜单列表*/
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
	`pid` BIGINT(20) DEFAULT NULL,
	`level` INT(11) NOT NULL,
	`menu_type` VARCHAR(1) DEFAULT '0',	
	`name` VARCHAR(100) NOT NULL,
	`path` VARCHAR(1024) NOT NULL,
	`order` INT(11) NOT NULL,
	`modifyTime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (`pid`) REFERENCES `system_menu` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=4000020202 DEFAULT CHARSET=utf8;

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('1000',NULL,'1','生产看板',' ','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('2000',NULL,'1','生产管理',' ','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('3000',NULL,'1','设备管理',' ','3',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('4000',NULL,'1','系统管理',' ','4',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('100001','1000','2','线平衡图',           '/group/list.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('100002','1000','2','产线时段效率/合格率','/group/list.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('100003','1000','2','全厂主电视界面',     '/group/list.do','3',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('100004','1000','2','主线工伤率/士气',    '/group/list.do','4',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('200001','2000','2','生产计划管理',	 '/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('200002','2000','2','生产设置',		 '/basic/order.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('200003','2000','2','生产进度',		 '/basic/orderSchedu.do','3',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('200004','2000','2','效率和质量管理','/basic/workerSchedu.do','4',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000101','200001','3','产品管理','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000102','200001','3','订单管理','/basic/order.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000103','200001','3','订单排产','/basic/orderSchedu.do','3',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000104','200001','3','工单管理','/basic/workerSchedu.do','4',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000201','200002','3','时段产量目标','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000202','200002','3','成品产量设置','/basic/order.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000203','200002','3','工作时间设置','/basic/orderSchedu.do','3',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000301','200003','3','订单进度','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000302','200003','3','工单进度','/basic/order.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000303','200003','3','工单详情','/basic/orderSchedu.do','3',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000401','200004','3','产线效率','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000402','200004','3','工序级员工亮率','/basic/order.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000403','200004','3','返工统计','/basic/orderSchedu.do','3',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('20000404','200004','3','不良分析','/basic/orderSchedu.do','3',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('300001','3000','2','设备信息','/piece/form.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('300002','3000','2','产线设备管理','/piece/chart.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('300003','3000','2','设备远程控制','/piece/form.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('300004','3000','2','设备实时数据','/piece/chart.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('300005','3000','2','设备分析','/piece/form.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('300006','3000','2','设备每日统计','/piece/chart.do','2',NULL);


INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000101','300001','3','网关管理','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000102','300001','3','模块(缝纫机)管理','/basic/order.do','2',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000201','300002','3','绑定','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000202','300002','3','解绑','/basic/order.do','2',NULL);

INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000501','300005','3','设备稼动率','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000502','300005','3','设备利用率','/basic/order.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000503','300005','3','设备故障率','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('30000504','300005','3','设备维修统计','/basic/order.do','2',NULL);



INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('400001','4000','2','员工管理','/piece/form.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('400002','4000','2','管理员管理','/piece/chart.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('400003','4000','2','角色与权限','/piece/form.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('400004','4000','2','机构设置','/piece/chart.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('400005','4000','2','字典维护','/piece/form.do','1',NULL);


INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('40000101','400001','3','员工信息','/basic/product.do','1',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('40000102','400001','3','员工能力','/basic/order.do','2',NULL);
INSERT INTO `system_menu` (`id`, `pid`, `level`, `name`, `path`, `order`, `modifyTime`) VALUES('40000103','400001','3','机修能力','/basic/product.do','1',NULL);

/*角色权限中间表
*  一个用户有多个权限，某种权限可指定多个用户，多对多
*/
DROP TABLE IF EXISTS `system_role_menu`;
CREATE TABLE `system_role_menu` (
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `role_id` BIGINT(20) DEFAULT NULL,
  `menu_id` BIGINT(20) DEFAULT NULL,
  KEY FK_ROLEMENU_MENU (`menu_id`),
  KEY FK_ROLEMENU_ROLE (`role_id`),
  CONSTRAINT FK_ROLEMENU_MENU FOREIGN KEY (`menu_id`) REFERENCES `system_menu` (`id`),
  CONSTRAINT FK_ROLEMENU_ROLE FOREIGN KEY (`role_id`) REFERENCES `system_roles` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'1000');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'2000');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'3000');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'4000');

INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'100001');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'100002');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'100003');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'100004');

INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'200001');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'200002');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'200003');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'200004');

	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000101');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000102');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000103');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000104');

	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000201');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000202');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000203');

	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000301');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000302');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000303');

	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000401');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000402');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000403');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'20000404');

INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'300001');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'300002');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'300003');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'300004');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'300005');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'300006');

	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000101');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000102');
	
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000201');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000202');

	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000501');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000502');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000503');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'30000504');	

INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'400001');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'400002');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'400003');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'400004');
INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'400005');

	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'40000101');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'40000102');
	INSERT INTO `system_role_menu` (`role_id` , `menu_id`) VALUES('21' ,'40000103');

	
/*产品管理（产品和订单:一对多）*/
DROP TABLE IF EXISTS `produce_product`;
CREATE TABLE `produce_product` (
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,    	    	#ID
  `product_num` VARCHAR(32) NOT NULL UNIQUE,    		#产品编号
  `product_name` VARCHAR(255) NOT NULL,    	   	    	#产品名称
  `picture_url` VARCHAR(255) DEFAULT NULL             		#产品图片
# productProces INT(11)                     	        	#工序数量
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `produce_product` (`product_num` , `product_name`) VALUES('P001' ,'衬衫');
INSERT INTO `produce_product` (`product_num` , `product_name`) VALUES('P002' ,'牛仔库');
INSERT INTO `produce_product` (`product_num` , `product_name`) VALUES('P003' ,'T-shirt');
INSERT INTO `produce_product` (`product_num` , `product_name`) VALUES('P004' ,'秋裤');

/*订单管理*/
DROP TABLE IF EXISTS `produce_orders`;
CREATE TABLE `produce_orders` (           
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,   	#ID
	`order_num` VARCHAR(32) NOT NULL UNIQUE,  	#订单编号
	`product_id` BIGINT(20) DEFAULT NULL,          	#产品编号
	`count` BIGINT(20) NOT NULL,                    #数量
	`customer_name` VARCHAR(64) NOT NULL,         	#客户名
	`start_date` DATETIME NOT NULL,          	#下单期
	`delivery_date` DATETIME NOT NULL,           	#交货期
	`unit_price` DECIMAL(5,2) DEFAULT NULL,         #单价
	`remarks` VARCHAR(100) DEFAULT NULL,         	#备注
	FOREIGN KEY (`product_id`) REFERENCES `produce_product` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `produce_orders` (`order_num`, `product_id`, `count`, `customer_name`, `start_date`, `delivery_date`) VALUES('YYK0701','1','500','优衣库','2020-07-01 00:00:00','2020-09-26 23:59:59');
INSERT INTO `produce_orders` (`order_num`, `product_id`, `count`, `customer_name`, `start_date`, `delivery_date`) VALUES('YYK0702','2','800','优衣库','2020-07-02 00:00:00','2020-09-26 23:59:59');
INSERT INTO `produce_orders` (`order_num`, `product_id`, `count`, `customer_name`, `start_date`, `delivery_date`) VALUES('DKL0812','3','2000','迪卡龙','2020-08-12 00:00:00','2020-09-26 23:59:59');
INSERT INTO `produce_orders` (`order_num`, `product_id`, `count`, `customer_name`, `start_date`, `delivery_date`) VALUES('HD0901','4','9000','红豆','2020-09-22 00:00:00','2020-10-26 23:59:59');

/*工序管理*/
DROP TABLE IF EXISTS `produce_process`;
CREATE TABLE `produce_process` (
	`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT, 			#ID
	`process_id` BIGINT(20) NOT NULL, 				#工序编号	
	`product_id` BIGINT(20) NOT NULL, 				#产品编号
	`des` VARCHAR(32) NOT NULL,               			#描述
	`cycle_time` INT(11) NOT NULL,                      		#工时
	`cycle_stitch` INT(11) DEFAULT '0',                     	#工序标准针数
	`cycle_trim` INT(11) DEFAULT '0',                      	 	#工序标准剪线数	
	`work_price` DECIMAL(5,2) NOT NULL,                		#工价
	`machine_id` INT(11) DEFAULT NULL,           			#机器类型
	`process_type` INT(11) DEFAULT NULL,            		#工序类型
	`sewing_length` INT(11) DEFAULT NULL,                   	#缝纫长度
	`sewing_time` INT(11) DEFAULT NULL,                     	#车缝时间
	`parts_name` VARCHAR(64) DEFAULT NULL,                  	#部件名称
	`remarks` VARCHAR(128) DEFAULT NULL,                    	#备注
	`video_url` VARCHAR(128)DEFAULT NULL,                   	#视频链接
	`picture_url`	VARCHAR(128)DEFAULT NULL,			#图片链接
	FOREIGN KEY (`product_id`) REFERENCES `produce_product` (`id`),
	FOREIGN KEY (`machine_id`) REFERENCES `device_machine_type` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `produce_process` (`process_id`, `product_id`, `des`, `cycle_time`, `work_price`, `machine_id`) VALUES('1','1','领子','120','0.45', '1');
INSERT INTO `produce_process` (`process_id`, `product_id`, `des`, `cycle_time`, `work_price`, `machine_id`) VALUES('2','1','领座','12','0.12', '1');
INSERT INTO `produce_process` (`process_id`, `product_id`, `des`, `cycle_time`, `work_price`, `machine_id`) VALUES('4','1','领肩','18','0.20', '4');
INSERT INTO `produce_process` (`process_id`, `product_id`, `des`, `cycle_time`, `work_price`, `machine_id`) VALUES('5','1','袖口','150','0.60', '1');
INSERT INTO `produce_process` (`process_id`, `product_id`, `des`, `cycle_time`, `work_price`, `machine_id`) VALUES('7','1','门襟','180','0.90', '2');
INSERT INTO `produce_process` (`process_id`, `product_id`, `des`, `cycle_time`, `work_price`, `machine_id`) VALUES('9','1','前片','130','0.70', '1');
INSERT INTO `produce_process` (`process_id`, `product_id`, `des`, `cycle_time`, `work_price`, `machine_id`) VALUES('10','1','胸袋','100','0.71', '1');

/*产品工序中间表 暂时不用
*  一产品有多工序，一工序能出现在不同产品上
*/
DROP TABLE IF EXISTS `produce_product_process`;
CREATE TABLE `produce_product_process` (
  `product_id` BIGINT(20) NOT NULL,            
  `process_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`product_id`,`process_id`),
  FOREIGN KEY (`product_id`) REFERENCES `produce_product` (`id`),
  FOREIGN KEY (`process_id`) REFERENCES `produce_process` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*订单排产，将订单分配给机构*/
DROP TABLE IF EXISTS `produce_order_dispatch`;
CREATE TABLE `produce_order_dispatch`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT, 				#ID
  `order_id` BIGINT(20) NOT NULL,        	  			#订单编号
  `product_id` BIGINT(20) NOT NULL,    					#产品编号
  `org_id` BIGINT(20) NOT NULL,        	 				#机构号
  `count` INT(11) NOT NULL,               	            		#分配数量
  `cnt_para`INT(11) DEFAULT '0',               	       			#计件参数(0:按照工序最小值 >=1按照指定工序产量)
  `dispatch_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,              #分配日期
  #PRIMARY KEY (`order_id`,`org_id`),
  FOREIGN KEY (`order_id`) REFERENCES `produce_orders` (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `produce_product` (`id`),  
  FOREIGN KEY (`org_id`) REFERENCES `system_org` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `produce_order_dispatch` (`order_id`, `product_id`, `org_id`, `count`) VALUES('1','1','41','300');



/*人员排位,机构将订单分配给机构本人员*/
DROP TABLE IF EXISTS `produce_task_dispatch`;
CREATE TABLE `produce_task_dispatch`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,   	#ID
  `user_id` BIGINT(20) NOT NULL,                	#员工ID
  `dispatch_id` BIGINT(20) NOT NULL,            	#工单ID(工单总数、机构)
  `process_id` BIGINT(20) NOT NULL,      		#分配的工序
  `post_cnt` BIGINT(20) NOT NULL,        	    	#分配的件数
#  `done_cnt` BIGINT(20) DEFAULT 0,        	    	#已完成的件数  
#  `avg_worktime` BIGINT(20) DEFAULT 0,     		#平均工时   
  FOREIGN KEY (`user_id`) REFERENCES `system_workers` (`id`),
  FOREIGN KEY (`dispatch_id`) REFERENCES `produce_order_dispatch` (`id`),  
  FOREIGN KEY (`process_id`) REFERENCES `produce_process` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('1','1','1','300');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('1','1','2','300');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('1','1','3','300');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('2','1','4','300');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('3','1','5','250');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('4','1','5','50');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('2','1','6','100');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('4','1','6','200');
INSERT INTO `produce_task_dispatch` (`user_id`, `dispatch_id`, `process_id`, `post_cnt`) VALUES('4','1','7','300');

/*计件消息*/
DROP TABLE IF EXISTS `produce_process_piece`;
CREATE TABLE `produce_process_piece`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `worker_id` BIGINT(20) NOT NULL,                	#员工ID
  `dispatch_id` BIGINT(20) NOT NULL,            	#工单ID(工单总数、机构)
  `process_id` BIGINT(20) NOT NULL,             	#工序ID
  `machine_id` BIGINT(20) NOT NULL,             	#机器ID  
  `cycle_time` INT(11) DEFAULT 0,     			#实际工时   CT
  `value_time` INT(11) DEFAULT 0,     			#车缝时间   VT  
  `cycle_stitch` INT(11),     				#工序实际针数
  `cycle_trim` INT(11),     				#工序实际剪线数
  `done_cnt` INT(11),        	   			#已完成的件数  
#  `start_time` DATETIME ,				#开始时间 
  `over_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,	#结束时间
  FOREIGN KEY (`worker_id`) REFERENCES `system_workers` (`id`),
  FOREIGN KEY (`dispatch_id`) REFERENCES `produce_order_dispatch` (`id`),  
  FOREIGN KEY (`process_id`) REFERENCES `produce_process` (`id`)
  #FOREIGN KEY (`machine_id`) REFERENCES `system_machine` (`id`) 
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


/*工序进度*/
DROP TABLE IF EXISTS `produce_process_detail`;
CREATE TABLE `produce_process_detail`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `dispatch_id` BIGINT(20) NOT NULL,            		#工单ID(工单总数、机构)
  `process_id` BIGINT(20) NOT NULL,             		#工序ID
  `avg_ct` INT(11) DEFAULT '0',     			    	#工序完成平均时间(有多个人同时做一个工序情况)
  `done_cnt` INT(11),        	   				#已完成的件数  
  `create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,	#时间
  FOREIGN KEY (`dispatch_id`) REFERENCES `produce_order_dispatch` (`id`),  
  FOREIGN KEY (`process_id`) REFERENCES `produce_process` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


/*设备运行状态:(离线、空闲、运行) */
DROP TABLE IF EXISTS `device_machine_runstate`;
CREATE TABLE `device_machine_runstate`(
  `id` INT(11) PRIMARY KEY AUTO_INCREMENT, 
  `name` VARCHAR(32) NOT NULL
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `device_machine_runstate` (`name`) VALUES('离线');
INSERT INTO `device_machine_runstate` (`name`) VALUES('空闲');
INSERT INTO `device_machine_runstate` (`name`) VALUES('运行');

/*电控故障类别*/
DROP TABLE IF EXISTS `device_ecufault`;
CREATE TABLE `device_ecufault`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `ecufault_group_id` BIGINT(20) NOT NULL,     			#机器故障分组 
  `error_code` BIGINT(11) NOT NULL UNIQUE,    			#故障码  
  `name` VARCHAR(32) NOT NULL, 				        #故障名
  `remarks` VARCHAR(128) DEFAULT NULL 		            	#描述
) ENGINE=INNODB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','1','硬件过流','电控硬件故障');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','2','掉电','系统关机');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','3','系统欠压','母线电压低');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','4','停机时过压',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','5','运行时过压',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','6','电磁铁回路故障','输出电磁铁异常');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','7','电流检测回路故障',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','8','电机堵转',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','9','制动回路故障',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','10','HMI通讯故障',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','11','机头停针信号故障',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','12','电机初始角度检测故障',' ');

INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','13','电机hall故障',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','14','DSP读写eeprom故障',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','15','电机超速保护',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','16','电机反转',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','17','HMI读写eeprom故障',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','18','电机过载',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','19','安全开关',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','20','加油时间保护',' ');
INSERT INTO `device_ecufault` (`ecufault_group_id`, `error_code`, `name`, `remarks`) VALUES('1','21','位置超差',' ');

/*设备信息*/
DROP TABLE IF EXISTS `device_machines`;
CREATE TABLE `device_machines`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT, 			#ID
  `machine_num` VARCHAR(16) NOT NULL UNIQUE, 			#设备编号
  `org_id` BIGINT(20) NOT NULL,          			#所属机构
  `name` VARCHAR(64) DEFAULT NULL,     				#设备名称 
  #`machine_type_id` INT(11) DEFAULT NULL,       		#类型(平、包、绷)
  #`machine_manufacturer_id` INT(11) DEFAULT NULL,  		#厂家
  #`series` VARCHAR(36) DEFAULT NULL,        			#型号(A4\A5\A7)
  `series_id` INT(11) DEFAULT NULL,        			#型号(A4\A5\A7)
  `cnt_para` INT(11) DEFAULT NULL,       			#计件参数
  `remarks` VARCHAR(100) DEFAULT NULL,      			#描述
  `create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,					 #创建时间  
  `modify_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,		 #修改时间  
  FOREIGN KEY (`org_id`) REFERENCES `system_org`(`id`) 
  #FOREIGN KEY (`series_id`) REFERENCES `system_machine_series`(`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `device_machines` (`machine_num`, `org_id`, `series_id`) VALUES('JK0705Z001','41','1');
INSERT INTO `device_machines` (`machine_num`, `org_id`, `series_id`) VALUES('JK0705Z002','41','1');
INSERT INTO `device_machines` (`machine_num`, `org_id`, `series_id`) VALUES('JK0705Z003','41','3');
INSERT INTO `device_machines` (`machine_num`, `org_id`, `series_id`) VALUES('JK0705Z073','41','7');
INSERT INTO `device_machines` (`machine_num`, `org_id`, `series_id`) VALUES('JI0705E009','41','9');
INSERT INTO `device_machines` (`machine_num`, `org_id`, `series_id`) VALUES('BZ0705S001','41','8');

/*设备时实数据*/
DROP TABLE IF EXISTS `device_machine_state`;
CREATE TABLE `device_machine_state`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT, 	#ID          
  `user_id` BIGINT(20) DEFAULT NULL,           	#当前用户   
  `run_state` INT(11),  			#运行状态 (离线、空闲、运行) 
  `lock_flag` BOOLEAN DEFAULT FALSE,		#锁机状态 
  `auto_flag` BOOLEAN  DEFAULT FALSE,		#自动测试状态
  
  `total_stitch` BIGINT(20) DEFAULT NULL,     	 #累计运行针数
  `total_trim` BIGINT(20) DEFAULT NULL,        	 #累计剪线次数
  `cur_stitch` BIGINT(20) DEFAULT NULL,     	 #本次运行针数
  `cur_trim` BIGINT(20) DEFAULT NULL,      	 #本次剪线次数
  
  `total_run_rime` BIGINT(20) DEFAULT NULL,      #累计运行时间
  `total_idle_time` BIGINT(20) DEFAULT NULL,     #累计空闲时间
  `cur_run_time` BIGINT(20) DEFAULT NULL,     	 #本次运行时间
  `cur_idle_time` BIGINT(20) DEFAULT NULL,    	 #本次空闲时间
  
  #`totay_run_time` BIGINT(20) DEFAULT NULL,      #本日运行时间
  #`totay_idle_time` BIGINT(20) DEFAULT NULL,     #本日空闲时间

  #`totay_stitch` BIGINT(20) DEFAULT NULL,        #本日运行时间
  #`totay_trim` BIGINT(20) DEFAULT NULL,          #本日空闲时间

  `create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,    			#时间
  FOREIGN KEY (`user_id`) REFERENCES `system_workers`(id), 				#当前登录用户
  FOREIGN KEY (`run_state`) REFERENCES `device_machine_runstate`(id)  	#设备运行状态
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `device_machine_state` (`user_id`, `run_state`, `cur_stitch`, `cur_trim`) VALUES(NULL,'1','2000','120');
INSERT INTO `device_machine_state` (`user_id`, `run_state`, `cur_stitch`, `cur_trim`) VALUES('1','3','2010','120');
INSERT INTO `device_machine_state` (`user_id`, `run_state`, `cur_stitch`, `cur_trim`) VALUES('2','1','2020','120');
INSERT INTO `device_machine_state` (`user_id`, `run_state`, `cur_stitch`, `cur_trim`) VALUES('3','2','2030','120');
INSERT INTO `device_machine_state` (`user_id`, `run_state`, `cur_stitch`, `cur_trim`) VALUES('4','1','2040','120');
INSERT INTO `device_machine_state` (`user_id`, `run_state`, `cur_stitch`, `cur_trim`) VALUES('2','3','2050','120');
INSERT INTO `device_machine_state` (`user_id`, `run_state`, `cur_stitch`, `cur_trim`) VALUES('4','1','2060','124');

/*电控故障记录*/
DROP TABLE IF EXISTS `device_ecufault_record`;
CREATE TABLE `device_ecufault_record`(  
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT, 					#ID 
  `machine_id` BIGINT(20) NOT NULL,         					#机器ID
  `error_code` INT(11) NOT NULL, 						#故障码ID
  `user_id` BIGINT(20) DEFAULT NULL,    					#当前操作车工
  `creat_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,  			#记录时间  
  `remarks` VARCHAR(100)  DEFAULT NULL,       					#备注
  FOREIGN KEY (`machine_id`) REFERENCES `device_machines`(`id`),		#设备编号 
  #FOREIGN KEY (`error_code`) REFERENCES `device_ecufault`(`error_code`), 	#故障码
  FOREIGN KEY (`user_id`) REFERENCES `system_workers`(`id`) 			#用户
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `device_ecufault_record` (`machine_id`, `error_code`, `user_id`) VALUES('1','8','1');
INSERT INTO `device_ecufault_record` (`machine_id`, `error_code`, `user_id`) VALUES('2','19','2');
INSERT INTO `device_ecufault_record` (`machine_id`, `error_code`, `user_id`) VALUES('5','13','4');

/*卡类型：操作工、机修、QC等*/
DROP TABLE IF EXISTS `system_rfid_type`;
CREATE TABLE `system_rfid_type`(
  `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(36) UNIQUE
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `system_rfid_type` (`name`) VALUES('操作工');
INSERT INTO `system_rfid_type` (`name`) VALUES('机修');
INSERT INTO `system_rfid_type` (`name`) VALUES('QC');
INSERT INTO `system_rfid_type` (`name`) VALUES('物料卡');

/******日志表******/
DROP TABLE IF EXISTS `system_oplog`;
CREATE TABLE `system_oplog` (
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `object` VARCHAR(100) NOT NULL,
  `type` INT(11) NOT NULL,
  `log` VARCHAR(1024) NOT NULL,
  `time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` BIGINT(20) NOT NULL,
  `ip` VARCHAR(20) NOT NULL
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


/*RFID卡信息*/
DROP TABLE IF EXISTS `system_rfid_cards`;
CREATE TABLE `system_rfid_cards`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,				 	#ID
  `rfid_type_id` INT(11) NOT NULL,              				#卡类型  
  `serial_num` VARCHAR(128) DEFAULT NULL,     	  			     	#序列号 
  `card_num` VARCHAR(32) DEFAULT NULL,     	  			     	#卡号
  `worker_id` BIGINT(20) NOT NULL,     	  					#卡片持有人
  `remarks` VARCHAR(32) DEFAULT NULL,  						#备注
  FOREIGN KEY (`worker_id`) REFERENCES `system_workers`(`id`),
  FOREIGN KEY (`rfid_type_id`) REFERENCES `system_rfid_type`(`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `system_rfid_cards` (`card_num`, `worker_id`, `rfid_type_id`) VALUES('20201030','1','1');
INSERT INTO `system_rfid_cards` (`card_num`, `worker_id`, `rfid_type_id`) VALUES('20201031','2','1');
INSERT INTO `system_rfid_cards` (`card_num`, `worker_id`, `rfid_type_id`) VALUES('20201032','3','1');
INSERT INTO `system_rfid_cards` (`card_num`, `worker_id`, `rfid_type_id`) VALUES('20201034','4','2');


/*RFID卡记录*/
DROP TABLE IF EXISTS `system_rfid_recorder`;
CREATE TABLE `system_rfid_recorder`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `machine_id` BIGINT(20) NOT NULL,           								#设备
  `rfid_card_id` BIGINT(20) NOT NULL,               							#卡信息
  `login_state` INT(1) DEFAULT NULL,        								#登陆，登出状态  
  `creat_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP, #,      					#刷卡时间  
  FOREIGN KEY (`machine_id`) REFERENCES `device_machines`(`id`),					#设备ID
  FOREIGN KEY (`rfid_card_id`) REFERENCES `system_rfid_cards`(`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `system_rfid_recorder` (`machine_id`, `rfid_card_id`, `login_state`)  VALUES('1','1','1');
INSERT INTO `system_rfid_recorder` (`machine_id`, `rfid_card_id`, `login_state`)  VALUES('1','1','0');
INSERT INTO `system_rfid_recorder` (`machine_id`, `rfid_card_id`, `login_state`)  VALUES('2','3','1');
INSERT INTO `system_rfid_recorder` (`machine_id`, `rfid_card_id`, `login_state`)  VALUES('3','4','0');


/*维修故障代码*/
DROP TABLE IF EXISTS `system_machine_fault`;
CREATE TABLE `system_machine_fault`(
  `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
  `code` INT(11) NOT NULL, 					#故障编码  
  `name` VARCHAR(64) NOT NULL, 					#故障名
  `remarks` VARCHAR(128) DEFAULT NULL				#描述
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `system_machine_fault` (`code`, `name`)  VALUES('1','跳针');
INSERT INTO `system_machine_fault` (`code`, `name`)  VALUES('2','掉线');
INSERT INTO `system_machine_fault` (`code`, `name`)  VALUES('3','宕机');
INSERT INTO `system_machine_fault` (`code`, `name`)  VALUES('4','电控故障');
INSERT INTO `system_machine_fault` (`code`, `name`)  VALUES('5','电磁铁故障');

/*返工原因*/
DROP TABLE IF EXISTS `system_rework_fault`;
CREATE TABLE `system_rework_fault`(
  `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
  `code` INT(11) NOT NULL, 					        #返工编码    
  `name` VARCHAR(64) NOT NULL, 				    		#原因
  `remarks` VARCHAR(128) DEFAULT NULL  					#描述
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `system_rework_fault` (`code`, `name`)  VALUES('1','色差');
INSERT INTO `system_rework_fault` (`code`, `name`)  VALUES('2','打皱');
INSERT INTO `system_rework_fault` (`code`, `name`)  VALUES('3','破洞');
INSERT INTO `system_rework_fault` (`code`, `name`)  VALUES('4','线头');
INSERT INTO `system_rework_fault` (`code`, `name`)  VALUES('5','不对称');
INSERT INTO `system_rework_fault` (`code`, `name`)  VALUES('6','尺寸不良');
INSERT INTO `system_rework_fault` (`code`, `name`)  VALUES('7','漏工序');

/*机修维修记录*/
DROP TABLE IF EXISTS `system_repair_record`;
CREATE TABLE `system_repair_record`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `rfid_recorder_id` BIGINT(20) NOT NULL,           			#刷卡记录
  `start_time` DATETIME DEFAULT NULL,					#开始时间
  `over_time` DATETIME DEFAULT NULL,  					#结束时间
  `machine_fault_codes` VARCHAR(256) NOT NULL				#故障码记录(01,05)
  #FOREIGN KEY (`rfid_recorder_id`) REFERENCES `system_rfid_recorder`(`id`),
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `system_repair_record` (`rfid_recorder_id`, `machine_fault_codes` ,`start_time` ,`over_time`)  VALUES('4','1,2,3','2020-07-01 09:00:00','2020-07-01 09:15:00');



/*返工记录*/
DROP TABLE IF EXISTS `system_rework_record`;
CREATE TABLE `system_rework_record`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `user_id` BIGINT(20) NOT NULL,					#操作工
  `timer` BIGINT(20) NOT NULL,						#返工时间
  `piece` BIGINT(20) NOT NULL,						#返工数量
  #`rework_id` BIGINT(20) NOT NULL,					#返工原因
  `date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,	#返工日期
  `rework_codes` VARCHAR(256) NOT NULL, 			#返工原因(01,05)
  FOREIGN KEY (`user_id`) REFERENCES `system_workers`(`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `system_rework_record` (`user_id`, `timer` ,`piece` ,`rework_codes`)  VALUES('1','400','30','1,2,3');

/*产量设置*/
DROP TABLE IF EXISTS `system_group_output`;
CREATE TABLE `system_group_output`(
  `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
  `group_id` BIGINT(20) NOT NULL,

  `output`  VARCHAR(1024), 					 #第1-N天目标产量('0024 0034 0045')第一天产量:24 第二天:34 第三天45
  `efficiency` VARCHAR(1024),           	 #第1-N天合格率  ('0040 0070 0085')第一天效率:40%第二天:70%第三天85%
 
  `creat_time` DATETIME  NULL DEFAULT CURRENT_TIMESTAMP,   #创建日期
                       
  FOREIGN KEY (`group_id`) REFERENCES `system_org`(`id`)    #操作的机构ID  
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*系统参数*/
DROP TABLE IF EXISTS `system_para`;
CREATE TABLE `system_para`(
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `para_value` BIGINT(20) NOT NULL,				#参数内容
  `remarks` VARCHAR(256) NOT NULL 				#参数说明
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;