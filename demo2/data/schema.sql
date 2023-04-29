CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `project` (
  `project_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_name` varchar(100) NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `epic` (
  `epic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `epic_name` varchar(100) NOT NULL,
  `project_id` int(11) unsigned NOT NULL,
  `start_date` datetime NULL,
  `completion_date` datetime NULL,
  `due_date` date NULL,
  PRIMARY KEY (`epic_id`),
  CONSTRAINT `epic_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `story` (
  `story_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `story_name` varchar(100) NOT NULL,
  `epic_id` int(11) unsigned NOT NULL,
  `start_date` datetime NULL,
  `completion_date` datetime NULL,
  `due_date` date NULL,
  `priority` tinyint(1) unsigned NULL,
  PRIMARY KEY (`story_id`),
  CONSTRAINT `story_ibfk_1` FOREIGN KEY (`epic_id`) REFERENCES `epic` (`epic_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `task` (
  `task_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `task_name` varchar(100) NOT NULL,
  `story_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `start_date` datetime NULL,
  `completion_date` datetime NULL,
  `due_date` date NULL,
  `priority` tinyint(1) unsigned NULL,
  PRIMARY KEY (`task_id`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`story_id`) REFERENCES `story` (`story_id`) ON DELETE CASCADE,
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `time` (
  `time_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `work_done` varchar(100) NULL,
  `task_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `hours` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`time_id`),
  CONSTRAINT `time_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE CASCADE,
  CONSTRAINT `time_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

