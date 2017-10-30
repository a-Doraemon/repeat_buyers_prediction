/*将各个csv数据存入MySQL（通过MySQL Workbench操作的）,名字为：user_log,user_info,train,test*/

INSERT INTO repeatbuyers.train_test SELECT * FROM repeatbuyers.train;
ALTER TABLE repeatbuyers.test CHANGE prob label;
INSERT INTO repeatbuyers.train_test SELECT * FROM repeatbuyers.test;
ALTER TABLE repeatbuyers.user_log DROP COLUMN item_id,cat_id,brand_id,time_tramp;
/*去除掉user_log中无用的数据，只保留train_test中所包括的user_id以及merchant_id的所有数据*/
INSERT INTO repeatbuyers.train_test_log SELECT * FROM repeatbuyers.train_test LEFT JOIN repeatbuyers.user_log ON train_test.user_id=user_log.user_id AND train_test.merchant_id=user_log.merchant_id;
/*统计各个每个用户对每个商家的各种浏览行为action_type的数量*/
INSERT INTO repeatbuyers.user_log_simple SELECT user_id,merchant_id,
SUM(CASE action_type WHEN '0' THEN 1 ELSE 0 END) AS 'click', 
SUM(CASE action_type WHEN '1' THEN 1 ELSE 0 END) AS 'add_to_cart',
SUM(CASE action_type WHEN '2' THEN 1 ELSE 0 END) AS 'purchase',
SUM(CASE action_type WHEN '3' THEN 1 ELSE 0 END) AS 'add_to_favourite',
label FROM ly.new_table GROUP BY user_id,merchant_id,action_type;