DROP TABLE IF EXISTS `table1`;

CREATE TABLE `table1` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`name` varchar(20) DEFAULT NULL COMMENT '姓名',
`age` int(11) DEFAULT NULL COMMENT '年龄',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `table1` (`id`, `name`, `age`)
VALUES
(1,'姓名1',10),
(2,'姓名2',11),
(3,'姓名2',11),
(4,'姓名2',11);