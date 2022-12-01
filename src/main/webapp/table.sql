select * from tbluser;
SELECT user_name FROM tbluser WHERE user_id = 'test1' AND user_pwd = 1234;
select money, flow_si from tblhistory WHERE user_id = 'test1';

CREATE TABLE `tblhistory` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `flow_si` char(1) NOT NULL DEFAULT 'S',
  `text` varchar(45) NOT NULL,
  `money` int NOT NULL,
  `history_date` datetime NOT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `tbluser` (
  `user_id` varchar(45) NOT NULL,
  `user_pwd` varchar(45) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `user_email` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

