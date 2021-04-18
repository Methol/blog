---
title: MySQL全库模糊搜索关键词
date: 2016-07-04 14:39:00
tags: [sql]
---

执行以下存储过程，全库搜索关键字

```
DELIMITER //
DROP PROCEDURE IF EXISTS `proc_FindStrInAllDataBase`//
# CALL `proc_FindStrInAllDataBase` ('testdb','中');
CREATE PROCEDURE `proc_FindStrInAllDataBase`
(
 IN para_databasename VARCHAR(128),
 IN para_finstr VARCHAR(128)
)
BEGIN
 -- 需要定义接收游标数据的变量
 DECLARE tmp_dbname VARCHAR(128);
 DECLARE tmp_tbname VARCHAR(128);
 DECLARE tmp_colname VARCHAR(128);
 -- 遍历数据结束标志
 DECLARE done INT DEFAULT FALSE;


 -- 游标
 DECLARE cur_db_tb CURSOR
 FOR
 SELECT
  #*,
  c.table_schema,c.table_name,c.COLUMN_NAME
 FROM
  information_schema.`COLUMNS` C
  INNER JOIN information_schema.`TABLES` t ON c.`TABLE_NAME`=t.`TABLE_NAME`
 WHERE
  T.`TABLE_TYPE`='BASE TABLE'
 AND
  (c.data_type  LIKE '%char%'  OR c.data_type  LIKE '%text%')
 AND
  (C.TABLE_SCHEMA=para_databasename OR IFNULL(para_databasename,'') ='') AND IFNULL(para_finstr,'')<>'';

 -- 将结束标志绑定到游标
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 CREATE TEMPORARY TABLE IF NOT EXISTS rstb(dbname VARCHAR(128),tbname VARCHAR(128),colname VARCHAR(128),cnt INT);
 -- 打开游标
 OPEN cur_db_tb;
   -- 开始循环
   read_loop: LOOP
   -- 提取游标里的数据，这里只有一个，多个的话也一样；
   FETCH cur_db_tb INTO  tmp_dbname,tmp_tbname,tmp_colname;
   -- 声明结束的时候
   IF done THEN
   LEAVE read_loop;
   END IF;
   -- 这里做你想做的循环的事件
   SET @sqlstr=CONCAT('select count(1) into @rn from ',tmp_dbname,'.',tmp_tbname,' where ',tmp_colname,' like ''%',para_finstr,'%''');

   PREPARE str FROM @sqlstr;
   EXECUTE str;
   DEALLOCATE PREPARE str;
   IF IFNULL(@rn,0)>0
    THEN
    INSERT INTO rstb VALUES(tmp_dbname,tmp_tbname,tmp_colname,@rn);
   END IF;

   END LOOP;
 -- 关闭游标
 CLOSE cur_db_tb;

 SELECT * FROM rstb;
 DROP TABLE rstb;

END
//
DELIMITER ;
```

执行效果如下：
![查询结果](https://cdn.jsdelivr.net/gh/methol/pic@main/upic/20210418/214903-OHpTem.png)