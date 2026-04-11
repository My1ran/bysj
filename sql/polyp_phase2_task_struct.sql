-- Phase 2 P1: structured columns for polyp_detect_task
-- Backup database before running this script.

ALTER TABLE `polyp_detect_task`
  ADD COLUMN `media_type` varchar(16) NULL COMMENT 'media type: image/video' AFTER `source_file_id`,
  ADD COLUMN `result_image_url` varchar(1024) NULL COMMENT 'result image url' AFTER `error_msg`,
  ADD COLUMN `result_video_url` varchar(1024) NULL COMMENT 'result video url' AFTER `result_image_url`,
  ADD COLUMN `result_frames_url` varchar(1024) NULL COMMENT 'result frames json url' AFTER `result_video_url`,
  ADD COLUMN `frame_count` int(11) NULL COMMENT 'total frame count' AFTER `result_frames_url`,
  ADD COLUMN `detected_frame_count` int(11) NULL COMMENT 'detected frame count' AFTER `frame_count`,
  ADD COLUMN `box_count` int(11) NULL COMMENT 'total detection boxes' AFTER `detected_frame_count`,
  ADD COLUMN `max_confidence` decimal(10,6) NULL COMMENT 'max confidence' AFTER `box_count`,
  ADD COLUMN `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'logical delete: 0 active, 1 deleted' AFTER `remark`;

CREATE INDEX `idx_polyp_task_is_deleted` ON `polyp_detect_task` (`is_deleted`);
CREATE INDEX `idx_polyp_task_media_type` ON `polyp_detect_task` (`media_type`);
CREATE INDEX `idx_polyp_task_create_time` ON `polyp_detect_task` (`create_time`);

-- Compatibility migration for old logical delete strategy.
UPDATE `polyp_detect_task`
SET `is_deleted` = 1
WHERE `status` = 'DELETED';
